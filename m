Return-Path: <netfilter-devel+bounces-6442-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DED3A68B6E
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Mar 2025 12:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99A246129D
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Mar 2025 11:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BF4253F23;
	Wed, 19 Mar 2025 11:19:36 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (unknown [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660422F19
	for <netfilter-devel@vger.kernel.org>; Wed, 19 Mar 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383175; cv=none; b=N4L78yoeLwF8yYjn69NL6yLWo7vuHCkiZO3aahcYTg0e16OD4R9/oprXlMqjl/C4RWOj1xd8V1SYNcDd/yHQ8dBkZwGFj3aWW9WXPngx3DgigOUSjCpFx3IW/FKgMI78onMNiUJuZBaDD7730ctYGb27VDkqp6k5DNUs9fxTGtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383175; c=relaxed/simple;
	bh=IRHHzhRp8jkCddFqObMD96L2mYJNymGb/jOslOoz6eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERbC1tcWxzdPAtZ+fT0W40mODik9nF7xZbCY0YhKB3XSiZ/XO+X9BdqbsiwKzQreGfz99Lb/TE2YoBebky3C9gm2sk7KxCOwnezZCdCE9BTz1XbhAleOsT7Z6EHatgjSmY/csVk1cXBQDrF91ILQg/c0MEHtcBa5UQgtt7TQL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1turSN-0007lp-Jt; Wed, 19 Mar 2025 12:19:31 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] netlink_delinerize: add more restrictions on meta nfproto removal
Date: Wed, 19 Mar 2025 12:18:51 +0100
Message-ID: <20250319111855.5885-1-fw@strlen.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can't remove 'meta nfproto' dependencies for all cases, e.g. inet.

   meta nfproto ipv4 ct protocol tcp

is listed as 'ct protocol tcp'.

meta l4proto removal checks were correct, but refactor this into a helper
function to split meta/ct checks from the caller.

We need to examine ct keys more closely to figure out if the dependency
can be inferred or not: only NFT_CT_SRC/DST and its variants imply the
network protocol to use.  All other keys must keep the l3 dependency.

Also extend test coverage.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1783
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/ct.c                   |  4 ++
 src/netlink_delinearize.c  | 82 +++++++++++++++++++++++++++++---------
 tests/py/inet/ct.t         |  5 +++
 tests/py/inet/ct.t.json    | 51 ++++++++++++++++++++++++
 tests/py/inet/ct.t.payload | 14 +++++++
 5 files changed, 138 insertions(+), 18 deletions(-)

diff --git a/src/ct.c b/src/ct.c
index 6793464859ca..022b4282c520 100644
--- a/src/ct.c
+++ b/src/ct.c
@@ -456,7 +456,11 @@ struct expr *ct_expr_alloc(const struct location *loc, enum nft_ct_keys key,
 
 	switch (key) {
 	case NFT_CT_SRC:
+	case NFT_CT_SRC_IP:
+	case NFT_CT_SRC_IP6:
 	case NFT_CT_DST:
+	case NFT_CT_DST_IP:
+	case NFT_CT_DST_IP6:
 		expr->ct.base = PROTO_BASE_NETWORK_HDR;
 		break;
 	case NFT_CT_PROTO_SRC:
diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index ae14065c00d6..ab8254e2a99c 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2250,17 +2250,71 @@ static bool __meta_dependency_may_kill(const struct expr *dep, uint8_t *nfproto)
 	return false;
 }
 
+static bool ct_may_dependency_kill(unsigned int meta_nfproto,
+				   const struct expr *ct)
+{
+	assert(ct->etype == EXPR_CT);
+
+	switch (ct->ct.key) {
+	case NFT_CT_DST:
+	case NFT_CT_SRC:
+		switch (ct->len) {
+		case 32:
+			return meta_nfproto == NFPROTO_IPV4;
+		case 128:
+			return meta_nfproto == NFPROTO_IPV6;
+		default:
+			break;
+		}
+		return false;
+	case NFT_CT_DST_IP:
+	case NFT_CT_SRC_IP:
+		return meta_nfproto == NFPROTO_IPV4;
+	case NFT_CT_DST_IP6:
+	case NFT_CT_SRC_IP6:
+		return meta_nfproto == NFPROTO_IPV6;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static bool meta_may_dependency_kill(uint8_t nfproto, const struct expr *meta, const struct expr *v)
+{
+	uint8_t l4proto;
+
+	if (meta->meta.key != NFT_META_L4PROTO)
+		return true;
+
+	if (v->etype != EXPR_VALUE || v->len != 8)
+		return false;
+
+	l4proto = mpz_get_uint8(v->value);
+
+	switch (l4proto) {
+	case IPPROTO_ICMP:
+		return nfproto == NFPROTO_IPV4;
+	case IPPROTO_ICMPV6:
+		return nfproto == NFPROTO_IPV6;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 /* We have seen a protocol key expression that restricts matching at the network
  * base, leave it in place since this is meaningful in bridge, inet and netdev
  * families. Exceptions are ICMP and ICMPv6 where this code assumes that can
  * only happen with IPv4 and IPv6.
  */
-static bool meta_may_dependency_kill(struct payload_dep_ctx *ctx,
+static bool ct_meta_may_dependency_kill(struct payload_dep_ctx *ctx,
 				     unsigned int family,
 				     const struct expr *expr)
 {
-	uint8_t l4proto, nfproto = NFPROTO_UNSPEC;
 	struct expr *dep = payload_dependency_get(ctx, PROTO_BASE_NETWORK_HDR);
+	uint8_t nfproto = NFPROTO_UNSPEC;
 
 	if (!dep)
 		return true;
@@ -2280,23 +2334,15 @@ static bool meta_may_dependency_kill(struct payload_dep_ctx *ctx,
 		return true;
 	}
 
-	if (expr->left->meta.key != NFT_META_L4PROTO)
-		return true;
-
-	l4proto = mpz_get_uint8(expr->right->value);
-
-	switch (l4proto) {
-	case IPPROTO_ICMP:
-	case IPPROTO_ICMPV6:
-		break;
+	switch (expr->left->etype) {
+	case EXPR_META:
+		return meta_may_dependency_kill(nfproto, expr->left, expr->right);
+	case EXPR_CT:
+		return ct_may_dependency_kill(nfproto, expr->left);
 	default:
-		return false;
+		break;
 	}
 
-	if ((nfproto == NFPROTO_IPV4 && l4proto == IPPROTO_ICMPV6) ||
-	    (nfproto == NFPROTO_IPV6 && l4proto == IPPROTO_ICMP))
-		return false;
-
 	return true;
 }
 
@@ -2322,8 +2368,8 @@ static void ct_meta_common_postprocess(struct rule_pp_ctx *ctx,
 
 		if (base < PROTO_BASE_TRANSPORT_HDR) {
 			if (payload_dependency_exists(&dl->pdctx, base) &&
-			    meta_may_dependency_kill(&dl->pdctx,
-						     dl->pctx.family, expr))
+			    ct_meta_may_dependency_kill(&dl->pdctx,
+							dl->pctx.family, expr))
 				payload_dependency_release(&dl->pdctx, base);
 
 			if (left->flags & EXPR_F_PROTOCOL)
diff --git a/tests/py/inet/ct.t b/tests/py/inet/ct.t
index 5312b328aa91..f2dbba89a703 100644
--- a/tests/py/inet/ct.t
+++ b/tests/py/inet/ct.t
@@ -3,11 +3,16 @@
 
 *inet;test-inet;input
 
+# dependeny should be removed
 meta nfproto ipv4 ct original saddr 1.2.3.4;ok;ct original ip saddr 1.2.3.4
 ct original ip6 saddr ::1;ok
 
 ct original ip daddr 1.2.3.4 accept;ok
 
+# dependeny must not be removed
+meta nfproto ipv4 ct mark 0x00000001;ok
+meta nfproto ipv6 ct protocol 6;ok
+
 # missing protocol context
 ct original saddr ::1;fail
 
diff --git a/tests/py/inet/ct.t.json b/tests/py/inet/ct.t.json
index 223ac9e7575f..155eecc5fa08 100644
--- a/tests/py/inet/ct.t.json
+++ b/tests/py/inet/ct.t.json
@@ -58,3 +58,54 @@
     }
 ]
 
+# meta nfproto ipv4 ct mark 0x00000001
+[
+    {
+        "match": {
+            "left": {
+                "meta": {
+                    "key": "nfproto"
+                }
+            },
+            "op": "==",
+            "right": "ipv4"
+        }
+    },
+    {
+        "match": {
+            "left": {
+                "ct": {
+                    "key": "mark"
+                }
+            },
+            "op": "==",
+            "right": 1
+        }
+    }
+]
+
+# meta nfproto ipv6 ct protocol 6
+[
+    {
+        "match": {
+            "left": {
+                "meta": {
+                    "key": "nfproto"
+                }
+            },
+            "op": "==",
+            "right": "ipv6"
+        }
+    },
+    {
+        "match": {
+            "left": {
+                "ct": {
+                    "key": "protocol"
+                }
+            },
+            "op": "==",
+            "right": 6
+        }
+    }
+]
diff --git a/tests/py/inet/ct.t.payload b/tests/py/inet/ct.t.payload
index f7a2ef27274a..216dad2bb531 100644
--- a/tests/py/inet/ct.t.payload
+++ b/tests/py/inet/ct.t.payload
@@ -15,3 +15,17 @@ inet test-inet input
   [ ct load dst_ip => reg 1 , dir original ]
   [ cmp eq reg 1 0x04030201 ]
   [ immediate reg 0 accept ]
+
+# meta nfproto ipv4 ct mark 0x00000001
+inet test-inet input
+  [ meta load nfproto => reg 1 ]
+  [ cmp eq reg 1 0x00000002 ]
+  [ ct load mark => reg 1 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# meta nfproto ipv6 ct protocol 6
+inet test-inet input
+  [ meta load nfproto => reg 1 ]
+  [ cmp eq reg 1 0x0000000a ]
+  [ ct load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
-- 
2.48.1


