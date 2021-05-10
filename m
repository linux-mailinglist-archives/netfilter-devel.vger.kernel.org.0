Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C058337949C
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 May 2021 18:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhEJQyd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 May 2021 12:54:33 -0400
Received: from mail.netfilter.org ([217.70.188.207]:54294 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhEJQyc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 May 2021 12:54:32 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id AF92164164
        for <netfilter-devel@vger.kernel.org>; Mon, 10 May 2021 18:52:38 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nftables 1/2] parser_bison: add set_elem_key_expr rule
Date:   Mon, 10 May 2021 18:53:20 +0200
Message-Id: <20210510165322.130181-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a rule to specify the set key expression in preparation for the
catch-all element support.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index b50b60649d2e..e4a5ade296d7 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -842,6 +842,9 @@ int nft_lex(void *, void *, void *);
 %type <expr>			xfrm_expr
 %destructor { expr_free($$); }	xfrm_expr
 
+%type <expr>			set_elem_key_expr
+%destructor { expr_free($$); }	set_elem_key_expr
+
 %%
 
 input			:	/* empty */
@@ -4084,13 +4087,16 @@ set_elem_expr		:	set_elem_expr_alloc
 			|	set_elem_expr_alloc		set_elem_expr_options
 			;
 
-set_elem_expr_alloc	:	set_lhs_expr	set_elem_stmt_list
+set_elem_key_expr	:	set_lhs_expr		{ $$ = $1; }
+			;
+
+set_elem_expr_alloc	:	set_elem_key_expr	set_elem_stmt_list
 			{
 				$$ = set_elem_expr_alloc(&@1, $1);
 				list_splice_tail($2, &$$->stmt_list);
 				xfree($2);
 			}
-			|	set_lhs_expr
+			|	set_elem_key_expr
 			{
 				$$ = set_elem_expr_alloc(&@1, $1);
 			}
-- 
2.30.2

