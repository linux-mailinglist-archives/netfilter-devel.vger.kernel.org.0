Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015FB37F0A1
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 May 2021 02:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhEMArD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 12 May 2021 20:47:03 -0400
Received: from mail.netfilter.org ([217.70.188.207]:59988 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241841AbhEMApE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 12 May 2021 20:45:04 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id DE25F64143
        for <netfilter-devel@vger.kernel.org>; Thu, 13 May 2021 02:43:02 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nftables] parser_bison: add shortcut syntax for matching flags without binary operations
Date:   Thu, 13 May 2021 02:43:48 +0200
Message-Id: <20210513004348.23640-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds the following shortcut syntax:

	expression flags / flags

instead of:

	expression and flags == flags

For example:

	tcp flags syn,ack / syn,ack,fin,rst
                  ^^^^^^^   ^^^^^^^^^^^^^^^
                   value         mask

instead of:

	tcp flags and (syn|ack|fin|rst) == syn|ack

The second list of comma-separated flags represents the mask which are
examined and the first list of comma-separated flags must be set.

You can also use the != operator with this syntax:

	tcp flags != fin,rst / syn,ack,fin,rst

This short is based on the prefix notation, but it is also similar to
the iptables tcp matching syntax.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
netlink delinearize code update to list this new syntax is missing in
this patch.

 src/parser_bison.y | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index b50b60649d2e..0747601e551d 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -4469,6 +4469,34 @@ relational_expr		:	expr	/* implicit */	rhs_expr
 			{
 				$$ = relational_expr_alloc(&@$, OP_IMPLICIT, $1, $2);
 			}
+			|	expr	/* implicit */	basic_rhs_expr	SLASH	list_rhs_expr
+			{
+				struct expr *expr;
+
+				expr = binop_expr_alloc(&@$, OP_AND, $1, $4);
+				$$ = relational_expr_alloc(&@$, OP_EQ, expr, $2);
+			}
+			|	expr	/* implicit */	list_rhs_expr	SLASH	list_rhs_expr
+			{
+				struct expr *expr;
+
+				expr = binop_expr_alloc(&@$, OP_AND, $1, $4);
+				$$ = relational_expr_alloc(&@$, OP_EQ, expr, $2);
+			}
+			|	expr	relational_op	basic_rhs_expr	SLASH	list_rhs_expr
+			{
+				struct expr *expr;
+
+				expr = binop_expr_alloc(&@$, OP_AND, $1, $5);
+				$$ = relational_expr_alloc(&@$, $2, expr, $3);
+			}
+			|	expr	relational_op	list_rhs_expr	SLASH	list_rhs_expr
+			{
+				struct expr *expr;
+
+				expr = binop_expr_alloc(&@$, OP_AND, $1, $5);
+				$$ = relational_expr_alloc(&@$, $2, expr, $3);
+			}
 			|	expr	relational_op	rhs_expr
 			{
 				$$ = relational_expr_alloc(&@2, $2, $1, $3);
-- 
2.20.1

