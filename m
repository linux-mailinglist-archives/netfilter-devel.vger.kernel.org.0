Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51C12EB5FE
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Jan 2021 00:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbhAEXQh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Jan 2021 18:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbhAEXQg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:16:36 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F343C061793;
        Tue,  5 Jan 2021 15:15:51 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1kwvYI-0000RS-CL; Wed, 06 Jan 2021 00:15:47 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netdev@vger.kernel.org>
Cc:     christian.perle@secunet.com, steffen.klassert@secunet.com,
        <netfilter-devel@vger.kernel.org>, Florian Westphal <fw@strlen.de>,
        Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH net 1/3] selftests: netfilter: add selftest for ipip pmtu discovery with enabled connection tracking
Date:   Wed,  6 Jan 2021 00:15:21 +0100
Message-Id: <20210105231523.622-2-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210105231523.622-1-fw@strlen.de>
References: <20210105121208.GA11593@cell>
 <20210105231523.622-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Convert Christians bug description into a reproducer.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Reported-by: Christian Perle <christian.perle@secunet.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tools/testing/selftests/netfilter/Makefile    |   3 +-
 .../selftests/netfilter/ipip-conntrack-mtu.sh | 206 ++++++++++++++++++
 2 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/netfilter/ipip-conntrack-mtu.sh

diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index a374e10ef506..3006a8e5b41a 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -4,7 +4,8 @@
 TEST_PROGS := nft_trans_stress.sh nft_nat.sh bridge_brouter.sh \
 	conntrack_icmp_related.sh nft_flowtable.sh ipvs.sh \
 	nft_concat_range.sh nft_conntrack_helper.sh \
-	nft_queue.sh nft_meta.sh
+	nft_queue.sh nft_meta.sh \
+	ipip-conntrack-mtu.sh
 
 LDLIBS = -lmnl
 TEST_GEN_FILES =  nf-queue
