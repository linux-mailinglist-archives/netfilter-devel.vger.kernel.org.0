Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3972C17679C
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2020 23:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCBWoe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 17:44:34 -0500
Received: from kadath.azazel.net ([81.187.231.250]:42636 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgCBWoe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GkNBoAaCfiOy1tSeFOFqzvydz3NU9hUze4l+ntnJSzU=; b=fUFPpOPoy6Bk738qgMg3cXQdSK
        PWX4RC2sTIDnfmiaIZWyVn18Yd0FAv1DRT25DcHrMdtU3awSbBi5TURawDF+5J2DyIdVfeQHm4Q6H
        UPSyAAe764GL3Z/yC0wUNSbp3aG/UunpMT68ndG+dILjVEMcyFkwI2PUbbUdZmX+k04Xa2e97n3oO
        SXLJ5beGpT3tNXk3oRCiP5r043jbWZFUQn4BEsz9dJ+5X+TU/NcvDjobidYiIZS8ldpswaQOvVuSH
        XGGEGRgjrn0/tw/Vc+Mc0rt29jRVEfR8d1WxaPuaqVB9PIa5j4305INIH8wskVDA8tStVMxh5Lk6g
        JT2GV+Ig==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j8tPB-0000Sg-LH; Mon, 02 Mar 2020 22:19:17 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 10/18] evaluate: allow boolean binop expressions with variable righthand arguments.
Date:   Mon,  2 Mar 2020 22:19:08 +0000
Message-Id: <20200302221916.1005019-11-jeremy@azazel.net>
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

Hitherto, the kernel has required constant values for the xor and mask
attributes of boolean bitwise expressions.  This has meant that the
righthand argument of a boolean binop must be constant.  Now the kernel
supports passing mask and xor via registers, we can relax this
restriction.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/evaluate.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 4a23b231c74d..1db175007c2d 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1135,7 +1135,7 @@ static int expr_evaluate_bitwise(struct eval_ctx *ctx, struct expr **expr)
 	op->byteorder = left->byteorder;
 	op->len	      = left->len;
 
-	if (expr_is_constant(left))
+	if (expr_is_constant(left) && expr_is_constant(op->right))
 		return constant_binop_simplify(ctx, expr);
 	return 0;
 }
@@ -1179,23 +1179,22 @@ static int expr_evaluate_binop(struct eval_ctx *ctx, struct expr **expr)
 					 "for %s expressions",
 					 sym, expr_name(left));
 
-	if (!expr_is_constant(right))
-		return expr_binary_error(ctx->msgs, right, op,
-					 "Right hand side of binary operation "
-					 "(%s) must be constant", sym);
-
-	if (!expr_is_singleton(right))
-		return expr_binary_error(ctx->msgs, left, op,
-					 "Binary operation (%s) is undefined "
-					 "for %s expressions",
-					 sym, expr_name(right));
-
 	/* The grammar guarantees this */
 	assert(expr_basetype(left) == expr_basetype(right));
 
 	switch (op->op) {
 	case OP_LSHIFT:
 	case OP_RSHIFT:
+		if (!expr_is_constant(right))
+			return expr_binary_error(ctx->msgs, right, op,
+						 "Right hand side of binary operation "
+						 "(%s) must be constant", sym);
+
+		if (!expr_is_singleton(right))
+			return expr_binary_error(ctx->msgs, left, op,
+						 "Binary operation (%s) is undefined "
+						 "for %s expressions",
+						 sym, expr_name(right));
 		return expr_evaluate_shift(ctx, expr);
 	case OP_AND:
 	case OP_XOR:
-- 
2.25.1

