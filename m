Return-Path: <netfilter-devel+bounces-1856-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA48A9E5C
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Apr 2024 17:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039C02831D5
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Apr 2024 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C030616C844;
	Thu, 18 Apr 2024 15:30:07 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA416C685;
	Thu, 18 Apr 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454207; cv=none; b=D4UbxYN9q3I5ow9CbjLDAKxw4GR8l1TNBXmCloEB4QBZrD0sJfyY1JYbUvKekvJ1GqaQyivGe2av+8HE6oLaTGJXnuIF2yIleE8ER919gpAcc8l3dMHX5JdHrdXugQV+QeJ7Q/3J5IPav7oFKp7meoZ/8qRWOEEet3ZyILm91as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454207; c=relaxed/simple;
	bh=jM1Uck/edh7GngO1jXbZjY6/H5RLArFcN9E1o/g6wqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPcpvH1Lsm9iVn9g+XEtYop6hqp4d7PfOSKFIlUow/PThys9gm5tsgJbdJJ+p4ZK9c8ZwV/+yQv9lV4MYinkj7QO0c4PjR3dlqopyl94Eo/8iQVWjKnRMifs7q6eOVAubh83fqMHCpVylKwQjkl4ujSq+0iajQ53f6L0l/Q+w9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rxTi5-00007V-7L; Thu, 18 Apr 2024 17:30:01 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next v2 02/12] selftests: netfilter: nft_queue.sh: shellcheck cleanups
Date: Thu, 18 Apr 2024 17:27:30 +0200
Message-ID: <20240418152744.15105-3-fw@strlen.de>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418152744.15105-1-fw@strlen.de>
References: <20240418152744.15105-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change intended.  Disable frequent shellcheck warnings wrt.
"unreachable" code, those helpers get called indirectly from busywait helper.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/net/netfilter/nft_queue.sh      | 211 +++++++++---------
 1 file changed, 103 insertions(+), 108 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_queue.sh b/tools/testing/selftests/net/netfilter/nft_queue.sh
index 9aee4169d198..8538f08c64c2 100755
--- a/tools/testing/selftests/net/netfilter/nft_queue.sh
+++ b/tools/testing/selftests/net/netfilter/nft_queue.sh
@@ -3,6 +3,8 @@
 # This tests nf_queue:
 # 1. can process packets from all hooks
 # 2. support running nfqueue from more than one base chain
+#
+# shellcheck disable=SC2162,SC2317
 
 source lib.sh
 ret=0
@@ -10,9 +12,9 @@ timeout=2
 
 cleanup()
 {
-	ip netns pids ${ns1} | xargs kill 2>/dev/null
-	ip netns pids ${ns2} | xargs kill 2>/dev/null
-	ip netns pids ${nsrouter} | xargs kill 2>/dev/null
+	ip netns pids "$ns1" | xargs kill 2>/dev/null
+	ip netns pids "$ns2" | xargs kill 2>/dev/null
+	ip netns pids "$nsrouter" | xargs kill 2>/dev/null
 
 	cleanup_all_ns
 
@@ -22,11 +24,7 @@ cleanup()
 	rm -f "$TMPFILE2" "$TMPFILE3"
 }
 
-nft --version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without nft tool"
-	exit $ksft_skip
-fi
+checktool "nft --version" "test without nft tool"
 
 trap cleanup EXIT
 
@@ -38,41 +36,40 @@ TMPFILE2=$(mktemp)
 TMPFILE3=$(mktemp)
 
 TMPINPUT=$(mktemp)
-dd conv=sparse status=none if=/dev/zero bs=1M count=200 of=$TMPINPUT
+dd conv=sparse status=none if=/dev/zero bs=1M count=200 of="$TMPINPUT"
 
-ip link add veth0 netns ${nsrouter} type veth peer name eth0 netns ${ns1} > /dev/null 2>&1
-if [ $? -ne 0 ];then
+if ! ip link add veth0 netns "$nsrouter" type veth peer name eth0 netns "$ns1" > /dev/null 2>&1; then
     echo "SKIP: No virtual ethernet pair device support in kernel"
     exit $ksft_skip
 fi
-ip link add veth1 netns ${nsrouter} type veth peer name eth0 netns ${ns2}
+ip link add veth1 netns "$nsrouter" type veth peer name eth0 netns "$ns2"
 
