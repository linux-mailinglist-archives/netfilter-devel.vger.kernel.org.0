Return-Path: <netfilter-devel+bounces-13851-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qUv+JYZLUmqiOAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13851-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 15:56:22 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38520741B93
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 15:56:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=anZI2NXe;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13851-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13851-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44EEF30131D7
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE82620DE;
	Sat, 11 Jul 2026 13:56:18 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0515E5DC;
	Sat, 11 Jul 2026 13:56:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783778178; cv=none; b=qElnqAyzYhQE61NynNnfbzcsOpvlgJhq8LCa1i4nXG4uIWhbPRJndn7CP7PRfAgAUv9Md9S5Q/P3RWeuji+Q6I6oPVAQ+NkTB+Ib6pUeW19t5wyxuuSCrbGd9B2iwvRkA4c5jo/opiRte6nRnxmu6psx2L2/wc70H+yFREMSJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783778178; c=relaxed/simple;
	bh=Ilxa91/xmSMwAQV50SahUhvBYhDXmrw6AvaV8FO5t+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LDd6x9S3nlXiv1klVaHAxN7ZmFlR9t8+pYILmyLLZPidiHYAHvq0Dibi1M0d1f9UAqpbS/KmbsjY09p156AxHs+fv229CYRm2SLwQ1MQl6eFeO8cvNWqCu7faOhmhJciyawef7HnEfI0Zjjre32HlswpM+63XYBYa1gdcSiPXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anZI2NXe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A4A1F000E9;
	Sat, 11 Jul 2026 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783778177;
	bh=VaIt5SuuNSmwgTajmIj4ItRNOiPXthdr8Oi+LYItYKo=;
	h=From:Date:Subject:To:Cc;
	b=anZI2NXegF0Jv+WXpfHyxi5tbL593/efATXYac0IDW0X6YqSk1IbZvErUeN60dheb
	 mTmiUNW5IVqPthTU1/pBqpFNPlp+e9DdOTqlKFEZgyFlD4lvHpspShlEqRoUCQN54Q
	 l1j1Efmg6lIkAfWd2oxiJ3DhXiHUOU3Rd6XYQ1WkZBynwNU6fp5KP/vrp40EvXLr8X
	 mDmWtN1ekDCKmxcVdWEcKKJj88N+ILll5I5bmBazxxi+riIdPG49nB38D+vQITiMK9
	 gsQJoXlBY92LRPp6LtLDKLilDlgph8yy46/kuNSGf0StoVkgkxicFohZJeh7XB0cJE
	 P3Ws9PtQx/Z8Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 11 Jul 2026 15:55:57 +0200
Subject: [PATCH nf] selftests: netfilter: nft_flowtable.sh: check offload
 counters for IP6IP6 tunnel test
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-flowtable-selftest-ip6ip6-fix-v1-1-60e9e7384df7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDMBAAvyJ77kISJSn9Sukh1Y1dCFGyQQvi3
 12Eucwc5gChyiTw6g6otLHwUlTso4PxF8tMyJM6OOO8CdZiysve4jcTCuXUSBry6hVM/Mdhekb
 vejeE2IM+1kqa7/8bSoLPeV5j9sBgcwAAAA==
X-Change-ID: 20260711-flowtable-selftest-ip6ip6-fix-4d8a623247a3
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:lorenzo@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-13851-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38520741B93

The IP6IP6 tunnel test uses test_tcp_forwarding() which only verifies
TCP data integrity but does not verify that flowtable offload actually
took place. Unlike the non-tunnel and IPIP tests, it omits the
check_counters() call.
The reply direction for IP6IP6 tunnel traffic goes through the physical
interface (oif=veth0), so it is already counted by the existing
routed_repl counter rule. Add check_counters() after the IP6IP6 test to
detect offload failures.

Fixes: 5e5180352193 ("selftests: netfilter: nft_flowtable.sh: Add IP6IP6 flowtable selftest")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/testing/selftests/net/netfilter/nft_flowtable.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 08ad07500e8a..0ea01a876c8b 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -629,7 +629,7 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IPIP tunnel"; then
 fi
 
 if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
-	echo "PASS: flow offload for ns1/ns2 IP6IP6 tunnel"
+	check_counters "flow offload for ns1/ns2 IP6IP6 tunnel"
 else
 	echo "FAIL: flow offload for ns1/ns2 with IP6IP6 tunnel" 1>&2
 	ip netns exec "$nsr1" nft list ruleset
@@ -683,7 +683,7 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IPIP tunnel over vlan"; then
 fi
 
 if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
-	echo "PASS: flow offload for ns1/ns2 IP6IP6 tunnel over vlan"
+	check_counters "flow offload for ns1/ns2 IP6IP6 tunnel over vlan"
 else
 	echo "FAIL: flow offload for ns1/ns2 with IP6IP6 tunnel over vlan" 1>&2
 	ip netns exec "$nsr1" nft list ruleset

---
base-commit: 3f1f755366687d051174739fb99f7d560202f60b
change-id: 20260711-flowtable-selftest-ip6ip6-fix-4d8a623247a3

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


