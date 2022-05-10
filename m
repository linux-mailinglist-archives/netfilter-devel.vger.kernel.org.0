Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02E65225E5
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 May 2022 22:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiEJUxl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 May 2022 16:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiEJUxk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 May 2022 16:53:40 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9485A145
        for <netfilter-devel@vger.kernel.org>; Tue, 10 May 2022 13:53:38 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1noWrP-0007Ml-PZ; Tue, 10 May 2022 22:53:35 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: conntrack: do not disable bh during destruction
Date:   Tue, 10 May 2022 22:53:24 +0200
Message-Id: <20220510205324.10160-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
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

After commit
12b0b21dc2241 ("netfilter: conntrack: remove unconfirmed list")
the extra local_bh disable/enable pair is no longer needed.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 0db9c5c94b5b..082a2fd8d85b 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -596,7 +596,6 @@ void nf_ct_destroy(struct nf_conntrack *nfct)
 	if (unlikely(nf_ct_protonum(ct) == IPPROTO_GRE))
 		destroy_gre_conntrack(ct);
 
-	local_bh_disable();
 	/* Expectations will have been removed in clean_from_lists,
 	 * except TFTP can create an expectation on the first packet,
 	 * before connection is in the list, so we need to clean here,
@@ -604,8 +603,6 @@ void nf_ct_destroy(struct nf_conntrack *nfct)
 	 */
 	nf_ct_remove_expectations(ct);
 
-	local_bh_enable();
-
 	if (ct->master)
 		nf_ct_put(ct->master);
 
-- 
2.35.1

