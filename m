Return-Path: <netfilter-devel+bounces-10641-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPvrFpIDhGmHwwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10641-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:42:26 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1B6EE0D9
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4893E302731D
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 02:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9CC2C0F7A;
	Thu,  5 Feb 2026 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="KtgP0GTa"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD302C0F68
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259303; cv=none; b=p3hYJA58RnCAHaXlrqldMCds73x0pn6E8QOmmylGBJeA44tbsIdF8osD+C88NGNGFck5j+Ngh6+pkmTh7jHG0Rkt/iTmfGsoicoLhCWADvGGIIQlCQD4xzu9S9tq2YymEY5wOhedwGg8oj2ulHbC3WgDZVFNfMAAs84BiXhcH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259303; c=relaxed/simple;
	bh=wIQrgb4yT7socSkzHUMM9ecb5OtBmKaeEFIBNIcen8k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKF9LV1KLIEN4UJDayM7pY5VnDozQ8oAF87KJ7C8OWivHGnYvuhyI1Q8UOv91UwvxoyPo3SPdSj5v71J4XGeuqvvF3Ofgw7wPEp3i2wEXtQZRdYf6HA47BPv6acmSiyTmMK4xRLIRu2fCtj1qgSLO1viPsQRljGQ8Eo1D6BmTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=KtgP0GTa; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C88E46087F
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 03:41:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770259301;
	bh=RIDITRPHRV+1cvuIXhcZZLX8tExFz0c0Ghi9NVAhSCA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KtgP0GTacG/ggUsO3inQGLR4trTefeix+ZkY0iJ4HUsmJoc/e2QHa5YrfOvfdFtvu
	 OKfz9PzGtmptO+FEupcT4Y4+2Ty/un/uhTUCycnIcXQFRM1LXajHtrebZ2xEZvu4ea
	 WDtZNO23SIltyIVEZu5Aov/SYHH820tUJOfWXXC9wA45YpdlXvnl8iMe2bIpbZvyZ0
	 RpS7+l1RA71NjN0EAc7ppEMGqymKM1gSKySS//rya/8Wq7HugVRi8xf1oc0AzR0FW2
	 zTHbkbwHGvUL27znAnTF63UiaKgVjyje8u5M9NJjwyjiJjecZkkCtSHasbNea5vcHi
	 NyXYiDcYiok5w==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft 06/20] segtree: rename set_elem_add() to set_elem_expr_add()
Date: Thu,  5 Feb 2026 03:41:15 +0100
Message-ID: <20260205024130.1470284-7-pablo@netfilter.org>
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
	TAGGED_FROM(0.00)[bounces-10641-lists,netfilter-devel=lfdr.de];
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
X-Rspamd-Queue-Id: 1E1B6EE0D9
X-Rspamd-Action: no action

Just a clean up, to prepare for the introduction of struct set_elem
that will provide a set_elem_add() function again.

Rename it now to leave room for such future change.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/segtree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/segtree.c b/src/segtree.c
index 90e4a616edf0..bf543b9b91ab 100644
--- a/src/segtree.c
+++ b/src/segtree.c
@@ -53,8 +53,8 @@ static void interval_expr_copy(struct expr *dst, struct expr *src)
 	list_splice_init(&src->stmt_list, &dst->stmt_list);
 }
 
-static void set_elem_add(const struct set *set, struct expr *init, mpz_t value,
-			 uint32_t flags, enum byteorder byteorder)
+static void set_elem_expr_add(const struct set *set, struct expr *init,
+			      mpz_t value, uint32_t flags, enum byteorder byteorder)
 {
 	struct expr *expr;
 
@@ -84,8 +84,8 @@ struct expr *get_set_intervals(const struct set *set, const struct expr *init)
 
 		switch (i->key->etype) {
 		case EXPR_VALUE:
-			set_elem_add(set, new_init, i->key->value,
-				     i->flags, byteorder);
+			set_elem_expr_add(set, new_init, i->key->value,
+					  i->flags, byteorder);
 			break;
 		case EXPR_CONCAT:
 			set_expr_add(new_init, expr_clone(i));
@@ -97,11 +97,11 @@ struct expr *get_set_intervals(const struct set *set, const struct expr *init)
 			break;
 		default:
 			range_expr_value_low(low, i);
-			set_elem_add(set, new_init, low, 0, i->byteorder);
+			set_elem_expr_add(set, new_init, low, 0, i->byteorder);
 			range_expr_value_high(high, i);
 			mpz_add_ui(high, high, 1);
-			set_elem_add(set, new_init, high,
-				     EXPR_F_INTERVAL_END, i->byteorder);
+			set_elem_expr_add(set, new_init, high,
+					  EXPR_F_INTERVAL_END, i->byteorder);
 			break;
 		}
 	}
-- 
2.47.3


