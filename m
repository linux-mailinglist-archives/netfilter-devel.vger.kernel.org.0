Return-Path: <netfilter-devel+bounces-13935-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1v5gMK85VmoZ1wAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13935-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 15:29:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FF7551F1
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 15:29:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13935-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13935-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D9E9301BC1B
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 13:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD05A26B973;
	Tue, 14 Jul 2026 13:19:09 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA925392C
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Jul 2026 13:19:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035149; cv=none; b=CE/nGBiGmcZzVJjiLucW3mgvNbK4EfJF2xrr0tmOCmr8mfhSGBimxqsl4/9S6y4yyx72EJbS9y32TdtWsCFNJwc1RL95sETO/SnoGXX+99ukulFvHkKXAuNvvyNmrNJPxMXJtytfvGASEw5rR8GUY7sFnh1DNGG5O4mUfIlI/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035149; c=relaxed/simple;
	bh=l4gxUy4OJOtvpB6WQ49uuF5ZJFAmNqc3xO2oMm2gOeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byoE5Egodt5cs2TzWLDQlMH2fBKLl8esPt4R+pucZmPuQ1oeCCWEIMhnpKoxprlINNwRZCd1bhvzG4XIAx7QtV3QpT/zaVlqDMDLwug0i1MkUY/mkCSTefZAFbnoF+3C2vWi2Z0ZMS6wK6e/w867KSN+QApPXxiq3xru8+HinzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7199960503; Tue, 14 Jul 2026 15:19:06 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: kadlec@netfilter.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH RFC nf-next 06/12] netfilter: ipset: add and use ip_set_ext_destroy_slow
Date: Tue, 14 Jul 2026 15:18:22 +0200
Message-ID: <20260714131828.10685-7-fw@strlen.de>
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
	TAGGED_FROM(0.00)[bounces-13935-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:from_mime,strlen.de:email,strlen.de:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D4FF7551F1

same rationale as previous patch, however, this time we cannot
add lockdep assertion in ip_set_ext_destroy().

At this time the function has too many call sites where set->lock
is held (e.g. during set destruction).

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter/ipset/ip_set.h  | 24 ++++++++++++++++++++----
 net/netfilter/ipset/ip_set_bitmap_gen.h |  2 ++
 net/netfilter/ipset/ip_set_hash_gen.h   |  8 ++++----
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfilter/ipset/ip_set.h
index 50cd719bc270..f9003ec21259 100644
--- a/include/linux/netfilter/ipset/ip_set.h
+++ b/include/linux/netfilter/ipset/ip_set.h
@@ -282,17 +282,33 @@ struct ip_set {
 	void *data;
 };
 
+static inline void
+__ip_set_destroy_comment(struct ip_set *set, void *data)
+{
+	struct ip_set_comment *c = ext_comment(data, set);
+
+	ip_set_extensions[IPSET_EXT_ID_COMMENT].destroy(set, c);
+}
+
 static inline void
 ip_set_ext_destroy(struct ip_set *set, void *data)
 {
 	/* Check that the extension is enabled for the set and
 	 * call it's destroy function for its extension part in data.
 	 */
-	if (SET_WITH_COMMENT(set)) {
-		struct ip_set_comment *c = ext_comment(data, set);
+	if (SET_WITH_COMMENT(set))
+		__ip_set_destroy_comment(set, data);
+}
 
-		ip_set_extensions[IPSET_EXT_ID_COMMENT].destroy(set, c);
-	}
+static inline void
+ip_set_ext_destroy_slow(struct ip_set *set, void *data)
+{
+	if (!SET_WITH_COMMENT(set))
+		return;
+
+	spin_lock_bh(&set->lock);
+	__ip_set_destroy_comment(set, data);
+	spin_unlock_bh(&set->lock);
 }
 
 int ip_set_put_flags(struct sk_buff *skb, struct ip_set *set);
diff --git a/net/netfilter/ipset/ip_set_bitmap_gen.h b/net/netfilter/ipset/ip_set_bitmap_gen.h
index b13cde902c17..ca68b6e51214 100644
--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -182,6 +182,8 @@ mtype_del(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	const struct mtype_adt_elem *e = value;
 	void *x = get_ext(set, map, e->id);
 
+	lockdep_assert_held(&set->lock);
+
 	if (mtype_do_del(e, map))
 		return -IPSET_ERR_EXIST;
 
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index c3dda56d786c..1eff2c065bb3 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -443,7 +443,7 @@ mtype_ext_cleanup(struct ip_set *set, struct hbucket *n)
 
 	for (i = 0; i < pos; i++)
 		if (test_bit(i, n->used))
-			ip_set_ext_destroy(set, ahash_data(n, i, set->dsize));
+			ip_set_ext_destroy_slow(set, ahash_data(n, i, set->dsize));
 }
 
 /* Flush a hash type of set: destroy all elements */
@@ -587,7 +587,7 @@ mtype_gc_do(struct ip_set *set, struct htype *h, struct htable *t, u32 r)
 			smp_mb__after_atomic();
 			mtype_del_cidr_all(set, h, data);
 			t->hregion[r].elements--;
-			ip_set_ext_destroy(set, data);
+			ip_set_ext_destroy_slow(set, data);
 			d++;
 		}
 		if (d >= AHASH_INIT_SIZE) {
@@ -1012,7 +1012,7 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 		data = ahash_data(n, j, set->dsize);
 		if (!deleted) {
 			mtype_del_cidr_all(set, h, data);
-			ip_set_ext_destroy(set, data);
+			ip_set_ext_destroy_slow(set, data);
 			t->hregion[r].elements--;
 		}
 		goto copy_data;
@@ -1167,7 +1167,7 @@ mtype_del(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 			smp_store_release(&n->pos, --pos);
 		t->hregion[r].elements--;
 		mtype_del_cidr_all(set, h, d);
-		ip_set_ext_destroy(set, data);
+		ip_set_ext_destroy_slow(set, data);
 
 		if (t->resizing && ext && ext->target) {
 			/* Resize is in process and kernel side del,
-- 
2.54.0


