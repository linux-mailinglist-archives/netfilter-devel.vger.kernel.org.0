Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5164886B0
	for <lists+netfilter-devel@lfdr.de>; Sat,  8 Jan 2022 23:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiAHW0u (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 8 Jan 2022 17:26:50 -0500
Received: from mail.netfilter.org ([217.70.188.207]:40126 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiAHW0s (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 8 Jan 2022 17:26:48 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id AA94B6428E
        for <netfilter-devel@vger.kernel.org>; Sat,  8 Jan 2022 23:23:59 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 10/14] netfilter: nft_payload: track register operations
Date:   Sat,  8 Jan 2022 23:26:34 +0100
Message-Id: <20220108222638.36037-11-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108222638.36037-1-pablo@netfilter.org>
References: <20220108222638.36037-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Check if the destination register already contains the data that this
payload store expression performs. This allows to skip this redundant
operation. If the destination contains a different selector, update
the register tracking information.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_payload.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index b9d636c706f4..b228fea0f263 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -210,6 +210,34 @@ static int nft_payload_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	return -1;
 }
 
+static bool nft_payload_reduce(struct nft_regs_track *track,
+			       const struct nft_expr *expr)
+{
+	const struct nft_payload *priv = nft_expr_priv(expr);
+	const struct nft_payload *payload;
+
+	if (!track->regs[priv->dreg].selector ||
+	    track->regs[priv->dreg].selector->ops != expr->ops) {
+		track->regs[priv->dreg].selector = expr;
+		track->regs[priv->dreg].bitwise = NULL;
+		return false;
+	}
+
+	payload = nft_expr_priv(track->regs[priv->dreg].selector);
+	if (priv->base != payload->base ||
+	    priv->offset != payload->offset ||
+	    priv->len != payload->len) {
+		track->regs[priv->dreg].selector = expr;
+		track->regs[priv->dreg].bitwise = NULL;
+		return false;
+	}
+
+	if (!track->regs[priv->dreg].bitwise)
+		return true;
+
+	return false;
+}
+
 static bool nft_payload_offload_mask(struct nft_offload_reg *reg,
 				     u32 priv_len, u32 field_len)
 {
@@ -513,6 +541,7 @@ static const struct nft_expr_ops nft_payload_ops = {
 	.eval		= nft_payload_eval,
 	.init		= nft_payload_init,
 	.dump		= nft_payload_dump,
+	.reduce		= nft_payload_reduce,
 	.offload	= nft_payload_offload,
 };
 
@@ -522,6 +551,7 @@ const struct nft_expr_ops nft_payload_fast_ops = {
 	.eval		= nft_payload_eval,
 	.init		= nft_payload_init,
 	.dump		= nft_payload_dump,
+	.reduce		= nft_payload_reduce,
 	.offload	= nft_payload_offload,
 };
 
-- 
2.30.2

