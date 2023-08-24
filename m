Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E07878736E
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Aug 2023 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjHXPDl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Aug 2023 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242067AbjHXPDU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:03:20 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B291BDA
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Aug 2023 08:02:58 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qZBrL-0008Sm-VC; Thu, 24 Aug 2023 17:02:55 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tests: 30s-stress: add failslab and abort phase tests
Date:   Thu, 24 Aug 2023 17:02:44 +0200
Message-ID: <20230824150249.26812-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo suggested to also cover abort phase by intentionally deleting
non-existent or adding clashing keys.

While at it:
add rules with anon sets and jumps to anonymous chains and a few
constant sets.

Pick different key sizes so there is a higher chance kernel picks
different backend storages such as bitmap or hash_fast.

add failslab support, this also covers unlikely or "impossible" cases like
failing GFP_KERNEL allocations.

randomly spawn 'nft monitor' in the background for a random duration
to cover notification path.

Try to randomly delete a set or chain from control plane.

Randomly set a table as dormant (and back to normal).

Allow to pass the test runtime as argument, so one can now do

./30s-stress 3600

to have the test run for one hour.

For such long test durations, make sure the ruleset
gets regenerated periodically.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Seems I forgit to submit this for inclusion, sorry for the delay.

 tests/shell/testcases/transactions/30s-stress | 390 +++++++++++++++++-
 1 file changed, 375 insertions(+), 15 deletions(-)

diff --git a/tests/shell/testcases/transactions/30s-stress b/tests/shell/testcases/transactions/30s-stress
index 3539a3078b13..4d3317e22b0c 100755
--- a/tests/shell/testcases/transactions/30s-stress
+++ b/tests/shell/testcases/transactions/30s-stress
@@ -1,12 +1,66 @@
 #!/bin/bash
 
+runtime=30
+
+# allow stand-alone execution as well, e.g. '$0 3600'
+if [ x"$1" != "x" ] ;then
+	if [ $1 -ge 0 ]; then
+		runtime="$1"
+	else
+		echo "Invalid runtime $1"
+		exit 1
+	fi
+fi
+
+if [ x = x"$NFT" ] ; then
+	NFT=nft
+fi
+
 testns=testns-$(mktemp -u "XXXXXXXX")
 tmp=""
 
-tables="foo bar baz"
-runtime=10
+faultname="/proc/self/make-it-fail"
+tables="foo bar"
+
+failslab_defaults() {
+	test -w $faultname || return
+
+	# Disable fault injection unless process has 'make-it-fail' set
+	echo Y > /sys/kernel/debug/failslab/task-filter
+
+	# allow all slabs to fail (if process is tagged).
+	find /sys/kernel/slab/ -wholename '*/kmalloc-[0-9]*/failslab' -type f -exec sh -c 'echo 1 > {}' \;
+
+	# no limit on the number of failures
+	echo -1 > /sys/kernel/debug/failslab/times
+
+	# Set to 2 for full dmesg traces for each injected error
+	echo 0 > /sys/kernel/debug/failslab/verbose
+}
+
+failslab_random()
+{
+	r=$((RANDOM%2))
+
+	if [ $r -eq 0 ]; then
+		echo Y > /sys/kernel/debug/failslab/ignore-gfp-wait
+	else
+		echo N > /sys/kernel/debug/failslab/ignore-gfp-wait
+	fi
+
+	r=$((RANDOM%5))
+	echo $r > /sys/kernel/debug/failslab/probability
+	r=$((RANDOM%100))
+	echo $r > /sys/kernel/debug/failslab/interval
+
+	# allow a small initial 'success budget'.
+	# failures only appear after this many allocated bytes.
+	r=$((RANDOM%16384))
+	echo $r > /sys/kernel/debug/$FAILTYPE/space
+}
 
 netns_del() {
+	ip netns pids "$testns" | xargs kill 2>/dev/null
 	ip netns del "$testns"
 }
 
@@ -21,12 +75,30 @@ cleanup() {
 	netns_del
 }
 
