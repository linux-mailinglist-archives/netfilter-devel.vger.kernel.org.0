Return-Path: <netfilter-devel+bounces-13904-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8PcoOFfeVGp8gAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13904-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 14:47:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E3F74B154
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 14:47:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cwx391WJ;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13904-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13904-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC694300380A
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC73840F8C3;
	Mon, 13 Jul 2026 12:47:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F240BCBC;
	Mon, 13 Jul 2026 12:46:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946832; cv=none; b=dp4ZOpMatArzdVYa0RZ1B8puCqrsmzBeGkOFETQuhM9afX5ZsvoYgRzoxyLCQaiDq2DbQKE89ur8XgnoMDWy/D//i4OWCO6YxP94jDm/Zb8rP7SDmFsQGZnzA1c5dlBx+PrlwAu9IDiZ2Dwgbe5e0YR6lkhEk2GkJNy8P+ueWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946832; c=relaxed/simple;
	bh=JUOlTSIvxKhsRlE6//c/p/Cj1l8zVEvYKyIj87vcuuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DbT0MUz7DUesh9iztYOp3XkQizZwfW0Xu1M8ONyv++PmIVtZLcPUMeOGYcN9s7ndf2JF/2AnBNc26nVnvCmtapdWmimyEP3Wrk8e8duHjb3quChVstxeb8AmFJdEbtks2gP0AqT4msy1ZJZHwyRnC/A2yJC+UGy4cWUPGHMm6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwx391WJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7F21F00A3A;
	Mon, 13 Jul 2026 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783946817;
	bh=qhSKO1TlOOgIkh5ph4Qqy3ckZiD3wlWr/B0sEX/B/4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cwx391WJDCkC6PST+9lD0BmWmBrunYda9r3NVBgyoDgOqQoGbTr7zYNqHfyQQQqKb
	 IPTnJ8PdU803ASNppjpRx2tJx8erw/nox28Syb/s7rlHM9PNxWExfOriWS1yrbY2+i
	 coKW8nNMjnFlxDzxBMO0fcGO71pUWeJXH0Y0g3OnTXM4QV4FQhxE+x4oqTQRTRs8wP
	 UQCyCdF9zhHMbgnt2/lhlGHydfnHBLXDeaQaGXZWTAvvM50UbUWOmm83bh6iJz0MA1
	 jAOSEdImg2YOFGGP90eMR1Ls4eKfzylog1jULVnJE9iiiaw6bwJYk6P3Fdz0YzC9CD
	 4DNfEXtfdrKtg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 13 Jul 2026 14:46:23 +0200
Subject: [PATCH nf-next v6 6/6] selftests: netfilter: nft_flowtable.sh: add
 SIT flowtable selftest
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-flowtable-sw-accel-ip6ip-v6-6-33f0155fc658@kernel.org>
References: <20260713-b4-flowtable-sw-accel-ip6ip-v6-0-33f0155fc658@kernel.org>
In-Reply-To: <20260713-b4-flowtable-sw-accel-ip6ip-v6-0-33f0155fc658@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
 Shuah Khan <shuah@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:nbd@nbd.name,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:shuah@kernel.org,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nbd.name,gmail.com,collabora.com,nvidia.com,netfilter.org,strlen.de,nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13904-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nft_flowtable.sh:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2E3F74B154

Similar to IPIP, IP6IP6 and IPv4 over IPv6, introduce specific selftest
for SIT flowtable sw acceleration in nft_flowtable.sh.

Also add tunnel-specific flow-add rules for sit1 and sit1.10 so that
check_counters() properly verifies offload occurred, and restore IPv6
default routes at cleanup to prevent tunnel routes leaking to subsequent
tests (e.g. IPsec).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/testing/selftests/net/netfilter/config       |  1 +
 .../selftests/net/netfilter/nft_flowtable.sh       | 53 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
index c3c121b6f300..a212b9edbcd9 100644
--- a/tools/testing/selftests/net/netfilter/config
+++ b/tools/testing/selftests/net/netfilter/config
@@ -35,6 +35,7 @@ CONFIG_IP_SCTP=m
 CONFIG_IPV6=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_TUNNEL=m
+CONFIG_IPV6_SIT=m
 CONFIG_IP_VS=m
 CONFIG_IP_VS_PROTO_TCP=y
 CONFIG_IP_VS_RR=m
diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 1cb5c65351b7..cda68070cd00 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -597,6 +597,10 @@ ip -net "$nsr1" addr add 192.168.210.1/24 dev tun6
 ip -net "$nsr1" addr add fee1:3::1/64 dev tun6 nodad
 ip netns exec "$nsr1" sysctl net.ipv4.conf.tun6.forwarding=1 > /dev/null
 
+ip -net "$nsr1" link add name sit1 type sit local 192.168.10.1 remote 192.168.10.2 ttl 255
+ip -net "$nsr1" link set sit1 up
+ip -net "$nsr1" addr add fe01:3::1/64 dev sit1 nodad
+
 ip -net "$nsr2" link add name tun0 type ipip local 192.168.10.2 remote 192.168.10.1
 ip -net "$nsr2" link set tun0 up
 ip -net "$nsr2" addr add 192.168.100.2/24 dev tun0
