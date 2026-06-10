Return-Path: <netfilter-devel+bounces-13208-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cHYTDx+mKWpxbQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13208-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 19:59:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B9A66C1A8
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 19:59:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13208-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13208-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 675093050DEB
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940463546E3;
	Wed, 10 Jun 2026 17:59:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6D3546E5;
	Wed, 10 Jun 2026 17:59:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114369; cv=none; b=Xs1TexsuTV3TwnLfUdGAvFY8ln8pQA48CPJ4u+/gOYFviZbJoFIm8Mk9aXYXoSqwBGQTNFE/7zySBOnf1ljXv0wxEJfDugZ8paPjFsEIPj4fIiqP93DslgGrvjZx279/49sSBu8YJJ2pqC4EfdHuqexf9ZaAVFrBW/Y9VazjS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114369; c=relaxed/simple;
	bh=zpTeorYlY6HcA3ishC/vc9S0siFloCceXbyPl8pB9HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mC4lsl0B1oH30ZJ6DWo5ptzOOFbyHpPwgLxd47m9UB95CQynjxDjfR9oOYm8ySydF7RABEV1zCURw4QlwLD6X8gBX/9xijCpJ74+/hMAYXf93c2VYuMxZKq5P9TSp0c9qyU3Gkxd8TwRXyFxeoug0Lu+NcEniGqd4VkjkukUjbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 556FD6080D; Wed, 10 Jun 2026 19:59:26 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next 2/2] selftests: netfilter: add phony nft_offload test
Date: Wed, 10 Jun 2026 19:58:44 +0200
Message-ID: <20260610175906.1767-3-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610175906.1767-1-fw@strlen.de>
References: <20260610175906.1767-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13208-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,strlen.de:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4B9A66C1A8

... "phony", because its not testing offloads, it tests the control
plane code.  Also test error unwind via fault injection framework.

For a proper test, real hardware would be required given we'd have
check if 'previously handed off to hardware' offload commands are
properly removed again on failure or rule flush.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 tools/testing/selftests/net/netfilter/config  |   6 +
 .../selftests/net/netfilter/nft_offload.sh    | 132 ++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100755 tools/testing/selftests/net/netfilter/nft_offload.sh

diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index d953ee218c0f..f88dd4ef8d26 100644
--- a/tools/testing/selftests/net/netfilter/Makefile
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -32,6 +32,7 @@ TEST_PROGS := \
 	nft_meta.sh \
 	nft_nat.sh \
 	nft_nat_zones.sh \
+	nft_offload.sh \
 	nft_queue.sh \
 	nft_synproxy.sh \
 	nft_tproxy_tcp.sh \
diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
index 979cff56e1f5..563a1e5c6322 100644
--- a/tools/testing/selftests/net/netfilter/config
+++ b/tools/testing/selftests/net/netfilter/config
@@ -11,6 +11,7 @@ CONFIG_BRIDGE_NF_EBTABLES_LEGACY=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_SHA1=m
+CONFIG_DEBUG_FS=y
 CONFIG_DUMMY=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_ESP=m
@@ -33,9 +34,14 @@ CONFIG_IPV6_TUNNEL=m
 CONFIG_IP_VS=m
 CONFIG_IP_VS_PROTO_TCP=y
 CONFIG_IP_VS_RR=m
+CONFIG_FAIL_FUNCTION=y
+CONFIG_FAULT_INJECTION=y
+CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_MACVLAN=m
 CONFIG_NAMESPACES=y
 CONFIG_NET_CLS_U32=m
