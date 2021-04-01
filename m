Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E63F3518CD
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Apr 2021 19:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhDARrk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Apr 2021 13:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbhDARls (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:41:48 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32DAC0A88A9
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Apr 2021 07:11:27 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lRy2g-0001be-EH; Thu, 01 Apr 2021 16:11:26 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 01/11] netfilter: nfnetlink: add and use nfnetlink_broadcast
Date:   Thu,  1 Apr 2021 16:11:04 +0200
Message-Id: <20210401141114.24712-2-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210401141114.24712-1-fw@strlen.de>
References: <20210401141114.24712-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This removes the only reference of net->nfnl outside of the nfnetlink
module.  This allows to move net->nfnl to net_generic infra.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter/nfnetlink.h | 2 ++
 net/netfilter/nfnetlink.c           | 7 +++++++
 net/netfilter/nfnetlink_acct.c      | 3 +--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index 791d516e1e88..d4c14257db5d 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -51,6 +51,8 @@ int nfnetlink_send(struct sk_buff *skb, struct net *net, u32 portid,
 		   unsigned int group, int echo, gfp_t flags);
 int nfnetlink_set_err(struct net *net, u32 portid, u32 group, int error);
 int nfnetlink_unicast(struct sk_buff *skb, struct net *net, u32 portid);
+void nfnetlink_broadcast(struct net *net, struct sk_buff *skb, __u32 portid,
+			 __u32 group, gfp_t allocation);
 
 static inline u16 nfnl_msg_type(u8 subsys, u8 msg_type)
 {
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index d3df66a39b5e..06e106b3ed85 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -178,6 +178,13 @@ int nfnetlink_unicast(struct sk_buff *skb, struct net *net, u32 portid)
 }
 EXPORT_SYMBOL_GPL(nfnetlink_unicast);
 
+void nfnetlink_broadcast(struct net *net, struct sk_buff *skb, __u32 portid,
+			 __u32 group, gfp_t allocation)
+{
+	netlink_broadcast(net->nfnl, skb, portid, group, allocation);
+}
+EXPORT_SYMBOL_GPL(nfnetlink_broadcast);
+
 /* Process one complete nfnetlink message. */
 static int nfnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
diff --git a/net/netfilter/nfnetlink_acct.c b/net/netfilter/nfnetlink_acct.c
index bb930f3b06c7..6895f31c5fbb 100644
--- a/net/netfilter/nfnetlink_acct.c
+++ b/net/netfilter/nfnetlink_acct.c
@@ -469,8 +469,7 @@ static void nfnl_overquota_report(struct net *net, struct nf_acct *nfacct)
 		kfree_skb(skb);
 		return;
 	}
-	netlink_broadcast(net->nfnl, skb, 0, NFNLGRP_ACCT_QUOTA,
-			  GFP_ATOMIC);
+	nfnetlink_broadcast(net, skb, 0, NFNLGRP_ACCT_QUOTA, GFP_ATOMIC);
 }
 
 int nfnl_acct_overquota(struct net *net, struct nf_acct *nfacct)
-- 
2.26.3