+nft_with_fault_inject()
+{
+	file="$1"
+
+	if [ -w "$faultname" ]; then
+		failslab_random
+
+		ip netns exec "$testns" bash -c "echo 1 > $faultname ; exec $NFT -f $file"
+	fi
+
+	ip netns exec "$testns" $NFT -f "$file"
+}
+
 trap cleanup EXIT
 tmp=$(mktemp)
 
 random_verdict()
 {
 	max="$1"
+
+	if [ $max -eq 0 ]; then
+		max=1
+	fi
+
 	rnd=$((RANDOM%max))
 
 	if [ $rnd -gt 0 ];then
@@ -43,8 +115,8 @@ random_verdict()
 
 randsleep()
 {
-	local s=$((RANDOM%3))
-	local ms=$((RANDOM%10))
+	local s=$((RANDOM%1))
+	local ms=$((RANDOM%1000))
 	sleep $s.$ms
 }
 
@@ -72,8 +144,79 @@ randdeltable()
 			r=$((RANDOM%10))
 
 			if [ $r -eq 1 ] ;then
-				ip netns exec $testns $NFT delete table $t
+				ip netns exec $testns $NFT delete table inet $t
+				randsleep
+			fi
+		done
+	done
+}
+
+randdelset()
+{
+	while [ -r $tmp ]; do
+		randsleep
+		for t in $tables; do
+			r=$((RANDOM%10))
+			s=$((RANDOM%10))
+
+			case $r in
+			0)
+				setname=set_$s
+				;;
+			1)
+				setname=sett${s}
+				;;
+			2)
+				setname=dmap_${s}
+				;;
+			3)
+				setname=dmapt${s}
+				;;
+			4)
+				setname=vmap_${s}
+				;;
+			5)
+				setname=vmapt${s}
+				;;
+			*)
+				continue
+				;;
+			esac
+
+			if [ $r -eq 1 ] ;then
+				ip netns exec $testns $NFT delete set inet $t $setname
+			fi
+		done
+	done
+}
+
+randdelchain()
+{
+	while [ -r $tmp ]; do
+		for t in $tables; do
+			local c=$((RANDOM%100))
+			randsleep
+			chain=$(printf "chain%03u" "$c")
+
+			local r=$((RANDOM%10))
+			if [ $r -eq 1 ];then
+				# chain can be invalid/unknown.
+				ip netns exec $testns $NFT delete chain inet $t $chain
+			fi
+		done
+	done
+}
+
+randdisable()
+{
+	while [ -r $tmp ]; do
+		for t in $tables; do
+			randsleep
+			local r=$((RANDOM%10))
+			if [ $r -eq 1 ];then
+				ip netns exec $testns $NFT add table inet $t '{flags dormant; }'
 				randsleep
+				ip netns exec $testns $NFT add table inet $t '{ }'
 			fi
 		done
 	done
@@ -89,30 +232,153 @@ randdelns()
 	done
 }
 
