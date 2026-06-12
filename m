Return-Path: <netfilter-devel+bounces-13230-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ++rYJO/PK2oIFgQAu9opvQ
	(envelope-from <netfilter-devel+bounces-13230-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2026 11:22:55 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ADA678376
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2026 11:22:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13230-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13230-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3495301A7F7
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2026 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618052BEFEB;
	Fri, 12 Jun 2026 09:22:36 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21E3988E1;
	Fri, 12 Jun 2026 09:22:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256156; cv=none; b=kVs+4PnJcD7Q7pWb8+eIgAXlAmWdwFRg9S4TP3YoqWWEpF34m2lJKIVNGWSLtvH2VzTsXdZuDKrJfgo7IudlI/MSxupJpbaevkeY+3GG7Hzcb+nQsp6pxk0CkcRcgLcLZUrCdfidZMRkITCPgBd6tKKReLZaTE7y3JtzH3rayWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256156; c=relaxed/simple;
	bh=K+tYxST+ulBMxf4nKUSLyts7S0iIj1/+RRPCekN1hfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmNjs8Hqy16kizrPHpnj0orB8P/wiNDgeLgrGiPVAHU6fH+bc8KpzlRc/q4z4EuiEPJr2zh2QcUyOE645vfR49bm+t3HehgGELQLCyugytyCyMtlMSEeH5TzuZV5TTJ1iJhHoW6SpiAPW1cVe8TzbAqXE8nIrxKSzG2QLGUF8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A0D6C607E1; Fri, 12 Jun 2026 11:22:29 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH v2 net-next 2/2] selftests: netfilter: add phony nft_offload test
Date: Fri, 12 Jun 2026 11:22:09 +0200
Message-ID: <20260612092209.11966-3-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612092209.11966-1-fw@strlen.de>
References: <20260612092209.11966-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13230-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,strlen.de:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06ADA678376

... "phony", because its not testing offloads, it tests the control
plane code.  Also test error unwind via fault injection framework.

For a proper test, real hardware would be required given we'd have
check if 'previously handed off to hardware' offload commands are
properly removed again on failure or rule flush.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: sort config
     shellcheck fixups

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
index 979cff56e1f5..c3c121b6f300 100644
--- a/tools/testing/selftests/net/netfilter/config
+++ b/tools/testing/selftests/net/netfilter/config
@@ -11,7 +11,12 @@ CONFIG_BRIDGE_NF_EBTABLES_LEGACY=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_SHA1=m
+CONFIG_DEBUG_FS=y
 CONFIG_DUMMY=m
+CONFIG_FAIL_FUNCTION=y
+CONFIG_FAULT_INJECTION=y
+CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_INET_DIAG=m
 CONFIG_INET_ESP=m
 CONFIG_INET_SCTP_DIAG=m
@@ -36,6 +41,7 @@ CONFIG_IP_VS_RR=m
 CONFIG_MACVLAN=m
 CONFIG_NAMESPACES=y
 CONFIG_NET_CLS_U32=m
+CONFIG_NETDEVSIM=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=m
diff --git a/tools/testing/selftests/net/netfilter/nft_offload.sh b/tools/testing/selftests/net/netfilter/nft_offload.sh
new file mode 100755
index 000000000000..859bdedf1a51
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
+read -r t < /proc/sys/kernel/tainted
+if [ "$t" -ne 0 ];then
+	echo SKIP: kernel is tainted
+	exit $ksft_skip
+fi
+
+cleanup() {
+    cleanup_netdevsim "$id" "$NS"
+    cleanup_ns "$NS"
+    [ "$fault" -eq 1 ] && echo '!nsim_setup_tc' > "$sysfs/inject"
+    rm -f "$file_ft" "$file_rs"
+}
+trap cleanup EXIT
+
+skip() {
+	echo "SKIP: $*"
+	[ $ret -eq 0 ] && exit 4
+
+	exit $ret
+}
+
+set -e
+setup_ns NS
+
+create_netdevsim "$id" "$NS" >/dev/null
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
+stop=$((now+duration))
+
+# fault-injection enabled rule loads are expected to fail.
+set +e
+while [ "$now" -le "$stop" ]; do
+	for f in "$file_ft" "$file_rs"; do
+		if ip netns exec "$NS" bash -c "echo 1 > $failname ; ip netns exec \"$NS\" nft -f $f" 2> /dev/null;then
+			ok=$((ok+1))
+		fi
+		count=$((count+1))
+	done
+	now=$(date +%s)
+done
+
+sleep 5
+
+read -r t < /proc/sys/kernel/tainted
+if [ "$t" -eq 0 ];then
+	echo "PASS: Not tainted. $count rounds, $ok successful ruleset loads with P $p."
+else
+	echo "ERROR: Tainted. $count rounds, $ok successful ruleset loads with P $p."
+	dmesg
+	ret=1
+fi
+
+exit $ret
-- 
2.53.0


