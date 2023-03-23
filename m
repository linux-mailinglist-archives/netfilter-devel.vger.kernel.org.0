Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5CB6C6E3E
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Mar 2023 17:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjCWQ7K (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Mar 2023 12:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjCWQ7I (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:59:08 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98773123
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Mar 2023 09:59:07 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     jeremy@azazel.net, fw@strlen.de
Subject: [PATCH nft,v3 05/12] evaluate: set up integer type to shift expression
Date:   Thu, 23 Mar 2023 17:58:48 +0100
Message-Id: <20230323165855.559837-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230323165855.559837-1-pablo@netfilter.org>
References: <20230323165855.559837-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Otherwise expr_evaluate_value() fails with invalid datatype:

 # nft --debug=netlink add rule ip x y 'ct mark set ip dscp & 0x0f << 1'
 BUG: invalid basetype invalid
 nft: evaluate.c:440: expr_evaluate_value: Assertion `0' failed.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 33b1aad72f66..1ee9bdc5aa47 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1308,6 +1308,7 @@ static int expr_evaluate_shift(struct eval_ctx *ctx, struct expr **expr)
 	if (byteorder_conversion(ctx, &op->right, BYTEORDER_HOST_ENDIAN) < 0)
 		return -1;
 
+	op->dtype     = &integer_type;
 	op->byteorder = BYTEORDER_HOST_ENDIAN;
 	op->len	      = max_shift_len;
 
-- 
2.30.2

