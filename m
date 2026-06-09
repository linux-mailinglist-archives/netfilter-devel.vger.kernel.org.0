Return-Path: <netfilter-devel+bounces-13139-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dmOTMS/DJ2ru1gIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13139-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 09:39:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A3865D4D7
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 09:39:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackhole.kfki.hu header.s=20151130 header.b=DJzq8iMq;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13139-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13139-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76E5830068DD
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A3F3DDDB2;
	Tue,  9 Jun 2026 07:34:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED73DD518
	for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2026 07:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990497; cv=none; b=o9UBRzFktU0sh3JY2e64PpgA5yrzK/eN6cNPoYOKgdXEkVarD3r7/4Tt49I9b9iVmTpeSXOa/zYKc0adqYyo5HHpiMZNlYlrOCmTjsCXx/ziuYBISugK4UXgPR5QIdVx2NbE214v0+VYIf2vZuv5JKMAFdIfC+3Q4dCnPzT+a94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990497; c=relaxed/simple;
	bh=MayscQ7fj3XdqBoN85CuwGzd1lx4Z0mojTjuK6HiBI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LE5y2otGwMosRhfocck/78gian2U8K7GOy3W7H1IvKWa1Rkj85pD1OVSIAe1RHSjulb68EWfvdt6jr31rJLUsO8adLT2wjSrQtTacBWeCUVPbbbrmSBJTH/2Rx32/c9VCsxy+DX1ME3UTnDwOdIkGhavUDGc+KRtdGbF1bGm7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=DJzq8iMq; arc=none smtp.client-ip=148.6.0.49
Received: from localhost (localhost [127.0.0.1])
	by smtp0.kfki.hu (Postfix) with ESMTP id 4gZL954zqYz3sb0c;
	Tue, 09 Jun 2026 09:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:from:from:received:received
	:received; s=20151130; t=1780990071; x=1782804472; bh=AhWiJDZx9e
	2kkd7hd1RD33ZYvJjhyEiRh7gRaIBiTdw=; b=DJzq8iMq9UHqFsLBraIRy+RsLS
	q8qODKsDz+OlVlhxgzuiwGoRJx0GI9/fMh4bG3tkUWGpFcxT/BRvVCZuPPYh/v1w
	CiwYVelWVPoxxsoYl6PpCaYgNoOune6p+qiIZi2Naiw/W4JwbYmwr+bXiz/UonaE
	KjtH+jXqXgJMZ1rc4=
X-Virus-Scanned: Debian amavis at smtp0.kfki.hu
Received: from smtp0.kfki.hu ([127.0.0.1])
 by localhost (smtp0.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id Bp-xXlVTxBpD; Tue,  9 Jun 2026 09:27:51 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (254C0692.nat.pool.telekom.hu [37.76.6.146])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp0.kfki.hu (Postfix) with ESMTPSA id 4gZL925p5bz3sb0f;
	Tue, 09 Jun 2026 09:27:50 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id 4B922140B3C; Tue,  9 Jun 2026 09:27:50 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v2 4/9] netfilter: ipset: Extend the rcu locked area properly
Date: Tue,  9 Jun 2026 09:27:45 +0200
Message-Id: <20260609072750.318774-5-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260609072750.318774-1-kadlec@netfilter.org>
References: <20260609072750.318774-1-kadlec@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-deepspam: 20ham 11%
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-13139-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04A3865D4D7

The rcu locked areas not covered fully the parts which
worked on the rcu protected pointers. Also, in hash gc
we need to be rcu and not lock protected.

Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/=
ip_set_hash_gen.h
index 6ab32d3a827e..20678116ae32 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -569,8 +569,8 @@ mtype_gc(struct work_struct *work)
 	set =3D gc->set;
 	h =3D set->data;
=20
-	spin_lock_bh(&set->lock);
-	t =3D ipset_dereference_set(h->table, set);
+	rcu_read_lock_bh();
+	t =3D rcu_dereference_bh(h->table);
 	atomic_inc(&t->uref);
 	numof_locks =3D ahash_numof_locks(t->htable_bits);
 	r =3D gc->region++;
@@ -580,7 +580,6 @@ mtype_gc(struct work_struct *work)
 	next_run =3D (IPSET_GC_PERIOD(set->timeout) * HZ) / numof_locks;
 	if (next_run < HZ/10)
 		next_run =3D HZ/10;
-	spin_unlock_bh(&set->lock);
=20
 	mtype_gc_do(set, h, t, r);
=20
@@ -588,6 +587,7 @@ mtype_gc(struct work_struct *work)
 		pr_debug("Table destroy after resize by expire: %p\n", t);
 		mtype_ahash_destroy(set, t, false);
 	}
+	rcu_read_unlock_bh();
=20
 	queue_delayed_work(system_power_efficient_wq, &gc->dwork, next_run);
=20
@@ -865,9 +865,7 @@ mtype_add(struct ip_set *set, void *value, const stru=
ct ip_set_ext *ext,
 	if (elements >=3D maxelem) {
 		u32 e;
 		if (SET_WITH_TIMEOUT(set)) {
-			rcu_read_unlock_bh();
 			mtype_gc_do(set, h, t, r);
-			rcu_read_lock_bh();
 		}
 		maxelem =3D h->maxelem;
 		elements =3D 0;
@@ -876,7 +874,6 @@ mtype_add(struct ip_set *set, void *value, const stru=
ct ip_set_ext *ext,
 		if (elements >=3D maxelem && SET_WITH_FORCEADD(set))
 			forceadd =3D true;
 	}
-	rcu_read_unlock_bh();
=20
 	spin_lock_bh(&t->hregion[r].lock);
 	n =3D rcu_dereference_bh(hbucket(t, key));
@@ -1034,6 +1031,7 @@ mtype_add(struct ip_set *set, void *value, const st=
ruct ip_set_ext *ext,
 		pr_debug("Table destroy after resize by add: %p\n", t);
 		mtype_ahash_destroy(set, t, false);
 	}
+	rcu_read_unlock_bh();
 	return ret;
 }
=20
@@ -1062,7 +1060,6 @@ mtype_del(struct ip_set *set, void *value, const st=
ruct ip_set_ext *ext,
 	key =3D HKEY(value, h->initval, t->htable_bits);
 	r =3D ahash_region(key);
 	atomic_inc(&t->uref);
-	rcu_read_unlock_bh();
=20
 	spin_lock_bh(&t->hregion[r].lock);
 	n =3D rcu_dereference_bh(hbucket(t, key));
@@ -1148,6 +1145,7 @@ mtype_del(struct ip_set *set, void *value, const st=
ruct ip_set_ext *ext,
 		pr_debug("Table destroy after resize by del: %p\n", t);
 		mtype_ahash_destroy(set, t, false);
 	}
+	rcu_read_unlock_bh();
 	return ret;
 }
=20
--=20
2.39.5


