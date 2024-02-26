Return-Path: <netfilter-devel+bounces-1100-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D42B8678A7
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Feb 2024 15:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F8CB21A59
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Feb 2024 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F0D12BE8B;
	Mon, 26 Feb 2024 14:34:15 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72112AAC5
	for <netfilter-devel@vger.kernel.org>; Mon, 26 Feb 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958055; cv=none; b=TORVtpWGp41jdyOpKmjUidUHoe0ezd3EGYaY5CaBgGiOIXszyv6Whl0Uqkzdv7uVmtYNL33fuJIPvy7WCI44ewoH1KcYVL79cV+2nr9WgKe0T9miuCYuD/s8udbVLKedBmZ6kyGTC97eeN5R5J5IjK32cFCKsLlURjcJIxGCKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958055; c=relaxed/simple;
	bh=h1i1YE6Ut1uXK2wkjS20RUF2YXYMsJlLRJ2rySFISdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIyuxKFVgISe1EDfYiJ+TVp2qYy/J8xVQlOOODMfeMzJAYy4egLkktRsCe93WS2xYLM+zqN19uJtAek+a2SipE0nNISJW3OBUfbDR5qIiTGiVHR/dlhGH/zyAaStlIKtOWHEKi3OmEFk0qwJ/Byy6wduINiBYm8fR6v10hK5Ii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rec3X-000332-EU; Mon, 26 Feb 2024 15:34:11 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 2/2] selftests: netfilter: add bridge conntrack + multicast test case
Date: Mon, 26 Feb 2024 15:21:48 +0100
Message-ID: <20240226142151.4670-3-fw@strlen.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226142151.4670-1-fw@strlen.de>
References: <20240226142151.4670-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test case for multicast packet confirm race.
Without preceding patch, this should result in:

 WARNING: CPU: 0 PID: 38 at net/netfilter/nf_conntrack_core.c:1198 __nf_conntrack_confirm+0x3ed/0x5f0
 Workqueue: events_unbound macvlan_process_broadcast
 RIP: 0010:__nf_conntrack_confirm+0x3ed/0x5f0
  ? __nf_conntrack_confirm+0x3ed/0x5f0
  nf_confirm+0x2ad/0x2d0
  nf_hook_slow+0x36/0xd0
  ip_local_deliver+0xce/0x110
  __netif_receive_skb_one_core+0x4f/0x70
  process_backlog+0x8c/0x130
  [..]

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tools/testing/selftests/netfilter/Makefile    |   3 +-
 .../selftests/netfilter/bridge_netfilter.sh   | 188 ++++++++++++++++++
 2 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/netfilter/bridge_netfilter.sh

diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index db27153eb4a0..936c3085bb83 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -7,7 +7,8 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
 	nft_queue.sh nft_meta.sh nf_nat_edemux.sh \
 	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
 	conntrack_vrf.sh nft_synproxy.sh rpath.sh nft_audit.sh \
-	conntrack_sctp_collision.sh xt_string.sh
+	conntrack_sctp_collision.sh xt_string.sh \
+	bridge_netfilter.sh
 
 HOSTPKG_CONFIG := pkg-config
 
