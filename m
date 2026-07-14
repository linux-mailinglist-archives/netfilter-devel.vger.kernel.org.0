Return-Path: <netfilter-devel+bounces-13939-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2rXLGQw5Vmrh1gAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13939-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 15:26:36 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECD0755140
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 15:26:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13939-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13939-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 360AD3085C0E
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 13:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E6628541A;
	Tue, 14 Jul 2026 13:19:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFA239567
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Jul 2026 13:19:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035166; cv=none; b=MX1Y7ouyy2Yc/5DcrlbbjbG11Wpkh7j9clPTjrGtlivJUmKN6NPEnr72bEbRkoPevHEekidNUS6QJHCRfX+XDWidYbDkRnHPSvMyC3E1zM3bV/f3TrNFxhASWmbWPP/r/Lpuqm6NE+QnDHPxrZU3ulJav/A4l1Z8NqMXvZ+7HL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035166; c=relaxed/simple;
	bh=x1f2DgliAn1icfm+POqcpAiwy7uyU1PSuIBDQRJIPBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhD3CMahaOok6wPqIpTxyQxFR35tozgAJ7T1YJzaoHI1HpSQnd59KpfSUilDOEYLLiyh9bm0lbFlbXBjm8vXCVRdveWZeeAofsERiCVx5Z/ZKJBjB5IUiWS9wWyjYiVGW5WjUhtYPlcCDweNqh+7QN4BVWagzAuU067fDsb39KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8A7D9607F4; Tue, 14 Jul 2026 15:19:23 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: kadlec@netfilter.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH RFC nf-next 10/12] netfilter: ipset: use correct lockdep annotation in ipset_dereference
Date: Tue, 14 Jul 2026 15:18:26 +0200
Message-ID: <20260714131828.10685-11-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13939-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:from_mime,strlen.de:email,strlen.de:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ECD0755140

Avoid always-true arguments where possible, they defeat lockdep.

ip_set_comment_free() is problematic: called from different contexts,
some hold set->lock spinlock (safe), some do not hold a lock but have other
means of mutual exclusion (e.g., entire set torn down).

Other callers need investigation: ip_set_comment_free() alters
set->ext_size in a non-atomic way.  I don't see how this is safe except
for "entire set is destroyed" case: parallel usage would be a bug.

Add a few lockdep assertions to ip_set_init_comment() callpaths to have
more confidence in the correctness of the
"Called from uadd only, protected by the set spinlock." comment at the
 start of ip_set_init_comment().

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter/ipset/ip_set.h | 3 +++
 net/netfilter/ipset/ip_set_core.c      | 3 +--
 net/netfilter/ipset/ip_set_hash_gen.h  | 6 ++----
 net/netfilter/ipset/ip_set_list_set.c  | 2 ++
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfilter/ipset/ip_set.h
index f9003ec21259..99bc997914f4 100644
--- a/include/linux/netfilter/ipset/ip_set.h
+++ b/include/linux/netfilter/ipset/ip_set.h
@@ -282,6 +282,9 @@ struct ip_set {
 	void *data;
 };
 
+#define ipset_dereference_locked(p, set)		\
+	rcu_dereference_protected(p, lockdep_is_held(&set->lock))
+
 static inline void
 __ip_set_destroy_comment(struct ip_set *set, void *data)
 {
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 6ece5cf305fe..a5f77f639d2a 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -346,8 +346,7 @@ void
 ip_set_init_comment(struct ip_set *set, struct ip_set_comment *comment,
 		    const struct ip_set_ext *ext)
 {
-	struct ip_set_comment_rcu *c = rcu_dereference_protected(comment->c,
-								 lockdep_is_held(&set->lock));
+	struct ip_set_comment_rcu *c = ipset_dereference_locked(comment->c, set);
 	size_t len = ext->comment ? strlen(ext->comment) : 0;
 
 	if (unlikely(c)) {
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index a0f2cd481b82..e615de2e616b 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -11,8 +11,6 @@
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/ipset/ip_set.h>
 
-#define __ipset_dereference(p)		\
-	rcu_dereference_protected(p, 1)
 #define ipset_dereference_nfnl(p)	\
 	rcu_dereference_protected(p,	\
 		lockdep_nfnl_is_held(NFNL_SUBSYS_IPSET))
@@ -271,7 +269,7 @@ mtype_add_cidr(struct ip_set *set, struct htype *h, u8 cidr, u8 n)
 	int i, j, found, len = 0, ret = 0;
 
 	spin_lock_bh(&set->lock);
-	nets = __ipset_dereference(h->rnets[n]);
+	nets = ipset_dereference_locked(h->rnets[n], set);
 	/* Add in increasing prefix order, so larger cidr first */
 	for (i = 0, found = -1; i < nets->len; i++) {
 		if (nets->nets[i].count)
@@ -323,7 +321,7 @@ mtype_del_cidr(struct ip_set *set, struct htype *h, u8 cidr, u8 n)
 	int found;
 
 	spin_lock_bh(&set->lock);
-	nets = __ipset_dereference(h->rnets[n]);
+	nets = ipset_dereference_locked(h->rnets[n], set);
 	for (i = 0, found = -1; i < nets->len; i++) {
 		if (nets->nets[i].count)
 			len++;
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index d7ddc57a4eca..27bc96458e13 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -326,6 +326,8 @@ list_set_udel(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	struct set_adt_elem *d = value;
 	struct set_elem *e, *n, *next, *prev = NULL;
 
+	lockdep_assert_held(&set->lock);
+
 	list_for_each_entry_safe(e, n, &map->members, list) {
 		if (SET_WITH_TIMEOUT(set) &&
 		    ip_set_timeout_expired(ext_timeout(e, set)))
-- 
2.54.0


