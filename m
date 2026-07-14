Return-Path: <netfilter-devel+bounces-13933-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p4YwHZc5VmoO1wAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13933-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 15:28:55 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A8D7551CE
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 15:28:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13933-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13933-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F5D532C60FB
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410525B093;
	Tue, 14 Jul 2026 13:19:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A042274B5F
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Jul 2026 13:18:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035141; cv=none; b=VsNvoe+y9dybDvGH1vc9xZS78D4Lt+/+LD4OkpQWFDA6Pi5wmnno38OqrcLKuPsyHCeZ7iDi7Nn6ptoETWU4MZoibwyhnfUwJ8JiJPHx/sEDqeKReHOEXM496VSC/0yo6DTos2YvoW85x/CdG8lD0RttRRffZQy1u2viVuK4uMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035141; c=relaxed/simple;
	bh=jCybzB0qyyMqqlychr2btla2tkoeNP80sY6bRhzjvrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q46N6jO3SIWPTKw6SfelEpa+B9P9R4Cws8KcNWBnNlziVscNvVQdIMjYENv/5BQSF1JcMbid/BaQso+u7ZDo/FXvNZI/EnlYV4MYEgGhMFV0L8H1mHXvszCyv0dC9JqLUf/EfeiSDqdQT9WWKVMMXFfYmBauJIESApGad4yuzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E0203606E9; Tue, 14 Jul 2026 15:18:57 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: kadlec@netfilter.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH RFC nf-next 04/12] netfilter: ipset: add and use mtype_del_cidr_all helper
Date: Tue, 14 Jul 2026 15:18:20 +0200
Message-ID: <20260714131828.10685-5-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714131828.10685-1-fw@strlen.de>
References: <20260714131828.10685-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13933-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:kadlec@netfilter.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,strlen.de:from_mime,strlen.de:email,strlen.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0A8D7551CE

Makes upcoming rewrite a bit easier on the eyes.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 34 +++++++++++++--------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index ac957a1d5f24..129f06ed85f8 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -194,6 +194,7 @@ static const union nf_inet_addr zeromask = {};
 #undef mtype_ext_cleanup
 #undef mtype_add_cidr
 #undef mtype_del_cidr
+#undef mtype_del_cidr_all
 #undef mtype_ahash_memsize
 #undef mtype_flush
 #undef mtype_destroy
@@ -241,6 +242,7 @@ static const union nf_inet_addr zeromask = {};
 #define mtype_ext_cleanup	IPSET_TOKEN(MTYPE, _ext_cleanup)
 #define mtype_add_cidr		IPSET_TOKEN(MTYPE, _add_cidr)
 #define mtype_del_cidr		IPSET_TOKEN(MTYPE, _del_cidr)
+#define mtype_del_cidr_all	IPSET_TOKEN(MTYPE, _del_cidr_all)
 #define mtype_ahash_memsize	IPSET_TOKEN(MTYPE, _ahash_memsize)
 #define mtype_flush		IPSET_TOKEN(MTYPE, _flush)
 #define mtype_destroy		IPSET_TOKEN(MTYPE, _destroy)
@@ -411,6 +413,17 @@ mtype_del_cidr(struct ip_set *set, struct htype *h, u8 cidr, u8 n)
 }
 #endif
 
+static void
+mtype_del_cidr_all(struct ip_set *set, struct htype *h, const struct mtype_elem *data)
+{
+#ifdef IP_SET_HASH_WITH_NETS
+	int k;
+
+	for (k = 0; k < IPSET_NET_COUNT; k++)
+		mtype_del_cidr(set, h, DCIDR_GET(data->cidr, k), k);
+#endif
+}
+
 /* Calculate the actual memory size of the set data */
 static size_t
 mtype_ahash_memsize(const struct htype *h, const struct htable *t)
@@ -552,9 +565,6 @@ mtype_gc_do(struct ip_set *set, struct htype *h, struct htable *t, u32 r)
 	struct mtype_elem *data;
 	u32 i, j, d;
 	size_t dsize = set->dsize;
-#ifdef IP_SET_HASH_WITH_NETS
-	u8 k;
-#endif
 	u8 pos, htable_bits = t->htable_bits;
 
 	spin_lock_bh(&t->hregion[r].lock);
@@ -575,11 +585,7 @@ mtype_gc_do(struct ip_set *set, struct htype *h, struct htable *t, u32 r)
 			pr_debug("expired %u/%u\n", i, j);
 			clear_bit(j, n->used);
 			smp_mb__after_atomic();
-#ifdef IP_SET_HASH_WITH_NETS
-			for (k = 0; k < IPSET_NET_COUNT; k++)
-				mtype_del_cidr(set, h,
-					DCIDR_GET(data->cidr, k), k);
-#endif
+			mtype_del_cidr_all(set, h, data);
 			t->hregion[r].elements--;
 			ip_set_ext_destroy(set, data);
 			d++;
@@ -1005,11 +1011,7 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 			j = 0;
 		data = ahash_data(n, j, set->dsize);
 		if (!deleted) {
-#ifdef IP_SET_HASH_WITH_NETS
-			for (i = 0; i < IPSET_NET_COUNT; i++)
-				mtype_del_cidr(set, h,
-					DCIDR_GET(data->cidr, i), i);
-#endif
+			mtype_del_cidr_all(set, h, data);
 			ip_set_ext_destroy(set, data);
 			t->hregion[r].elements--;
 		}
@@ -1164,11 +1166,7 @@ mtype_del(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 		if (i + 1 == pos)
 			smp_store_release(&n->pos, --pos);
 		t->hregion[r].elements--;
-#ifdef IP_SET_HASH_WITH_NETS
-		for (j = 0; j < IPSET_NET_COUNT; j++)
-			mtype_del_cidr(set, h,
-				DCIDR_GET(d->cidr, j), j);
-#endif
+		mtype_del_cidr_all(set, h, d);
 		ip_set_ext_destroy(set, data);
 
 		if (t->resizing && ext && ext->target) {
-- 
2.54.0


