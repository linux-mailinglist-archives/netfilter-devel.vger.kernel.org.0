Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C8E52C1D6
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiERSEn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 14:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbiERSEm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 14:04:42 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F0131AB79D
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 11:04:38 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/3] parser_bison: fix error location for set elements
Date:   Wed, 18 May 2022 20:04:33 +0200
Message-Id: <20220518180435.298462-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

opt_newline causes interfere since it points to the previous line.
Refer to set element key for error reporting.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index ca5c488cd5ff..e03fb35d96c7 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -2915,7 +2915,7 @@ verdict_map_list_expr	:	verdict_map_list_member_expr
 
 verdict_map_list_member_expr:	opt_newline	set_elem_expr	COLON	verdict_expr	opt_newline
 			{
-				$$ = mapping_expr_alloc(&@$, $2, $4);
+				$$ = mapping_expr_alloc(&@2, $2, $4);
 			}
 			;
 
@@ -4263,7 +4263,7 @@ set_list_member_expr	:	opt_newline	set_expr	opt_newline
 			}
 			|	opt_newline	set_elem_expr	COLON	set_rhs_expr	opt_newline
 			{
-				$$ = mapping_expr_alloc(&@$, $2, $4);
+				$$ = mapping_expr_alloc(&@2, $2, $4);
 			}
 			;
 
-- 
2.30.2