-ip -net ${nsrouter} link set veth0 up
-ip -net ${nsrouter} addr add 10.0.1.1/24 dev veth0
-ip -net ${nsrouter} addr add dead:1::1/64 dev veth0 nodad
+ip -net "$nsrouter" link set veth0 up
+ip -net "$nsrouter" addr add 10.0.1.1/24 dev veth0
+ip -net "$nsrouter" addr add dead:1::1/64 dev veth0 nodad
 
-ip -net ${nsrouter} link set veth1 up
-ip -net ${nsrouter} addr add 10.0.2.1/24 dev veth1
-ip -net ${nsrouter} addr add dead:2::1/64 dev veth1 nodad
+ip -net "$nsrouter" link set veth1 up
+ip -net "$nsrouter" addr add 10.0.2.1/24 dev veth1
+ip -net "$nsrouter" addr add dead:2::1/64 dev veth1 nodad
 
-ip -net ${ns1} link set eth0 up
-ip -net ${ns2} link set eth0 up
+ip -net "$ns1" link set eth0 up
+ip -net "$ns2" link set eth0 up
 
-ip -net ${ns1} addr add 10.0.1.99/24 dev eth0
-ip -net ${ns1} addr add dead:1::99/64 dev eth0 nodad
-ip -net ${ns1} route add default via 10.0.1.1
-ip -net ${ns1} route add default via dead:1::1
+ip -net "$ns1" addr add 10.0.1.99/24 dev eth0
+ip -net "$ns1" addr add dead:1::99/64 dev eth0 nodad
+ip -net "$ns1" route add default via 10.0.1.1
+ip -net "$ns1" route add default via dead:1::1
 
