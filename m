Return-Path: <netfilter-devel+bounces-3627-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E2696905A
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2024 01:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB681F240BA
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Sep 2024 23:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2C18858C;
	Mon,  2 Sep 2024 23:17:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572341A4E71
	for <netfilter-devel@vger.kernel.org>; Mon,  2 Sep 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725319062; cv=none; b=q7CO82PfboYjcQA06IAiFMur0f1Eyst37+2wep51X7ept1/gM3twVKBb3XnUJpxbuJBOqfF+CeJJAoiJx7kCPLrWQufBTxG6P1djqkQyu5yl6CWWGwyurye51rOgMbHXXh+pp90EVvfF+5CDAqUC80/3QD83PPzeOg7oWhWvcC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725319062; c=relaxed/simple;
	bh=LwedWUKf/q2/HISSCoTSRpUR91jrwuC1IpSCdxzKMWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dIXraZF6SLQ8tTmNM/bCIynBA1HoOg/2pHEuBQNlTOnbd0OUenCb1WKZnoca6IP+PEzGl3bF6bXK2Wy/3HFuKzN5Bmf1kaGtbXmSQ+h0ODzSlyQHUBPIxO7K6JYw0wJ/FZ+66vErkpcitP3+FpSjh7D+47D5OwggDzk8bxHWXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: phil@nwl.cc,
	fw@strlen.de
Subject: [PATCH nf-next,v2 7/9] netfilter: nf_tables: consolidate timeout extension for elements
Date: Tue,  3 Sep 2024 01:17:24 +0200
Message-Id: <20240902231726.171964-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240902231726.171964-1-pablo@netfilter.org>
References: <20240902231726.171964-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expiration and timeout are stored in separated set element extensions,
but they are tightly coupled. Consolidate them in a single extension to
simplify and prepare for set element updates.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes.

 include/net/netfilter/nf_tables.h | 18 ++++++-------
 net/netfilter/nf_tables_api.c     | 43 ++++++++++++-------------------
 net/netfilter/nft_dynset.c        | 13 ++++------
 3 files changed, 30 insertions(+), 44 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 7a2f7417ed9e..a950a1f932bf 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -683,7 +683,6 @@ void nf_tables_destroy_set(const struct nft_ctx *ctx, struct nft_set *set);
  *	@NFT_SET_EXT_DATA: mapping data
  *	@NFT_SET_EXT_FLAGS: element flags
  *	@NFT_SET_EXT_TIMEOUT: element timeout
- *	@NFT_SET_EXT_EXPIRATION: element expiration time
  *	@NFT_SET_EXT_USERDATA: user data associated with the element
  *	@NFT_SET_EXT_EXPRESSIONS: expressions assiciated with the element
  *	@NFT_SET_EXT_OBJREF: stateful object reference associated with element
@@ -695,7 +694,6 @@ enum nft_set_extensions {
 	NFT_SET_EXT_DATA,
 	NFT_SET_EXT_FLAGS,
 	NFT_SET_EXT_TIMEOUT,
-	NFT_SET_EXT_EXPIRATION,
 	NFT_SET_EXT_USERDATA,
 	NFT_SET_EXT_EXPRESSIONS,
 	NFT_SET_EXT_OBJREF,
@@ -807,14 +805,14 @@ static inline u8 *nft_set_ext_flags(const struct nft_set_ext *ext)
 	return nft_set_ext(ext, NFT_SET_EXT_FLAGS);
 }
 
-static inline u64 *nft_set_ext_timeout(const struct nft_set_ext *ext)
-{
-	return nft_set_ext(ext, NFT_SET_EXT_TIMEOUT);
-}
+struct nft_timeout {
+	u64	timeout;
+	u64	expiration;
+};
 
-static inline u64 *nft_set_ext_expiration(const struct nft_set_ext *ext)
+static inline struct nft_timeout *nft_set_ext_timeout(const struct nft_set_ext *ext)
 {
-	return nft_set_ext(ext, NFT_SET_EXT_EXPIRATION);
+	return nft_set_ext(ext, NFT_SET_EXT_TIMEOUT);
 }
 
 static inline struct nft_userdata *nft_set_ext_userdata(const struct nft_set_ext *ext)
@@ -830,8 +828,8 @@ static inline struct nft_set_elem_expr *nft_set_ext_expr(const struct nft_set_ex
 static inline bool __nft_set_elem_expired(const struct nft_set_ext *ext,
 					  u64 tstamp)
 {
-	return nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION) &&
-	       time_after_eq64(tstamp, READ_ONCE(*nft_set_ext_expiration(ext)));
+	return nft_set_ext_exists(ext, NFT_SET_EXT_TIMEOUT) &&
+	       time_after_eq64(tstamp, READ_ONCE(nft_set_ext_timeout(ext)->expiration));
 }
 
 static inline bool nft_set_elem_expired(const struct nft_set_ext *ext)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ee7f8c12918b..4cf2162b0d07 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5688,12 +5688,8 @@ const struct nft_set_ext_type nft_set_ext_types[] = {
 		.align	= __alignof__(u8),
 	},
 	[NFT_SET_EXT_TIMEOUT]		= {
-		.len	= sizeof(u64),
-		.align	= __alignof__(u64),
-	},
-	[NFT_SET_EXT_EXPIRATION]	= {
-		.len	= sizeof(u64),
-		.align	= __alignof__(u64),
+		.len	= sizeof(struct nft_timeout),
+		.align	= __alignof__(struct nft_timeout),
 	},
 	[NFT_SET_EXT_USERDATA]		= {
 		.len	= sizeof(struct nft_userdata),
@@ -5812,16 +5808,16 @@ static int nf_tables_fill_setelem(struct sk_buff *skb,
 		         htonl(*nft_set_ext_flags(ext))))
 		goto nla_put_failure;
 
