Return-Path: <netfilter-devel+bounces-13947-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B+VcDMmdV2rdXwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13947-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jul 2026 16:48:41 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FCB75F8E6
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jul 2026 16:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=h5jJXO3y;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13947-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13947-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E8B0300B599
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jul 2026 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC84396565;
	Wed, 15 Jul 2026 14:48:35 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E059388377
	for <netfilter-devel@vger.kernel.org>; Wed, 15 Jul 2026 14:48:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126915; cv=none; b=eTTPzT5IrHQdzw68D7ac5oNkXYQ4w7MJV9vKXNOGWQ7i09uU7sN5hP6xZKYD3A4gzbsbmJGta+4E973g0Kdc7cv/Ep0TWL0YLPeCxEeJp65O0oirBBdmLPCeKt0dA7d8oRYfOlfaKAzWjbz4XaJ6OiuspEmE4ED4dq4r9FC4CYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126915; c=relaxed/simple;
	bh=6ouk3uokvdotrDHfaQMI0gS2Pljg30PRdbhVcrFQaB4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KdKsGDDQyH8uudsFUIxb3cAtwa6CWfMhIzVfk3goFwkB49uGzr5PansyxfNh8gHo9+SnvBUeA8HUpKeBpPUoKKwRZ1WP2fKmxs7yH0nO1ZqrQ7jLuzUp5jN079XIse3+ZCZMAbld0wefVkZH5ybrJQ/2W+9ma/gm/TpOpUWbWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=h5jJXO3y; arc=none smtp.client-ip=79.135.106.29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1784126908; x=1784386108;
	bh=DkneTlIFzL+4NL/atILUBCQHg45PwZkk92XrOGD3QrE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=h5jJXO3yr7QkQ4rUWA2xexbZML4Ygpib6+nS6qMRaaPYZWz1a9aDXr7WY/8vHSjzJ
	 yuGrwKYxhouoD6HFInPrdobV7feahyQRHVSNdh6qA76n7g9b2jkQ3zlKMbdbQa1lkf
	 UV7GId9znsj5Ncb2KG02vahmhrYHqLMiK4cyybSvz5xCVrsjH57A9qlJbzRc8tceHv
	 X8RW45UArJDiMDi5O094fyi7cR0VoaM5/6nIKhIj8EmftKiLOifjSuSlW7UhqE/Ozj
	 gT89iHbhI6vM29l8ha+7MaZUEYZvf3ilpvFdWs/+7jqW8KK8JwCZWYlFlCrX9DXGmB
	 ydMsT8qB8e+Hg==
Date: Wed, 15 Jul 2026 14:48:23 +0000
To: netfilter-devel@vger.kernel.org
From: Jaeyeong Lee <iostreampy@proton.me>
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, sveyret@gmail.com, coreteam@netfilter.org, netdev@vger.kernel.org
Subject: [PATCH nf] netfilter: conntrack: prevent helper extension relocation
Message-ID: <20260715144755.00ea7dfcd9f@proton.me>
Feedback-ID: 96968035:user:proton
X-Pm-Message-ID: 156e66a3a153ac3049c51837541c2585302d63b9
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13947-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[proton.me:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:sveyret@gmail.com,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[iostreampy@proton.me,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iostreampy@proton.me,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,proton.me:dkim,proton.me:email,proton.me:mid,proton.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5FCB75F8E6
X-Rspamd-Action: no action

nf_ct_ext_add() may relocate an unconfirmed conntrack's extension blob
when the current allocation is too small. struct nf_conn_help embeds the
hlist head for the master's expectations. The first expectation's
lnode.pprev therefore points into that extension blob.

An nftables CT expectation object can link an expectation before a later
NAT expression adds extensions to the same unconfirmed conntrack. If an
addition relocates the blob, the copied hlist head still points to the
expectation, but the expectation's pprev continues to point into the
freed old blob. Removing the expectation later executes hlist_del_rcu()
and writes through this stale pointer.

Reserve enough storage for every extension whenever the helper extension
is added. Account for the alignment padding that may be required between
extensions so the reservation is independent of their addition order.
No expectation can be linked before its master has a helper extension,
so subsequent additions fit in the existing allocation and cannot
invalidate expectation list pointers. Conntracks without helpers are
unaffected.

Fixes: 857b46027d6f ("netfilter: nft_ct: add ct expectations support")
Cc: stable@vger.kernel.org
Signed-off-by: Jaeyeong Lee <iostreampy@proton.me>
---
 net/netfilter/nf_conntrack_extend.c | 31 +++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_conntrack_extend.c b/net/netfilter/nf_conntra=
ck_extend.c
index 0da105e1ded..e5e04e0ec40 100644
--- a/net/netfilter/nf_conntrack_extend.c
+++ b/net/netfilter/nf_conntrack_extend.c
@@ -54,35 +54,38 @@ static const u8 nf_ct_ext_type_len[NF_CT_EXT_NUM] =3D {
 #endif
 };
=20
+#define NF_CT_EXT_TYPE_SIZE(type) \
+=09ALIGN(sizeof(type), __alignof__(struct nf_ct_ext))
+
 static __always_inline unsigned int total_extension_size(void)
 {
 =09/* remember to add new extensions below */
 =09BUILD_BUG_ON(NF_CT_EXT_NUM > 10);
=20
 =09return sizeof(struct nf_ct_ext) +
-=09       sizeof(struct nf_conn_help)
+=09       NF_CT_EXT_TYPE_SIZE(struct nf_conn_help)
 #if IS_ENABLED(CONFIG_NF_NAT)
-=09=09+ sizeof(struct nf_conn_nat)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_nat)
 #endif
-=09=09+ sizeof(struct nf_conn_seqadj)
-=09=09+ sizeof(struct nf_conn_acct)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_seqadj)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_acct)
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
-=09=09+ sizeof(struct nf_conntrack_ecache)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conntrack_ecache)
 #endif
 #ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
-=09=09+ sizeof(struct nf_conn_tstamp)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_tstamp)
 #endif
 #ifdef CONFIG_NF_CONNTRACK_TIMEOUT
-=09=09+ sizeof(struct nf_conn_timeout)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_timeout)
 #endif
 #ifdef CONFIG_NF_CONNTRACK_LABELS
-=09=09+ sizeof(struct nf_conn_labels)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_labels)
 #endif
 #if IS_ENABLED(CONFIG_NETFILTER_SYNPROXY)
-=09=09+ sizeof(struct nf_conn_synproxy)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_synproxy)
 #endif
 #if IS_ENABLED(CONFIG_NET_ACT_CT)
-=09=09+ sizeof(struct nf_conn_act_ct_ext)
+=09=09+ NF_CT_EXT_TYPE_SIZE(struct nf_conn_act_ct_ext)
 #endif
 =09;
 }
@@ -112,6 +115,14 @@ void *nf_ct_ext_add(struct nf_conn *ct, enum nf_ct_ext=
_id id, gfp_t gfp)
 =09newlen =3D newoff + nf_ct_ext_type_len[id];
=20
 =09alloc =3D max(newlen, NF_CT_EXT_PREALLOC);
+=09/*
+=09 * nf_conn_help contains the expectation list head.  Once an
+=09 * expectation is linked, its lnode.pprev points into this allocation,
+=09 * so later extension additions must not be allowed to relocate it.
+=09 */
+=09if (id =3D=3D NF_CT_EXT_HELPER)
+=09=09alloc =3D max(alloc, total_extension_size());
+
 =09new =3D krealloc(ct->ext, alloc, gfp);
 =09if (!new)
 =09=09return NULL;
--=20
2.43.0



