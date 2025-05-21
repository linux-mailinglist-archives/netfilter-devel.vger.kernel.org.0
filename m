Return-Path: <netfilter-devel+bounces-7194-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3846BABF02F
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 May 2025 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D6C188F596
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 May 2025 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435C25393D;
	Wed, 21 May 2025 09:40:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B21A3BD7
	for <netfilter-devel@vger.kernel.org>; Wed, 21 May 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820429; cv=none; b=dH+9yb745TxWjBx58bkRVZDKvmHk+nt2O8vmirMQUpdfyt7cCQl4NoArfQVogkApMgajmQu+eAwIMIy6HPJHAQALdVaQQUXLQSO65NMndHqmIEP/gzeGLZosrkD3l2ujMXdQlmckcKFoPaiK28AXxUj1YyCvpK2yBLSscBgAbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820429; c=relaxed/simple;
	bh=K4OMoLW6unvCA3DcKFDOq6LCMggVXQkRHPLO0ZgWfvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCER5baqUZJQywQukAj5W1pTfV2VqWdSKGtwM6BYap9cWTVjGbYvc3fZGXfU8rQ3QNJzQX7YEGRZ5Zy7USacLkyHf7oOVqjFqY/iy4IY8GBt8VsjMNNKXtijH5EyFpN2y9E9Yd+BG9LX5jxyxgwfGPmX1FaqxY1oTy+Zs2guK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 96AAB60140; Wed, 21 May 2025 11:40:25 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 5/5] selftests: netfilter: nft_fib.sh: add type and oif tests with and without VRFs
Date: Wed, 21 May 2025 11:38:49 +0200
Message-ID: <20250521093858.1831-6-fw@strlen.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521093858.1831-1-fw@strlen.de>
References: <20250521093858.1831-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the existing VRF test with a more comprehensive one.

