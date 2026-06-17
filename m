Return-Path: <netfilter-devel+bounces-13299-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id luGkMJ9kMmqYzQUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13299-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 11:10:55 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA884697C6F
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 11:10:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackhole.kfki.hu header.s=20151130 header.b=V7p8cbQW;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13299-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13299-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E1AB30C6FD2
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831853E0C41;
	Wed, 17 Jun 2026 08:49:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC33DE424
	for <netfilter-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:49:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686159; cv=none; b=WGvM8tJDRZiIzk2x1yMnj/4Rq+cMug1DrB4pNNF+EskXpM0vCUETLNv+kY0Q9UVIvj9ytg/2WCSjBo86RyABP6H1jC27aNUg1yF0TLz24FhmJTyBOSKLnhipYVHcDi1ixCoh192vRVAq8yT1DLympOm9Z5JNlgIFPZkO88OelE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686159; c=relaxed/simple;
	bh=XtzjSMkNoeuWEwU5Y5sUt5sfWaa3bb/AbulbsrJBXn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHqASsjk0UIMbr/esyv/4XkcuedwuA6Ak4U+uXuFg8kMl8GNaUilp8p0kL7w4lWFNpnlD1jCfM1hYJV1hbOBNqSBjej+WqGUSVF3VaCfRo8Ks7z1PJsQpKiqy3EWDcqGPLU3x3L6MKBYF81CI/7yMd1BmdKqAv2IUNVsNNECylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=V7p8cbQW; arc=none smtp.client-ip=148.6.0.49
Received: from localhost (localhost [127.0.0.1])
	by smtp0.kfki.hu (Postfix) with ESMTP id 4ggHQL5nzPz3sb0q;
	Wed, 17 Jun 2026 10:41:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:from:from:received:received
	:received; s=20151130; t=1781685688; x=1783500089; bh=O8dC+I8CJ9
	keVEGMYboSepei/pahSohoEKjZMkcDqvw=; b=V7p8cbQWCS5AbB4BgIsiQl2P2w
	DPKEwPps+cwHJTn9mbznmhwC+uoG2b7ctFaI+oojbR7baVYV0gp1AjzVDWO1CQMj
	oH/DcbIAY5eYsZHkW95jamZ2/hGTTqZq6LGTZNT1UvdR7KuMFoDs+GdEK/dg+ff7
	JqmHQwJqMRbVLAsL8=
X-Virus-Scanned: Debian amavis at smtp0.kfki.hu
Received: from smtp0.kfki.hu ([127.0.0.1])
 by localhost (smtp0.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id z0SkhuQMio8h; Wed, 17 Jun 2026 10:41:28 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (unknown [148.6.40.64])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp0.kfki.hu (Postfix) with ESMTPSA id 4ggHQJ63bFz3sb0W;
	Wed, 17 Jun 2026 10:41:28 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id A80941406DA; Wed, 17 Jun 2026 10:41:28 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v3 2/7] netfilter: ipset: Don't use test_bit() in lockless RCU readers in bitmap types
Date: Wed, 17 Jun 2026 10:41:23 +0200
Message-Id: <20260617084128.6603-3-kadlec@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-13299-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	DMARC_NA(0.00)[netfilter.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,blackhole.kfki.hu:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA884697C6F

The pair of the patch "netfilter: ipset: Don't use test_bit() in lockless
RCU readers in hash types" for the bitmap types.

Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
---
 net/netfilter/ipset/ip_set_bitmap_gen.h   | 4 +++-
 net/netfilter/ipset/ip_set_bitmap_ip.c    | 2 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c | 2 +-
 net/netfilter/ipset/ip_set_bitmap_port.c  | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_bitmap_gen.h b/net/netfilter/ipse=
t/ip_set_bitmap_gen.h
index 798c7993635e..bb9b5bed10e1 100644
--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -165,6 +165,7 @@ mtype_add(struct ip_set *set, void *value, const stru=
ct ip_set_ext *ext,
 		ip_set_init_skbinfo(ext_skbinfo(x, set), ext);
=20
 	/* Activate element */
+	smp_mb__before_atomic();
 	set_bit(e->id, map->members);
 	set->elements++;
=20
@@ -219,7 +220,7 @@ mtype_list(const struct ip_set *set,
 		cond_resched_rcu();
 		id =3D cb->args[IPSET_CB_ARG0];
 		x =3D get_ext(set, map, id);
-		if (!test_bit(id, map->members) ||
+		if (!test_bit_acquire(id, map->members) ||
 		    (SET_WITH_TIMEOUT(set) &&
 #ifdef IP_SET_BITMAP_STORED_TIMEOUT
 		     mtype_is_filled(x) &&
@@ -278,6 +279,7 @@ mtype_gc(struct timer_list *t)
 			x =3D get_ext(set, map, id);
 			if (ip_set_timeout_expired(ext_timeout(x, set))) {
 				clear_bit(id, map->members);
+				smp_mb__after_atomic();
 				ip_set_ext_destroy(set, x);
 				set->elements--;
 			}
diff --git a/net/netfilter/ipset/ip_set_bitmap_ip.c b/net/netfilter/ipset=
/ip_set_bitmap_ip.c
index 5988b9bb9029..ac7febce074f 100644
--- a/net/netfilter/ipset/ip_set_bitmap_ip.c
+++ b/net/netfilter/ipset/ip_set_bitmap_ip.c
@@ -67,7 +67,7 @@ static int
 bitmap_ip_do_test(const struct bitmap_ip_adt_elem *e,
 		  struct bitmap_ip *map, size_t dsize)
 {
-	return !!test_bit(e->id, map->members);
+	return !!test_bit_acquire(e->id, map->members);
 }
=20
 static int
diff --git a/net/netfilter/ipset/ip_set_bitmap_ipmac.c b/net/netfilter/ip=
set/ip_set_bitmap_ipmac.c
index 752f59ef8744..5921fd9d2dca 100644
--- a/net/netfilter/ipset/ip_set_bitmap_ipmac.c
+++ b/net/netfilter/ipset/ip_set_bitmap_ipmac.c
@@ -86,7 +86,7 @@ bitmap_ipmac_do_test(const struct bitmap_ipmac_adt_elem=
 *e,
 {
 	const struct bitmap_ipmac_elem *elem;
=20
-	if (!test_bit(e->id, map->members))
+	if (!test_bit_acquire(e->id, map->members))
 		return 0;
 	elem =3D get_const_elem(map->extensions, e->id, dsize);
 	if (e->add_mac && elem->filled =3D=3D MAC_FILLED)
diff --git a/net/netfilter/ipset/ip_set_bitmap_port.c b/net/netfilter/ips=
et/ip_set_bitmap_port.c
index 7138e080def4..ca875c982424 100644
--- a/net/netfilter/ipset/ip_set_bitmap_port.c
+++ b/net/netfilter/ipset/ip_set_bitmap_port.c
@@ -58,7 +58,7 @@ static int
 bitmap_port_do_test(const struct bitmap_port_adt_elem *e,
 		    const struct bitmap_port *map, size_t dsize)
 {
-	return !!test_bit(e->id, map->members);
+	return !!test_bit_acquire(e->id, map->members);
 }
=20
 static int
--=20
2.39.5


