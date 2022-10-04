Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C65F4CC6
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Oct 2022 01:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJDXqL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Oct 2022 19:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiJDXpo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:45:44 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B943205ED
        for <netfilter-devel@vger.kernel.org>; Tue,  4 Oct 2022 16:45:06 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/2] evaluate: datatype memleak after binop transfer
Date:   Wed,  5 Oct 2022 01:44:42 +0200
Message-Id: <20221004234442.779257-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221004234442.779257-1-pablo@netfilter.org>
References: <20221004234442.779257-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The following ruleset:

	ip version vmap { 4 : jump t3, 6 : jump t4 }

results in a memleak.

expr_evaluate_shift() overrides the datatype which results in a datatype
memleak after the binop transfer that triggers a left-shift of the
constant (in the map).

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 2e2b8df0f004..0bf6a0d1b110 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1189,7 +1189,6 @@ static int expr_evaluate_shift(struct eval_ctx *ctx, struct expr **expr)
 	if (byteorder_conversion(ctx, &op->right, BYTEORDER_HOST_ENDIAN) < 0)
 		return -1;
 
-	op->dtype     = &integer_type;
 	op->byteorder = BYTEORDER_HOST_ENDIAN;
 	op->len       = left->len;
 
-- 
2.30.2