-	if (nft_set_ext_exists(ext, NFT_SET_EXT_TIMEOUT) &&
-	    nla_put_be64(skb, NFTA_SET_ELEM_TIMEOUT,
-			 nf_jiffies64_to_msecs(*nft_set_ext_timeout(ext)),
-			 NFTA_SET_ELEM_PAD))
-		goto nla_put_failure;
-
-	if (nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION)) {
+	if (nft_set_ext_exists(ext, NFT_SET_EXT_TIMEOUT)) {
 		u64 expires, now = get_jiffies_64();
 
-		expires = READ_ONCE(*nft_set_ext_expiration(ext));
+		if (nft_set_ext_timeout(ext)->timeout != READ_ONCE(set->timeout) &&
+		    nla_put_be64(skb, NFTA_SET_ELEM_TIMEOUT,
+				 nf_jiffies64_to_msecs(nft_set_ext_timeout(ext)->timeout),
+				 NFTA_SET_ELEM_PAD))
+			goto nla_put_failure;
+
+		expires = READ_ONCE(nft_set_ext_timeout(ext)->expiration);
 		if (time_before64(now, expires))
 			expires -= now;
 		else
@@ -6493,13 +6489,14 @@ struct nft_elem_priv *nft_set_elem_init(const struct nft_set *set,
 			       nft_set_ext_data(ext), data, set->dlen) < 0)
 		goto err_ext_check;
 
-	if (nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION)) {
-		*nft_set_ext_expiration(ext) = get_jiffies_64() + expiration;
+	if (nft_set_ext_exists(ext, NFT_SET_EXT_TIMEOUT)) {
+		nft_set_ext_timeout(ext)->timeout = timeout;
+
 		if (expiration == 0)
-			*nft_set_ext_expiration(ext) += timeout;
+			expiration = timeout;
+
+		nft_set_ext_timeout(ext)->expiration = get_jiffies_64() + expiration;
 	}
-	if (nft_set_ext_exists(ext, NFT_SET_EXT_TIMEOUT))
-		*nft_set_ext_timeout(ext) = timeout;
 
 	return elem;
 
@@ -7013,15 +7010,9 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	}
 
 	if (timeout > 0) {
-		err = nft_set_ext_add(&tmpl, NFT_SET_EXT_EXPIRATION);
+		err = nft_set_ext_add(&tmpl, NFT_SET_EXT_TIMEOUT);
 		if (err < 0)
 			goto err_parse_key_end;
-
-		if (timeout != set->timeout) {
-			err = nft_set_ext_add(&tmpl, NFT_SET_EXT_TIMEOUT);
-			if (err < 0)
-				goto err_parse_key_end;
-		}
 	}
 
 	if (num_exprs) {
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 67474fd002b2..88ea2454c6df 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -94,9 +94,9 @@ void nft_dynset_eval(const struct nft_expr *expr,
 	if (set->ops->update(set, &regs->data[priv->sreg_key], nft_dynset_new,
 			     expr, regs, &ext)) {
 		if (priv->op == NFT_DYNSET_OP_UPDATE &&
-		    nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION)) {
+		    nft_set_ext_exists(ext, NFT_SET_EXT_TIMEOUT)) {
 			timeout = priv->timeout ? : READ_ONCE(set->timeout);
-			WRITE_ONCE(*nft_set_ext_expiration(ext), get_jiffies_64() + timeout);
+			WRITE_ONCE(nft_set_ext_timeout(ext)->expiration, get_jiffies_64() + timeout);
 		}
 
 		nft_set_elem_update_expr(ext, regs, pkt);
@@ -312,12 +312,9 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	if (priv->num_exprs)
 		nft_dynset_ext_add_expr(priv);
 
-	if (set->flags & NFT_SET_TIMEOUT) {
-		if (timeout || READ_ONCE(set->timeout)) {
-			nft_set_ext_add(&priv->tmpl, NFT_SET_EXT_TIMEOUT);
-			nft_set_ext_add(&priv->tmpl, NFT_SET_EXT_EXPIRATION);
-		}
-	}
+	if (set->flags & NFT_SET_TIMEOUT &&
+	    (timeout || READ_ONCE(set->timeout)))
+		nft_set_ext_add(&priv->tmpl, NFT_SET_EXT_TIMEOUT);
 
 	priv->timeout = timeout;
 
-- 
2.30.2


