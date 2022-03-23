Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9A4E5311
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Mar 2022 14:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiCWNYt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Mar 2022 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbiCWNYs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:24:48 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6F24F16
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Mar 2022 06:23:15 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nX0xF-00017I-K0; Wed, 23 Mar 2022 14:23:13 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v3 16/16] netfilter: conntrack: avoid unconditional local_bh_disable
Date:   Wed, 23 Mar 2022 14:22:14 +0100
Message-Id: <20220323132214.6700-17-fw@strlen.de>
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

Now that the conntrack entry isn't placed on the pcpu list anymore the
bh only needs to be disabled in the 'expectation present' case.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index c8d58d6d5b87..6e59a35a29b9 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1739,10 +1739,9 @@ init_conntrack(struct net *net, struct nf_conn *tmpl,
 				 ecache ? ecache->expmask : 0,
 			     GFP_ATOMIC);
 
-	local_bh_disable();
 	cnet = nf_ct_pernet(net);
 	if (cnet->expect_count) {
-		spin_lock(&nf_conntrack_expect_lock);
+		spin_lock_bh(&nf_conntrack_expect_lock);
 		exp = nf_ct_find_expectation(net, zone, tuple);
 		if (exp) {
 			pr_debug("expectation arrives ct=%p exp=%p\n",
@@ -1765,7 +1764,7 @@ init_conntrack(struct net *net, struct nf_conn *tmpl,
 #endif
 			NF_CT_STAT_INC(net, expect_new);
 		}
-		spin_unlock(&nf_conntrack_expect_lock);
+		spin_unlock_bh(&nf_conntrack_expect_lock);
 	}
 	if (!exp)
 		__nf_ct_try_assign_helper(ct, tmpl, GFP_ATOMIC);
@@ -1773,8 +1772,6 @@ init_conntrack(struct net *net, struct nf_conn *tmpl,
 	/* Now it is going to be associated with an sk_buff, set refcount to 1. */
 	refcount_set(&ct->ct_general.use, 1);
 
-	local_bh_enable();
-
 	if (exp) {
 		if (exp->expectfn)
 			exp->expectfn(ct, exp);
-- 
2.34.1