-ip -net ${ns2} addr add 10.0.2.99/24 dev eth0
-ip -net ${ns2} addr add dead:2::99/64 dev eth0 nodad
-ip -net ${ns2} route add default via 10.0.2.1
-ip -net ${ns2} route add default via dead:2::1
+ip -net "$ns2" addr add 10.0.2.99/24 dev eth0
+ip -net "$ns2" addr add dead:2::99/64 dev eth0 nodad
+ip -net "$ns2" route add default via 10.0.2.1
+ip -net "$ns2" route add default via dead:2::1
 
 load_ruleset() {
 	local name=$1
 	local prio=$2
 
-ip netns exec ${nsrouter} nft -f /dev/stdin <<EOF
+ip netns exec "$nsrouter" nft -f /dev/stdin <<EOF
 table inet $name {
 	chain nfq {
 		ip protocol icmp queue bypass
@@ -108,7 +105,7 @@ EOF
 load_counter_ruleset() {
 	local prio=$1
 
-ip netns exec ${nsrouter} nft -f /dev/stdin <<EOF
+ip netns exec "$nsrouter" nft -f /dev/stdin <<EOF
 table inet countrules {
 	chain pre {
 		type filter hook prerouting priority $prio; policy accept;
@@ -135,13 +132,11 @@ EOF
 }
 
 test_ping() {
-  ip netns exec ${ns1} ping -c 1 -q 10.0.2.99 > /dev/null
-  if [ $? -ne 0 ];then
+  if ! ip netns exec "$ns1" ping -c 1 -q 10.0.2.99 > /dev/null; then
 	return 1
   fi
 
-  ip netns exec ${ns1} ping -c 1 -q dead:2::99 > /dev/null
-  if [ $? -ne 0 ];then
+  if ! ip netns exec "$ns1" ping -c 1 -q dead:2::99 > /dev/null; then
 	return 2
   fi
 
@@ -149,13 +144,11 @@ test_ping() {
 }
 
 test_ping_router() {
-  ip netns exec ${ns1} ping -c 1 -q 10.0.2.1 > /dev/null
-  if [ $? -ne 0 ];then
+  if ! ip netns exec "$ns1" ping -c 1 -q 10.0.2.1 > /dev/null; then
 	return 3
   fi
 
-  ip netns exec ${ns1} ping -c 1 -q dead:2::1 > /dev/null
-  if [ $? -ne 0 ];then
+  if ! ip netns exec "$ns1" ping -c 1 -q dead:2::1 > /dev/null; then
 	return 4
   fi
 
@@ -165,7 +158,7 @@ test_ping_router() {
 test_queue_blackhole() {
 	local proto=$1
 
-ip netns exec ${nsrouter} nft -f /dev/stdin <<EOF
+ip netns exec "$nsrouter" nft -f /dev/stdin <<EOF
 table $proto blackh {
 	chain forward {
 	type filter hook forward priority 0; policy accept;
@@ -173,24 +166,23 @@ table $proto blackh {
 	}
 }
 EOF
-	if [ $proto = "ip" ] ;then
-		ip netns exec ${ns1} ping -W 2 -c 1 -q 10.0.2.99 > /dev/null
+	if [ "$proto" = "ip" ] ;then
+		ip netns exec "$ns1" ping -W 2 -c 1 -q 10.0.2.99 > /dev/null
 		lret=$?
-	elif [ $proto = "ip6" ]; then
-		ip netns exec ${ns1} ping -W 2 -c 1 -q dead:2::99 > /dev/null
+	elif [ "$proto" = "ip6" ]; then
+		ip netns exec "$ns1" ping -W 2 -c 1 -q dead:2::99 > /dev/null
 		lret=$?
 	else
 		lret=111
 	fi
 
 	# queue without bypass keyword should drop traffic if no listener exists.
-	if [ $lret -eq 0 ];then
+	if [ "$lret" -eq 0 ];then
 		echo "FAIL: $proto expected failure, got $lret" 1>&2
 		exit 1
 	fi
 
-	ip netns exec ${nsrouter} nft delete table $proto blackh
-	if [ $? -ne 0 ] ;then
+	if ! ip netns exec "$nsrouter" nft delete table "$proto" blackh; then
 	        echo "FAIL: $proto: Could not delete blackh table"
 	        exit 1
 	fi
@@ -198,26 +190,41 @@ EOF
         echo "PASS: $proto: statement with no listener results in packet drop"
 }
 
+nf_queue_wait()
+{
+	local procfile="/proc/self/net/netfilter/nfnetlink_queue"
+	local netns id
+
+	netns="$1"
+	id="$2"
+
+	# if this file doesn't exist, nfnetlink_module isn't loaded.
+	# rather than loading it ourselves, wait for kernel module autoload
+	# completion, nfnetlink should do so automatically because nf_queue
+	# helper program, spawned in the background, asked for this functionality.
+	test -f "$procfile" &&
+		ip netns exec "$netns" cat "$procfile" | grep -q "^ *$id "
+}
+
 test_queue()
 {
-	local expected=$1
+	local expected="$1"
 	local last=""
 
 	# spawn nf_queue listeners
-	ip netns exec ${nsrouter} ./nf_queue -c -q 0 -t $timeout > "$TMPFILE0" &
-	ip netns exec ${nsrouter} ./nf_queue -c -q 1 -t $timeout > "$TMPFILE1" &
-	sleep 1
-	test_ping
-	ret=$?
-	if [ $ret -ne 0 ];then
-		echo "FAIL: netns routing/connectivity with active listener on queue $queue: $ret" 1>&2
+	ip netns exec "$nsrouter" ./nf_queue -c -q 0 -t $timeout > "$TMPFILE0" &
+	ip netns exec "$nsrouter" ./nf_queue -c -q 1 -t $timeout > "$TMPFILE1" &
+
+	busywait "$BUSYWAIT_TIMEOUT" nf_queue_wait "$nsrouter" 0
+	busywait "$BUSYWAIT_TIMEOUT" nf_queue_wait "$nsrouter" 1
+
+	if ! test_ping;then
+		echo "FAIL: netns routing/connectivity with active listener on queues 0 and 1: $ret" 1>&2
 		exit $ret
 	fi
 
-	test_ping_router
-	ret=$?
-	if [ $ret -ne 0 ];then
-		echo "FAIL: netns router unreachable listener on queue $queue: $ret" 1>&2
+	if ! test_ping_router;then
+		echo "FAIL: netns router unreachable listener on queue 0 and 1: $ret" 1>&2
 		exit $ret
 	fi
 
@@ -228,9 +235,7 @@ test_queue()
 		last=$(tail -n1 "$file")
 		if [ x"$last" != x"$expected packets total" ]; then
 			echo "FAIL: Expected $expected packets total, but got $last" 1>&2
-			cat "$file" 1>&2
-
-			ip netns exec ${nsrouter} nft list ruleset
+			ip netns exec "$nsrouter" nft list ruleset
 			exit 1
 		fi
 	done
@@ -245,56 +250,50 @@ listener_ready()
 
 test_tcp_forward()
 {
-	ip netns exec ${nsrouter} ./nf_queue -q 2 -t $timeout &
+	ip netns exec "$nsrouter" ./nf_queue -q 2 -t "$timeout" &
 	local nfqpid=$!
 
-	timeout 5 ip netns exec ${ns2} socat -u TCP-LISTEN:12345 STDOUT >/dev/null &
+	timeout 5 ip netns exec "$ns2" socat -u TCP-LISTEN:12345 STDOUT >/dev/null &
 	local rpid=$!
 
-	busywait $BUSYWAIT_TIMEOUT listener_ready ${ns2}
-
-	ip netns exec ${ns1} socat -u STDIN TCP:10.0.2.99:12345 <"$TMPINPUT" >/dev/null
+	busywait "$BUSYWAIT_TIMEOUT" listener_ready "$ns2"
 
-	wait $rpid
+	ip netns exec "$ns1" socat -u STDIN TCP:10.0.2.99:12345 <"$TMPINPUT" >/dev/null
 
-	[ $? -eq 0 ] && echo "PASS: tcp and nfqueue in forward chain"
+	wait "$rpid" && echo "PASS: tcp and nfqueue in forward chain"
 }
 
 test_tcp_localhost()
 {
-	dd conv=sparse status=none if=/dev/zero bs=1M count=200 of=$TMPINPUT
-	timeout 5 ip netns exec ${nsrouter} socat -u TCP-LISTEN:12345 STDOUT >/dev/null &
+	dd conv=sparse status=none if=/dev/zero bs=1M count=200 of="$TMPINPUT"
+	timeout 5 ip netns exec "$nsrouter" socat -u TCP-LISTEN:12345 STDOUT >/dev/null &
 	local rpid=$!
 
-	ip netns exec ${nsrouter} ./nf_queue -q 3 -t $timeout &
+	ip netns exec "$nsrouter" ./nf_queue -q 3 -t "$timeout" &
 	local nfqpid=$!
 
-	busywait $BUSYWAIT_TIMEOUT listener_ready ${nsrouter}
+	busywait "$BUSYWAIT_TIMEOUT" listener_ready "$nsrouter"
 
-	ip netns exec ${nsrouter} socat -u STDIN TCP:127.0.0.1:12345 <"$TMPINPUT" >/dev/null
+	ip netns exec "$nsrouter" socat -u STDIN TCP:127.0.0.1:12345 <"$TMPINPUT" >/dev/null
 
-	wait $rpid
-	[ $? -eq 0 ] && echo "PASS: tcp via loopback"
+	wait "$rpid" && echo "PASS: tcp via loopback"
 	wait 2>/dev/null
 }
 
 test_tcp_localhost_connectclose()
 {
-	ip netns exec ${nsrouter} ./connect_close -p 23456 -t $timeout &
+	ip netns exec "$nsrouter" ./connect_close -p 23456 -t "$timeout" &
+	ip netns exec "$nsrouter" ./nf_queue -q 3 -t "$timeout" &
 
-	ip netns exec ${nsrouter} ./nf_queue -q 3 -t $timeout &
-	local nfqpid=$!
-
-	sleep 1
+	busywait "$BUSYWAIT_TIMEOUT" nf_queue_wait "$nsrouter" 3
 
-	wait $rpid
-	[ $? -eq 0 ] && echo "PASS: tcp via loopback with connect/close"
+	wait && echo "PASS: tcp via loopback with connect/close"
 	wait 2>/dev/null
 }
 
 test_tcp_localhost_requeue()
 {
-ip netns exec ${nsrouter} nft -f /dev/stdin <<EOF
+ip netns exec "$nsrouter" nft -f /dev/stdin <<EOF
 flush ruleset
 table inet filter {
 	chain output {
@@ -307,17 +306,17 @@ table inet filter {
 	}
 }
 EOF
-	timeout 5 ip netns exec ${nsrouter} socat -u TCP-LISTEN:12345 STDOUT >/dev/null &
+	timeout 5 ip netns exec "$nsrouter" socat -u TCP-LISTEN:12345 STDOUT >/dev/null &
 	local rpid=$!
 
-	ip netns exec ${nsrouter} ./nf_queue -c -q 1 -t $timeout > "$TMPFILE2" &
+	ip netns exec "$nsrouter" ./nf_queue -c -q 1 -t "$timeout" > "$TMPFILE2" &
 
 	# nfqueue 1 will be called via output hook.  But this time,
         # re-queue the packet to nfqueue program on queue 2.
-	ip netns exec ${nsrouter} ./nf_queue -G -d 150 -c -q 0 -Q 1 -t $timeout > "$TMPFILE3" &
+	ip netns exec "$nsrouter" ./nf_queue -G -d 150 -c -q 0 -Q 1 -t "$timeout" > "$TMPFILE3" &
 
-	busywait $BUSYWAIT_TIMEOUT listener_ready ${nsrouter}
-	ip netns exec ${nsrouter} socat -u STDIN TCP:127.0.0.1:12345 <"$TMPINPUT" > /dev/null
+	busywait "$BUSYWAIT_TIMEOUT" listener_ready "$nsrouter"
+	ip netns exec "$nsrouter" socat -u STDIN TCP:127.0.0.1:12345 <"$TMPINPUT" > /dev/null
 
 	wait
 
@@ -330,17 +329,16 @@ EOF
 }
 
 test_icmp_vrf() {
-	ip -net $ns1 link add tvrf type vrf table 9876
-	if [ $? -ne 0 ];then
+	if ! ip -net "$ns1" link add tvrf type vrf table 9876;then
 		echo "SKIP: Could not add vrf device"
 		return
 	fi
 
-	ip -net $ns1 li set eth0 master tvrf
-	ip -net $ns1 li set tvrf up
+	ip -net "$ns1" li set eth0 master tvrf
+	ip -net "$ns1" li set tvrf up
 
-	ip -net $ns1 route add 10.0.2.0/24 via 10.0.1.1 dev eth0 table 9876
-ip netns exec ${ns1} nft -f /dev/stdin <<EOF
+	ip -net "$ns1" route add 10.0.2.0/24 via 10.0.1.1 dev eth0 table 9876
+ip netns exec "$ns1" nft -f /dev/stdin <<EOF
 flush ruleset
 table inet filter {
 	chain output {
@@ -355,38 +353,35 @@ table inet filter {
 	}
 }
 EOF
-	ip netns exec ${ns1} ./nf_queue -q 1 -t $timeout &
+	ip netns exec "$ns1" ./nf_queue -q 1 -t "$timeout" &
 	local nfqpid=$!
 
-	sleep 1
-	ip netns exec ${ns1} ip vrf exec tvrf ping -c 1 10.0.2.99 > /dev/null
+	busywait "$BUSYWAIT_TIMEOUT" nf_queue_wait "$ns1" 1
+
+	ip netns exec "$ns1" ip vrf exec tvrf ping -c 1 10.0.2.99 > /dev/null
 
 	for n in output post; do
 		for d in tvrf eth0; do
-			ip netns exec ${ns1} nft list chain inet filter $n | grep -q "oifname \"$d\" icmp type echo-request counter packets 1"
-			if [ $? -ne 0 ] ; then
+			if ! ip netns exec "$ns1" nft list chain inet filter "$n" | grep -q "oifname \"$d\" icmp type echo-request counter packets 1"; then
 				echo "FAIL: chain $n: icmp packet counter mismatch for device $d" 1>&2
-				ip netns exec ${ns1} nft list ruleset
+				ip netns exec "$ns1" nft list ruleset
 				ret=1
 				return
 			fi
 		done
 	done
 
-	wait $nfqpid
-	[ $? -eq 0 ] && echo "PASS: icmp+nfqueue via vrf"
+	wait "$nfqpid" && echo "PASS: icmp+nfqueue via vrf"
 	wait 2>/dev/null
 }
 
-ip netns exec ${nsrouter} sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
-ip netns exec ${nsrouter} sysctl net.ipv4.conf.veth0.forwarding=1 > /dev/null
-ip netns exec ${nsrouter} sysctl net.ipv4.conf.veth1.forwarding=1 > /dev/null
+ip netns exec "$nsrouter" sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
+ip netns exec "$nsrouter" sysctl net.ipv4.conf.veth0.forwarding=1 > /dev/null
+ip netns exec "$nsrouter" sysctl net.ipv4.conf.veth1.forwarding=1 > /dev/null
 
 load_ruleset "filter" 0
 
-test_ping
-ret=$?
-if [ $ret -eq 0 ];then
+if test_ping; then
 	# queue bypass works (rules were skipped, no listener)
 	echo "PASS: ${ns1} can reach ${ns2}"
 else
-- 
2.43.2


