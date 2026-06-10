Return-Path: <netfilter-devel+bounces-13195-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xUmaHR2BKWp1YAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13195-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 17:22:05 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF066AA96
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 17:22:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=KoG1N8th;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13195-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13195-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D956E322FC23
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF17426EA0;
	Wed, 10 Jun 2026 15:12:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35517426EA9
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jun 2026 15:12:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104340; cv=none; b=dF8DWFUfe/soXLuETVT1HO6mBvMCZo5uRNQvsoYeBdQXcrEp8tSowqq9aENU9pvKz7t9Vk/AibDnf2eDr6BEkki6sC89dTkUWLqw0jf1U2GjUtlQmNhpODyV8kLjiBYZUj5X5xw0Al3RAaOfDAqUCJ55YCwCzFYatrr4Ysi0Ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104340; c=relaxed/simple;
	bh=iqIIj05dDEp0xVebnZDEHeRLAjYV8Dg+cnEkopPQoyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mCuqQEGHFDOrI600y+aHxDhhpFP7LQG2jI3LuWuYh8GiNYb7XnFtjzSOCFNzZOvRNxksWWBYOk/JQSHD+qvnmUXnzmjTdJrmyDINnnZdiOxRQc9oeMH6ZH3z0oHOLjn0rmWogss4fPOc4ZrEUcAYfvVNc0XKcRX0nzLYxsL40nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=KoG1N8th; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id D3E476017E
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jun 2026 17:12:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781104329;
	bh=7BHHI22OF/vvglKZW30fZV9iEdw957DDXnYHv5LyyUI=;
	h=From:To:Subject:Date:From;
	b=KoG1N8thbvm2FrEsIkctZcjWlHlQ3JED0lUpPlyDaL2/SUitZzwHJ9YYh0WyhsR8P
	 EDRRDA/J3uRPpNB385sh8otO75O8+4sco1XoyJd5N8tqXEytgpmvfUz2M1PgtgzPix
	 NIxXNxab8ldvAXv8HS+PwjwLEtI6FAgyx06/rHe7Y3gmAllf3DQONHIlejCkBwf61s
	 AE2OFdURmQewti4MpATkFMkejyedv4iBn9wff6OB8nCU4dCJscvIOrzS1Eqa+fbm+R
	 d5KxACTr4P0hIy5TLMlbLNqsjrqRzd1AYtjJupL70MhTbiJd5GldgDgQrHBDdOMFto
	 b6bYLevhuDNHA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_conntrack,v2] objopt: restrict NFCT_GOPT_IS_{S,D}PAT to supported layer 4 protocols
Date: Wed, 10 Jun 2026 17:12:06 +0200
Message-ID: <20260610151206.191842-1-pablo@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13195-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: D4BF066AA96

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


