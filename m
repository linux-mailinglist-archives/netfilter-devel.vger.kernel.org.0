Return-Path: <netfilter-devel+bounces-13600-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WCErJrxdRmpiRwsAu9opvQ
	(envelope-from <netfilter-devel+bounces-13600-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 14:46:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65F6F7D95
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 14:46:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=ISfcySSD;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13600-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13600-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A13B03028016
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jul 2026 12:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4585B47DF8A;
	Thu,  2 Jul 2026 12:36:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1939A4CF
	for <netfilter-devel@vger.kernel.org>; Thu,  2 Jul 2026 12:36:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995802; cv=none; b=H+cTrsKs8vkCU++qYBwuLByikkg6+tJcrm/lesPHLAu8xyBLPZ4ewE6u53vFGfXru3fhDb7Rl+3VpWpAhYmkJtrgYXXRbMMYIFS2P10BjLRYoxybsfj/EqU6vp41hoK4CZLpaWwDyMJD8HcyFc9/VKIosO2Bh8GqnNoqYKTmB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995802; c=relaxed/simple;
	bh=Oc3WlKUETG7EkL+5TVSDOJqeWlTqWMSZ0nbzNdGJTKQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CFGhk5zRopT5ZyofBmDEnWyrcRRDNPJbxV0KNitqZC8+1dBlgZ1qcz+OGIyZg+zQuhfNtI+UTjPQrsTmfmdS9VzmgQEXRh5+pbl1D6dRK4V2uMCM94gg5xqRx3XuciIkQLIEeBzZk6bOK3t7iDHPwFFYVJr8LoqKrp6q/LylrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ISfcySSD; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 7E8446057B
	for <netfilter-devel@vger.kernel.org>; Thu,  2 Jul 2026 14:36:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782995798;
	bh=i2PDZt6teaZp9dEQNn95JG6IdDAFamH0ll+wbfLFiEI=;
	h=From:To:Subject:Date:From;
	b=ISfcySSDffsi+q9Urk9ZER4L3Y1tUErAizHjs7yVcOD4AdGNnsWf/UEcxJ/m04XHz
	 CJBEw+C8/pKoEO2ThPOCSa3yIjCrx/de6UC6CXkpbZAVk/RrPHrVVwOUkamXGaSCb5
	 qXm8n61tzkAKts2N58ApIhbhGjijdRuurwNOCsltic8fkudJ/t5TX03D7DZNGhXul3
	 7rbFAFg5yWG32k8lnnd00zJe5ItjTIsBhkUhMcs9YaKaAXF2DGzMIxnuToVxxB1+Qt
	 zPJdfalQVVvpykHw2YuBaroc8+7DV+XtQYn/F/o7lx/0DINuYdCA4ID+IPEGEyghUx
	 BhqG7UYbfjqVQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] segtree: fix get element command with open intervals
Date: Thu,  2 Jul 2026 14:36:33 +0200
Message-ID: <20260702123634.349861-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13600-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE65F6F7D95

Skip the closing end element in case this is an open interval.
Otherwise, a bogus end element max(type) + 1 is provided, eg. in
inet_service, this results as a 0x10000 with end interval flag
which is interpreted by the kernel as a matching closing element.

Fixes: a43cc8d53096 ("src: support for get element command")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/segtree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/segtree.c b/src/segtree.c
index a12820bcf1ec..e877814505f4 100644
--- a/src/segtree.c
+++ b/src/segtree.c
@@ -73,12 +73,13 @@ static void set_elem_expr_add(const struct set *set, struct expr *init,
 struct expr *get_set_intervals(const struct set *set, const struct expr *init)
 {
 	enum byteorder byteorder = get_key_byteorder(set->key);
+	mpz_t low, high, mask;
 	struct expr *new_init;
-	mpz_t low, high;
 	struct expr *i;
 
 	mpz_init2(low, set->key->len);
 	mpz_init2(high, set->key->len);
+	mpz_init2(mask, set->key->len);
 
 	new_init = set_expr_alloc(&internal_location, NULL);
 
@@ -105,6 +106,10 @@ struct expr *get_set_intervals(const struct set *set, const struct expr *init)
 			range_expr_value_low(low, i->key);
 			set_elem_expr_add(set, new_init, low, 0, byteorder);
 			range_expr_value_high(high, i->key);
+			mpz_bitmask(mask, i->len);
+			if (!mpz_cmp(mask, high))
+				break;
+
 			mpz_add_ui(high, high, 1);
 			set_elem_expr_add(set, new_init, high,
 					  EXPR_F_INTERVAL_END, byteorder);
@@ -115,6 +120,7 @@ struct expr *get_set_intervals(const struct set *set, const struct expr *init)
 		}
 	}
 
+	mpz_clear(mask);
 	mpz_clear(low);
 	mpz_clear(high);
 
-- 
2.47.3


