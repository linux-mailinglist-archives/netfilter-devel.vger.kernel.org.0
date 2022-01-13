Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF3B48D70E
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jan 2022 13:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiAMMCc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 13 Jan 2022 07:02:32 -0500
Received: from mail.netfilter.org ([217.70.188.207]:51674 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiAMMC0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:02:26 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id DEE2D605C2
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Jan 2022 12:59:31 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nft_connlimit: memleak if nf_ct_netns_get() fails
Date:   Thu, 13 Jan 2022 13:02:20 +0100
Message-Id: <20220113120220.378992-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Check if nf_ct_netns_get() fails then release the limit object
previously allocated via kmalloc().

Fixes: 37f319f37d90 ("netfilter: nft_connlimit: move stateful fields out of expression data")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_connlimit.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_connlimit.c b/net/netfilter/nft_connlimit.c
index 7d00a1452b1d..3362417ebfdb 100644
--- a/net/netfilter/nft_connlimit.c
+++ b/net/netfilter/nft_connlimit.c
@@ -62,6 +62,7 @@ static int nft_connlimit_do_init(const struct nft_ctx *ctx,
 {
 	bool invert = false;
 	u32 flags, limit;
+	int err;
 
 	if (!tb[NFTA_CONNLIMIT_COUNT])
 		return -EINVAL;
@@ -84,7 +85,15 @@ static int nft_connlimit_do_init(const struct nft_ctx *ctx,
 	priv->limit	= limit;
 	priv->invert	= invert;
 
-	return nf_ct_netns_get(ctx->net, ctx->family);
+	err = nf_ct_netns_get(ctx->net, ctx->family);
+	if (err < 0)
+		goto err_netns;
+
+	return 0;
+err_netns:
+	kfree(priv->list);
+
+	return err;
 }
 
 static void nft_connlimit_do_destroy(const struct nft_ctx *ctx,
-- 
2.30.2

