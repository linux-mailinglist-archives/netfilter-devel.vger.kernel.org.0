Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C2A557C72
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jun 2022 15:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiFWNFd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jun 2022 09:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiFWNFb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:05:31 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DE640E45
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Jun 2022 06:05:30 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1o4MWW-0005Ye-Mr; Thu, 23 Jun 2022 15:05:28 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 1/6] netfilter: nfnetlink: add missing __be16 cast
Date:   Thu, 23 Jun 2022 15:05:09 +0200
Message-Id: <20220623130514.13775-2-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623130514.13775-1-fw@strlen.de>
References: <20220623130514.13775-1-fw@strlen.de>
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

Sparse flags this as suspicious, because this compares
integer with a be16 with no conversion.

Its a compat check for old userspace that sends host byte order,
so force a be16 cast here.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nfnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index 2f7c477fc9e7..c24b1240908f 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -626,7 +626,7 @@ static void nfnetlink_rcv_skb_batch(struct sk_buff *skb, struct nlmsghdr *nlh)
 	nfgenmsg = nlmsg_data(nlh);
 	skb_pull(skb, msglen);
 	/* Work around old nft using host byte order */
-	if (nfgenmsg->res_id == NFNL_SUBSYS_NFTABLES)
+	if (nfgenmsg->res_id == (__force __be16)NFNL_SUBSYS_NFTABLES)
 		res_id = NFNL_SUBSYS_NFTABLES;
 	else
 		res_id = ntohs(nfgenmsg->res_id);
-- 
2.35.1

