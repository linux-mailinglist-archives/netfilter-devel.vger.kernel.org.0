Return-Path: <netfilter-devel+bounces-13187-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VtdzM31AKWogTAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13187-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 12:46:21 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE39B6686A1
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 12:46:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=S8m6Rjrn;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13187-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13187-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03AEF30ABEFA
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 10:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571423F1672;
	Wed, 10 Jun 2026 10:30:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27FE3F20ED
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jun 2026 10:30:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087448; cv=none; b=V40/9rhzYao+af+/3fwgjCKKv4/rIkZ/iFV4tU03hK4i6E8DAaZsBdVLeOAMbMRz7ZFQwWm7mnQ335cFupCh+hMsyNTmsUAA7xo0wy961jskY0Q/Y8rqEP0x0zmAGlcoCeu5iZsO/94szlE9R6bo+UOH03rIuT+jP19mbRcfn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087448; c=relaxed/simple;
	bh=H0jBkem1FacugaiY6wKtmQau54HUFe++eGaBe0IKaac=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WedIt2mF5AQVsEo/aSKByJcmIV4pMlNllC75CvIp6+o4M8+zT+O+q0zgNoAA82zPuiBvzbPwNR7jLwkPXyB+OZJ0XfWN3fEBq8QW1JC5iP52uShUyzhNpGgfaDCa587sKpy8qKQmdEtN+x3V6o3ZBQqa6rLvBu/dt/yRztDanvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=S8m6Rjrn; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 75A1E6019E
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jun 2026 12:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781087443;
	bh=RPJSlrJkXy2ybbGT/pf0yEl8gczbH5MRjButURvWF/k=;
	h=From:To:Subject:Date:From;
	b=S8m6Rjrnds4P0r/p/Hu35QSm8PsO3Bnq2Lk2CW/tYb5ktxVs2QOQE5XUM2Zl24iCg
	 VxRdFHxwvjT/kJzhvNcaSglxopI4IPfBQwMWiq99w2V0Au/sGjhvtpw7GG/rkcuaMt
	 96PlPOsxDUfmuRVHnfE9Y+15aTHuIkJ7B4C/RJYJN/t3u/MIDFzv5EoWazgeDP/vzK
	 z4hCMQhKSik9FeuiEcm4Vjm/5/Yybf5eN/lLlS1ddOEm1YMBuePHWgB+/1KyUtxwr6
	 oa3N+zp1ATGc8opoV2CFJA0njXbHQVMr9PKa27X9/JC3uwGtPupgTf9xga7o2DxtUp
	 YM952Ir4zyW4g==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_conntrack] objopt: restrict NFCT_GOPT_IS_{S,D}PAT to supported layer 4 protocols
Date: Wed, 10 Jun 2026 12:30:39 +0200
Message-ID: <20260610103039.167819-1-pablo@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13187-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE39B6686A1

If layer 4 protocol has no ports, then return false. Otherwise, users
like the conntrack utility filtering does not properly work with layer 4
protocol such as ICMP and ICMPv6.

Fixes: 93c459d603cc ("objopt: use indirect calls instead of switch")
Reported-by: Jan Kasprzak <kas@fi.muni.cz>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/conntrack/objopt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/conntrack/objopt.c b/src/conntrack/objopt.c
index 1581480667e5..6024d15e2602 100644
--- a/src/conntrack/objopt.c
+++ b/src/conntrack/objopt.c
@@ -182,8 +182,27 @@ static int getobjopt_is_dnat(const struct nf_conntrack *ct)
 	}
 }
 
+static bool l4proto_has_ports(const struct nf_conntrack *ct)
+{
+	switch (ct->head.orig.l3protonum) {
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


