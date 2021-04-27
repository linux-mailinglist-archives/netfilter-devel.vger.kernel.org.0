Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711A436C91C
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Apr 2021 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhD0QQn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 27 Apr 2021 12:16:43 -0400
Received: from mail.netfilter.org ([217.70.188.207]:53596 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbhD0QMC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:12:02 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id F2F9764137
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Apr 2021 18:10:10 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/5,v2] netfilter: nftables: add loop check helper function
Date:   Tue, 27 Apr 2021 18:10:40 +0200
Message-Id: <20210427161043.57022-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210427161043.57022-1-pablo@netfilter.org>
References: <20210427161043.57022-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds nft_check_loops() to reuse it in the new catch-all
element codebase.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes

 net/netfilter/nf_tables_api.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d66be7d8f3e5..502240fbb087 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8626,26 +8626,38 @@ EXPORT_SYMBOL_GPL(nft_chain_validate_hooks);
 static int nf_tables_check_loops(const struct nft_ctx *ctx,
 				 const struct nft_chain *chain);
 
+static int nft_check_loops(const struct nft_ctx *ctx,
+			   const struct nft_set_ext *ext)
+{
+	const struct nft_data *data;
+	int ret;
+
+	data = nft_set_ext_data(ext);
+	switch (data->verdict.code) {
+	case NFT_JUMP:
+	case NFT_GOTO:
+		ret = nf_tables_check_loops(ctx, data->verdict.chain);
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
 static int nf_tables_loop_check_setelem(const struct nft_ctx *ctx,
 					struct nft_set *set,
 					const struct nft_set_iter *iter,
 					struct nft_set_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
-	const struct nft_data *data;
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_FLAGS) &&
 	    *nft_set_ext_flags(ext) & NFT_SET_ELEM_INTERVAL_END)
 		return 0;
 
-	data = nft_set_ext_data(ext);
-	switch (data->verdict.code) {
-	case NFT_JUMP:
-	case NFT_GOTO:
-		return nf_tables_check_loops(ctx, data->verdict.chain);
-	default:
-		return 0;
-	}
+	return nft_check_loops(ctx, ext);
 }
 
 static int nf_tables_check_loops(const struct nft_ctx *ctx,
-- 
2.30.2

