Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0383E142097
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Jan 2020 23:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgASW5M (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 Jan 2020 17:57:12 -0500
Received: from kadath.azazel.net ([81.187.231.250]:56578 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgASW5L (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JyEgMHBRJE5J2jQdBCAQWpZmlFyp61Gu5dwsIFD9GdE=; b=AsJQJm2hHdTrojF1jZyiENurG7
        fmMz6tu6LrLJa5kaM2FCkyCoCwtZjKtoa+rq/H2621VaWsX5ZKj0JHOU/3dWs2r+HWrq63bc6Cv3K
        BvwYL62BZ5pOU2ew9XTt4fO0t46YFRT/fRhmxe45kW8uZBjlRuyn7tWIbSMFWA4OGgiXr643rCJBo
        sHbxw+NraraYFMpVc2AijAVsdA0DJ/eldj/x7xmnchbn5ac0yCNsc6ZBH1q0AdpGBjEdgdMnjL0Z2
        riXgTd7d4McJHaWV4e1cJEGuy9R14gkUMeWlwO2510/X04zX6B3wF5ZbVstN7zh5lDyeADXWWOlLg
        5R/9A1sg==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1itJVG-0006wh-NW
        for netfilter-devel@vger.kernel.org; Sun, 19 Jan 2020 22:57:10 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v3 2/9] src: white-space fixes.
Date:   Sun, 19 Jan 2020 22:57:03 +0000
Message-Id: <20200119225710.222976-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119225710.222976-1-jeremy@azazel.net>
References: <20200119225710.222976-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Remove some trailing white-space and fix some indentation.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/evaluate.c            | 11 +++++------
 src/netlink_delinearize.c |  2 +-
 src/netlink_linearize.c   |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 9d5fdaf0ef3e..5bd0858cbee1 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2336,14 +2336,13 @@ static int stmt_evaluate_meta(struct eval_ctx *ctx, struct stmt *stmt)
 static int stmt_evaluate_ct(struct eval_ctx *ctx, struct stmt *stmt)
 {
 	if (stmt_evaluate_arg(ctx, stmt,
-				 stmt->ct.tmpl->dtype,
-				 stmt->ct.tmpl->len,
-				 stmt->ct.tmpl->byteorder,
-				 &stmt->ct.expr) < 0)
+			      stmt->ct.tmpl->dtype,
+			      stmt->ct.tmpl->len,
+			      stmt->ct.tmpl->byteorder,
+			      &stmt->ct.expr) < 0)
 		return -1;
 
-	if (stmt->ct.key == NFT_CT_SECMARK &&
-	    expr_is_constant(stmt->ct.expr))
+	if (stmt->ct.key == NFT_CT_SECMARK && expr_is_constant(stmt->ct.expr))
 		return stmt_error(ctx, stmt,
 				  "ct secmark must not be set to constant value");
 
diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 154353b8161a..387e4b046c6b 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -171,7 +171,7 @@ static void netlink_parse_immediate(struct netlink_parse_ctx *ctx,
 	struct expr *expr;
 
 	if (nftnl_expr_is_set(nle, NFTNL_EXPR_IMM_VERDICT)) {
-		nld.verdict = nftnl_expr_get_u32(nle, NFTNL_EXPR_IMM_VERDICT); 
+		nld.verdict = nftnl_expr_get_u32(nle, NFTNL_EXPR_IMM_VERDICT);
 		if  (nftnl_expr_is_set(nle, NFTNL_EXPR_IMM_CHAIN)) {
 			nld.chain = nftnl_expr_get(nle, NFTNL_EXPR_IMM_CHAIN,
 						   &nld.len);
diff --git a/src/netlink_linearize.c b/src/netlink_linearize.c
index 498326d0087a..d5e177d5e75c 100644
--- a/src/netlink_linearize.c
+++ b/src/netlink_linearize.c
@@ -1243,7 +1243,7 @@ static void netlink_gen_queue_stmt(struct netlink_linearize_ctx *ctx,
 }
 
 static void netlink_gen_ct_stmt(struct netlink_linearize_ctx *ctx,
-				  const struct stmt *stmt)
+				const struct stmt *stmt)
 {
 	struct nftnl_expr *nle;
 	enum nft_registers sreg;
-- 
2.24.1

