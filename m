Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF1977CCD3
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Aug 2023 14:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbjHOMlw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Aug 2023 08:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjHOMlr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:41:47 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419FDF1
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Aug 2023 05:41:46 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qVtMl-0007JW-SX; Tue, 15 Aug 2023 14:41:43 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tests: add transaction stress test with parallel delete/add/flush and netns deletion
Date:   Tue, 15 Aug 2023 14:41:36 +0200
Message-ID: <20230815124139.17713-1-fw@strlen.de>
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

Based on nft_trans_stress.sh from kernel selftests, changed to run from
run-tests.sh, plus additional ideas from Pablo Neira, such as del+readd
of the netns.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/shell/testcases/transactions/30s-stress | 225 ++++++++++++++++++
 1 file changed, 225 insertions(+)
 create mode 100755 tests/shell/testcases/transactions/30s-stress

diff --git a/tests/shell/testcases/transactions/30s-stress b/tests/shell/testcases/transactions/30s-stress
new file mode 100755
index 000000000000..3539a3078b13
--- /dev/null
+++ b/tests/shell/testcases/transactions/30s-stress
@@ -0,0 +1,225 @@
+#!/bin/bash
+
+testns=testns-$(mktemp -u "XXXXXXXX")
+tmp=""
+
+tables="foo bar baz"
+runtime=10
+
+netns_del() {
+	ip netns del "$testns"
+}
+
+netns_add()
+{
+	ip netns add "$testns"
+	ip -netns "$testns" link set lo up
+}
+
+cleanup() {
+	[ "$tmp" = "" ] || rm -f "$tmp"
+	netns_del
+}
+
+trap cleanup EXIT
+tmp=$(mktemp)
+
+random_verdict()
+{
+	max="$1"
+	rnd=$((RANDOM%max))
+
+	if [ $rnd -gt 0 ];then
+		printf "jump chain%03u" "$((rnd+1))"
+		return
+	fi
+
+	if [ $((RANDOM & 1)) -eq 0 ] ;then
+		echo "accept"
+	else
+		echo "drop"
+	fi
+}
+
+randsleep()
+{
+	local s=$((RANDOM%3))
+	local ms=$((RANDOM%10))
+	sleep $s.$ms
+}
+
+randlist()
+{
+	while [ -r $tmp ]; do
+		randsleep
+		ip netns exec $testns $NFT list ruleset > /dev/null
+	done
+}
+
+randflush()
+{
+	while [ -r $tmp ]; do
+		randsleep
+		ip netns exec $testns $NFT flush ruleset > /dev/null
+	done
+}
+
+randdeltable()
+{
+	while [ -r $tmp ]; do
+		randsleep
+		for t in $tables; do
+			r=$((RANDOM%10))
+
+			if [ $r -eq 1 ] ;then
+				ip netns exec $testns $NFT delete table $t
+				randsleep
+			fi
+		done
+	done
+}
+
+randdelns()
+{
+	while [ -r $tmp ]; do
+		randsleep
+		netns_del
+		netns_add
+		randsleep
+	done
+}
+
+randload()
+{
+	while [ -r $tmp ]; do
+		r=$((RANDOM%10))
+
+		if [ $r -eq 1 ] ;then
+			(echo "flush ruleset"; cat "$tmp"
+			 echo "insert rule inet foo INPUT meta nftrace set 1"
+			 echo "insert rule inet foo OUTPUT meta nftrace set 1"
+			) | ip netns exec "$testns" $NFT -f /dev/stdin
+		else
+			ip netns exec "$testns" $NFT -f "$tmp"
+		fi
+
+		randsleep
+	done
+}
+
+floodping() {
+	cpunum=$(grep -c processor /proc/cpuinfo)
+
+	while [ -r $tmp ]; do
+		i=0
+		while [ $i -lt $cpunum ]; do
+			mask=$(printf 0x%x $((1<<$i)))
+		        timeout 3 ip netns exec "$testns" taskset $mask ping -4 -fq 127.0.0.1 > /dev/null &
+		        timeout 3 ip netns exec "$testns" taskset $mask ping -6 -fq ::1 > /dev/null &
+			i=$((i+1))
+		done
+
+		wait
+		randsleep
+	done
+}
+
+stress_all()
+{
+	randlist &
+	randflush &
+	randdeltable &
+	randdelns &
+	randload &
+}
+
+for table in $tables; do
+	count=$((RANDOM % 200))
+	echo add table inet "$table" >> "$tmp"
+	echo flush table inet "$table" >> "$tmp"
+
+	echo "add chain inet $table INPUT { type filter hook input priority 0; }" >> "$tmp"
+	echo "add chain inet $table OUTPUT { type filter hook output priority 0; }" >> "$tmp"
+	for c in $(seq 1 $count); do
+		chain=$(printf "chain%03u" "$c")
+		echo "add chain inet $table $chain" >> "$tmp"
+	done
+
+	for c in $(seq 1 $count); do
+		chain=$(printf "chain%03u" "$c")
+		for BASE in INPUT OUTPUT; do
+			echo "add rule inet $table $BASE counter jump $chain" >> "$tmp"
+		done
+		echo "add rule inet $table $chain counter return" >> "$tmp"
+	done
+
+	cnt=0
+	for key in "ip saddr" "ip saddr . tcp dport"; do
+		for flags in "" "flags interval;" ; do
+			timeout=$((RANDOM%10))
+			timeout=$((timeout+1))
+			timeout="timeout ${timeout}s"
+
+			cnt=$((cnt+1))
+			echo "add set inet $table set_${cnt}  { typeof ${key} ; ${flags} }" >> "$tmp"
+			echo "add set inet $table sett${cnt} { typeof ${key} ; $timeout; ${flags} }" >> "$tmp"
+			echo "add map inet $table dmap_${cnt} { typeof ${key} : meta mark ; ${flags} }" >> "$tmp"
+			echo "add map inet $table dmapt${cnt} { typeof ${key} : meta mark ; $timeout ; ${flags} }" >> "$tmp"
+			echo "add map inet $table vmap_${cnt} { typeof ${key} : verdict ; ${flags} }" >> "$tmp"
+			echo "add map inet $table vmapt${cnt} { typeof ${key} : verdict; $timeout ; ${flags} }" >> "$tmp"
+		done
+	done
+
+	cnt=0
+	for key in "single" "concat"; do
+		for flags in "" "interval" ; do
+			want="${key}${flags}"
+			cnt=$((cnt+1))
+
+			for e in $(seq 1 255);do
+				case "$want" in
+				"single")
+					element="10.1.1.$e"
+					;;
+				"concat")
+					element="10.1.2.$e . $((RANDOM%65536))"
+					;;
+				"singleinterval")
+					element="10.1.$e.0-10.1.$e.$e"
+					;;
+				"concatinterval")
+					element="10.1.$e.0-10.1.$e.$e . $((RANDOM%65536))"
+					;;
+				*)
+					echo "bogus key $want"
+					exit 111
+					;;
+				esac
+
+				echo "add element inet $table set_${cnt} { $element }" >> "$tmp"
+				echo "add element inet $table sett${cnt} { $element timeout $((RANDOM%60))s }" >> "$tmp"
+				echo "add element inet $table dmap_${cnt} { $element : $RANDOM }" >> "$tmp"
+				echo "add element inet $table dmapt${cnt} { $element timeout $((RANDOM%60))s : $RANDOM }" >> "$tmp"
+				echo "add element inet $table vmap_${cnt} { $element : `random_verdict $count` }" >> "$tmp"
+				echo "add element inet $table vmapt${cnt} { $element timeout $((RANDOM%60))s : `random_verdict $count` }" >> "$tmp"
+			done
+		done
+	done
+done
+
+netns_add
+
+ip netns exec "$testns" $NFT -f "$tmp" || exit 1
+
+stress_all 2>/dev/null &
+
+randsleep
+
+floodping 2> /dev/null &
+
+sleep $runtime
+
+# this stops stress_all
+rm -f "$tmp"
+tmp=""
+sleep 4
-- 
2.41.0

