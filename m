Return-Path: <netfilter-devel+bounces-10647-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHvnKKADhGmHwwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10647-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:42:40 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B185EE104
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E5AF302BA3D
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 02:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB99B2C027C;
	Thu,  5 Feb 2026 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="YajDuamz"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5A2877C3
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259310; cv=none; b=q5lAcoZqABxFz9snDQzFqNb8GUpszNbqpoy9Ab5BHKMhk7u5pO/B25KMqD+II1TcyLeY7ciQyzubjrgn63DCPh/c9PG84ZOWKwNGh7nmMnpwZGkjV6Wo4mTmrHpfTuuKyL9gqutb0ids49yAtNybGKG4VCvDI+c6H7WHVIMACx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259310; c=relaxed/simple;
	bh=IDI+BBUxoM2h54+TVkEEUAHR41BCkrnm+fKucOkV8D8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNIe4y5wnh0GCqbbzyTrbBARFZXGGb5s1i/62LOdy2eLhjwLHgsR7o/XVO6lQ4jqFrz90Z3fH2N57FvS4ui0LrJa7eGDbzHUNwYYCkGP2TvW/wZsUQM0aKeqzH4xHnSBvSwSm/ZKMSzacbAEqvAh+AJsZvcVPiC8pzyGrlduA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=YajDuamz; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C749860882
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 03:41:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770259308;
	bh=nfbKjwzW1AiOqvohnR/m48VUtzjFqCcPs4tCydxojEM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YajDuamz7wIgbQFUIJUY21I/ZiaTi6jjpTzCHeGVv3ouGR+n/jRwmHhzsYaVQf7bC
	 JeuWgU2FeCALFf3iiNdkGCzi2mvOdUMP4IO+UsQ0Ri+bZe++URJwOudNtlSXk4NhAk
	 X0AAc14EzyNFL8kV6uTgYnFOOf5RnE3OUjlkxWDli/lgrpPgBiFnX0xhQM7/l5Jbcs
	 8a+oiMvuanEf8LdNltGIy5+wiX6YhkaP44Nexo+1bFHd+bkPl/iRrTAOyObCbvx80d
	 1hTS2HMDdq5Glq8UNtMFrykWfR2GuqqT8VwoFtMQH9lPVKhBMjLT4qJgkpyXYdBx+n
	 qXEKnm0rKaVXQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft 12/20] segtree: remove EXPR_VALUE from expr_value()
Date: Thu,  5 Feb 2026 03:41:21 +0100
Message-ID: <20260205024130.1470284-13-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205024130.1470284-1-pablo@netfilter.org>
References: <20260205024130.1470284-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-10647-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:dkim,netfilter.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B185EE104
X-Rspamd-Action: no action

Rework the following commit:

 7e6be917987c ("segtree: fix decomposition of unclosed intervals containing address prefixes")

this allows to add an assert(expr->etype == EXPR_SET_ELEM), in order to
normalize the input.

The closed flag tells us if this interval is represented with two
element or only one (as an open interval).

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/segtree.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/src/segtree.c b/src/segtree.c
index 5e03122ebfb7..95cab41668f0 100644
--- a/src/segtree.c
+++ b/src/segtree.c
@@ -114,17 +114,12 @@ struct expr *get_set_intervals(const struct set *set, const struct expr *init)
 
 static struct expr *expr_value(struct expr *expr)
 {
-	switch (expr->etype) {
-	case EXPR_SET_ELEM:
-		if (expr->key->etype == EXPR_MAPPING)
-			return expr->key->left;
+	assert(expr->etype == EXPR_SET_ELEM);
 
-		return expr->key;
-	case EXPR_VALUE:
-		return expr;
-	default:
-		BUG("invalid expression type %s", expr_name(expr));
-	}
+	if (expr->key->etype == EXPR_MAPPING)
+		return expr->key->left;
+
+	return expr->key;
 }
 
 static struct expr *get_set_interval_find(const struct set *cache_set,
@@ -528,7 +523,7 @@ static struct expr *interval_to_range(struct expr *low, struct expr *i, mpz_t ra
 }
 
 static void
-add_interval(struct expr *set, struct expr *low, struct expr *i)
+add_interval(struct expr *set, struct expr *low, struct expr *i, bool closed)
 {
 	struct expr *expr;
 	mpz_t range, p;
@@ -537,7 +532,7 @@ add_interval(struct expr *set, struct expr *low, struct expr *i)
 	mpz_init(p);
 
 	mpz_sub(range, expr_value(i)->value, expr_value(low)->value);
-	if (i->etype != EXPR_VALUE)
+	if (closed)
 		mpz_sub_ui(range, range, 1);
 
 	mpz_and(p, expr_value(low)->value, range);
@@ -633,7 +628,7 @@ void interval_map_decompose(struct expr *set)
 			}
 		}
 
-		add_interval(set, low, i);
+		add_interval(set, low, i, true);
 
 		if (i->key->flags & EXPR_F_INTERVAL_END) {
 			expr_free(low);
@@ -648,11 +643,12 @@ void interval_map_decompose(struct expr *set)
 	i = constant_expr_alloc(&low->location, low->dtype,
 				low->byteorder, expr_value(low)->len, NULL);
 	mpz_bitmask(i->value, i->len);
+	i = set_elem_expr_alloc(&low->location, i);
 
-	if (!mpz_cmp(i->value, expr_value(low)->value)) {
+	if (!mpz_cmp(i->key->value, expr_value(low)->value)) {
 		set_expr_add(set, low);
 	} else {
-		add_interval(set, low, i);
+		add_interval(set, low, i, false);
 		expr_free(low);
 	}
 
-- 
2.47.3


