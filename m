Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F6C176796
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2020 23:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCBWoX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 17:44:23 -0500
Received: from kadath.azazel.net ([81.187.231.250]:42564 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBWoX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d3DE9n7HukkhlGkga5/z10hP5uDrQRKAur534w1xi64=; b=KhKxbfF2RE7XaMdm118+6IUFRh
        CcJWO0RL/r5lqT0KlN5Rm16BKG4yGscFksiFLbcJGMhwvBlfYRuXbv68sBa++nOZrCiUMK5YbjXRH
        m3Fx2BF3+jVHKJuRM71itDziILXtdpnq1HCqk6ta6j/9ptzq2hpJ5K8PH2tlQLjea+rzHUeqZTkFC
        Mn1yixEhYGBykRwAg1PM5pY3w/cZ/zQi5zwTns+yujdexihCx9SPTUmESMo62WspG1g5xE1ukS83e
        ffR32HVssVZq2KOs9e5KbjXOOZIxi3efSA7EkJ013nbnjwp8sedkWQq5XK4ORwwhojaXfsmYomIZe
        SoV7/4yw==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j8tPC-0000Sg-Ev; Mon, 02 Mar 2020 22:19:18 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 15/18] netlink_delinearize: add postprocessing for payload binops.
Date:   Mon,  2 Mar 2020 22:19:13 +0000
Message-Id: <20200302221916.1005019-16-jeremy@azazel.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302221916.1005019-1-jeremy@azazel.net>
References: <20200302221916.1005019-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If a user uses a variable payload expression in a payload statement, we
need to undo any munging during delinearization.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/netlink_delinearize.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 571cab1d932b..73faa93c862e 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2125,6 +2125,30 @@ static void relational_binop_postprocess(struct rule_pp_ctx *ctx, struct expr *e
 	}
 }
 
+static bool payload_binop_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
+{
+	struct expr *expr = *exprp;
+
+	if (expr->op != OP_RSHIFT)
+		return false;
+
+	if (expr->left->etype != EXPR_BINOP || expr->left->op != OP_AND)
+		return false;
+
+	if (expr->left->left->etype != EXPR_PAYLOAD)
+		return false;
+
+	expr_set_type(expr->right, &integer_type,
+		      BYTEORDER_HOST_ENDIAN);
+	expr_postprocess(ctx, &expr->right);
+
+	binop_postprocess(ctx, expr);
+	*exprp = expr_get(expr->left);
+	expr_free(expr);
+
+	return true;
+}
+
 static struct expr *string_wildcard_expr_alloc(struct location *loc,
 					       const struct expr *mask,
 					       const struct expr *expr)
@@ -2258,6 +2282,9 @@ static void expr_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
 		expr_set_type(expr, expr->arg->dtype, !expr->arg->byteorder);
 		break;
 	case EXPR_BINOP:
+		if (payload_binop_postprocess(ctx, exprp))
+			break;
+
 		expr_postprocess(ctx, &expr->left);
 		switch (expr->op) {
 		case OP_LSHIFT:
-- 
2.25.1

