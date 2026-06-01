Return-Path: <netfilter-devel+bounces-12992-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LNlMrAEHmpRggkAu9opvQ
	(envelope-from <netfilter-devel+bounces-12992-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 02 Jun 2026 00:16:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B9625D62
	for <lists+netfilter-devel@lfdr.de>; Tue, 02 Jun 2026 00:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD6C1303C3D2
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jun 2026 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A6F374E47;
	Mon,  1 Jun 2026 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="NtDGOuEy"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4911368D4C
	for <netfilter-devel@vger.kernel.org>; Mon,  1 Jun 2026 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351893; cv=none; b=AFCkpI/AsAXX4zX/aOzRltL7ttcMUE+mDluMupz13nz7G3MVZEoQDxlNaUJFZBfjtr0Lz1Gjk3TB5nDeZeL/OB/Zn/zylTwSQyyi4fcsXk8aq4l5KHTy584d4nWnaiWvISGB95u5WuwYQhTqdSJkk74wl00wQR1YBpYAHIjC2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351893; c=relaxed/simple;
	bh=ha3Pp4aKjoxx+jhcNgDAbcdjp8AtEir+Tj4PogbMIZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8fzOSxKH9bD/pJCv9g3J82zDSWcUo/knFy4xOiCE1bCtwRS+2CFxODNfp9PgsC00NDOY3Y26VzYPI/iWQ8MizbK3gZcGvh9R6qKtXtrtkoPUAiOD6UWFGiLLLBphQOs/fqDJcMUdqzp2d4MFzT9tII3VUFXAu6uZDDFAXnVbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=NtDGOuEy; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 33FBD601AC;
	Tue,  2 Jun 2026 00:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780351890;
	bh=00xefjxoXkGeMH5bBmRPqhTmRyNw2ibryG8X8nFI80Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtDGOuEy/rVT7a1ryNOFScPw/bK3xaXRvQ/B+vbLoL/MyUoVrLD9iRAquXLnpI3z/
	 +/ZFf2z3SkxBoTJQf15xxrqeAdmlRsDtVNv8vaGvwPAyF/GDFDjXT37Q33dfps0h4B
	 XTLrrvx3xAE/7x3K5/FgBLtCuZFfnEjD/u1vylXPPPOEBONoRo5sz4zoHhRUwuLC8y
	 hh3Z5S7rfdwYhVqdDxYtRwuOTIwGC1cwSggNqVkCLwCdtRAoYTDz2C4pv252wtnECq
	 ua27oUTOnyItNMM7UkhPzVXCnjAVkvqLXYhO/5fBTxu5G1wZBFdxO+YbTOkUeXDze/
	 1B2P8uu54J79w==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf-next,v2 5/5] netfilter: conntrack: revert ct extension genid infrastructure
Date: Tue,  2 Jun 2026 00:11:17 +0200
Message-ID: <20260601221117.570707-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601221117.570707-1-pablo@netfilter.org>
References: <20260601221117.570707-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-12992-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:email,netfilter.org:mid,netfilter.org:dkim]
X-Rspamd-Queue-Id: 8D0B9625D62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This infrastructure is not used anymore after moving ct timeout and
helper to use datapath refcount to track object use.

