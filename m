Return-Path: <netfilter-devel+bounces-13605-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KZYQOPJrRmrCUAsAu9opvQ
	(envelope-from <netfilter-devel+bounces-13605-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 15:47:30 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A9F6F87B3
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 15:47:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackhole.kfki.hu header.s=20151130 header.b=Adv+gWw4;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13605-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13605-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE47301779E
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jul 2026 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90A44A2E2C;
	Thu,  2 Jul 2026 13:47:15 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4669264A9D
	for <netfilter-devel@vger.kernel.org>; Thu,  2 Jul 2026 13:47:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000035; cv=none; b=oS7l83jOVjKwasLnX8rkcRQd2CoaTWUwanJvG+75PjNbVWvgpeodX1jzyi8dKV0Qr7GYK3ZRTrlNyoRT2RO3ZmVKTdIFKvsnTiL9gz+bkiqXpFNQbCIYqBNvuNv5fi2Y76G94hBPwp4kiYXxaoW1W6vCvR6DdN0GlgmPRhyCar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000035; c=relaxed/simple;
	bh=Xn8rKzs70RQfk4GK24bxBxt1okYY486rsNF7siHE1GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpJaGmMPMmfdEhi+jUjEAPXPG3WBXGSIEBG37EC8e/3QD8G4s5UXwOQjOoGlHLflMAKB4NLfIOqcLGZh2QnIOd3MhixhLU9+2GREUeYJfVZE13OAFdJCE6oOXPWM7EFQtrXUBdM8gEWrJHQUFEy3ZCil153FKWwRaL2Q66KtVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=Adv+gWw4; arc=none smtp.client-ip=148.6.0.51
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4grdTz5DhSz7s7wW;
	Thu, 02 Jul 2026 15:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:from:from:received:received
	:received; s=20151130; t=1783000021; x=1784814422; bh=5BCE53ky7M
	SLOy1wkkble7kg6GuXK78JkH0kEFZFT0I=; b=Adv+gWw4IXUaqtMKPRosjLRObI
	z3d5WK/tV/gf5wPGSQZWDRGRtX/tQYrjy+uxc8jlI6S8O2KimQ4ZkSTncjcmrcTL
	hl5cpTX96zksiOrEM5n0IHbhKeMnrtvOTKuygP1tsCAOVBh97lv/qax0Fhcf3zYG
	SLaq/B1XnkLWwNfcs=
X-Virus-Scanned: Debian amavis at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
 by localhost (smtp2.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id adDUbAzm58oh; Thu,  2 Jul 2026 15:47:01 +0200 (CEST)
Received: from mentat.rmki.kfki.hu (unknown [148.6.40.64])
	(Authenticated sender: kadlecsik.jozsef@wigner.hu)
	by smtp2.kfki.hu (Postfix) with ESMTPSA id 4grdTx5hvnz7s7wS;
	Thu, 02 Jul 2026 15:47:01 +0200 (CEST)
Received: by mentat.rmki.kfki.hu (Postfix, from userid 1000)
	id 89ADD1408F6; Thu,  2 Jul 2026 15:47:01 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4/5] netfilter: ipset: allocate the proper memory for the generic hash structure
Date: Thu,  2 Jul 2026 15:47:00 +0200
Message-Id: <20260702134701.207721-5-kadlec@netfilter.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260702134701.207721-1-kadlec@netfilter.org>
References: <20260702134701.207721-1-kadlec@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-13605-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42A9F6F87B3

Because a single create function is emitted for every hash type,
from the IPv4 and IPv6 generic hash structure definitions the last
one, i.e. the IPv6 was in effect for IPv4 too. Use the proper size
when allocating the structure. Comment properly that because create()
refers to elements of the generic hash structure, all referred ones
must come before the IPv4/IPv6 dependent 'next' member.

Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/=
ip_set_hash_gen.h
index c0132d0f4cc0..8231317b0f1f 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -303,10 +303,13 @@ struct htype {
 	u8 netmask;		/* netmask value for subnets to store */
 	union nf_inet_addr bitmask;	/* stores bitmask */
 #endif
-	struct mtype_elem next; /* temporary storage for uadd */
 #ifdef IP_SET_HASH_WITH_NETS
 	struct net_prefixes nets[NLEN]; /* book-keeping of prefixes */
 #endif
+	/* Because 'next' is IPv4/IPv6 dependent, no elements of this
+	 * structure and referred in create() may come after 'next'.
+	 */
+	struct mtype_elem next; /* temporary storage for uadd */
 };
=20
 /* ADD|DEL entries saved during resize */
@@ -1584,7 +1587,13 @@ IPSET_TOKEN(HTYPE, _create)(struct net *net, struc=
t ip_set *set,
 	if (tb[IPSET_ATTR_MAXELEM])
 		maxelem =3D ip_set_get_h32(tb[IPSET_ATTR_MAXELEM]);
=20
-	hsize =3D sizeof(*h);
+#ifdef IP_SET_PROTO_UNDEF
+	hsize =3D sizeof(struct htype);
+#else
+	hsize =3D set->family =3D=3D NFPROTO_IPV6 ?
+		sizeof(struct IPSET_TOKEN(HTYPE, 6)) :
+		sizeof(struct IPSET_TOKEN(HTYPE, 4));
+#endif
 	h =3D kzalloc(hsize, GFP_KERNEL);
 	if (!h)
 		return -ENOMEM;
--=20
2.39.5


