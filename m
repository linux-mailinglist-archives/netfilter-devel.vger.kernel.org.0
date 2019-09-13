Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEA1B236A
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2019 17:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfIMPce (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Sep 2019 11:32:34 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:43842 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfIMPce (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:32:34 -0400
Received: from localhost ([::1]:56932 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1i8nYl-0000Ke-SP; Fri, 13 Sep 2019 17:32:31 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] parser_bison: Fix 'exists' keyword on Big Endian
Date:   Fri, 13 Sep 2019 17:32:24 +0200
Message-Id: <20190913153224.486-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Size value passed to constant_expr_alloc() must correspond with actual
data size, otherwise wrong portion of data will be taken later when
serializing into netlink message.

Booleans require really just a bit, but make type of boolean_keys be
uint8_t (introducing new 'val8' name for it) and pass the data length
using sizeof() to avoid any magic numbers.

While being at it, fix len value in parser_json.c as well although it
worked before due to the value being rounded up to the next multiple of
8.

Fixes: 9fd9baba43c8e ("Introduce boolean datatype and boolean expression")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/parser_bison.y | 5 +++--
 src/parser_json.c  | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 3fccea6734c0b..cd249c82d9382 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -135,6 +135,7 @@ int nft_lex(void *, void *, void *);
 %union {
 	uint64_t		val;
 	uint32_t		val32;
+	uint8_t			val8;
 	const char *		string;
 
 	struct list_head	*list;
@@ -800,7 +801,7 @@ int nft_lex(void *, void *, void *);
 
 %type <expr>			boolean_expr
 %destructor { expr_free($$); }	boolean_expr
-%type <val>			boolean_keys
+%type <val8>			boolean_keys
 
 %type <expr>			exthdr_exists_expr
 %destructor { expr_free($$); }	exthdr_exists_expr
@@ -3964,7 +3965,7 @@ boolean_expr		:	boolean_keys
 			{
 				$$ = constant_expr_alloc(&@$, &boolean_type,
 							 BYTEORDER_HOST_ENDIAN,
-							 1, &$1);
+							 sizeof($1) * BITS_PER_BYTE, &$1);
 			}
 			;
 
diff --git a/src/parser_json.c b/src/parser_json.c
index 398ae19275c3b..06254cd6c41d4 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -351,7 +351,8 @@ static struct expr *json_parse_immediate(struct json_ctx *ctx, json_t *root)
 	case JSON_FALSE:
 		buf[0] = json_is_true(root);
 		return constant_expr_alloc(int_loc, &boolean_type,
-					   BYTEORDER_HOST_ENDIAN, 1, buf);
+					   BYTEORDER_HOST_ENDIAN,
+					   sizeof(char) * BITS_PER_BYTE, buf);
 	default:
 		json_error(ctx, "Unexpected JSON type %s for immediate value.",
 			   json_typename(root));
-- 
2.22.0