Revert commit c56716c69ce1 ("netfilter: extensions: introduce extension
genid count") this patch disables all ct extensions (leading to NULL)
for unconfirmed conntracks, when this is only targeted at ct helper and
ct timeout. There is also codebase that dereferences the ct extension
without checking for NULL which could lead to crash.

This also reverts commit 2843fb69980b ("netfilter: conntrack: add
nf_ct_iterate_destroy") since the sledgehammer approach does not work
with unconfirmed conntrack that are flying to sit in nfqueue, or
elsewhere, then allowing potential UaF on reinjection.

Fixes: c56716c69ce1 ("netfilter: extensions: introduce extension genid count")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: keep nf_ct_iterate_destroy() in place.

 include/net/netfilter/nf_conntrack_extend.h | 12 -----
 net/netfilter/nf_conntrack_core.c           | 58 ---------------------
 net/netfilter/nf_conntrack_extend.c         | 32 +-----------
 3 files changed, 1 insertion(+), 101 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_extend.h b/include/net/netfilter/nf_conntrack_extend.h
index 0b247248b032..fd5c4dbf72ca 100644
--- a/include/net/netfilter/nf_conntrack_extend.h
+++ b/include/net/netfilter/nf_conntrack_extend.h
@@ -38,7 +38,6 @@ enum nf_ct_ext_id {
 struct nf_ct_ext {
 	u8 offset[NF_CT_EXT_NUM];
 	u8 len;
-	unsigned int gen_id;
 	char data[] __aligned(8);
 };
 
@@ -52,8 +51,6 @@ static inline bool nf_ct_ext_exist(const struct nf_conn *ct, u8 id)
 	return (ct->ext && __nf_ct_ext_exist(ct->ext, id));
 }
 
-void *__nf_ct_ext_find(const struct nf_ct_ext *ext, u8 id);
-
 static inline void *nf_ct_ext_find(const struct nf_conn *ct, u8 id)
 {
 	struct nf_ct_ext *ext = ct->ext;
@@ -61,19 +58,10 @@ static inline void *nf_ct_ext_find(const struct nf_conn *ct, u8 id)
 	if (!ext || !__nf_ct_ext_exist(ext, id))
 		return NULL;
 
-	if (unlikely(ext->gen_id))
-		return __nf_ct_ext_find(ext, id);
-
 	return (void *)ct->ext + ct->ext->offset[id];
 }
 
 /* Add this type, returns pointer to data or NULL. */
 void *nf_ct_ext_add(struct nf_conn *ct, enum nf_ct_ext_id id, gfp_t gfp);
 
-/* ext genid.  if ext->id != ext_genid, extensions cannot be used
- * anymore unless conntrack has CONFIRMED bit set.
- */
-extern atomic_t nf_conntrack_ext_genid;
-void nf_ct_ext_bump_genid(void);
-
 #endif /* _NF_CONNTRACK_EXTEND_H */
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 31e0bae1d75d..e3b03a58de97 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -840,33 +840,6 @@ static void __nf_conntrack_hash_insert(struct nf_conn *ct,
 			   &nf_conntrack_hash[reply_hash]);
 }
 
-static bool nf_ct_ext_valid_pre(const struct nf_ct_ext *ext)
-{
-	/* if ext->gen_id is not equal to nf_conntrack_ext_genid, some extensions
-	 * may contain stale pointers to e.g. helper that has been removed.
-	 *
-	 * The helper can't clear this because the nf_conn object isn't in
-	 * any hash and synchronize_rcu() isn't enough because associated skb
-	 * might sit in a queue.
-	 */
-	return !ext || ext->gen_id == atomic_read(&nf_conntrack_ext_genid);
-}
-
-static bool nf_ct_ext_valid_post(struct nf_ct_ext *ext)
-{
-	if (!ext)
-		return true;
-
-	if (ext->gen_id != atomic_read(&nf_conntrack_ext_genid))
-		return false;
-
-	/* inserted into conntrack table, nf_ct_iterate_cleanup()
-	 * will find it.  Disable nf_ct_ext_find() id check.
-	 */
-	WRITE_ONCE(ext->gen_id, 0);
-	return true;
-}
-
 int
 nf_conntrack_hash_check_insert(struct nf_conn *ct)
 {
@@ -882,9 +855,6 @@ nf_conntrack_hash_check_insert(struct nf_conn *ct)
 
 	zone = nf_ct_zone(ct);
 
-	if (!nf_ct_ext_valid_pre(ct->ext))
-		return -EAGAIN;
-
 	local_bh_disable();
 	do {
 		sequence = read_seqcount_begin(&nf_conntrack_generation);
@@ -918,18 +888,6 @@ nf_conntrack_hash_check_insert(struct nf_conn *ct)
 			goto chaintoolong;
 	}
 
-	/* If genid has changed, we can't insert anymore because ct
-	 * extensions could have stale pointers and nf_ct_iterate_destroy
-	 * might have completed its table scan already.
-	 *
-	 * Increment of the ext genid right after this check is fine:
-	 * nf_ct_iterate_destroy blocks until locks are released.
-	 */
-	if (!nf_ct_ext_valid_post(ct->ext)) {
-		err = -EAGAIN;
-		goto out;
-	}
-
 	smp_wmb();
 	/* The caller holds a reference to this object */
 	refcount_set(&ct->ct_general.use, 2);
@@ -1257,11 +1215,6 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 		return NF_DROP;
 	}
 
-	if (!nf_ct_ext_valid_pre(ct->ext)) {
-		NF_CT_STAT_INC(net, insert_failed);
-		goto dying;
-	}
-
 	/* We have to check the DYING flag after unlink to prevent
 	 * a race against nf_ct_get_next_corpse() possibly called from
 	 * user context, else we insert an already 'dead' hash, blocking
@@ -1324,16 +1277,6 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 	nf_conntrack_double_unlock(hash, reply_hash);
 	local_bh_enable();
 
-	/* ext area is still valid (rcu read lock is held,
-	 * but will go out of scope soon, we need to remove
-	 * this conntrack again.
-	 */
-	if (!nf_ct_ext_valid_post(ct->ext)) {
-		nf_ct_kill(ct);
-		NF_CT_STAT_INC_ATOMIC(net, drop);
-		return NF_DROP;
-	}
-
 	help = nfct_help(ct);
 	if (help && help->helper)
 		nf_conntrack_event_cache(IPCT_HELPER, ct);
@@ -2439,7 +2382,6 @@ nf_ct_iterate_destroy(int (*iter)(struct nf_conn *i, void *data), void *data)
 	 */
 	synchronize_net();
 
-	nf_ct_ext_bump_genid();
 	iter_data.data = data;
 	nf_ct_iterate_cleanup(iter, &iter_data);
 
diff --git a/net/netfilter/nf_conntrack_extend.c b/net/netfilter/nf_conntrack_extend.c
index dd62cc12e775..0da105e1ded9 100644
--- a/net/netfilter/nf_conntrack_extend.c
+++ b/net/netfilter/nf_conntrack_extend.c
@@ -27,8 +27,6 @@
 
 #define NF_CT_EXT_PREALLOC	128u /* conntrack events are on by default */
 
-atomic_t nf_conntrack_ext_genid __read_mostly = ATOMIC_INIT(1);
-
 static const u8 nf_ct_ext_type_len[NF_CT_EXT_NUM] = {
 	[NF_CT_EXT_HELPER] = sizeof(struct nf_conn_help),
 #if IS_ENABLED(CONFIG_NF_NAT)
@@ -118,10 +116,8 @@ void *nf_ct_ext_add(struct nf_conn *ct, enum nf_ct_ext_id id, gfp_t gfp)
 	if (!new)
 		return NULL;
 
-	if (!ct->ext) {
+	if (!ct->ext)
 		memset(new->offset, 0, sizeof(new->offset));
-		new->gen_id = atomic_read(&nf_conntrack_ext_genid);
-	}
 
 	new->offset[id] = newoff;
 	new->len = newlen;
@@ -131,29 +127,3 @@ void *nf_ct_ext_add(struct nf_conn *ct, enum nf_ct_ext_id id, gfp_t gfp)
 	return (void *)new + newoff;
 }
 EXPORT_SYMBOL(nf_ct_ext_add);
-
-/* Use nf_ct_ext_find wrapper. This is only useful for unconfirmed entries. */
-void *__nf_ct_ext_find(const struct nf_ct_ext *ext, u8 id)
-{
-	unsigned int gen_id = atomic_read(&nf_conntrack_ext_genid);
-	unsigned int this_id = READ_ONCE(ext->gen_id);
-
-	if (!__nf_ct_ext_exist(ext, id))
-		return NULL;
-
-	if (this_id == 0 || ext->gen_id == gen_id)
-		return (void *)ext + ext->offset[id];
-
-	return NULL;
-}
-EXPORT_SYMBOL(__nf_ct_ext_find);
-
-void nf_ct_ext_bump_genid(void)
-{
-	unsigned int value = atomic_inc_return(&nf_conntrack_ext_genid);
-
-	if (value == UINT_MAX)
-		atomic_set(&nf_conntrack_ext_genid, 1);
-
-	msleep(HZ);
-}
-- 
2.47.3