diff --git a/tools/testing/selftests/netfilter/bridge_netfilter.sh b/tools/testing/selftests/netfilter/bridge_netfilter.sh
new file mode 100644
index 000000000000..659b3ab02c8b
--- /dev/null
+++ b/tools/testing/selftests/netfilter/bridge_netfilter.sh
@@ -0,0 +1,188 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test bridge netfilter + conntrack, a combination that doesn't really work,
+# with multicast/broadcast packets racing for hash table insertion.
+
+#           eth0    br0     eth0
+# setup is: ns1 <->,ns0 <-> ns3
+#           ns2 <-'    `'-> ns4
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+ret=0
+
+sfx=$(mktemp -u "XXXXXXXX")
+ns0="ns0-$sfx"
+ns1="ns1-$sfx"
+ns2="ns2-$sfx"
+ns3="ns3-$sfx"
+ns4="ns4-$sfx"
+
+ebtables -V > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run test without ebtables"
+	exit $ksft_skip
+fi
+
+ip -Version > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+for i in $(seq 0 4); do
+  eval ip netns add \$ns$i
+done
+
+cleanup() {
+  for i in $(seq 0 4); do eval ip netns del \$ns$i;done
+}
+
+trap cleanup EXIT
+
+do_ping()
+{
+	fromns="$1"
+	dstip="$2"
+
+	ip netns exec $fromns ping -c 1 -q $dstip > /dev/null
+	if [ $? -ne 0 ]; then
+		echo "ERROR: ping from $fromns to $dstip"
+		ip netns exec ${ns0} nft list ruleset
+		ret=1
+	fi
+}
+
+bcast_ping()
+{
+	fromns="$1"
+	dstip="$2"
+
+	for i in $(seq 1 1000); do
+		ip netns exec $fromns ping -q -f -b -c 1 -q $dstip > /dev/null 2>&1
+		if [ $? -ne 0 ]; then
+			echo "ERROR: ping -b from $fromns to $dstip"
+			ip netns exec ${ns0} nft list ruleset
+			fi
+	done
+}
+
+ip link add veth1 netns ${ns0} type veth peer name eth0 netns ${ns1}
+if [ $? -ne 0 ]; then
+	echo "SKIP: Can't create veth device"
+	exit $ksft_skip
+fi
+
+ip link add veth2 netns ${ns0} type veth peer name eth0 netns $ns2
+ip link add veth3 netns ${ns0} type veth peer name eth0 netns $ns3
+ip link add veth4 netns ${ns0} type veth peer name eth0 netns $ns4
+
+ip -net ${ns0} link set lo up
+
+for i in $(seq 1 4); do
+  ip -net ${ns0} link set veth$i up
+done
+
+ip -net ${ns0} link add br0 type bridge stp_state 0 forward_delay 0 nf_call_iptables 1 nf_call_ip6tables 1 nf_call_arptables 1
+if [ $? -ne 0 ]; then
+	echo "SKIP: Can't create bridge br0"
+	exit $ksft_skip
+fi
+
+# make veth0,1,2 part of bridge.
+for i in $(seq 1 3); do
+  ip -net ${ns0} link set veth$i master br0
+done
+
+# add a macvlan on top of the bridge.
+MACVLAN_ADDR=ba:f3:13:37:42:23
+ip -net ${ns0} link add link br0 name macvlan0 type macvlan mode private
+ip -net ${ns0} link set macvlan0 address ${MACVLAN_ADDR}
+ip -net ${ns0} link set macvlan0 up
+ip -net ${ns0} addr add 10.23.0.1/24 dev macvlan0
+
+# add a macvlan on top of veth4.
+MACVLAN_ADDR=ba:f3:13:37:42:24
+ip -net ${ns0} link add link veth4 name macvlan4 type macvlan mode vepa
+ip -net ${ns0} link set macvlan4 address ${MACVLAN_ADDR}
+ip -net ${ns0} link set macvlan4 up
+
+# make the macvlan part of the bridge.
+# veth4 is not a bridge port, only the macvlan on top of it.
+ip -net ${ns0} link set macvlan4 master br0
+
+ip -net ${ns0} link set br0 up
+ip -net ${ns0} addr add 10.0.0.1/24 dev br0
+ip netns exec ${ns0} sysctl -q net.bridge.bridge-nf-call-iptables=1
+ret=$?
+if [ $ret -ne 0 ] ; then
+	echo "SKIP: bridge netfilter not available"
+	ret=$ksft_skip
+fi
+
+# for testing, so namespaces will reply to ping -b probes.
+ip netns exec ${ns0} sysctl -q net.ipv4.icmp_echo_ignore_broadcasts=0
+
+# enable conntrack in ns0 and drop broadcast packets in forward to
+# avoid them from getting confirmed in the postrouting hook before
+# the cloned skb is passed up the stack.
+ip netns exec ${ns0} nft -f - <<EOF
+table ip filter {
+	chain input {
+		type filter hook input priority 1; policy accept
+		iifname br0 counter
+		ct state new accept
+	}
+}
+
+table bridge filter {
+	chain forward {
+		type filter hook forward priority 0; policy accept
+		meta pkttype broadcast ip protocol icmp counter drop
+	}
+}
+EOF
+
+# place 1, 2 & 3 in same subnet, connected via ns0:br0.
+# ns4 is placed in same subnet as well, but its not
+# part of the bridge: the corresponding veth4 is not
+# part of the bridge, only its macvlan interface.
+for i in $(seq 1 4); do
+  eval ip -net \$ns$i link set lo up
+  eval ip -net \$ns$i link set eth0 up
+done
+for i in $(seq 1 2); do
+  eval ip -net \$ns$i addr add 10.0.0.1$i/24 dev eth0
+done
+
+ip -net ${ns3} addr add 10.23.0.13/24 dev eth0
+ip -net ${ns4} addr add 10.23.0.14/24 dev eth0
+
+# test basic connectivity
+do_ping ${ns1} 10.0.0.12
+do_ping ${ns3} 10.23.0.1
+do_ping ${ns4} 10.23.0.1
+
+if [ $ret -eq 0 ];then
+	echo "PASS: netns connectivity: ns1 can reach ns2, ns3 and ns4 can reach ns0"
+fi
+
+bcast_ping ${ns1} 10.0.0.255
+
+# This should deliver broadcast to macvlan0, which is on top of ns0:br0.
+bcast_ping ${ns3} 10.23.0.255
+
+# same, this time via veth4:macvlan4.
+bcast_ping ${ns4} 10.23.0.255
+
+read t < /proc/sys/kernel/tainted
+
+if [ $t -eq 0 ];then
+	echo PASS: kernel not tainted
+else
+	echo ERROR: kernel is tainted
+	ret=1
+fi
+
+exit $ret
-- 
2.43.0


