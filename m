Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4124E5308
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Mar 2022 14:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbiCWNYS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Mar 2022 09:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbiCWNYS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:24:18 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CE3403E1
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Mar 2022 06:22:49 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nX0wp-00015g-Jf; Wed, 23 Mar 2022 14:22:47 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v3 09/16] netfilter: nfnetlink_cttimeout: use rcu protection in cttimeout_get_timeout
Date:   Wed, 23 Mar 2022 14:22:07 +0100
Message-Id: <20220323132214.6700-10-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220323132214.6700-1-fw@strlen.de>
References: <20220323132214.6700-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I'd like to be able to switch lifetime management of ctnl_timeout
to free-on-zero-refcount.

This isn't possible at the moment because removal of the structures
from the pernet list requires the nfnl mutex and release may happen from
softirq.

Current solution is to prevent this by disallowing policy object removal
if the refcount is > 1 (i.e., policy is still referenced from the ruleset).

Switch traversal to rcu-read-lock as a first step to reduce reliance on
nfnl mutex protection: removal from softirq would require a extra list
spinlock.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nfnetlink_cttimeout.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index eea486f32971..aef2547bb579 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -253,6 +253,7 @@ static int cttimeout_get_timeout(struct sk_buff *skb,
 				 const struct nlattr * const cda[])
 {
 	struct nfct_timeout_pernet *pernet = nfct_timeout_pernet(info->net);
+	struct sk_buff *skb2;
 	int ret = -ENOENT;
 	char *name;
 	struct ctnl_timeout *cur;
@@ -268,31 +269,31 @@ static int cttimeout_get_timeout(struct sk_buff *skb,
 		return -EINVAL;
 	name = nla_data(cda[CTA_TIMEOUT_NAME]);
 
-	list_for_each_entry(cur, &pernet->nfct_timeout_list, head) {
-		struct sk_buff *skb2;
+	skb2 = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb2)
+		return -ENOMEM;
+
+	rcu_read_lock();
 
+	list_for_each_entry_rcu(cur, &pernet->nfct_timeout_list, head) {
 		if (strncmp(cur->name, name, CTNL_TIMEOUT_NAME_MAX) != 0)
 			continue;
 
-		skb2 = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-		if (skb2 == NULL) {
-			ret = -ENOMEM;
-			break;
-		}
-
 		ret = ctnl_timeout_fill_info(skb2, NETLINK_CB(skb).portid,
 					     info->nlh->nlmsg_seq,
 					     NFNL_MSG_TYPE(info->nlh->nlmsg_type),
 					     IPCTNL_MSG_TIMEOUT_NEW, cur);
-		if (ret <= 0) {
-			kfree_skb(skb2);
+		if (ret <= 0)
 			break;
-		}
 
-		ret = nfnetlink_unicast(skb2, info->net, NETLINK_CB(skb).portid);
-		break;
+		rcu_read_unlock();
+
+		return nfnetlink_unicast(skb2, info->net, NETLINK_CB(skb).portid);
 	}
 
+	rcu_read_unlock();
+	kfree_skb(skb2);
+
 	return ret;
 }
 
-- 
2.34.1

