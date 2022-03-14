Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426AF4D7904
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Mar 2022 01:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiCNAzl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 13 Mar 2022 20:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiCNAzf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 13 Mar 2022 20:55:35 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1630E1C
        for <netfilter-devel@vger.kernel.org>; Sun, 13 Mar 2022 17:54:26 -0700 (PDT)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id AD86463018
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Mar 2022 01:52:11 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 07/12,v2] netfilter: nft_osf: track register operations
Date:   Mon, 14 Mar 2022 01:54:12 +0100
Message-Id: <20220314005417.315832-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220314005417.315832-1-pablo@netfilter.org>
References: <20220314005417.315832-1-pablo@netfilter.org>
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

Allow to recycle the previous output of the OS fingerprint expression
if flags and ttl are the same.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: use nft_reg_track_cmp()

 net/netfilter/nft_osf.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index d82677e83400..5eed18f90b02 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -120,6 +120,30 @@ static int nft_osf_validate(const struct nft_ctx *ctx,
 						    (1 << NF_INET_FORWARD));
 }
 
+static bool nft_osf_reduce(struct nft_regs_track *track,
+			   const struct nft_expr *expr)
+{
+	struct nft_osf *priv = nft_expr_priv(expr);
+	struct nft_osf *osf;
+
+	if (!nft_reg_track_cmp(track, expr, priv->dreg)) {
+		nft_reg_track_update(track, expr, priv->dreg, NFT_OSF_MAXGENRELEN);
+		return false;
+	}
+
+	osf = nft_expr_priv(track->regs[priv->dreg].selector);
+	if (priv->flags != osf->flags ||
+	    priv->ttl != osf->ttl) {
+		nft_reg_track_update(track, expr, priv->dreg, NFT_OSF_MAXGENRELEN);
+		return false;
+	}
+
+	if (!track->regs[priv->dreg].bitwise)
+		return true;
+
+	return false;
+}
+
 static struct nft_expr_type nft_osf_type;
 static const struct nft_expr_ops nft_osf_op = {
 	.eval		= nft_osf_eval,
@@ -128,6 +152,7 @@ static const struct nft_expr_ops nft_osf_op = {
 	.dump		= nft_osf_dump,
 	.type		= &nft_osf_type,
 	.validate	= nft_osf_validate,
+	.reduce		= nft_osf_reduce,
 };
 
 static struct nft_expr_type nft_osf_type __read_mostly = {
-- 
2.30.2

