Return-Path: <netfilter-devel+bounces-13300-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PSRvNjdhMmr9zAUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13300-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 10:56:23 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE4C697B2F
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 10:56:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackhole.kfki.hu header.s=20151130 header.b=ISe1LQBD;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13300-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13300-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC1D53117A2F
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B031C3E51F0;
	Wed, 17 Jun 2026 08:49:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC893DB630
	for <netfilter-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:49:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686159; cv=none; b=tyAKFcintvHxu/SKNkuSvgm8ipWgcYGiuJqUEMRjHF/gJruqM4A0RQ2HwtY1VZVm0UGwBCRrHUvksZ2xgBzGzkcnUg66U+2F6ue3K3mSF5mwtUbu/ShNkItgY/169Ow7D2QgGA1NVf05CSAn05aU/zNCte9d9uGBcYgcy+pGdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686159; c=relaxed/simple;
	bh=tu+erhzBZnVNrWQdpsjdbiIJA+5157XQv71ZV/C3+qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6RmiJPPLgoymHtZhVl0j7JVXcr1kR6HBFo5Q+1BbrVPiZTpiKeAFUsmOmIjoyg9oYeovTg4MLiCaJrY0xOk+oDGI4oklnXi7UojFe1SF7FTRMPZgnW0o9BTTWOPfCb7kdTxbxzviVoc1pmSVSvHeQbS3PFfgf4StJxLtFv/K4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=ISe1LQBD; arc=none smtp.client-ip=148.6.0.49
Received: from localhost (localhost [127.0.0.1])
	by smtp0.kfki.hu (Postfix) with ESMTP id 4ggHQN5FJ5z3sb0b;
	Wed, 17 Jun 2026 10:41:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:from:from:received:received
	:received; s=20151130; t=1781685690; x=1783500091; bh=7GjbYDLURB
	6QR7tF4yORzterPGcO08IBtSzSEj1m0T8=; b=ISe1LQBDWm9mqyJeUE/DM7qBVW
	PC/wOiGhOeIq3c4wP9tpmjFtMqDS/Or6wG5aDvYbITY6+rzOnPPMteG/LpgNfM9e
	04d6LgQeDnZyC/WxPpVKDPjOa0d1F8Yv3VLgLS1JkkIQ2LS7LGyn3LZgHoI905FA
	EAYtRsghm1BR7ggVU=
X-Virus-Scanned: Debian amavis at smtp0.kfki.hu
Received: from smtp0.kfki.hu ([127.0.0.1])
 by localhost (smtp0.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id NgnPG8q-CzK6; Wed, 17 Jun 2026 10:41:30 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (unknown [148.6.40.64])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp0.kfki.hu (Postfix) with ESMTPSA id 4ggHQJ6PSbz3sb0d;
	Wed, 17 Jun 2026 10:41:28 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id ACA641406DC; Wed, 17 Jun 2026 10:41:28 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v3 4/7] netfilter: ipset: exlude gc when resize is in progress
Date: Wed, 17 Jun 2026 10:41:25 +0200
Message-Id: <20260617084128.6603-5-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260617084128.6603-1-kadlec@netfilter.org>
References: <20260617084128.6603-1-kadlec@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13300-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EE4C697B2F

Zhengchuan Liang reported that because resize does not copy
the comment extension into the resized set but uses it's pointer,
ongoing gc can free the extension in the original set which then
results stale pointer in the resized one. The proposed patch was
to recreate the extensions for every element in the resized set.
It is both expensive and wastes memory, so better exclude gc
when resizing in progress detected: resizing will destroy
the original set anyway, so doing gc on it is unnecessary.

Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reported by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/=
ip_set_hash_gen.h
index 00c27b95207f..662942101200 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -84,6 +84,7 @@ struct htable {
 	atomic_t uref;		/* References for dumping and gc */
 	u8 htable_bits;		/* size of hash table =3D=3D 2^htable_bits */
 	u32 maxelem;		/* Maxelem per region */
+	spinlock_t gc_lock;	/* Lock to exclude gc and resize */
 	struct ip_set_region *hregion;	/* Region locks and ext sizes */
 	struct hbucket __rcu *bucket[]; /* hashtable buckets */
 };
@@ -569,7 +570,7 @@ mtype_gc(struct work_struct *work)
 	set =3D gc->set;
 	h =3D set->data;
=20
-	spin_lock_bh(&set->lock);
+	rcu_read_lock_bh();
 	t =3D ipset_dereference_set(h->table, set);
 	atomic_inc(&t->uref);
 	numof_locks =3D ahash_numof_locks(t->htable_bits);
@@ -580,9 +581,11 @@ mtype_gc(struct work_struct *work)
 	next_run =3D (IPSET_GC_PERIOD(set->timeout) * HZ) / numof_locks;
 	if (next_run < HZ/10)
 		next_run =3D HZ/10;
-	spin_unlock_bh(&set->lock);
+	rcu_read_unlock_bh();
=20
+	spin_lock_bh(&t->gc_lock);
 	mtype_gc_do(set, h, t, r);
+	spin_unlock_bh(&t->gc_lock);
=20
 	if (atomic_dec_and_test(&t->uref) && atomic_read(&t->ref)) {
 		pr_debug("Table destroy after resize by expire: %p\n", t);
@@ -679,6 +682,7 @@ mtype_resize(struct ip_set *set, bool retried)
 	atomic_inc(&orig->uref);
 	pr_debug("attempt to resize set %s from %u to %u, t %p\n",
 		 set->name, orig->htable_bits, htable_bits, orig);
+	spin_lock_bh(&orig->gc_lock);
 	for (r =3D 0; r < ahash_numof_locks(orig->htable_bits); r++) {
 		/* Expire may replace a hbucket with another one */
 		rcu_read_lock_bh();
@@ -692,8 +696,13 @@ mtype_resize(struct ip_set *set, bool retried)
 				if (!test_bit_acquire(j, n->used))
 					continue;
 				data =3D ahash_data(n, j, dsize);
-				if (SET_ELEM_EXPIRED(set, data))
-					continue;
+				/* Parallel gc is excluded so we copy
+				 * the already expired elements too.
+				 * - If resize succeeds next gc on new
+				 *   hash will purge the entries.
+				 * - If resize fails next gc on the
+				 *   original hash will do the cleanup.
+				 */
 #ifdef IP_SET_HASH_WITH_NETS
 				/* We have readers running parallel with us,
 				 * so the live data cannot be modified.
@@ -755,6 +764,7 @@ mtype_resize(struct ip_set *set, bool retried)
 		}
 		rcu_read_unlock_bh();
 	}
+	spin_unlock_bh(&orig->gc_lock);
=20
 	/* There can't be any other writer. */
 	rcu_assign_pointer(h->table, t);
@@ -792,6 +802,7 @@ mtype_resize(struct ip_set *set, bool retried)
=20
 cleanup:
 	rcu_read_unlock_bh();
+	spin_unlock_bh(&orig->gc_lock);
 	atomic_set(&orig->ref, 0);
 	atomic_dec(&orig->uref);
 	mtype_ahash_destroy(set, t, false);
@@ -1619,6 +1630,7 @@ IPSET_TOKEN(HTYPE, _create)(struct net *net, struct=
 ip_set *set,
 	}
 	t->htable_bits =3D hbits;
 	t->maxelem =3D h->maxelem / ahash_numof_locks(hbits);
+	spin_lock_init(&t->gc_lock);
 	RCU_INIT_POINTER(h->table, t);
=20
 	INIT_LIST_HEAD(&h->ad);
--=20
2.39.5


