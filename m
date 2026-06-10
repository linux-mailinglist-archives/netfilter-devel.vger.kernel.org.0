Return-Path: <netfilter-devel+bounces-13197-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XvVCH+uCKWpZYQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13197-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 17:29:47 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E8D66ACA1
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 17:29:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=Z0mtT0Pl;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13197-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13197-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3A7831409FA
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA033093A6;
	Wed, 10 Jun 2026 15:17:44 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D72DC79A
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jun 2026 15:17:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104664; cv=none; b=HiZywhJXrQPilLIcHcKxp/QFNi4dKU9+MdW41FgMPsNxdrRugcac8AtSeNi+eLHzw8ZnlP/3yq9i9ZzA3Czn+ttdhfQntv6Di1d13plMpocsS7Pjfwuqju3NdIH2UXh/xVgcoBIoVSvhRDC0C9z2430H3teKMJANj+Qqci7x0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104664; c=relaxed/simple;
	bh=iqIIj05dDEp0xVebnZDEHeRLAjYV8Dg+cnEkopPQoyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N9Vyb9Iwf7LPXSonS+gJuFvISM0rEGReC2Dqb/ew1jkSE/74GqC/FrU5gQWD9NSJdLwNsfUK3e/DKD3m5+OvU801DfNg+TW6Ajxo4HovyuXiTq0I0Ak087Vb4M7DNulARvNIbbnc48xOdsGX86DmSsLW+dzgBCTqXOn9keYiGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Z0mtT0Pl; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 3D2E46019E
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jun 2026 17:17:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781104661;
	bh=7BHHI22OF/vvglKZW30fZV9iEdw957DDXnYHv5LyyUI=;
	h=From:To:Subject:Date:From;
	b=Z0mtT0PlYrTE/TvWUewqdb3bcar2Cybcd5t7HQzuyfpjg8apHc2FRe3Ms/jDjjhPV
	 0utVkCY35YwK4hF+ndxzHJr3POqj9yQ6fHf7XCTo3/+ZXkgo2AOqPTcJmEMmC50fid
	 COrhFlP38UKUSYRzO1XHZFQVnNbevtV6j2i3JHfHkPSgAvftar4VLQJJnVvcRTxyQ5
	 U4zZ638sFmun63Gl/ScN1cjbi8cO6s8qvwJ3HqFQyEg6pXs5o57c0iBcrla+c/z4wP
	 v0SbLag8/XERHPlKKNi0HzS/IfAeZ9BxXgTWxPPRAzfUr+TzBHDIIk9iwbDy7bG9/1
	 RqKIVf7+fgq7w==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_conntrack,v2] objopt: restrict NFCT_GOPT_IS_{S,D}PAT to supported layer 4 protocols
Date: Wed, 10 Jun 2026 17:17:35 +0200
Message-ID: <20260610151735.192168-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13197-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8E8D66ACA1

If layer 4 protocol has no ports, then return false. Otherwise, users
like the conntrack utility filtering does not properly work with layer 4
protocol such as ICMP and ICMPv6.

Fixes: b4c3a23c884c ("Introduce the new libnetfilter_conntrack API, features:")
Reported-by: Jan Kasprzak <kas@fi.muni.cz>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: - incorrect field, use .protonum, not .l3protonum
    - update Fixes: tag

 src/conntrack/objopt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/conntrack/objopt.c b/src/conntrack/objopt.c
index 1581480667e5..7e8d71d15fbe 100644
--- a/src/conntrack/objopt.c
+++ b/src/conntrack/objopt.c
@@ -182,8 +182,27 @@ static int getobjopt_is_dnat(const struct nf_conntrack *ct)
 	}
 }
 
+static bool l4proto_has_ports(const struct nf_conntrack *ct)
+{
+	switch (ct->head.orig.protonum) {
+	case IPPROTO_UDP:
+	case IPPROTO_UDPLITE:
+	case IPPROTO_SCTP:
+	case IPPROTO_TCP:
+	case IPPROTO_DCCP:
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 static int getobjopt_is_spat(const struct nf_conntrack *ct)
 {
+	if (!l4proto_has_ports(ct))
+		return 0;
+
 	return ((test_bit(ATTR_STATUS, ct->head.set) ?
 		ct->status & IPS_SRC_NAT_DONE : 1) &&
 		ct->repl.l4dst.tcp.port !=
@@ -192,6 +211,9 @@ static int getobjopt_is_spat(const struct nf_conntrack *ct)
 
 static int getobjopt_is_dpat(const struct nf_conntrack *ct)
 {
+	if (!l4proto_has_ports(ct))
+		return 0;
+
 	return ((test_bit(ATTR_STATUS, ct->head.set) ?
 		ct->status & IPS_DST_NAT_DONE : 1) &&
 		ct->repl.l4src.tcp.port !=
-- 
2.47.3


