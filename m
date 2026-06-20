Return-Path: <netfilter-devel+bounces-13365-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /tIGLfwTN2oPJAcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13365-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2026 00:28:12 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1256A9D06
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2026 00:28:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=T2aaCPGY;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13365-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13365-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E9C63014741
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jun 2026 22:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243E835203E;
	Sat, 20 Jun 2026 22:27:55 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C2350A18;
	Sat, 20 Jun 2026 22:27:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781994475; cv=none; b=IVKtdFV3z3Bn+LvxRMUGf3XG9evN6lGMfl0hjjwKxTvY22/MNPmHq4FUCZyShKOxduZOfMIy0/KilbZYWYgR8AXL9nD4Ot0i21LGyfWZn+E40Jbh2tEI0zkNmH00Abv9qUmczslCmbybdQL4R083rfIb24bE4GjUdVhP3/YJFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781994475; c=relaxed/simple;
	bh=giba2CZxSGw8PL2UdlEgPcfmimZNbLr61Jxy14hELpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJDwvb7bl4d4P7Jho3w5eKSrJzjR7FyVPgKdV2c2qoXMn5pi3+CgusXSQadwwj8KFycbB3XImF9w0Djn8O4XVJPoWwNMVLN351VN+DwpwTeEGt+kCW3DPAlnSNHVEhJ0MjKwMi647fJXBeOda43kAIJ3J9HDX87v4juPEcYpcdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=T2aaCPGY; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 73AB96019D;
	Sun, 21 Jun 2026 00:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781994469;
	bh=2B5uKM0TpE40ne8Qo1WgZYNW+QSbMxvtFmNxYzBPYRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2aaCPGYaUxVQprLlh9Xbq5mOXQjIOQdqmCKZQiEqTJ+oud247c/Gwj/T8wm0dtr2
	 U54mROCWp//ySQGiJFEIaWGvxO0g9j5XtL9TvP524f2lfue5XIn/cOHeh6QF8CpuCo
	 AMMSnhWrMj4IAl5FSvM4ODhh1khv1IIJhxWYIx4dZWV9VErXvCKVh06b718j8dLhkI
	 JwAXRLJielroUwsFw2T5Rr0f6a/FV3XN9m9EaEc8Tdtzm7bAIB+UQO/PtS/xOpXBXN
	 ryfmbHbaG+vxsJeUHiqPcseM5hyHKZvCaBgiU2TCObz5EEHyRSnbM63OLcTBWB4n53
	 nNs+1CAUFZMHw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 06/14] netfilter: ipset: Don't use test_bit() in lockless RCU readers in bitmap types
Date: Sun, 21 Jun 2026 00:27:30 +0200
Message-ID: <20260620222738.112506-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620222738.112506-1-pablo@netfilter.org>
References: <20260620222738.112506-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13365-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F1256A9D06

From: Jozsef Kadlecsik <kadlec@netfilter.org>

The pair of the patch "netfilter: ipset: Don't use test_bit() in lockless
RCU readers in hash types" for the bitmap types.

Fixes: 02a3231b6d82 ("netfilter: nf_conntrack_expect: store netns and zone in expectation")
Fixes: b0da3905bb1e ("netfilter: ipset: Bitmap types using the unified code base")
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/ipset/ip_set_bitmap_gen.h   | 4 +++-
 net/netfilter/ipset/ip_set_bitmap_ip.c    | 2 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c | 2 +-
 net/netfilter/ipset/ip_set_bitmap_port.c  | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_bitmap_gen.h b/net/netfilter/ipset/ip_set_bitmap_gen.h
index 798c7993635e..bb9b5bed10e1 100644
--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -165,6 +165,7 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 		ip_set_init_skbinfo(ext_skbinfo(x, set), ext);
 
 	/* Activate element */
+	smp_mb__before_atomic();
 	set_bit(e->id, map->members);
 	set->elements++;
 
@@ -219,7 +220,7 @@ mtype_list(const struct ip_set *set,
 		cond_resched_rcu();
 		id = cb->args[IPSET_CB_ARG0];
 		x = get_ext(set, map, id);
-		if (!test_bit(id, map->members) ||
+		if (!test_bit_acquire(id, map->members) ||
 		    (SET_WITH_TIMEOUT(set) &&
 #ifdef IP_SET_BITMAP_STORED_TIMEOUT
 		     mtype_is_filled(x) &&
@@ -278,6 +279,7 @@ mtype_gc(struct timer_list *t)
 			x = get_ext(set, map, id);
 			if (ip_set_timeout_expired(ext_timeout(x, set))) {
 				clear_bit(id, map->members);
+				smp_mb__after_atomic();
 				ip_set_ext_destroy(set, x);
 				set->elements--;
 			}
diff --git a/net/netfilter/ipset/ip_set_bitmap_ip.c b/net/netfilter/ipset/ip_set_bitmap_ip.c
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
 
 static int
diff --git a/net/netfilter/ipset/ip_set_bitmap_ipmac.c b/net/netfilter/ipset/ip_set_bitmap_ipmac.c
index 752f59ef8744..5921fd9d2dca 100644
--- a/net/netfilter/ipset/ip_set_bitmap_ipmac.c
+++ b/net/netfilter/ipset/ip_set_bitmap_ipmac.c
@@ -86,7 +86,7 @@ bitmap_ipmac_do_test(const struct bitmap_ipmac_adt_elem *e,
 {
 	const struct bitmap_ipmac_elem *elem;
 
-	if (!test_bit(e->id, map->members))
+	if (!test_bit_acquire(e->id, map->members))
 		return 0;
 	elem = get_const_elem(map->extensions, e->id, dsize);
 	if (e->add_mac && elem->filled == MAC_FILLED)
diff --git a/net/netfilter/ipset/ip_set_bitmap_port.c b/net/netfilter/ipset/ip_set_bitmap_port.c
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
 
 static int
-- 
2.47.3


