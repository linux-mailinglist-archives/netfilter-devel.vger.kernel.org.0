Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67C4699DAC
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Feb 2023 21:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBPU1v (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Feb 2023 15:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBPU1u (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:27:50 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B597210CF
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Feb 2023 12:27:48 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     ffmancera@riseup.net
Subject: [PATCH nft] src: use start condition with new destroy command
Date:   Thu, 16 Feb 2023 21:27:44 +0100
Message-Id: <20230216202744.448107-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

tests/py reports the following problem:

any/ct.t: ERROR: line 116: add rule ip test-ip4 output ct event set new | related | destroy | label: This rule should not have failed.
any/ct.t: ERROR: line 117: add rule ip test-ip4 output ct event set new,related,destroy,label: This rule should not have failed.
any/ct.t: ERROR: line 118: add rule ip test-ip4 output ct event set new,destroy: This rule should not have failed.

Use start condition and update parser to handle 'destroy' keyword.

Fixes: e1dfd5cc4c46 ("src: add support to command "destroy")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/parser.h   | 1 +
 src/parser_bison.y | 2 ++
 src/scanner.l      | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/parser.h b/include/parser.h
index 1bd490f085d2..71df43093204 100644
--- a/include/parser.h
+++ b/include/parser.h
@@ -52,6 +52,7 @@ enum startcond_type {
 	PARSER_SC_TYPE,
 	PARSER_SC_VLAN,
 	PARSER_SC_XT,
+	PARSER_SC_CMD_DESTROY,
 	PARSER_SC_CMD_EXPORT,
 	PARSER_SC_CMD_IMPORT,
 	PARSER_SC_CMD_LIST,
diff --git a/src/parser_bison.y b/src/parser_bison.y
index b229de7a5cf7..043909d082ca 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -969,6 +969,7 @@ close_scope_comp	: { scanner_pop_start_cond(nft->scanner, PARSER_SC_EXPR_COMP);
 close_scope_ct		: { scanner_pop_start_cond(nft->scanner, PARSER_SC_CT); };
 close_scope_counter	: { scanner_pop_start_cond(nft->scanner, PARSER_SC_COUNTER); };
 close_scope_dccp	: { scanner_pop_start_cond(nft->scanner, PARSER_SC_EXPR_DCCP); };
+close_scope_destroy	: { scanner_pop_start_cond(nft->scanner, PARSER_SC_CMD_DESTROY); };
 close_scope_dst		: { scanner_pop_start_cond(nft->scanner, PARSER_SC_EXPR_DST); };
 close_scope_dup		: { scanner_pop_start_cond(nft->scanner, PARSER_SC_STMT_DUP); };
 close_scope_esp		: { scanner_pop_start_cond(nft->scanner, PARSER_SC_EXPR_ESP); };
@@ -4912,6 +4913,7 @@ keyword_expr		:	ETHER   close_scope_eth { $$ = symbol_value(&@$, "ether"); }
 			|	SNAT	close_scope_nat	{ $$ = symbol_value(&@$, "snat"); }
 			|	ECN			{ $$ = symbol_value(&@$, "ecn"); }
 			|	RESET	close_scope_reset	{ $$ = symbol_value(&@$, "reset"); }
+			|	DESTROY	close_scope_destroy	{ $$ = symbol_value(&@$, "destroy"); }
 			|	ORIGINAL		{ $$ = symbol_value(&@$, "original"); }
 			|	REPLY			{ $$ = symbol_value(&@$, "reply"); }
 			|	LABEL			{ $$ = symbol_value(&@$, "label"); }
diff --git a/src/scanner.l b/src/scanner.l
index c0c49b97ade7..bc5b5b62b9ce 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -216,6 +216,7 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 %s SCANSTATE_TYPE
 %s SCANSTATE_VLAN
 %s SCANSTATE_XT
+%s SCANSTATE_CMD_DESTROY
 %s SCANSTATE_CMD_EXPORT
 %s SCANSTATE_CMD_IMPORT
 %s SCANSTATE_CMD_LIST
@@ -359,7 +360,8 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 "import"                { scanner_push_start_cond(yyscanner, SCANSTATE_CMD_IMPORT); return IMPORT; }
 "export"		{ scanner_push_start_cond(yyscanner, SCANSTATE_CMD_EXPORT); return EXPORT; }
 "monitor"		{ scanner_push_start_cond(yyscanner, SCANSTATE_CMD_MONITOR); return MONITOR; }
-"destroy"		{ return DESTROY; }
+"destroy"		{ scanner_push_start_cond(yyscanner, SCANSTATE_CMD_DESTROY); return DESTROY; }
+
 
 "position"		{ return POSITION; }
 "index"			{ return INDEX; }
-- 
2.30.2

