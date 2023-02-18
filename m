Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E886F69B565
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Feb 2023 23:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBQWUS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Feb 2023 17:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBQWUR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:20:17 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E90463BD5
        for <netfilter-devel@vger.kernel.org>; Fri, 17 Feb 2023 14:20:16 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pT95R-0008TH-DR; Fri, 17 Feb 2023 23:20:13 +0100
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Cc:     syzkaller-bugs@googlegroups.com, Florian Westphal <fw@strlen.de>,
        syzbot+f61594de72d6705aea03@syzkaller.appspotmail.com
Subject: [PATCH nf] ebtables: fix table blob use-after-free
Date:   Fri, 17 Feb 2023 23:20:06 +0100
Message-Id: <20230217222006.169428-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

We are not allowed to return an error at this point.
Looking at the code it looks like ret is always 0 at this
point, but its not.

t = find_table_lock(net, repl->name, &ret, &ebt_mutex);

... this can return a valid table, with ret != 0.

This bug causes update of table->private with the new
blob, but then frees the blob right away in the caller.

Syzbot report:

BUG: KASAN: vmalloc-out-of-bounds in __ebt_unregister_table+0xc00/0xcd0 net/bridge/netfilter/ebtables.c:1168
Read of size 4 at addr ffffc90005425000 by task kworker/u4:4/74
Workqueue: netns cleanup_net
Call Trace:
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 __ebt_unregister_table+0xc00/0xcd0 net/bridge/netfilter/ebtables.c:1168
 ebt_unregister_table+0x35/0x40 net/bridge/netfilter/ebtables.c:1372
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:169
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:613
...

ip(6)tables appears to be ok (ret should be 0 at this point) but make
this more obvious.

Fixes: c58dd2dd443c ("netfilter: Can't fail and free after table replacement")
Reported-by: syzbot+f61594de72d6705aea03@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/bridge/netfilter/ebtables.c | 2 +-
 net/ipv4/netfilter/ip_tables.c  | 3 +--
 net/ipv6/netfilter/ip6_tables.c | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index ce5dfa3babd2..757ec46fc45a 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1090,7 +1090,7 @@ static int do_replace_finish(struct net *net, struct ebt_replace *repl,
 
 	audit_log_nfcfg(repl->name, AF_BRIDGE, repl->nentries,
 			AUDIT_XT_OP_REPLACE, GFP_KERNEL);
-	return ret;
+	return 0;
 
 free_unlock:
 	mutex_unlock(&ebt_mutex);
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 2ed7c58b471a..aae5fd51dfd7 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1045,7 +1045,6 @@ __do_replace(struct net *net, const char *name, unsigned int valid_hooks,
 	struct xt_counters *counters;
 	struct ipt_entry *iter;
 
-	ret = 0;
 	counters = xt_counters_alloc(num_counters);
 	if (!counters) {
 		ret = -ENOMEM;
@@ -1091,7 +1090,7 @@ __do_replace(struct net *net, const char *name, unsigned int valid_hooks,
 		net_warn_ratelimited("iptables: counters copy to user failed while replacing table\n");
 	}
 	vfree(counters);
-	return ret;
+	return 0;
 
  put_module:
 	module_put(t->me);
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 2d816277f2c5..ac902f7bca47 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1062,7 +1062,6 @@ __do_replace(struct net *net, const char *name, unsigned int valid_hooks,
 	struct xt_counters *counters;
 	struct ip6t_entry *iter;
 
-	ret = 0;
 	counters = xt_counters_alloc(num_counters);
 	if (!counters) {
 		ret = -ENOMEM;
@@ -1108,7 +1107,7 @@ __do_replace(struct net *net, const char *name, unsigned int valid_hooks,
 		net_warn_ratelimited("ip6tables: counters copy to user failed while replacing table\n");
 	}
 	vfree(counters);
-	return ret;
+	return 0;
 
  put_module:
 	module_put(t->me);
-- 
2.39.2