+CONFIG_NETDEVSIM=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=m
diff --git a/tools/testing/selftests/net/netfilter/nft_offload.sh b/tools/testing/selftests/net/netfilter/nft_offload.sh
new file mode 100755
index 000000000000..152f09a81403
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/nft_offload.sh
@@ -0,0 +1,132 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+
+checktool "nft --version" "run test without nft tool"
+modprobe -q netdevsim
+
+sysfs="/sys/kernel/debug/fail_function"
+failname="/proc/self/make-it-fail"
+duration=30
+fault=0
+ret=0
+file_ft=""
+file_rs=""
+id=$((RANDOM%65536))
+
+read t < /proc/sys/kernel/tainted
+if [ "$t" -ne 0 ];then
+	echo SKIP: kernel is tainted
+	exit $ksft_skip
+fi
+
+cleanup() {
+    cleanup_netdevsim "$id" "$NS"
+    cleanup_ns "$NS"
+    [ $fault -eq 1 ] && echo '!nsim_setup_tc' > "$sysfs/inject"
+    rm -f "$file_ft" "$file_rs"
+}
+trap cleanup EXIT
+
+skip() {
+	echo "SKIP: $@"
+	[ $ret -eq 0 ] && exit 4
+
+	exit $ret
+}
+
+set -e
+setup_ns NS
+
+nsim=$(create_netdevsim "$id" "$NS" )
+
+nsim_port=$(create_netdevsim_port "$id" "$NS" 2)
+
+file_ft=$(mktemp)
+cat > "$file_ft" <<EOF
+flush ruleset
+table inet t {
+	flowtable f {
+		flags offload
+		hook ingress priority filter + 10
+		devices = { "$nsim_port", "dummyf1" }
+	}
+
+	chain cf {
+		type filter hook forward priority 0; policy accept;
+		ct state new meta l4proto tcp flow add @f
+	}
+}
+EOF
+
+if ip netns exec "$NS" nft -f "$file_ft"; then
+	echo "PASS: flowtable offload"
+else
+	echo "FAIL: flowtable offload"
+	ret=1
+fi
+
+file_rs=$(mktemp)
+cat > "$file_rs" <<EOF
+table netdev t {
+	chain c {
+		type filter hook ingress device $nsim_port priority 1
+		flags offload
+		ip saddr 10.2.1.1 ip daddr 10.2.1.2 ip protocol icmp accept
+		ip saddr 10.2.1.1 ip daddr 10.2.1.3 ip protocol icmp drop
+		ip saddr 10.2.1.0/24 ip daddr 10.2.1.0/24 ip protocol icmp accept
+		ip6 saddr dead:beef::1 ip6 daddr dead:beef::2 meta l4proto ipv6-icmp accept
+		ip6 saddr dead:beef::1 ip6 daddr dead:beef::3 meta l4proto ipv6-icmp drop
+		ip6 saddr dead:beef::/64 ip6 daddr dead:beef::/64 meta l4proto ipv6-icmp accept
+	}
+}
+EOF
+if ip netns exec "$NS" nft -f "$file_rs"; then
+	echo "PASS: ruleset offload"
+else
+	echo "FAIL: ruleset offload"
+	ret=1
+fi
+
+test -d "$sysfs" || skip "$sysfs not present"
+grep -q nsim_setup_tc "$sysfs/injectable" || skip "nsim_setup_tc fault injection not available"
+
+echo Y > "$sysfs/task-filter"
+echo 0 > "$sysfs/verbose"
+echo "nsim_setup_tc" > "$sysfs/inject"
+fault=1
+
+p=$(((RANDOM%90) + 10))
+echo $p > "$sysfs/probability"
+echo -1 > "$sysfs/times"
+
+count=0
+ok=0
+
+now=$(date +%s)
+stop=$((now+$duration))
+
+# fault-injection enabled rule loads are expected to fail.
+set +e
+while [ $now -le $stop ]; do
+	for f in "$file_ft" "$file_rs"; do
+		ip netns exec "$NS" bash -c "echo 1 > $failname ; ip netns exec "$NS" nft -f $f" 2> /dev/null
+		[ $? -eq 0 ] && ok=$((ok+1))
+		count=$((count+1))
+	done
+	now=$(date +%s)
+done
+
+sleep 5
+
+read t < /proc/sys/kernel/tainted
+if [ "$t" -eq 0 ];then
+	echo PASS: kernel not tainted. $count rounds, $ok successful ruleset loads with P $p.
+else
+	echo ERROR: kernel is tainted. $count rounds, $ok successful ruleset loads with P $p.
+	dmesg
+	ret=1
+fi
+
+exit $ret
-- 
2.53.0


