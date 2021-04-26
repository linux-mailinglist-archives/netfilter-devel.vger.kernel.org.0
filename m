Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5546836AA37
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Apr 2021 03:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhDZBPF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Apr 2021 21:15:05 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49718 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDZBPF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:15:05 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id F354B63E72
        for <netfilter-devel@vger.kernel.org>; Mon, 26 Apr 2021 03:13:47 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 3/4] netfilter: nftables: add helper function to flush set elements
Date:   Mon, 26 Apr 2021 03:14:17 +0200
Message-Id: <20210426011418.69330-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210426011418.69330-1-pablo@netfilter.org>
References: <20210426011418.69330-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds nft_set_flush() which prepares for the catch-all
element support.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 502240fbb087..a8b226ef570c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5869,6 +5869,18 @@ static int nft_flush_set(const struct nft_ctx *ctx,
 	return err;
 }
 
+static int nft_set_flush(struct nft_ctx *ctx, struct nft_set *set, u8 genmask)
+{
+	struct nft_set_iter iter = {
+		.genmask	= genmask,
+		.fn		= nft_flush_set,
+	};
+
+	set->ops->walk(ctx, set, &iter);
+
+	return iter.err;
+}
+
 static int nf_tables_delsetelem(struct sk_buff *skb,
 				const struct nfnl_info *info,
 				const struct nlattr * const nla[])
@@ -5892,14 +5904,10 @@ static int nf_tables_delsetelem(struct sk_buff *skb,
 	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
 		return -EBUSY;
 
-	if (nla[NFTA_SET_ELEM_LIST_ELEMENTS] == NULL) {
-		struct nft_set_iter iter = {
-			.genmask	= genmask,
-			.fn		= nft_flush_set,
-		};
-		set->ops->walk(&ctx, set, &iter);
-
-		return iter.err;
+	if (!nla[NFTA_SET_ELEM_LIST_ELEMENTS]) {
+		err = nft_set_flush(&ctx, set, genmask);
+		if (err < 0)
+			return err;
 	}
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
-- 
2.30.2

