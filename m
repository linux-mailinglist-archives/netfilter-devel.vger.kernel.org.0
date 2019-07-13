Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2929067B27
	for <lists+netfilter-devel@lfdr.de>; Sat, 13 Jul 2019 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfGMQDw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 13 Jul 2019 12:03:52 -0400
Received: from fnsib-smtp05.srv.cat ([46.16.61.55]:33469 "EHLO
        fnsib-smtp05.srv.cat" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfGMQDw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 13 Jul 2019 12:03:52 -0400
Received: from localhost.localdomain (unknown [47.62.206.189])
        by fnsib-smtp05.srv.cat (Postfix) with ESMTPSA id 34DD81EF20E;
        Sat, 13 Jul 2019 18:03:49 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Cc:     Ander Juaristi <a@juaristi.eus>
Subject: [PATCH] netfilter: support for element deletion
Date:   Sat, 13 Jul 2019 18:03:43 +0200
Message-Id: <20190713160343.31620-1-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch implements element deletion from ruleset.

Example:

	table ip set-test {
		set testset {
			type ipv4_addr;
			flags timeout;
		}

		chain outputchain {
			policy accept;
			type filter hook output priority filter;

			delete @testset { ip saddr }
		}
	}

Signed-off-by: Ander Juaristi <a@juaristi.eus>
---
 include/linux/netfilter/nf_tables.h | 1 +
 src/parser_bison.y                  | 1 +
 src/statement.c                     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/linux/netfilter/nf_tables.h b/include/linux/netfilter/nf_tables.h
index 7bdb234..76a6b17 100644
--- a/include/linux/netfilter/nf_tables.h
+++ b/include/linux/netfilter/nf_tables.h
@@ -634,6 +634,7 @@ enum nft_lookup_attributes {
 enum nft_dynset_ops {
 	NFT_DYNSET_OP_ADD,
 	NFT_DYNSET_OP_UPDATE,
+	NFT_DYNSET_OP_DELETE,
 };
 
 enum nft_dynset_flags {
diff --git a/src/parser_bison.y b/src/parser_bison.y
index 670e91f..21646dc 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -2998,6 +2998,7 @@ set_stmt		:	SET	set_stmt_op	set_elem_expr_stmt	symbol_expr
 
 set_stmt_op		:	ADD	{ $$ = NFT_DYNSET_OP_ADD; }
 			|	UPDATE	{ $$ = NFT_DYNSET_OP_UPDATE; }
+			|	DELETE  { $$ = NFT_DYNSET_OP_DELETE; }
 			;
 
 map_stmt		:	set_stmt_op	symbol_expr '{'	set_elem_expr_stmt	COLON	set_elem_expr_stmt	'}'
diff --git a/src/statement.c b/src/statement.c
index c559423..eba53bf 100644
--- a/src/statement.c
+++ b/src/statement.c
@@ -660,6 +660,7 @@ struct stmt *nat_stmt_alloc(const struct location *loc,
 const char * const set_stmt_op_names[] = {
 	[NFT_DYNSET_OP_ADD]	= "add",
 	[NFT_DYNSET_OP_UPDATE]	= "update",
+	[NFT_DYNSET_OP_DELETE]  = "delete",
 };
 
 static void set_stmt_print(const struct stmt *stmt, struct output_ctx *octx)
-- 
2.17.1

