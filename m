Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DEC6BE611
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Mar 2023 10:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCQJ6o (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Mar 2023 05:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCQJ6m (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:58:42 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6078DCA34
        for <netfilter-devel@vger.kernel.org>; Fri, 17 Mar 2023 02:58:41 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 5/9] evaluate: get length from statement instead of lhs expression
Date:   Fri, 17 Mar 2023 10:58:29 +0100
Message-Id: <20230317095833.1225401-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230317095833.1225401-1-pablo@netfilter.org>
References: <20230317095833.1225401-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Get length from statement, instead infering it from the expression that
is used to set the value. In the particular case of {ct|meta} mark, this
is 32 bits.

Otherwise, bytecode generation is not correct:

 # nft -c --debug=netlink 'add rule ip6 x y ct mark set ip6 dscp << 2 | 0x10'
  [ payload load 2b @ network header + 0 => reg 1 ]
  [ bitwise reg 1 = ( reg 1 & 0x0000c00f ) ^ 0x00000000 ]
  [ bitwise reg 1 = ( reg 1 >> 0x00000006 ) ]
  [ byteorder reg 1 = ntoh(reg 1, 2, 1) ]
  [ bitwise reg 1 = ( reg 1 << 0x00000002 ) ]
  [ bitwise reg 1 = ( reg 1 & 0x00000fef ) ^ 0x00000010 ]    <--- incorrect!
  [ ct set mark with reg 1 ]

the previous bitwise shift already upgraded to 32-bits (not visible from
the netlink debug output above).

After this patch, the last | 0x10 uses 32-bits:

 [ bitwise reg 1 = ( reg 1 & 0xffffffef ) ^ 0x00000010 ]

note that mask 0xffffffef is used instead of 0x00000fef.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 6d61cdb25f3d..2a679c90a3ac 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1324,7 +1324,7 @@ static int expr_evaluate_bitwise(struct eval_ctx *ctx, struct expr **expr)
 
 	op->dtype     = left->dtype;
 	op->byteorder = left->byteorder;
-	op->len	      = left->len;
+	op->len	      = ctx->ectx.len;
 
 	if (expr_is_constant(left))
 		return constant_binop_simplify(ctx, expr);
-- 
2.30.2

