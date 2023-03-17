Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A826BE60C
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Mar 2023 10:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCQJ6l (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Mar 2023 05:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCQJ6k (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:58:40 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 273D6D308
        for <netfilter-devel@vger.kernel.org>; Fri, 17 Mar 2023 02:58:39 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/9] evaluate: insert byte-order conversions for expressions between 9 and 15 bits
Date:   Fri, 17 Mar 2023 10:58:25 +0100
Message-Id: <20230317095833.1225401-2-pablo@netfilter.org>
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

From: Jeremy Sowden <jeremy@azazel.net>

Round up expression lengths when determining whether to insert a
byte-order conversion.  For example, if one is masking a network header
which spans a byte boundary, the mask will span two bytes and so it will
need to be in NBO.

Fixes: bb03cbcd18a1 ("evaluate: no need to swap byte-order for values of fewer than 16 bits.")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index edc3c5cb04f3..21d360493ceb 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -193,7 +193,7 @@ static int byteorder_conversion(struct eval_ctx *ctx, struct expr **expr,
 				  byteorder_names[(*expr)->byteorder]);
 	}
 
-	if (expr_is_constant(*expr) || (*expr)->len / BITS_PER_BYTE < 2)
+	if (expr_is_constant(*expr) || div_round_up((*expr)->len, BITS_PER_BYTE) < 2)
 		(*expr)->byteorder = byteorder;
 	else {
 		op = byteorder_conversion_op(*expr, byteorder);
-- 
2.30.2