@@ -608,6 +612,10 @@ ip -net "$nsr2" addr add 192.168.210.2/24 dev tun6
 ip -net "$nsr2" addr add fee1:3::2/64 dev tun6 nodad
 ip netns exec "$nsr2" sysctl net.ipv4.conf.tun6.forwarding=1 > /dev/null
 
+ip -net "$nsr2" link add name sit1 type sit local 192.168.10.2 remote 192.168.10.1 ttl 255
+ip -net "$nsr2" link set sit1 up
+ip -net "$nsr2" addr add fe01:3::2/64 dev sit1 nodad
+
 ip -net "$nsr1" route change default via 192.168.100.2
 ip -net "$nsr2" route change default via 192.168.100.1
 
@@ -626,6 +634,9 @@ ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun0 acce
 ip netns exec "$nsr1" nft -a insert rule inet filter forward \
 	'meta oif tun6 tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
 ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun6 accept'
+ip netns exec "$nsr1" nft -a insert rule inet filter forward \
+	'meta oif sit1 tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
+ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif sit1 accept'
 ip netns exec "$nsr1" nft -a insert rule inet filter forward \
 	'meta oif "veth0" tcp sport 12345 ct mark set 1 flow add @f1 counter name routed_repl accept'
 
@@ -652,6 +663,19 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IP4IP6 tunnel"; then
 	ret=1
 fi
 
+ip -6 -net "$nsr1" route delete default
+ip -6 -net "$nsr1" route add default via fe01:3::2
+ip -6 -net "$nsr2" route delete default
+ip -6 -net "$nsr2" route add default via fe01:3::1
+
+if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
+	check_counters "flow offload for ns1/ns2 SIT tunnel"
+else
+	echo "FAIL: flow offload for ns1/ns2 with SIT tunnel" 1>&2
+	ip netns exec "$nsr1" nft list ruleset
+	ret=1
+fi
+
 # Create vlan tagged devices for IPIP traffic.
 ip -net "$nsr1" link add link veth1 name veth1.10 type vlan id 10
 ip -net "$nsr1" link set veth1.10 up
@@ -682,6 +706,13 @@ ip netns exec "$nsr1" nft -a insert rule inet filter forward \
 	'meta oif tun6.10 tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
 ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun6.10 accept'
 
+ip -net "$nsr1" link add name sit1.10 type sit local 192.168.20.1 remote 192.168.20.2 ttl 255
+ip -net "$nsr1" link set sit1.10 up
+ip -net "$nsr1" addr add fe01:5::1/64 dev sit1.10 nodad
+ip netns exec "$nsr1" nft -a insert rule inet filter forward \
+	'meta oif sit1.10 tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
+ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif sit1.10 accept'
+
 ip -net "$nsr2" link add link veth0 name veth0.10 type vlan id 10
 ip -net "$nsr2" link set veth0.10 up
 ip -net "$nsr2" addr add 192.168.20.2/24 dev veth0.10
@@ -699,6 +730,11 @@ ip -net "$nsr2" link set tun6.10 up
 ip -net "$nsr2" addr add 192.168.220.2/24 dev tun6.10
 ip -net "$nsr2" addr add fee1:5::2/64 dev tun6.10 nodad
 ip netns exec "$nsr2" sysctl net.ipv4.conf.tun6/10.forwarding=1 > /dev/null
+
+ip -net "$nsr2" link add name sit1.10 type sit local 192.168.20.2 remote 192.168.20.1 ttl 255
+ip -net "$nsr2" link set sit1.10 up
+ip -net "$nsr2" addr add fe01:5::2/64 dev sit1.10 nodad
+
 ip -6 -net "$nsr2" route delete default
 ip -6 -net "$nsr2" route add default via fee1:5::1
 
@@ -725,11 +761,28 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IP4IP6 tunnel over vlan"; then
 	ret=1
 fi
 
+ip -6 -net "$nsr1" route delete default
+ip -6 -net "$nsr1" route add default via fe01:5::2
+ip -6 -net "$nsr2" route delete default
+ip -6 -net "$nsr2" route add default via fe01:5::1
+
+if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
+	check_counters "flow offload for ns1/ns2 SIT tunnel over vlan"
+else
+	echo "FAIL: flow offload for ns1/ns2 with SIT tunnel over vlan" 1>&2
+	ip netns exec "$nsr1" nft list ruleset
+	ret=1
+fi
+
 # Restore the previous configuration
 ip -net "$nsr1" route change default via 192.168.10.2
 ip -net "$nsr2" route change default via 192.168.10.1
 ip -net "$ns2" route del default via 10.0.2.1
 ip -6 -net "$ns2" route del default via dead:2::1
+ip -6 -net "$nsr1" route delete default
+ip -6 -net "$nsr1" route add default via fee1:2::2
+ip -6 -net "$nsr2" route delete default
+ip -6 -net "$nsr2" route add default via fee1:2::1
 }
 
 # Another test:

-- 
2.55.0


