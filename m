Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405793BC2A8
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Jul 2021 20:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhGESdS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Jul 2021 14:33:18 -0400
Received: from mail.netfilter.org ([217.70.188.207]:48490 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhGESdS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:33:18 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1165461653
        for <netfilter-devel@vger.kernel.org>; Mon,  5 Jul 2021 20:30:30 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 1/2] netfilter: nft_last: honor NFTA_LAST_SET on restoration
Date:   Mon,  5 Jul 2021 20:30:36 +0200
Message-Id: <20210705183037.10815-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

NFTA_LAST_SET tells us if this expression has ever seen a packet, do not
ignore this attribute when restoring the ruleset.

Fixes: 836382dc2471 ("netfilter: nf_tables: add last expression")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_last.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_last.c b/net/netfilter/nft_last.c
index 913ac45167f2..bbb352b64c73 100644
--- a/net/netfilter/nft_last.c
+++ b/net/netfilter/nft_last.c
@@ -23,15 +23,21 @@ static int nft_last_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 {
 	struct nft_last_priv *priv = nft_expr_priv(expr);
 	u64 last_jiffies;
+	u32 last_set = 0;
 	int err;
 
-	if (tb[NFTA_LAST_MSECS]) {
+	if (tb[NFTA_LAST_SET]) {
+		last_set = ntohl(nla_get_be32(tb[NFTA_LAST_SET]));
+		if (last_set == 1)
+			priv->last_set = 1;
+	}
+
+	if (last_set && tb[NFTA_LAST_MSECS]) {
 		err = nf_msecs_to_jiffies64(tb[NFTA_LAST_MSECS], &last_jiffies);
 		if (err < 0)
 			return err;
 
 		priv->last_jiffies = jiffies + (unsigned long)last_jiffies;
-		priv->last_set = 1;
 	}
 
 	return 0;
-- 
2.20.1

