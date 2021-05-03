Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45653371493
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 May 2021 13:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhECLwT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 May 2021 07:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhECLwT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 May 2021 07:52:19 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7064FC06174A
        for <netfilter-devel@vger.kernel.org>; Mon,  3 May 2021 04:51:26 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ldX6i-0005IO-CS; Mon, 03 May 2021 13:51:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     syzkaller-bugs@googlegroups.com, Florian Westphal <fw@strlen.de>,
        syzbot+dcccba8a1e41a38cb9df@syzkaller.appspotmail.com
Subject: [PATCH nf] netfilter: arptables: use pernet ops struct during unregister
Date:   Mon,  3 May 2021 13:51:15 +0200
Message-Id: <20210503115115.30856-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Like with iptables and ebtables, hook unregistration has to use the
pernet ops struct, not the template.

This triggered following splat:
  hook not found, pf 3 num 0
  WARNING: CPU: 0 PID: 224 at net/netfilter/core.c:480 __nf_unregister_net_hook+0x1eb/0x610 net/netfilter/core.c:480
[..]
 nf_unregister_net_hook net/netfilter/core.c:502 [inline]
 nf_unregister_net_hooks+0x117/0x160 net/netfilter/core.c:576
 arpt_unregister_table_pre_exit+0x67/0x80 net/ipv4/netfilter/arp_tables.c:1565

Fixes: f9006acc8dfe5 ("netfilter: arp_tables: pass table pointer via nf_hook_ops")
Reported-by: syzbot+dcccba8a1e41a38cb9df@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter_arp/arp_tables.h | 3 +--
 net/ipv4/netfilter/arp_tables.c          | 5 ++---
 net/ipv4/netfilter/arptable_filter.c     | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/netfilter_arp/arp_tables.h b/include/linux/netfilter_arp/arp_tables.h
index 2aab9612f6ab..4f9a4b3c5892 100644
--- a/include/linux/netfilter_arp/arp_tables.h
+++ b/include/linux/netfilter_arp/arp_tables.h
@@ -53,8 +53,7 @@ int arpt_register_table(struct net *net, const struct xt_table *table,
 			const struct arpt_replace *repl,
 			const struct nf_hook_ops *ops);
 void arpt_unregister_table(struct net *net, const char *name);
-void arpt_unregister_table_pre_exit(struct net *net, const char *name,
-				    const struct nf_hook_ops *ops);
+void arpt_unregister_table_pre_exit(struct net *net, const char *name);
 extern unsigned int arpt_do_table(struct sk_buff *skb,
 				  const struct nf_hook_state *state,
 				  struct xt_table *table);
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index cf20316094d0..c53f14b94356 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -1556,13 +1556,12 @@ int arpt_register_table(struct net *net,
 	return ret;
 }
 
-void arpt_unregister_table_pre_exit(struct net *net, const char *name,
-				    const struct nf_hook_ops *ops)
+void arpt_unregister_table_pre_exit(struct net *net, const char *name)
 {
 	struct xt_table *table = xt_find_table(net, NFPROTO_ARP, name);
 
 	if (table)
-		nf_unregister_net_hooks(net, ops, hweight32(table->valid_hooks));
+		nf_unregister_net_hooks(net, table->ops, hweight32(table->valid_hooks));
 }
 EXPORT_SYMBOL(arpt_unregister_table_pre_exit);
 
diff --git a/net/ipv4/netfilter/arptable_filter.c b/net/ipv4/netfilter/arptable_filter.c
index b8f45e9bbec8..6922612df456 100644
--- a/net/ipv4/netfilter/arptable_filter.c
+++ b/net/ipv4/netfilter/arptable_filter.c
@@ -54,7 +54,7 @@ static int __net_init arptable_filter_table_init(struct net *net)
 
 static void __net_exit arptable_filter_net_pre_exit(struct net *net)
 {
-	arpt_unregister_table_pre_exit(net, "filter", arpfilter_ops);
+	arpt_unregister_table_pre_exit(net, "filter");
 }
 
 static void __net_exit arptable_filter_net_exit(struct net *net)
-- 
2.26.3

