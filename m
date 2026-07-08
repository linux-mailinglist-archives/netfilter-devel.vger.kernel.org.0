Return-Path: <netfilter-devel+bounces-13737-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VxNGI/1ZTmqKLAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13737-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 16:09:01 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C707271E9
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 16:09:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13737-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13737-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 821083015449
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 14:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADF641B358;
	Wed,  8 Jul 2026 14:03:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E733FBEC4;
	Wed,  8 Jul 2026 14:03:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519436; cv=none; b=rfDi1sn046p8dct37UX5JD37V8t1obA/5XXMyw+2/vKlQv6ZvDscMR5HNioayWbr3BcBN6gnAqcGROo4JmPh1B0z1ectlCiLlxBruCDuZDILP/o5B1EAkkfuD1/AZjNgGv4vPSiREow2TSGiMM05mJL/vl9BcDjqF2bufYsKQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519436; c=relaxed/simple;
	bh=GZqqENE0CkOFzySmxRnTowzhlQZDflgw5mk43qPWkHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKqw542QNqPmbpo80nxc9fQgAilsLoUNRpZQ5kZwLp+bK5spHuX+gfQlMltQ+Za4TYA10YQZRe8b48ta0ZUx8T18QZcJrT7ZT7KUZ7L2pFdfpc2k8p0mmH12NRgA/ONAWC7J5VCrP1rfWcNvvTGKeUj34w2I560XTRW1DtzmprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5946160605; Wed, 08 Jul 2026 16:03:53 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 08/17] netfilter: ipset: cleanup the add/del backlog when resize failed
Date: Wed,  8 Jul 2026 16:03:00 +0200
Message-ID: <20260708140309.19633-9-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708140309.19633-1-fw@strlen.de>
References: <20260708140309.19633-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13737-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20C707271E9

From: Jozsef Kadlecsik <kadlec@netfilter.org>

Sashiko pointed out that the add/del backlog was not cleaned up
when resize failed. Fix it in the corresponding error path. Also,
make sure that the add/del backlog is htable-specific so when
resize creates a new htable, old/new backlog can't be mixed up.

Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 28 +++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 8104dbac02fa..c0132d0f4cc0 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -85,6 +85,7 @@ struct htable {
 	atomic_t uref;		/* References for dumping and gc */
 	u8 htable_bits;		/* size of hash table == 2^htable_bits */
 	u32 maxelem;		/* Maxelem per region */
+	struct list_head ad;	/* Resize add|del backlist */
 	struct ip_set_region *hregion;	/* Region locks and ext sizes */
 	struct hbucket __rcu *bucket[]; /* hashtable buckets */
 };
@@ -302,7 +303,6 @@ struct htype {
 	u8 netmask;		/* netmask value for subnets to store */
 	union nf_inet_addr bitmask;	/* stores bitmask */
 #endif
-	struct list_head ad;	/* Resize add|del backlist */
 	struct mtype_elem next; /* temporary storage for uadd */
 #ifdef IP_SET_HASH_WITH_NETS
 	struct net_prefixes nets[NLEN]; /* book-keeping of prefixes */
@@ -452,13 +452,14 @@ static void
 mtype_destroy(struct ip_set *set)
 {
 	struct htype *h = set->data;
+	struct htable *t = (__force struct htable *)h->table;
 	struct list_head *l, *lt;
 
-	mtype_ahash_destroy(set, (__force struct htable *)h->table, true);
-	list_for_each_safe(l, lt, &h->ad) {
+	list_for_each_safe(l, lt, &t->ad) {
 		list_del(l);
 		kfree(l);
 	}
+	mtype_ahash_destroy(set, t, true);
 	kfree(h);
 
 	set->data = NULL;
@@ -672,6 +673,7 @@ mtype_resize(struct ip_set *set, bool retried)
 	}
 	t->htable_bits = htable_bits;
 	t->maxelem = h->maxelem / ahash_numof_locks(htable_bits);
+	INIT_LIST_HEAD(&t->ad);
 	for (i = 0; i < ahash_numof_locks(htable_bits); i++)
 		spin_lock_init(&t->hregion[i].lock);
 
@@ -774,7 +776,7 @@ mtype_resize(struct ip_set *set, bool retried)
 	 * Kernel-side add cannot trigger a resize and userspace actions
 	 * are serialized by the mutex.
 	 */
-	list_for_each_safe(l, lt, &h->ad) {
+	list_for_each_safe(l, lt, &orig->ad) {
 		x = list_entry(l, struct mtype_resize_ad, list);
 		if (x->ad == IPSET_ADD) {
 			mtype_add(set, &x->d, &x->ext, &x->mext, x->flags);
@@ -801,10 +803,21 @@ mtype_resize(struct ip_set *set, bool retried)
 	spin_lock_bh(&h->gc.lock);
 	orig->resizing = false;
 	spin_unlock_bh(&h->gc.lock);
+	/* Make sure parallel readers see that orig->resizing is false
+	 * before we decrement uref */
+	synchronize_rcu();
 	atomic_dec(&orig->uref);
 	mtype_ahash_destroy(set, t, false);
 	if (ret == -EAGAIN)
 		goto retry;
+
+	/* Cleanup the backlog of ADD/DEL elements */
+	spin_lock_bh(&set->lock);
+	list_for_each_safe(l, lt, &orig->ad) {
+		list_del(l);
+		kfree(l);
+	}
+	spin_unlock_bh(&set->lock);
 	goto out;
 
 hbwarn:
@@ -1022,7 +1035,7 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 		memcpy(&x->mext, mext, sizeof(struct ip_set_ext));
 		x->flags = flags;
 		spin_lock_bh(&set->lock);
-		list_add_tail(&x->list, &h->ad);
+		list_add_tail(&x->list, &t->ad);
 		spin_unlock_bh(&set->lock);
 	}
 	goto out;
@@ -1146,7 +1159,7 @@ mtype_del(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	spin_unlock_bh(&t->hregion[r].lock);
 	if (x) {
 		spin_lock_bh(&set->lock);
-		list_add(&x->list, &h->ad);
+		list_add(&x->list, &t->ad);
 		spin_unlock_bh(&set->lock);
 	}
 	if (atomic_dec_and_test(&t->uref) && t->resizing) {
@@ -1625,9 +1638,8 @@ IPSET_TOKEN(HTYPE, _create)(struct net *net, struct ip_set *set,
 	}
 	t->htable_bits = hbits;
 	t->maxelem = h->maxelem / ahash_numof_locks(hbits);
+	INIT_LIST_HEAD(&t->ad);
 	RCU_INIT_POINTER(h->table, t);
-
-	INIT_LIST_HEAD(&h->ad);
 	set->data = h;
 #ifndef IP_SET_PROTO_UNDEF
 	if (set->family == NFPROTO_IPV4) {
-- 
2.54.0


