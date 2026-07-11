Return-Path: <netfilter-devel+bounces-13853-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OfenIIZRUmqnOQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13853-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 16:21:58 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1FE741C7A
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 16:21:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=aJQCZ7X9;
	dmarc=pass (policy=quarantine) header.from=proton.me;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13853-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13853-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 775E4300139F
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50392877DE;
	Sat, 11 Jul 2026 14:21:51 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE425B0AB
	for <netfilter-devel@vger.kernel.org>; Sat, 11 Jul 2026 14:21:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783779711; cv=none; b=XREZLhaHfQH/6adnyP0zQLKTo4PE9hTlwkHlOE6LO2W3jE13QME+PHTy6lrZc49YzDCYa8whaYXFQan8oY2kA5uk1Dn6xvqWWVL9FNf+UHaPyoV4eShkI+yFr6GVFnoeODRSyKfRFMgnoWGv/5WSMFhRcpBPQpbG0tLLnVXIuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783779711; c=relaxed/simple;
	bh=9VgTuae7YklpPhn9o9d5BejBxPyPMzTcZyQxOf7ig6A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OATcr43yM7E+/ehb+AdUphYqdyzO+t4xzcIWf3m6RXjQskc5bdKF5nGubUU3tk2U4Co/g77EMudc9VPWJlfxDkdGdT+o2dPCoF3efB8BY8wn70pLieThgNBBWlAuLwaDVdB26rYLfR9SjsRqdyF9Agl32SIhgBYP2ZNr0LoM130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aJQCZ7X9; arc=none smtp.client-ip=57.129.93.249
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1783779696; x=1784038896;
	bh=CQf0T5WGi3yE5K9cZ86h7diOf3x8NC/KWodXIQEg9CA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aJQCZ7X9cmG2D29cWzh4xKg5ZwrZokkCv50o1cxPEYdFZqJFbk5iCS8zc5uVmPvnf
	 T2ICN7yPjFSusarsvvT8N+O/Bhzd3dW7h1TtQQCPcJR1tkmj326hUE/MZ5cm8XSM+T
	 NZQf9TMylWjcAdQDR5FIVATkb39Sf7VxvWKGMnea6dPfF+q9eClKlEA2ie7M8IV15J
	 OnHAaCheCI2CgRP8O9zkjIngpDm/EmV8EvZ7Up2gySZU62MJ9lj5J1KY4+bNmZ9Er3
	 2KKbDhsrP8Y/LeDPgWtHHb0oh4Fg7dzQx8qzUTQBiEFkVLClBeB9LewjjQBQGjZYpP
	 +ntQgY3hjd3qA==
