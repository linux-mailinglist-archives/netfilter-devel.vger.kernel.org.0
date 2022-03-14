Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB424D8AB6
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Mar 2022 18:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiCNRYi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Mar 2022 13:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbiCNRYe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:24:34 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 698E430F79
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Mar 2022 10:23:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id E029362FFE
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Mar 2022 18:21:07 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v3 09/14] netfilter: nft_immediate: cancel register tracking for data destination register
Date:   Mon, 14 Mar 2022 18:23:08 +0100
Message-Id: <20220314172313.63348-10-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220314172313.63348-1-pablo@netfilter.org>
References: <20220314172313.63348-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The immediate expression might clobber existing data on the registers,
cancel register tracking for the destination register.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: no changes

 net/netfilter/nft_immediate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index d0f67d325bdf..b80f7b507349 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -223,6 +223,17 @@ static bool nft_immediate_offload_action(const struct nft_expr *expr)
 	return false;
 }
 
+static bool nft_immediate_reduce(struct nft_regs_track *track,
+				 const struct nft_expr *expr)
+{
+	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+
+	if (priv->dreg != NFT_REG_VERDICT)
+		nft_reg_track_cancel(track, priv->dreg, priv->dlen);
+
+	return false;
+}
+
 static const struct nft_expr_ops nft_imm_ops = {
 	.type		= &nft_imm_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_immediate_expr)),
@@ -233,6 +244,7 @@ static const struct nft_expr_ops nft_imm_ops = {
 	.destroy	= nft_immediate_destroy,
 	.dump		= nft_immediate_dump,
 	.validate	= nft_immediate_validate,
+	.reduce		= nft_immediate_reduce,
 	.offload	= nft_immediate_offload,
 	.offload_action	= nft_immediate_offload_action,
 };
-- 
2.30.2