+random_element_string=""
+
+# create a random element.  Could cause any of the following:
+# 1. Invalid set/map
+# 2. Element already exists in set/map w. create
+# 3. Element is new but wants to jump to unknown chain
+# 4. Element already exsists in set/map w. add, but verdict (map data) differs
+# 5. Element is created/added/deleted from 'flags constant' set.
+random_elem()
+{
+	tr=$((RANDOM%2))
+	t=0
+
+	for table in $tables; do
+		if [ $t -ne $tr ]; then
+			t=$((t+1))
+			continue
+		fi
+
+		kr=$((RANDOM%2))
+		k=0
+		cnt=0
+		for key in "single" "concat"; do
+			if [ $k -ne $kr ] ;then
+				cnt=$((cnt+2))
+				k=$((k+1))
+				continue
+			fi
+
+			fr=$((RANDOM%2))
+			f=0
+			for flags in "" "interval" ; do
+				cnt=$((cnt+1))
+				if [ $f -ne fkr ] ;then
+					f=$((f+1))
+					continue
+				fi
+
+				want="${key}${flags}"
+
+				e=$((RANDOM%256))
+				case "$want" in
+				"single") element="10.1.1.$e"
+					;;
+				"concat") element="10.1.2.$e . $((RANDOM%65536))"
+					;;
+				"singleinterval") element="10.1.$e.0-10.1.$e.$e"
+					;;
+				"concatinterval") element="10.1.$e.0-10.1.$e.$e . $((RANDOM%65536))"
+					;;
+				*)	echo "bogus key $want"
+					exit 111
+					;;
+				esac
+
+				# This may result in invalid jump, but thats what we want.
+				count=$(($RANDOM%100))
+
+				r=$((RANDOM%7))
+				case "$r" in
+				0)
+					random_element_string=" inet $table set_${cnt} { $element }"
+					;;
+				1)	random_element_string="inet $table sett${cnt} { $element timeout $((RANDOM%60))s }"
+					;;
+				2)	random_element_string="inet $table dmap_${cnt} { $element : $RANDOM }"
+					;;
+				3)	random_element_string="inet $table dmapt${cnt} { $element timeout $((RANDOM%60))s : $RANDOM }"
+					;;
+				4)	random_element_string="inet $table vmap_${cnt} { $element : `random_verdict $count` }"
+					;;
+				5)	random_element_string="inet $table vmapt${cnt} { $element timeout $((RANDOM%60))s : `random_verdict $count` }"
+					;;
+				6)	random_element_string="inet $table setc${cnt} { $element }"
+					;;
+				esac
+
+				return
+			done
+		done
+	done
+}
+
 randload()
 {
 	while [ -r $tmp ]; do
+		random_element_string=""
 		r=$((RANDOM%10))
 
-		if [ $r -eq 1 ] ;then
+		what=""
+		case $r in
+		1)
 			(echo "flush ruleset"; cat "$tmp"
 			 echo "insert rule inet foo INPUT meta nftrace set 1"
 			 echo "insert rule inet foo OUTPUT meta nftrace set 1"
-			) | ip netns exec "$testns" $NFT -f /dev/stdin
+			) | nft_with_fault_inject "/dev/stdin"
+			;;
+		2)	what="add"
+			;;
+		3)	what="create"
+			;;
+		4)	what="delete"
+			;;
+		5)	what="destroy"
+			;;
+		6)	what="get"
+			;;
+		*)
+			randsleep
+			;;
+		esac
+
+		if [ x"$what" = "x" ]; then
+			nft_with_fault_inject "$tmp"
 		else
-			ip netns exec "$testns" $NFT -f "$tmp"
+			# This can trigger abort path, for various reasons:
+			# invalid set name
+			# key mismatches set specification (concat vs. single value)
+			# attempt to delete non-existent key
+			# attempt to create dupliacte key
+			# attempt to add duplicate key with non-matching value (data)
+			# attempt to add new uniqeue key with a jump to an unknown chain
+			random_elem
+			( cat "$tmp"; echo "$what element $random_element_string") | nft_with_fault_inject "/dev/stdin"
 		fi
+	done
+}
 