diff --git a/tools/testing/selftests/netfilter/ipip-conntrack-mtu.sh b/tools/testing/selftests/netfilter/ipip-conntrack-mtu.sh
new file mode 100755
index 000000000000..4a6f5c3b3215
--- /dev/null
+++ b/tools/testing/selftests/netfilter/ipip-conntrack-mtu.sh
@@ -0,0 +1,206 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+# Conntrack needs to reassemble fragments in order to have complete
+# packets for rule matching.  Reassembly can lead to packet loss.
+
+# Consider the following setup:
+#            +--------+       +---------+       +--------+
+#            |Router A|-------|Wanrouter|-------|Router B|
+#            |        |.IPIP..|         |..IPIP.|        |
+#            +--------+       +---------+       +--------+
+#           /                  mtu 1400                   \
+#          /                                               \
+#+--------+                                                 +--------+
+#|Client A|                                                 |Client B|
+#|        |                                                 |        |
+#+--------+                                                 +--------+
+
+# Router A and Router B use IPIP tunnel interfaces to tunnel traffic
+# between Client A and Client B over WAN. Wanrouter has MTU 1400 set
+# on its interfaces.
+
+rnd=$(mktemp -u XXXXXXXX)
+rx=$(mktemp)
+
+r_a="ns-ra-$rnd"
+r_b="ns-rb-$rnd"
+r_w="ns-rw-$rnd"
+c_a="ns-ca-$rnd"
+c_b="ns-cb-$rnd"
+
+checktool (){
+	if ! $1 > /dev/null 2>&1; then
+		echo "SKIP: Could not $2"
+		exit $ksft_skip
+	fi
+}
+
+checktool "iptables --version" "run test without iptables"
+checktool "ip -Version" "run test without ip tool"
+checktool "which nc" "run test without nc (netcat)"
+checktool "ip netns add ${r_a}" "create net namespace"
+
+for n in ${r_b} ${r_w} ${c_a} ${c_b};do
+	ip netns add ${n}
+done
+
+cleanup() {
+	for n in ${r_a} ${r_b} ${r_w} ${c_a} ${c_b};do
+		ip netns del ${n}
+	done
+	rm -f ${rx}
+}
+
+trap cleanup EXIT
+
+test_path() {
+	msg="$1"
+
+	ip netns exec ${c_b} nc -n -w 3 -q 3 -u -l -p 5000 > ${rx} < /dev/null &
+
+	sleep 1
+	for i in 1 2 3; do
+		head -c1400 /dev/zero | tr "\000" "a" | ip netns exec ${c_a} nc -n -w 1 -u 192.168.20.2 5000
+	done
+
+	wait
+
+	bytes=$(wc -c < ${rx})
+
+	if [ $bytes -eq 1400 ];then
+		echo "OK: PMTU $msg connection tracking"
+	else
+		echo "FAIL: PMTU $msg connection tracking: got $bytes, expected 1400"
+		exit 1
+	fi
+}
+
+# Detailed setup for Router A
+# ---------------------------
+# Interfaces:
+# eth0: 10.2.2.1/24
+# eth1: 192.168.10.1/24
+# ipip0: No IP address, local 10.2.2.1 remote 10.4.4.1
+# Routes:
+# 192.168.20.0/24 dev ipip0    (192.168.20.0/24 is subnet of Client B)
+# 10.4.4.1 via 10.2.2.254      (Router B via Wanrouter)
+# No iptables rules at all.
+
+ip link add veth0 netns ${r_a} type veth peer name veth0 netns ${r_w}
+ip link add veth1 netns ${r_a} type veth peer name veth0 netns ${c_a}
+
+l_addr="10.2.2.1"
+r_addr="10.4.4.1"
+ip netns exec ${r_a} ip link add ipip0 type ipip local ${l_addr} remote ${r_addr} mode ipip || exit $ksft_skip
+
+for dev in lo veth0 veth1 ipip0; do
+    ip -net ${r_a} link set $dev up
+done
+
+ip -net ${r_a} addr add 10.2.2.1/24 dev veth0
+ip -net ${r_a} addr add 192.168.10.1/24 dev veth1
+
+ip -net ${r_a} route add 192.168.20.0/24 dev ipip0
+ip -net ${r_a} route add 10.4.4.0/24 via 10.2.2.254
+
+ip netns exec ${r_a} sysctl -q net.ipv4.conf.all.forwarding=1 > /dev/null
+
+# Detailed setup for Router B
+# ---------------------------
+# Interfaces:
+# eth0: 10.4.4.1/24
+# eth1: 192.168.20.1/24
+# ipip0: No IP address, local 10.4.4.1 remote 10.2.2.1
+# Routes:
+# 192.168.10.0/24 dev ipip0    (192.168.10.0/24 is subnet of Client A)
+# 10.2.2.1 via 10.4.4.254      (Router A via Wanrouter)
+# No iptables rules at all.
+
+ip link add veth0 netns ${r_b} type veth peer name veth1 netns ${r_w}
+ip link add veth1 netns ${r_b} type veth peer name veth0 netns ${c_b}
+
+l_addr="10.4.4.1"
+r_addr="10.2.2.1"
+
+ip netns exec ${r_b} ip link add ipip0 type ipip local ${l_addr} remote ${r_addr} mode ipip || exit $ksft_skip
+
+for dev in lo veth0 veth1 ipip0; do
+	ip -net ${r_b} link set $dev up
+done
+
+ip -net ${r_b} addr add 10.4.4.1/24 dev veth0
+ip -net ${r_b} addr add 192.168.20.1/24 dev veth1
+
+ip -net ${r_b} route add 192.168.10.0/24 dev ipip0
+ip -net ${r_b} route add 10.2.2.0/24 via 10.4.4.254
+ip netns exec ${r_b} sysctl -q net.ipv4.conf.all.forwarding=1 > /dev/null
+
+# Client A
+ip -net ${c_a} addr add 192.168.10.2/24 dev veth0
+ip -net ${c_a} link set dev lo up
+ip -net ${c_a} link set dev veth0 up
+ip -net ${c_a} route add default via 192.168.10.1
+
+# Client A
+ip -net ${c_b} addr add 192.168.20.2/24 dev veth0
+ip -net ${c_b} link set dev veth0 up
+ip -net ${c_b} link set dev lo up
+ip -net ${c_b} route add default via 192.168.20.1
+
+# Wan
+ip -net ${r_w} addr add 10.2.2.254/24 dev veth0
+ip -net ${r_w} addr add 10.4.4.254/24 dev veth1
+
+ip -net ${r_w} link set dev lo up
+ip -net ${r_w} link set dev veth0 up mtu 1400
+ip -net ${r_w} link set dev veth1 up mtu 1400
+
+ip -net ${r_a} link set dev veth0 mtu 1400
+ip -net ${r_b} link set dev veth0 mtu 1400
+
+ip netns exec ${r_w} sysctl -q net.ipv4.conf.all.forwarding=1 > /dev/null
+
+# Path MTU discovery
+# ------------------
+# Running tracepath from Client A to Client B shows PMTU discovery is working
+# as expected:
+#
+# clienta:~# tracepath 192.168.20.2
+# 1?: [LOCALHOST]                      pmtu 1500
+# 1:  192.168.10.1                                          0.867ms
+# 1:  192.168.10.1                                          0.302ms
+# 2:  192.168.10.1                                          0.312ms pmtu 1480
+# 2:  no reply
+# 3:  192.168.10.1                                          0.510ms pmtu 1380
+# 3:  192.168.20.2                                          2.320ms reached
+# Resume: pmtu 1380 hops 3 back 3
+
+# ip netns exec ${c_a} traceroute --mtu 192.168.20.2
+
+# Router A has learned PMTU (1400) to Router B from Wanrouter.
+# Client A has learned PMTU (1400 - IPIP overhead = 1380) to Client B
+# from Router A.
+
+#Send large UDP packet
+#---------------------
+#Now we send a 1400 bytes UDP packet from Client A to Client B:
+
+# clienta:~# head -c1400 /dev/zero | tr "\000" "a" | nc -u 192.168.20.2 5000
+test_path "without"
+
+# The IPv4 stack on Client A already knows the PMTU to Client B, so the
+# UDP packet is sent as two fragments (1380 + 20). Router A forwards the
+# fragments between eth1 and ipip0. The fragments fit into the tunnel and
+# reach their destination.
+
+#When sending the large UDP packet again, Router A now reassembles the
+#fragments before routing the packet over ipip0. The resulting IPIP
+#packet is too big (1400) for the tunnel PMTU (1380) to Router B, it is
+#dropped on Router A before sending.
+
+ip netns exec ${r_a} iptables -A FORWARD -m conntrack --ctstate NEW
+test_path "with"
-- 
2.26.2

