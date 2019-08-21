Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713A19761F
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 11:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfHUJ0w (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 05:26:52 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:43784 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfHUJ0w (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:26:52 -0400
Received: from localhost ([::1]:56874 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1i0MtG-00055v-EQ; Wed, 21 Aug 2019 11:26:50 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 11/14] nft: Bore up nft_parse_payload()
Date:   Wed, 21 Aug 2019 11:25:59 +0200
Message-Id: <20190821092602.16292-12-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821092602.16292-1-phil@nwl.cc>
References: <20190821092602.16292-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Allow for closer inspection by storing payload expression's base and
length values. Also facilitate for two consecutive payload expressions
as LHS of a (cmp/lookup) statement as used with concatenations.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-shared.c | 8 ++++++++
 iptables/nft-shared.h | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index d5984d0577ed1..0f8cabf9abcc7 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -445,8 +445,16 @@ static void nft_parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 
 static void nft_parse_payload(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 {
+	if (ctx->flags & NFT_XT_CTX_PAYLOAD) {
+		memcpy(&ctx->prev_payload, &ctx->payload,
+		       sizeof(ctx->prev_payload));
+		ctx->flags |= NFT_XT_CTX_PREV_PAYLOAD;
+	}
+
 	ctx->reg = nftnl_expr_get_u32(e, NFTNL_EXPR_META_DREG);
+	ctx->payload.base = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_BASE);
 	ctx->payload.offset = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_OFFSET);
+	ctx->payload.len = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_LEN);
 	ctx->flags |= NFT_XT_CTX_PAYLOAD;
 }
 
diff --git a/iptables/nft-shared.h b/iptables/nft-shared.h
index ff3beef1af0de..cb7eea6208cd2 100644
--- a/iptables/nft-shared.h
+++ b/iptables/nft-shared.h
@@ -43,6 +43,7 @@ enum {
 	NFT_XT_CTX_META		= (1 << 1),
 	NFT_XT_CTX_BITWISE	= (1 << 2),
 	NFT_XT_CTX_IMMEDIATE	= (1 << 3),
+	NFT_XT_CTX_PREV_PAYLOAD	= (1 << 4),
 };
 
 struct nft_xt_ctx {
@@ -53,9 +54,10 @@ struct nft_xt_ctx {
 
 	uint32_t reg;
 	struct {
+		uint32_t base;
 		uint32_t offset;
 		uint32_t len;
-	} payload;
+	} payload, prev_payload;
 	struct {
 		uint32_t key;
 	} meta;
-- 
2.22.0

