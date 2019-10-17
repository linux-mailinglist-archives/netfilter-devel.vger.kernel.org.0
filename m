Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C648DAAD9
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393659AbfJQLHz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 07:07:55 -0400
Received: from correo.us.es ([193.147.175.20]:46382 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393652AbfJQLHz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:07:55 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E27F711EB20
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Oct 2019 13:07:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D299F21FE4
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Oct 2019 13:07:50 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C65C2CA0F3; Thu, 17 Oct 2019 13:07:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DB4E2DA7B6;
        Thu, 17 Oct 2019 13:07:48 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 17 Oct 2019 13:07:48 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id AEDEE42EE38F;
        Thu, 17 Oct 2019 13:07:48 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     ejallot@gmail.com
Subject: [PATCH nft 1/2] src: define flowtable device compound as a list
Date:   Thu, 17 Oct 2019 13:07:46 +0200
Message-Id: <20191017110747.25985-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This fixes a memleak when releasing the compound expression via
expr_free().

Fixes: 92911b362e90 ("src: add support to add flowtables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y | 2 +-
 src/parser_json.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 1e2b30015f78..8ad581f69271 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -1826,7 +1826,7 @@ flowtable_expr		:	'{'	flowtable_list_expr	'}'
 
 flowtable_list_expr	:	flowtable_expr_member
 			{
-				$$ = compound_expr_alloc(&@$, EXPR_INVALID);
+				$$ = compound_expr_alloc(&@$, EXPR_LIST);
 				compound_expr_add($$, $1);
 			}
 			|	flowtable_list_expr	COMMA	flowtable_expr_member
diff --git a/src/parser_json.c b/src/parser_json.c
index bc29dedf5b4c..55dbc177cc98 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -2914,7 +2914,7 @@ static struct cmd *json_parse_cmd_add_element(struct json_ctx *ctx,
 static struct expr *json_parse_flowtable_devs(struct json_ctx *ctx,
 					      json_t *root)
 {
-	struct expr *tmp, *expr = compound_expr_alloc(int_loc, EXPR_INVALID);
+	struct expr *tmp, *expr = compound_expr_alloc(int_loc, EXPR_LIST);
 	const char *dev;
 	json_t *value;
 	size_t index;
-- 
2.11.0

