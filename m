Return-Path: <netfilter-devel+bounces-8993-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21786BB3FB0
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Oct 2025 15:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFD43B1C2D
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Oct 2025 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C2229ACC5;
	Thu,  2 Oct 2025 13:06:02 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DB1E480
	for <netfilter-devel@vger.kernel.org>; Thu,  2 Oct 2025 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410362; cv=none; b=NRcztOzQPo+hq581ktddOQs8/WEDAVfIFFlRLyJiWh43VUZDmjyco8Uqhug8/C0gxF2z5nSiWeUp2GCx+JrKVsruEtsBPgZ9i1wyfvrY0nzdPMHmsy35chZIdvEPkJAYJoQDAYXOchAzd1TtDqSrXxvsV2KVgOw9/RDa1aJQaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410362; c=relaxed/simple;
	bh=rOEywkGqBmmda5vLm15GNSSMBVR40NZguW0344s98qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGhqA1niSlVXa5RvLGGWvC8fvLXW6U+WdvP8HjtZquXN9rbDa72mBbXGltYlfLBYhYZn3vH+Y1Lcn7HGj7/cOmBVRnsJgbmpBqbk6EutNhErgosQ5qK23DF8NSh41yadU+ozf+BSyPsqQTv3zkzDTWlcTXRHOtDevVLQK2qcsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A604B60298; Thu,  2 Oct 2025 15:05:58 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH nf] selftests: netfilter: query conntrack state to check for port clash resolution
Date: Thu,  2 Oct 2025 15:05:41 +0200
Message-ID: <20251002130545.22956-1-fw@strlen.de>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub reported this self test flaking occasionally (fails, but passes on
re-run) on debug kernels.

This is because the test checks for elapsed time to determine if both
connections were established in parallel.

Rework this to no longer depend on timing.
Use busywait helper to check that both sockets have moved to established
state and then query the conntrack engine for the two entries.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netfilter-devel/20250926163318.40d1a502@kernel.org/
Fixes: 117e149e26d1 ("selftests: netfilter: test nat source port clash resolution interaction with tcp early demux")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/net/netfilter/nf_nat_edemux.sh  | 58 +++++++++++++------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nf_nat_edemux.sh b/tools/testing/selftests/net/netfilter/nf_nat_edemux.sh
index 1014551dd769..6731fe1eaf2e 100755
--- a/tools/testing/selftests/net/netfilter/nf_nat_edemux.sh
+++ b/tools/testing/selftests/net/netfilter/nf_nat_edemux.sh
@@ -17,9 +17,31 @@ cleanup()
 
 checktool "socat -h" "run test without socat"
 checktool "iptables --version" "run test without iptables"
+checktool "conntrack --version" "run test without conntrack"
 
 trap cleanup EXIT
 
+connect_done()
+{
+	local ns="$1"
+	local port="$2"
+
+	ip netns exec "$ns" ss -nt -o state established "dport = :$port" | grep -q "$port"
+}
+
+check_ctstate()
+{
+	local ns="$1"
+	local dp="$2"
+
+	if ! ip netns exec "$ns" conntrack --get -s 192.168.1.2 -d 192.168.1.1 -p tcp \
+	     --sport 10000 --dport "$dp" --state ESTABLISHED > /dev/null 2>&1;then
+		echo "FAIL: Did not find expected state for dport $2"
+		ip netns exec "$ns" bash -c 'conntrack -L; conntrack -S; ss -nt'
+		ret=1
+	fi
+}
+
 setup_ns ns1 ns2
 
 # Connect the namespaces using a veth pair
@@ -44,15 +66,18 @@ socatpid=$!
 ip netns exec "$ns2" sysctl -q net.ipv4.ip_local_port_range="10000 10000"
 
 # add a virtual IP using DNAT
-ip netns exec "$ns2" iptables -t nat -A OUTPUT -d 10.96.0.1/32 -p tcp --dport 443 -j DNAT --to-destination 192.168.1.1:5201
+ip netns exec "$ns2" iptables -t nat -A OUTPUT -d 10.96.0.1/32 -p tcp --dport 443 -j DNAT --to-destination 192.168.1.1:5201 || exit 1
 
 # ... and route it to the other namespace
 ip netns exec "$ns2" ip route add 10.96.0.1 via 192.168.1.1
 
-# add a persistent connection from the other namespace
-ip netns exec "$ns2" socat -t 10 - TCP:192.168.1.1:5201 > /dev/null &
+# listener should be up by now, wait if it isn't yet.
+wait_local_port_listen "$ns1" 5201 tcp
 
-sleep 1
+# add a persistent connection from the other namespace
+sleep 10 | ip netns exec "$ns2" socat -t 10 - TCP:192.168.1.1:5201 > /dev/null &
+cpid0=$!
+busywait "$BUSYWAIT_TIMEOUT" connect_done "$ns2" "5201"
 
 # ip daddr:dport will be rewritten to 192.168.1.1 5201
 # NAT must reallocate source port 10000 because
@@ -71,26 +96,25 @@ fi
 ip netns exec "$ns1" iptables -t nat -A PREROUTING -p tcp --dport 5202 -j REDIRECT --to-ports 5201
 ip netns exec "$ns1" iptables -t nat -A PREROUTING -p tcp --dport 5203 -j REDIRECT --to-ports 5201
 
-sleep 5 | ip netns exec "$ns2" socat -t 5 -u STDIN TCP:192.168.1.1:5202,connect-timeout=5 >/dev/null &
+sleep 5 | ip netns exec "$ns2" socat -T 5 -u STDIN TCP:192.168.1.1:5202,connect-timeout=5 >/dev/null &
+cpid1=$!
 
-# if connect succeeds, client closes instantly due to EOF on stdin.
-# if connect hangs, it will time out after 5s.
-echo | ip netns exec "$ns2" socat -t 3 -u STDIN TCP:192.168.1.1:5203,connect-timeout=5 >/dev/null &
+sleep 5 | ip netns exec "$ns2" socat -T 5 -u STDIN TCP:192.168.1.1:5203,connect-timeout=5 >/dev/null &
 cpid2=$!
 
-time_then=$(date +%s)
-wait $cpid2
-rv=$?
-time_now=$(date +%s)
+busywait "$BUSYWAIT_TIMEOUT" connect_done "$ns2" 5202
+busywait "$BUSYWAIT_TIMEOUT" connect_done "$ns2" 5203
 
-# Check how much time has elapsed, expectation is for
-# 'cpid2' to connect and then exit (and no connect delay).
-delta=$((time_now - time_then))
+check_ctstate "$ns1" 5202
+check_ctstate "$ns1" 5203
 
-if [ $delta -lt 2 ] && [ $rv -eq 0 ]; then
+kill $socatpid $cpid0 $cpid1 $cpid2
+socatpid=0
+
+if [ $ret -eq 0 ]; then
 	echo "PASS: could connect to service via redirected ports"
 else
-	echo "FAIL: socat cannot connect to service via redirect ($delta seconds elapsed, returned $rv)"
+	echo "FAIL: socat cannot connect to service via redirect"
 	ret=1
 fi
 
-- 
2.49.1