Date: Sat, 11 Jul 2026 14:21:32 +0000
To: netfilter-devel@vger.kernel.org
From: Jaeyeong Lee <iostreampy@proton.me>
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, gregkh@linuxfoundation.org
Subject: [PATCH nf] netfilter: nf_nat: do not reuse an unexpected expectation on RTCP clash
Message-ID: <178377968720.33756.12204817361601593230@proton.me>
In-Reply-To: <2026071134-turkey-detonator-0d87@gregkh>
References: <aQrSf6maL27cH2V4V9ELFdSqdtCWQ-B5iZr8fjR2Wz7zAJ7L32oW50bdrePoTMnJ4CRjDrns-jNMNFHGWNUxYe3UcV91AK99Ilncjab2uDk=@proton.me> <2026071134-turkey-detonator-0d87@gregkh>
Feedback-ID: 96968035:user:proton
X-Pm-Message-ID: 2527d8d58ad7340505069a3e395e555abb35f7de
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13853-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[proton.me:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[iostreampy@proton.me,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iostreampy@proton.me,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E1FE741C7A

Since commit b8b09dc2bf35 ("netfilter: nf_conntrack_expect: use conntrack
GC to reap expectations") nf_ct_unexpect_related() no longer unlinks the
expectation from the global hash and from the per-master list. It only
marks it with NF_CT_EXPECT_DEAD and defers the unlink to the conntrack GC
worker and to the expectation list walkers; the reference taken at insert
time is kept until a walker calls nf_ct_unlink_expect().

The NAT SIP and H.323 helpers still assume the old, synchronous contract.
Their RTP/RTCP port-search loop unexpects rtp_exp on an RTCP -EBUSY clash
and then continues the loop, reusing the very same rtp_exp object:

=09ret =3D nf_ct_expect_related(rtcp_exp, ...);
=09...
=09else if (ret =3D=3D -EBUSY) {
=09=09nf_ct_unexpect_related(rtp_exp);
=09=09continue;=09=09=09/* reuse rtp_exp next port */
=09}

rtp_exp is still linked in nf_ct_expect_hash[] and in
master_help->expectations when the loop mutates its tuple and calls
nf_ct_expect_related() again. nf_ct_expect_insert() then runs
hlist_add_head_rcu() on the already-linked lnode -- same master list, so
it becomes self-referential -- and on hnode, and takes an extra,
unbalanced reference. The per-master expectation list is corrupted and
the conntrack GC worker trips over it:

  Oops: general protection fault, probably for non-canonical address
        0xdead000000000122
  Workqueue: events_power_efficient gc_worker
  RIP: 0010:nf_ct_unlink_expect_report+0x3e/0xd0
  Call Trace:
   nf_ct_expectation_gc+0x59/0x70
   gc_worker+0x344/0x620
   process_one_work+0x19f/0x3d0

nf_ct_expectation_gc() walks the cyclic master_help->expectations,
unlinks the entry, then visits the same now-poisoned node again and
unlinks it a second time. Under KASAN this is reported as a
use-after-free of the nf_conntrack_expect slab object. It is reachable by
an unprivileged user in a user+net namespace that assigns the "sip" or
H.323 conntrack helper with NAT and drives the RTP-succeeds /
RTCP-clashes case, and is thus a local privilege escalation primitive.

A DEAD expectation must be treated as a terminal object: never mutate its
tuple and never re-insert it. Stop reusing rtp_exp after unexpecting it in
both helpers and fail the media setup instead of retrying the next port
pair. rtp_exp is left DEAD and linked and is reaped by the GC / master
teardown as intended, and the callers drop the allocation references
unconditionally, so nothing is leaked.

This gives up the "try the next port pair" retry when only the RTCP port
of a pair is busy; that best-effort search is not a correctness
requirement, the packet is dropped and the endpoint renegotiates.

Fixes: b8b09dc2bf35 ("netfilter: nf_conntrack_expect: use conntrack GC to r=
eap expectations")
Signed-off-by: Jaeyeong Lee <iostreampy@proton.me>
---
 net/ipv4/netfilter/nf_nat_h323.c | 3 ++-
 net/netfilter/nf_nat_sip.c       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/netfilter/nf_nat_h323.c b/net/ipv4/netfilter/nf_nat_h=
323.c
index 183e8a3ff2ba..78cdc107a0dc 100644
--- a/net/ipv4/netfilter/nf_nat_h323.c
+++ b/net/ipv4/netfilter/nf_nat_h323.c
@@ -236,7 +236,8 @@ static int nat_rtp_rtcp(struct sk_buff *skb, struct nf_=
conn *ct,
 =09=09=09=09break;
 =09=09=09else if (ret =3D=3D -EBUSY) {
 =09=09=09=09nf_ct_unexpect_related(rtp_exp);
-=09=09=09=09continue;
+=09=09=09=09nated_port =3D 0;
+=09=09=09=09break;
 =09=09=09} else if (ret < 0) {
 =09=09=09=09nf_ct_unexpect_related(rtp_exp);
 =09=09=09=09nated_port =3D 0;
diff --git a/net/netfilter/nf_nat_sip.c b/net/netfilter/nf_nat_sip.c
index aea02f6aff09..aa34b7eb96f2 100644
--- a/net/netfilter/nf_nat_sip.c
+++ b/net/netfilter/nf_nat_sip.c
@@ -637,7 +637,8 @@ static unsigned int nf_nat_sdp_media(struct sk_buff *sk=
b, unsigned int protoff,
 =09=09=09break;
 =09=09else if (ret =3D=3D -EBUSY) {
 =09=09=09nf_ct_unexpect_related(rtp_exp);
-=09=09=09continue;
+=09=09=09port =3D 0;
+=09=09=09break;
 =09=09} else if (ret < 0) {
 =09=09=09nf_ct_unexpect_related(rtp_exp);
 =09=09=09port =3D 0;
--=20
2.43.0



