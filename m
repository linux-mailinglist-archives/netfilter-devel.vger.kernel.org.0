Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D156316AF58
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Feb 2020 19:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBXSjq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Feb 2020 13:39:46 -0500
Received: from correo.us.es ([193.147.175.20]:45010 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgBXSjp (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:39:45 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4E438E8D68
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Feb 2020 19:39:38 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 40C66DA72F
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Feb 2020 19:39:38 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 40060DA7B6; Mon, 24 Feb 2020 19:39:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 647DEDA72F;
        Mon, 24 Feb 2020 19:39:35 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 24 Feb 2020 19:39:35 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 3CBD4424EECB;
        Mon, 24 Feb 2020 19:39:35 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, nevola@gmail.com
Subject: [PATCH 7/6 nft,v2] src: nat concatenation support with anonymous maps
Date:   Mon, 24 Feb 2020 19:39:37 +0100
Message-Id: <20200224183938.318160-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch extends the parser to define the mapping datatypes, eg.

  ... dnat ip addr . port to ip saddr map { 1.1.1.1 : 2.2.2.2 . 30 }
  ... dnat ip addr . port to ip saddr map @y

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: IPv6 support and fix incorrect datatype.

 src/evaluate.c            | 23 ++++++++++++++++++++---
 src/netlink_delinearize.c |  1 +
 src/parser_bison.y        |  7 +++++++
 src/scanner.l             |  1 +
 src/statement.c           |  3 +++
 5 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 0afd0403d3a4..2d4985c0d409 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2853,15 +2853,32 @@ static int stmt_evaluate_nat_map(struct eval_ctx *ctx, struct stmt *stmt)
 {
 	struct expr *one, *two, *data, *tmp;
 	const struct datatype *dtype;
-	int err;
+	int addr_type, err;
 
-	dtype = get_addr_dtype(stmt->nat.family);
+	if (stmt->nat.ipportmap) {
+		switch (stmt->nat.family) {
+		case NFPROTO_IPV4:
+			addr_type = TYPE_IPADDR;
+			break;
+		case NFPROTO_IPV6:
+			addr_type = TYPE_IP6ADDR;
+			break;
+		default:
+			return -1;
+		}
+		dtype = concat_type_alloc((addr_type << TYPE_BITS) |
+					   TYPE_INET_SERVICE);
+	} else {
+		dtype = get_addr_dtype(stmt->nat.family);
+	}
 
 	expr_set_context(&ctx->ectx, dtype, dtype->size);
 	if (expr_evaluate(ctx, &stmt->nat.addr))
 		return -1;
 
 	data = stmt->nat.addr->mappings->set->data;
+	datatype_set(data, dtype);
+
 	if (expr_ops(data)->type != EXPR_CONCAT)
 		return __stmt_evaluate_arg(ctx, stmt, dtype, dtype->size,
 					   BYTEORDER_BIG_ENDIAN,
@@ -2875,6 +2892,7 @@ static int stmt_evaluate_nat_map(struct eval_ctx *ctx, struct stmt *stmt)
 					   BYTEORDER_BIG_ENDIAN,
 					   &stmt->nat.addr);
 
+	dtype = get_addr_dtype(stmt->nat.family);
 	tmp = one;
 	err = __stmt_evaluate_arg(ctx, stmt, dtype, dtype->size,
 				  BYTEORDER_BIG_ENDIAN,
@@ -2891,7 +2909,6 @@ static int stmt_evaluate_nat_map(struct eval_ctx *ctx, struct stmt *stmt)
 	if (tmp != two)
 		BUG("Internal error: Unexpected alteration of l4 expression");
 
-	stmt->nat.ipportmap = true;
 	return err;
 }
 
diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 6203a53c6154..0058e2cfe42a 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -1065,6 +1065,7 @@ static void netlink_parse_nat(struct netlink_parse_ctx *ctx,
 	}
 
 	if (is_nat_proto_map(addr, family)) {
+		stmt->nat.family = family;
 		stmt->nat.ipportmap = true;
 		ctx->stmt = stmt;
 		return;
diff --git a/src/parser_bison.y b/src/parser_bison.y
index fd00b40a104a..4c27fcc635dc 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -373,6 +373,7 @@ int nft_lex(void *, void *, void *);
 %token FLAGS			"flags"
 %token CPI			"cpi"
 
+%token PORT			"port"
 %token UDP			"udp"
 %token SPORT			"sport"
 %token DPORT			"dport"
@@ -3141,6 +3142,12 @@ nat_stmt_args		:	stmt_expr
 			{
 				$<stmt>0->nat.flags = $2;
 			}
+			|	nf_key_proto ADDR DOT	PORT	TO	stmt_expr
+			{
+				$<stmt>0->nat.family = $1;
+				$<stmt>0->nat.addr = $6;
+				$<stmt>0->nat.ipportmap = true;
+			}
 			;
 
 masq_stmt		:	masq_stmt_alloc		masq_stmt_args
diff --git a/src/scanner.l b/src/scanner.l
index 3932883b9ade..45699c85d7d0 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -471,6 +471,7 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 "udplite"		{ return UDPLITE; }
 "sport"			{ return SPORT; }
 "dport"			{ return DPORT; }
+"port"			{ return PORT; }
 
 "tcp"			{ return TCP; }
 "ackseq"		{ return ACKSEQ; }
diff --git a/src/statement.c b/src/statement.c
index be35bceff19a..182edac8f2ec 100644
--- a/src/statement.c
+++ b/src/statement.c
@@ -607,6 +607,9 @@ static void nat_stmt_print(const struct stmt *stmt, struct output_ctx *octx)
 			break;
 		}
 
+		if (stmt->nat.ipportmap)
+			nft_print(octx, " addr . port");
+
 		nft_print(octx, " to");
 	}
 
-- 
2.11.0