It tests following combinations:
 - fib type (returns address type, e.g. unicast)
 - fib oif (route output interface index
 - both with and without 'iif' keyword (changes result, e.g.
  'fib daddr type local' will be true when the destination address
  is configured on the local machine, but
  'fib daddr . iif type local' will only be true when the destination
  address is configured on the incoming interface.

Add all types of addresses to test with for both ipv4 and ipv6:
- local address on the incoming interface
- local address on another interface
- local address on another interface thats part of a vrf
- address on another host

The ruleset stores obtained results from 'fib' in nftables sets and
then queries the sets to check that it has the expected results.

Perform one pass while packets are coming in on interface NOT part of
a VRF and then again when it was added and make sure fib returns the
expected routes and address types for the various addresses in the
setup.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/net/netfilter/nft_fib.sh        | 392 ++++++++++++++++--
 1 file changed, 365 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_fib.sh b/tools/testing/selftests/net/netfilter/nft_fib.sh
index f636ad781033..9929a9ffef65 100755
--- a/tools/testing/selftests/net/netfilter/nft_fib.sh
+++ b/tools/testing/selftests/net/netfilter/nft_fib.sh
@@ -324,12 +324,338 @@ test_fib_vrf_dev_add_dummy()
 		return 1
 	fi
 
-	ip -net "$nsrouter" link set veth0 master tvrf
 	ip -net "$nsrouter" link set dummy0 master tvrf
 	ip -net "$nsrouter" link set dummy0 up
 	ip -net "$nsrouter" link set tvrf up
 }
 
+load_ruleset_vrf()
+{
+# Due to the many different possible combinations using named counters
+# or one-rule-per-expected-result is complex.
+#
+# Instead, add dynamic sets for the fib modes
+# (fib address type, fib output interface lookup .. ),
+# and then add the obtained fib results to them.
+#
+# The test is successful if the sets contain the expected results
+# and no unexpected extra entries existed.
+ip netns exec "$nsrouter" nft -f - <<EOF
+flush ruleset
+table inet t {
+	set fibif4 {
+		typeof meta iif . ip daddr . fib daddr oif
+		flags dynamic
+		counter
+	}
+
+	set fibif4iif {
+		typeof meta iif . ip daddr . fib daddr . iif oif
+		flags dynamic
+		counter
+	}
+
+	set fibif6 {
+		typeof meta iif . ip6 daddr . fib daddr oif
+		flags dynamic
+		counter
+	}
+
+	set fibif6iif {
+		typeof meta iif . ip6 daddr . fib daddr . iif oif
+		flags dynamic
+		counter
+	}
+
+	set fibtype4 {
+		typeof meta iif . ip daddr . fib daddr type
+		flags dynamic
+		counter
+	}
+
+	set fibtype4iif {
+		typeof meta iif . ip daddr . fib daddr . iif type
+		flags dynamic
+		counter
+	}
+
+	set fibtype6 {
+		typeof meta iif . ip6 daddr . fib daddr type
+		flags dynamic
+		counter
+	}
+
+	set fibtype6iif {
+		typeof meta iif . ip6 daddr . fib daddr . iif type
+		flags dynamic
+		counter
+	}
+
+	chain fib_test {
+		meta nfproto ipv4 jump {
+			add @fibif4 { meta iif . ip daddr . fib daddr oif }
+			add @fibif4iif { meta iif . ip daddr . fib daddr . iif oif }
+			add @fibtype4 { meta iif . ip daddr . fib daddr type }
+			add @fibtype4iif { meta iif . ip daddr . fib daddr . iif type }
+
+			add @fibif4 { meta iif . ip saddr . fib saddr oif }
+			add @fibif4iif { meta iif . ip saddr . fib saddr . iif oif }
+		}
+
+		meta nfproto ipv6 jump {
+			add @fibif6    { meta iif . ip6 daddr . fib daddr oif }
+			add @fibif6iif { meta iif . ip6 daddr . fib daddr . iif oif }
+			add @fibtype6    { meta iif . ip6 daddr . fib daddr type }
+			add @fibtype6iif { meta iif . ip6 daddr . fib daddr . iif type }
+
+			add @fibif6 { meta iif . ip6 saddr . fib saddr oif }
+			add @fibif6iif { meta iif . ip6 saddr . fib saddr . iif oif }
+		}
+	}
+
+	chain prerouting {
+		type filter hook prerouting priority 0;
+		icmp type echo-request counter jump fib_test
+
+		# neighbour discovery to be ignored.
+		icmpv6 type echo-request counter jump fib_test
+	}
+}
+EOF
+
+if [ $? -ne 0 ] ;then
+	echo "SKIP: Could not load ruleset for fib vrf test"
+	[ $ret -eq 0 ] && ret=$ksft_skip
+	return 1
+fi
+}
+
+check_type()
+{
+	local setname="$1"
+	local iifname="$2"
+	local addr="$3"
+	local type="$4"
+	local count="$5"
+
+	[ -z "$count" ] && count=1
+
+	if ! ip netns exec "$nsrouter" nft get element inet t "$setname" { "$iifname" . "$addr" . "$type" } |grep -q "counter packets $count";then
+		echo "FAIL: did not find $iifname . $addr . $type in $setname"
+		ip netns exec "$nsrouter" nft list set inet t "$setname"
+		ret=1
+		return 1
+	fi
+
+	# delete the entry, this allows to check if anything unexpected appeared
+	# at the end of the test run: all dynamic sets should be empty by then.
+	if ! ip netns exec "$nsrouter" nft delete element inet t "$setname" { "$iifname" . "$addr" . "$type" } ; then
+		echo "FAIL: can't delete $iifname . $addr . $type in $setname"
+		ip netns exec "$nsrouter" nft list set inet t "$setname"
+		ret=1
+		return 1
+	fi
+
+	return 0
+}
+
+check_local()
+{
+	check_type $@ "local" 1
+}
+
+check_unicast()
+{
+	check_type $@ "unicast" 1
+}
+
+check_rpf()
+{
+	check_type $@
+}
+
+check_fib_vrf_sets_empty()
+{
+	local setname=""
+	local lret=0
+
+	# A non-empty set means that we have seen unexpected packets OR
+	# that a fib lookup provided unexpected results.
+	for setname in "fibif4" "fibif4iif" "fibif6" "fibif6iif" \
+		       "fibtype4" "fibtype4iif" "fibtype6" "fibtype6iif";do
+		if ip netns exec "$nsrouter" nft list set inet t "$setname" | grep -q elements;then
+			echo "FAIL: $setname not empty"
+	                ip netns exec "$nsrouter" nft list set inet t "$setname"
+			ret=1
+			lret=1
+		fi
+	done
+
+	return $lret
+}
+
+check_fib_vrf_type()
+{
+	local msg="$1"
+
+	local addr
+	# the incoming interface is always veth0.  As its not linked to a VRF,
+	# the 'tvrf' device should NOT show up anywhere.
+	local ifname="veth0"
+	local lret=0
+
+	# local_veth0, local_veth1
+	for addr in "10.0.1.1" "10.0.2.1"; do
+		check_local fibtype4  "$ifname" "$addr" || lret=1
+		check_type  fibif4    "$ifname" "$addr" "0" || lret=1
+	done
+	for addr in "dead:1::1" "dead:2::1";do
+		check_local fibtype6  "$ifname" "$addr" || lret=1
+		check_type  fibif6    "$ifname" "$addr" "0" || lret=1
+	done
+
+	# when restricted to the incoming interface, 10.0.1.1 should
+	# be 'local', but 10.0.2.1 unicast.
+	check_local fibtype4iif   "$ifname" "10.0.1.1" || lret=1
+	check_unicast fibtype4iif "$ifname" "10.0.2.1" || lret=1
+
+	# same for the ipv6 addresses.
+	check_local fibtype6iif   "$ifname" "dead:1::1" || lret=1
+	check_unicast fibtype6iif "$ifname" "dead:2::1" || lret=1
+
+	# None of these addresses should find a valid route when restricting
+	# to the incoming interface (we ask for daddr - 10.0.1.1/2.1 are
+	# reachable via 'lo'.
+	for addr in "10.0.1.1" "10.0.2.1" "10.9.9.1" "10.9.9.2";do
+		check_type fibif4iif "$ifname" "$addr" "0" || lret=1
+	done
+
+	# expect default route (veth1), dummy0 is part of VRF but iif isn't.
+	for addr in "10.9.9.1" "10.9.9.2";do
+		check_unicast fibtype4    "$ifname" "$addr" || lret=1
+		check_unicast fibtype4iif "$ifname" "$addr" || lret=1
+		check_type fibif4 "$ifname" "$addr" "veth1" || lret=1
+	done
+	for addr in "dead:9::1" "dead:9::2";do
+		check_unicast fibtype6    "$ifname" "$addr" || lret=1
+		check_unicast fibtype6iif "$ifname" "$addr" || lret=1
+		check_type fibif6 "$ifname" "$addr" "veth1" || lret=1
+	done
+
+	# same for the IPv6 equivalent addresses.
+	for addr in "dead:1::1" "dead:2::1" "dead:9::1" "dead:9::2";do
+		check_type  fibif6iif "$ifname" "$addr" "0" || lret=1
+	done
+
+	check_unicast fibtype4    "$ifname" "10.0.2.99" || lret=1
+	check_unicast fibtype4iif "$ifname" "10.0.2.99" || lret=1
+	check_unicast fibtype6    "$ifname" "dead:2::99" || lret=1
+	check_unicast fibtype6iif "$ifname" "dead:2::99" || lret=1
+
+	check_type fibif4 "$ifname" "10.0.2.99" "veth1" || lret=1
+	check_type fibif4iif "$ifname" "10.0.2.99" 0 || lret=1
+	check_type fibif6 "$ifname" "dead:2::99" "veth1" || lret=1
+	check_type fibif6iif "$ifname" "dead:2::99" 0 || lret=1
+
+	check_rpf  fibif4    "$ifname" "10.0.1.99" "veth0" 5 || lret=1
+	check_rpf  fibif4iif "$ifname" "10.0.1.99" "veth0" 5 || lret=1
+	check_rpf  fibif6    "$ifname" "dead:1::99" "veth0" 5 || lret=1
+	check_rpf  fibif6iif "$ifname" "dead:1::99" "veth0" 5 || lret=1
+
+	check_fib_vrf_sets_empty || lret=1
+
+	if [ $lret -eq 0 ];then
+		echo "PASS: $msg"
+	else
+		echo "FAIL: $msg"
+		ret=1
+	fi
+}
+
+check_fib_veth_vrf_type()
+{
+	local msg="$1"
+
+	local addr
+	local ifname
+	local setname
+	local lret=0
+
+	# as veth0 is now part of tvrf interface, packets will be seen
+	# twice, once with iif veth0, then with iif tvrf.
+
+	for ifname in "veth0" "tvrf"; do
+		for addr in "10.0.1.1" "10.9.9.1"; do
+			check_local fibtype4  "$ifname" "$addr" || lret=1
+			# addr local, but nft_fib doesn't return routes with RTN_LOCAL.
+			check_type  fibif4    "$ifname" "$addr" 0 || lret=1
+			check_type  fibif4iif "$ifname" "$addr" 0 || lret=1
+		done
+
+		for addr in "dead:1::1" "dead:9::1"; do
+			check_local fibtype6 "$ifname" "$addr" || lret=1
+			# same, address is local but no route is returned for lo.
+			check_type  fibif6    "$ifname" "$addr" 0 || lret=1
+			check_type  fibif6iif "$ifname" "$addr" 0 || lret=1
+		done
+
+		for t in fibtype4 fibtype4iif; do
+			check_unicast "$t" "$ifname" 10.9.9.2 || lret=1
+		done
+		for t in fibtype6 fibtype6iif; do
+			check_unicast "$t" "$ifname" dead:9::2 || lret=1
+		done
+
+		check_unicast fibtype4iif "$ifname" "10.9.9.1" || lret=1
+		check_unicast fibtype6iif "$ifname" "dead:9::1" || lret=1
+
+		check_unicast fibtype4    "$ifname" "10.0.2.99" || lret=1
+		check_unicast fibtype4iif "$ifname" "10.0.2.99" || lret=1
+
+		check_unicast fibtype6    "$ifname" "dead:2::99" || lret=1
+		check_unicast fibtype6iif "$ifname" "dead:2::99" || lret=1
+
+		check_type fibif4    "$ifname"  "10.0.2.99" "veth1" || lret=1
+		check_type fibif6    "$ifname" "dead:2::99" "veth1" || lret=1
+		check_type fibif4    "$ifname"   "10.9.9.2" "dummy0" || lret=1
+		check_type fibif6    "$ifname"  "dead:9::2" "dummy0" || lret=1
+
+		# restricted to iif -- MUST NOT provide result, its != $ifname.
+		check_type fibif4iif "$ifname"  "10.0.2.99" 0 || lret=1
+		check_type fibif6iif "$ifname" "dead:2::99" 0 || lret=1
+
+		check_rpf  fibif4 "$ifname" "10.0.1.99" "veth0" 4 || lret=1
+		check_rpf  fibif6 "$ifname" "dead:1::99" "veth0" 4 || lret=1
+		check_rpf  fibif4iif "$ifname" "10.0.1.99" "$ifname" 4 || lret=1
+		check_rpf  fibif6iif "$ifname" "dead:1::99" "$ifname" 4 || lret=1
+	done
+
+	check_local fibtype4iif "veth0" "10.0.1.1" || lret=1
+	check_local fibtype6iif "veth0" "dead:1::1" || lret=1
+
+	check_unicast fibtype4iif "tvrf" "10.0.1.1" || lret=1
+	check_unicast fibtype6iif "tvrf" "dead:1::1" || lret=1
+
+	# 10.9.9.2 should not provide a result for iif veth, but
+	# should when iif is tvrf.
+	# This is because its reachable via dummy0 which is part of
+	# tvrf.  iif veth0 MUST conceal the dummy0 result (i.e. return oif 0).
+	check_type fibif4iif "veth0" "10.9.9.2" 0 || lret=1
+	check_type fibif6iif "veth0"  "dead:9::2" 0 || lret=1
+
+	check_type fibif4iif "tvrf" "10.9.9.2" "tvrf" || lret=1
+	check_type fibif6iif "tvrf" "dead:9::2" "tvrf" || lret=1
+
+	check_fib_vrf_sets_empty || lret=1
+
+	if [ $lret -eq 0 ];then
+		echo "PASS: $msg"
+	else
+		echo "FAIL: $msg"
+		ret=1
+	fi
+}
+
 # Extends nsrouter config by adding dummy0+vrf.
 #
 #  10.0.1.99     10.0.1.1           10.0.2.1         10.0.2.99
@@ -341,8 +667,6 @@ test_fib_vrf_dev_add_dummy()
 #                          [tvrf]
 test_fib_vrf()
 {
-	local dummynet="10.9.9"
-	local dummynet6="dead:9"
 	local cntname=""
 
 	if ! test_fib_vrf_dev_add_dummy; then
@@ -350,37 +674,51 @@ test_fib_vrf()
 		return
 	fi
 
-	ip -net "$nsrouter" addr add "$dummynet.1"/24 dev dummy0
-	ip -net "$nsrouter" addr add "${dummynet6}::1"/64 dev dummy0 nodad
+	ip -net "$nsrouter" addr add "10.9.9.1"/24 dev dummy0
+	ip -net "$nsrouter" addr add "dead:9::1"/64 dev dummy0 nodad
 
+	ip -net "$nsrouter" route add default via 10.0.2.99
+	ip -net "$nsrouter" route add default via dead:2::99
 
-ip netns exec "$nsrouter" nft -f - <<EOF
-flush ruleset
-table inet t {
-	counter fibcount4 { }
-	counter fibcount6 { }
+	load_ruleset_vrf || return
 
-	chain prerouting {
-		type filter hook prerouting priority 0;
-		meta iifname veth0 ip daddr ${dummynet}.2 fib daddr oif dummy0 counter name fibcount4
-		meta iifname veth0 ip6 daddr ${dummynet6}::2 fib daddr oif dummy0 counter name fibcount6
-	}
-}
-EOF
 	# no echo reply for these addresses: The dummy interface is part of tvrf,
-	test_ping_unreachable "$dummynet.2" "${dummynet6}::2" &
+	# but veth0 (incoming interface) isn't linked to it.
+	test_ping_unreachable "10.9.9.1" "dead:9::1" &
+	test_ping_unreachable "10.9.9.2" "dead:9::2" &
+
+	# expect replies from these.
+	test_ping "10.0.1.1" "dead:1::1"
+	test_ping "10.0.2.1" "dead:2::1"
+	test_ping "10.0.2.99" "dead:2::99"
 
 	wait
 
-	for cntname in fibcount4 fibcount6;do
-		if ip netns exec "$nsrouter" nft list counter inet t "$cntname" | grep -q "packets 1"; then
-			echo "PASS: vrf fib lookup did return expected output interface for $cntname"
-		else
-			ip netns exec "$nsrouter" nft list counter inet t "$cntname"
-			echo "FAIL: vrf fib lookup did not return expected output interface for $cntname"
-			ret=1
-		fi
-	done
+	check_fib_vrf_type "fib expression address types match (iif not in vrf)"
+
+	# second round: this time, make veth0 (rx interface) part of the vrf.
+	# 10.9.9.1 / dead:9::1 become reachable from ns1, while ns2
+	# becomes unreachable.
+	ip -net "$nsrouter" link set veth0 master tvrf
+	ip -net "$nsrouter" addr add dead:1::1/64 dev veth0 nodad
+
+	# this reload should not be needed, but in case
+	# there is some error (missing or unexpected entry) this will prevent them
+	# from leaking into round 2.
+	load_ruleset_vrf || return
+
+	test_ping "10.0.1.1" "dead:1::1"
+	test_ping "10.9.9.1" "dead:9::1"
+
+	# ns2 should no longer be reachable (veth1 not in vrf)
+	test_ping_unreachable "10.0.2.99" "dead:2::99" &
+
+	# vrf via dummy0, but host doesn't exist
+	test_ping_unreachable "10.9.9.2" "dead:9::2" &
+
+	wait
+
+	check_fib_veth_vrf_type "fib expression address types match (iif in vrf)"
 }
 
 ip netns exec "$nsrouter" sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
-- 
2.49.0