+randmonitor()
+{
+	while [ -r $tmp ]; do
 		randsleep
+		timeout=$((RANDOM%16))
+		timeout $((timeout+1)) $NFT monitor > /dev/null
 	done
 }
 
 floodping() {
 	cpunum=$(grep -c processor /proc/cpuinfo)
+	cpunum=$((cpunum+1))
 
 	while [ -r $tmp ]; do
+		spawn=$((RANDOM%$cpunum))
+
+		# spawn at most $cpunum processes. Or maybe none at all.
 		i=0
-		while [ $i -lt $cpunum ]; do
+		while [ $i -lt $spawn ]; do
 			mask=$(printf 0x%x $((1<<$i)))
 		        timeout 3 ip netns exec "$testns" taskset $mask ping -4 -fq 127.0.0.1 > /dev/null &
 		        timeout 3 ip netns exec "$testns" taskset $mask ping -6 -fq ::1 > /dev/null &
@@ -126,15 +392,33 @@ floodping() {
 
 stress_all()
 {
+	# if fault injection is enabled, first a quick test to trigger
+	# abort paths without any parallel deletes/flushes.
+	if [ -w $faultname ] ;then
+		for i in $(seq 1 10);do
+			nft_with_fault_inject "$tmp"
+		done
+	fi
+
 	randlist &
 	randflush &
 	randdeltable &
+	randdisable &
+	randdelchain &
+	randdelset &
 	randdelns &
 	randload &
+	randmonitor &
 }
 
+gen_ruleset() {
+echo > "$tmp"
 for table in $tables; do
-	count=$((RANDOM % 200))
+	count=$((RANDOM % 100))
+	if [ $count -lt 1 ];then
+		count=1
+	fi
+
 	echo add table inet "$table" >> "$tmp"
 	echo flush table inet "$table" >> "$tmp"
 
@@ -145,15 +429,61 @@ for table in $tables; do
 		echo "add chain inet $table $chain" >> "$tmp"
 	done
 
+	echo "add chain inet $table defaultchain" >> "$tmp"
+
 	for c in $(seq 1 $count); do
 		chain=$(printf "chain%03u" "$c")
 		for BASE in INPUT OUTPUT; do
 			echo "add rule inet $table $BASE counter jump $chain" >> "$tmp"
 		done
-		echo "add rule inet $table $chain counter return" >> "$tmp"
+		if [ $((RANDOM%10)) -eq 1 ];then
+			echo "add rule inet $table $chain counter jump defaultchain" >> "$tmp"
+		else
+			echo "add rule inet $table $chain counter return" >> "$tmp"
+		fi
 	done
 
 	cnt=0
+
+	# add a few anonymous sets. rhashtable is convered by named sets below.
+	c=$((RANDOM%$count))
+	chain=$(printf "chain%03u" "$((c+1))")
+	echo "insert rule inet $table $chain tcp dport 22-26 ip saddr { 1.2.3.4, 5.6.7.8 } counter comment hash_fast" >> "$tmp"
+	echo "insert rule inet $table $chain ip6 saddr { ::1, dead::beef } counter" comment hash >> "$tmp"
+	echo "insert rule inet $table $chain ip saddr { 1.2.3.4 - 5.6.7.8, 127.0.0.1 } comment rbtree" >> "$tmp"
+	# bitmap 1byte, with anon chain jump
+	echo "insert rule inet $table $chain ip protocol { 6, 17 } jump { jump defaultchain; counter; }" >> "$tmp"
+	# bitmap 2byte
+	echo "insert rule inet $table $chain tcp dport != { 22, 23, 80 } goto defaultchain" >> "$tmp"
+	echo "insert rule inet $table $chain tcp dport { 1-1024, 8000-8080 } jump defaultchain comment rbtree" >> "$tmp"
+	# pipapo (concat + set), with goto anonymous chain.
+	echo "insert rule inet $table $chain ip saddr . tcp dport { 1.2.3.4 . 1-1024, 1.2.3.6 - 1.2.3.10 . 8000-8080, 1.2.3.4 . 8080, 1.2.3.6 - 1.2.3.10 . 22 } goto { jump defaultchain; counter; }" >> "$tmp"
+
+	# add a few anonymous sets. rhashtable is convered by named sets below.
+	c=$((RANDOM%$count))
+	chain=$(printf "chain%03u" "$((c+1))")
+	echo "insert rule inet $table $chain tcp dport 22-26 ip saddr { 1.2.3.4, 5.6.7.8 } counter comment hash_fast" >> "$tmp"
+	echo "insert rule inet $table $chain ip6 saddr { ::1, dead::beef } counter" comment hash >> "$tmp"
+	echo "insert rule inet $table $chain ip saddr { 1.2.3.4 - 5.6.7.8, 127.0.0.1 } comment rbtree" >> "$tmp"
+	# bitmap 1byte, with anon chain jump
+	echo "insert rule inet $table $chain ip protocol { 6, 17 } jump { jump defaultchain; counter; }" >> "$tmp"
+	# bitmap 2byte
+	echo "insert rule inet $table $chain tcp dport != { 22, 23, 80 } goto defaultchain" >> "$tmp"
+	echo "insert rule inet $table $chain tcp dport { 1-1024, 8000-8080 } jump defaultchain comment rbtree" >> "$tmp"
+	# pipapo (concat + set), with goto anonymous chain.
+	echo "insert rule inet $table $chain ip saddr . tcp dport { 1.2.3.4 . 1-1024, 1.2.3.6 - 1.2.3.10 . 8000-8080, 1.2.3.4 . 8080, 1.2.3.6 - 1.2.3.10 . 22 } goto { jump defaultchain; counter; }" >> "$tmp"
+
+	# add constant/immutable sets
+	size=$((RANDOM%5120000))
+	size=$((size+2))
+	echo "add set inet $table setc1 { typeof tcp dport; size $size; flags constant; elements = { 22, 44 } }" >> "$tmp"
+	echo "add set inet $table setc2 { typeof ip saddr; size $size; flags constant; elements = { 1.2.3.4, 5.6.7.8 } }" >> "$tmp"
+	echo "add set inet $table setc3 { typeof ip6 daddr; size $size; flags constant; elements = { ::1, dead::1 } }" >> "$tmp"
+	echo "add set inet $table setc4 { typeof tcp dport; size $size; flags interval,constant; elements = { 22-44, 55-66 } }" >> "$tmp"
+	echo "add set inet $table setc5 { typeof ip saddr; size $size; flags interval,constant; elements = { 1.2.3.4-5.6.7.8, 10.1.1.1 } }" >> "$tmp"
+	echo "add set inet $table setc6 { typeof ip6 daddr; size $size; flags interval,constant; elements = { ::1, dead::1-dead::3 } }" >> "$tmp"
+
+	# add named sets with various combinations (plain value, range, concatenated values, concatenated ranges, with timeouts, with data ...)
 	for key in "ip saddr" "ip saddr . tcp dport"; do
 		for flags in "" "flags interval;" ; do
 			timeout=$((RANDOM%10))
@@ -175,11 +505,15 @@ for table in $tables; do
 		for flags in "" "interval" ; do
 			want="${key}${flags}"
 			cnt=$((cnt+1))
+			maxip=$((RANDOM%256))
 
-			for e in $(seq 1 255);do
+			if [ $maxip -eq 0 ];then
+				maxip=1
+			fi
+
+			for e in $(seq 1 $maxip);do
 				case "$want" in
-				"single")
-					element="10.1.1.$e"
+				"single") element="10.1.1.$e"
 					;;
 				"concat")
 					element="10.1.2.$e . $((RANDOM%65536))"
@@ -206,18 +540,44 @@ for table in $tables; do
 		done
 	done
 done
+}
+
+run_test()
+{
+	local time_now=$(date +%s)
+	local time_stop=$((time_now + $runtime))
+	local regen=30
+
+	while [ $time_now -lt $time_stop ]; do
+		if [ $regen -gt 0 ];then
+			sleep 1
+			time_now=$(date +%s)
+			regen=$((regen-1))
+			continue
+		fi
+
+		# This clobbers the previously generated ruleset, this is intentional.
+		gen_ruleset
+		regen=$((RANDOM%60))
+		regen=$((regen+2))
+		time_now=$(date +%s)
+	done
+}
 
 netns_add
 
+gen_ruleset
 ip netns exec "$testns" $NFT -f "$tmp" || exit 1
 
+failslab_defaults
+
 stress_all 2>/dev/null &
 
 randsleep
 
 floodping 2> /dev/null &
 
-sleep $runtime
+run_test
 
 # this stops stress_all
 rm -f "$tmp"
-- 
2.41.0

