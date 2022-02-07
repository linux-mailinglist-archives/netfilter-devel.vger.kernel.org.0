Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C464ABFFE
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Feb 2022 14:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381204AbiBGNt0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Feb 2022 08:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379192AbiBGN2b (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:28:31 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99288C043181
        for <netfilter-devel@vger.kernel.org>; Mon,  7 Feb 2022 05:28:30 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nH44D-000796-3t; Mon, 07 Feb 2022 14:28:29 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 2/3] parser_json: fix flowtable device datatype
Date:   Mon,  7 Feb 2022 14:28:15 +0100
Message-Id: <20220207132816.21129-3-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207132816.21129-1-fw@strlen.de>
References: <20220207132816.21129-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Failed with: BUG: invalid expresion type symbol

Fixes: 78bbe7f7a55be489 ("mnl: do not use expr->identifier to fetch device name")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/parser_json.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/parser_json.c b/src/parser_json.c
index f07b798adecd..2ab0196461e2 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -3125,7 +3125,9 @@ static struct expr *json_parse_flowtable_devs(struct json_ctx *ctx,
 	size_t index;
 
 	if (!json_unpack(root, "s", &dev)) {
-		tmp = symbol_expr_alloc(int_loc, SYMBOL_VALUE, NULL, dev);
+		tmp = constant_expr_alloc(int_loc, &string_type,
+					  BYTEORDER_HOST_ENDIAN,
+					  strlen(dev) * BITS_PER_BYTE, dev);
 		compound_expr_add(expr, tmp);
 		return expr;
 	}
@@ -3141,7 +3143,9 @@ static struct expr *json_parse_flowtable_devs(struct json_ctx *ctx,
 			expr_free(expr);
 			return NULL;
 		}
-		tmp = symbol_expr_alloc(int_loc, SYMBOL_VALUE, NULL, dev);
+		tmp = constant_expr_alloc(int_loc, &string_type,
+					  BYTEORDER_HOST_ENDIAN,
+					  strlen(dev) * BITS_PER_BYTE, dev);
 		compound_expr_add(expr, tmp);
 	}
 	return expr;
-- 
2.34.1

