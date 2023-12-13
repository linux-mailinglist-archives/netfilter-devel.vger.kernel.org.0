Return-Path: <netfilter-devel+bounces-256-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E289680AC33
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Dec 2023 19:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203CF1C20C4C
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Dec 2023 18:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172C37150;
	Fri,  8 Dec 2023 18:38:47 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27A2118
	for <netfilter-devel@vger.kernel.org>; Fri,  8 Dec 2023 10:38:43 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rBfkI-0000sI-BU; Fri, 08 Dec 2023 19:38:42 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 nft] evaluate: fix bogus assertion failure with boolean datatype
Date: Fri,  8 Dec 2023 19:38:33 +0100
Message-ID: <20231208183836.21467-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assertion is too strict, as found by afl++:

typeof iifname . ip saddr . meta ipsec
elements = { "eth0" . 10.1.1.2 . 1 }

meta ipsec is boolean (1 bit), but datasize of 1 is set at 8 bit.

Fixes: 22b750aa6dc9 ("src: allow use of base integer types as set keys in concatenations")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: fix patch subject line

 src/evaluate.c                                  |  7 ++++---
 .../testcases/sets/dumps/typeof_sets_0.nft      |  9 +++++++++
 tests/shell/testcases/sets/typeof_sets_0        | 17 +++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index a62a23460e7b..e3e0c00eb635 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4647,14 +4647,15 @@ static int set_expr_evaluate_concat(struct eval_ctx *ctx, struct expr **expr)
 						 "expressions",
 						 i->dtype->name);
 
-		if (i->dtype->size)
-			assert(i->len == i->dtype->size);
-
 		flags &= i->flags;
 
 		ntype = concat_subtype_add(ntype, i->dtype->type);
 
 		dsize_bytes = div_round_up(i->len, BITS_PER_BYTE);
+
+		if (i->dtype->size)
+			assert(dsize_bytes == div_round_up(i->dtype->size, BITS_PER_BYTE));
+
 		(*expr)->field_len[(*expr)->field_count++] = dsize_bytes;
 		size += netlink_padded_len(i->len);
 	}
diff --git a/tests/shell/testcases/sets/dumps/typeof_sets_0.nft b/tests/shell/testcases/sets/dumps/typeof_sets_0.nft
index 6f5b83af6bb9..63fc5b145137 100644
--- a/tests/shell/testcases/sets/dumps/typeof_sets_0.nft
+++ b/tests/shell/testcases/sets/dumps/typeof_sets_0.nft
@@ -55,6 +55,11 @@ table inet t {
 		elements = { 3567 . 1.2.3.4 }
 	}
 
+	set s12 {
+		typeof iifname . ip saddr . meta ipsec
+		elements = { "eth0" . 10.1.1.2 . exists }
+	}
+
 	chain c1 {
 		osf name @s1 accept
 	}
@@ -94,4 +99,8 @@ table inet t {
 	chain c11 {
 		vlan id . ip saddr @s11 accept
 	}
+
+	chain c12 {
+		iifname . ip saddr . meta ipsec @s12 accept
+	}
 }
diff --git a/tests/shell/testcases/sets/typeof_sets_0 b/tests/shell/testcases/sets/typeof_sets_0
index 92555a1f923e..016227da6242 100755
--- a/tests/shell/testcases/sets/typeof_sets_0
+++ b/tests/shell/testcases/sets/typeof_sets_0
@@ -113,6 +113,10 @@ INPUT="table inet t {$INPUT_OSF_SET
 		typeof vlan id . ip saddr
 		elements = { 3567 . 1.2.3.4 }
 	}
+	set s12 {
+		typeof meta iifname . ip saddr . meta ipsec
+		elements = { \"eth0\" . 10.1.1.2 . 1 }
+	}
 $INPUT_OSF_CHAIN
 	chain c2 {
 		ether type vlan vlan id @s2 accept
@@ -138,6 +142,10 @@ $INPUT_VERSION_CHAIN
 	chain c11 {
 		ether type vlan vlan id . ip saddr @s11 accept
 	}
+
+	chain c12 {
+		meta iifname . ip saddr . meta ipsec @s12 accept
+	}
 }"
 
 EXPECTED="table inet t {$INPUT_OSF_SET
@@ -181,6 +189,11 @@ $INPUT_VERSION_SET
 		typeof vlan id . ip saddr
 		elements = { 3567 . 1.2.3.4 }
 	}
+
+	set s12 {
+		typeof iifname . ip saddr . meta ipsec
+		elements = { \"eth0\" . 10.1.1.2 . exists }
+	}
 $INPUT_OSF_CHAIN
 	chain c2 {
 		vlan id @s2 accept
@@ -205,6 +218,10 @@ $INPUT_SCTP_CHAIN$INPUT_VERSION_CHAIN
 	chain c11 {
 		vlan id . ip saddr @s11 accept
 	}
+
+	chain c12 {
+		iifname . ip saddr . meta ipsec @s12 accept
+	}
 }"
 
 
-- 
2.41.0


