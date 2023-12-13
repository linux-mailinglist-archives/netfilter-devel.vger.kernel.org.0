Return-Path: <netfilter-devel+bounces-316-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21593811886
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Dec 2023 17:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951731C20906
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Dec 2023 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7E185379;
	Wed, 13 Dec 2023 16:00:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1666F91
	for <netfilter-devel@vger.kernel.org>; Wed, 13 Dec 2023 08:00:50 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rDRfE-00015a-Ni; Wed, 13 Dec 2023 17:00:48 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] evaluate: stmt_nat: set reference must point to a map
Date: Wed, 13 Dec 2023 17:00:37 +0100
Message-ID: <20231213160043.2081-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nat_concat_map() requires a datamap, else we crash:
set->data is dereferenced.

Also update expr_evaluate_map() so that EXPR_SET_REF is checked there
too.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c                                         |  9 +++++++++
 .../bogons/nft-f/nat_stmt_with_set_instead_of_map      | 10 ++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tests/shell/testcases/bogons/nft-f/nat_stmt_with_set_instead_of_map

diff --git a/src/evaluate.c b/src/evaluate.c
index 1b3e8097454d..da382912ea71 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2041,6 +2041,9 @@ static int expr_evaluate_map(struct eval_ctx *ctx, struct expr **expr)
 		break;
 	case EXPR_SET_REF:
 		/* symbol has been already evaluated to set reference */
+		if (!set_is_map(mappings->set->flags))
+			return expr_error(ctx->msgs, map->mappings,
+					  "Expression is not a map");
 		break;
 	default:
 		return expr_binary_error(ctx->msgs, map->mappings, map->map,
@@ -3969,6 +3972,12 @@ static bool nat_concat_map(struct eval_ctx *ctx, struct stmt *stmt)
 		if (expr_evaluate(ctx, &stmt->nat.addr->mappings))
 			return false;
 
+		if (!set_is_datamap(stmt->nat.addr->mappings->set->flags)) {
+			expr_error(ctx->msgs, stmt->nat.addr->mappings,
+					  "Expression is not a map");
+			return false;
+		}
+
 		if (stmt->nat.addr->mappings->set->data->etype == EXPR_CONCAT ||
 		    stmt->nat.addr->mappings->set->data->dtype->subtypes) {
 			stmt->nat.type_flags |= STMT_NAT_F_CONCAT;
diff --git a/tests/shell/testcases/bogons/nft-f/nat_stmt_with_set_instead_of_map b/tests/shell/testcases/bogons/nft-f/nat_stmt_with_set_instead_of_map
new file mode 100644
index 000000000000..b1302278cc9b
--- /dev/null
+++ b/tests/shell/testcases/bogons/nft-f/nat_stmt_with_set_instead_of_map
@@ -0,0 +1,10 @@
+table inet x {
+        set y {
+                type ipv4_addr
+                elements = { 2.2.2.2, 3.3.3.3 }
+        }
+
+        chain y {
+                snat ip to ip saddr map @y
+        }
+}
-- 
2.41.0


