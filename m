Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B286F817A
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 May 2023 13:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjEELRX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 May 2023 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjEELRP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 May 2023 07:17:15 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00861A4B1
        for <netfilter-devel@vger.kernel.org>; Fri,  5 May 2023 04:17:14 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1putR3-0005Rb-8T; Fri, 05 May 2023 13:17:13 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 3/3] netfilter: nf_tables: don't initialize registers in nft_do_chain()
Date:   Fri,  5 May 2023 13:16:56 +0200
Message-Id: <20230505111656.32238-4-fw@strlen.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505111656.32238-1-fw@strlen.de>
References: <20230505111656.32238-1-fw@strlen.de>
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

This reverts commit 4c905f6740a3 ("netfilter: nf_tables: initialize registers in nft_do_chain()").
Previous patch makes sure that loads from uninitialized registers are
rejected from the control plane, so this zeroing isn't needed anymore.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 4d0ce12221f6..b917cf00dda7 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -256,7 +256,7 @@ nft_do_chain(struct nft_pktinfo *pkt, void *priv)
 	const struct net *net = nft_net(pkt);
 	const struct nft_expr *expr, *last;
 	const struct nft_rule_dp *rule;
-	struct nft_regs regs = {};
+	struct nft_regs regs;
 	unsigned int stackptr = 0;
 	struct nft_jumpstack jumpstack[NFT_JUMP_STACK_SIZE];
 	bool genbit = READ_ONCE(net->nft.gencursor);
-- 
2.39.2

