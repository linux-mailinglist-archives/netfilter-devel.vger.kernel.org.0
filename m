Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC149C91F
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jan 2022 12:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiAZLzE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jan 2022 06:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbiAZLzD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:55:03 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C2C061749
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Jan 2022 03:55:03 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nCgtA-0007bT-BX; Wed, 26 Jan 2022 12:55:00 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Stefano Brivio <sbrivio@redhat.com>
Subject: [PATCH nf] selftests: nft_concat_range: add test for reload with no element add/del
Date:   Wed, 26 Jan 2022 12:54:54 +0100
Message-Id: <20220126115454.31412-1-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a specific test for the reload issue fixed with
commit 23c54263efd7cb ("netfilter: nft_set_pipapo: allocate pcpu scratch maps on clone").

Add to set, then flush set content + restore without other add/remove in
the transaction.

On kernels before the fix, this test case fails:
  net,mac with reload    [FAIL]

Cc: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/netfilter/nft_concat_range.sh   | 72 ++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/netfilter/nft_concat_range.sh b/tools/testing/selftests/netfilter/nft_concat_range.sh
index ed61f6cab60f..df322e47a54f 100755
--- a/tools/testing/selftests/netfilter/nft_concat_range.sh
+++ b/tools/testing/selftests/netfilter/nft_concat_range.sh
@@ -27,7 +27,7 @@ TYPES="net_port port_net net6_port port_proto net6_port_mac net6_port_mac_proto
        net6_port_net6_port net_port_mac_proto_net"
 
 # Reported bugs, also described by TYPE_ variables below
-BUGS="flush_remove_add"
+BUGS="flush_remove_add reload"
 
 # List of possible paths to pktgen script from kernel tree for performance tests
 PKTGEN_SCRIPT_PATHS="
@@ -354,6 +354,23 @@ TYPE_flush_remove_add="
 display		Add two elements, flush, re-add
 "
 
+TYPE_reload="
+display		net,mac with reload
+type_spec	ipv4_addr . ether_addr
+chain_spec	ip daddr . ether saddr
+dst		addr4
+src		mac
+start		1
+count		1
+src_delta	2000
+tools		sendip nc bash
+proto		udp
+
+race_repeat	0
+
+perf_duration	0
+"
+
 # Set template for all tests, types and rules are filled in depending on test
 set_template='
 flush ruleset
@@ -1473,6 +1490,59 @@ test_bug_flush_remove_add() {
 	nft flush ruleset
 }
 
+# - add ranged element, check that packets match it
+# - reload the set, check packets still match
+test_bug_reload() {
+	setup veth send_"${proto}" set || return ${KSELFTEST_SKIP}
+	rstart=${start}
+
+	range_size=1
+	for i in $(seq "${start}" $((start + count))); do
+		end=$((start + range_size))
+
+		# Avoid negative or zero-sized port ranges
+		if [ $((end / 65534)) -gt $((start / 65534)) ]; then
+			start=${end}
+			end=$((end + 1))
+		fi
+		srcstart=$((start + src_delta))
+		srcend=$((end + src_delta))
+
+		add "$(format)" || return 1
+		range_size=$((range_size + 1))
+		start=$((end + range_size))
+	done
+
+	# check kernel does allocate pcpu sctrach map
+	# for reload with no elemet add/delete
+	( echo flush set inet filter test ;
+	  nft list set inet filter test ) | nft -f -
+
+	start=${rstart}
+	range_size=1
+
+	for i in $(seq "${start}" $((start + count))); do
+		end=$((start + range_size))
+
+		# Avoid negative or zero-sized port ranges
+		if [ $((end / 65534)) -gt $((start / 65534)) ]; then
+			start=${end}
+			end=$((end + 1))
+		fi
+		srcstart=$((start + src_delta))
+		srcend=$((end + src_delta))
+
+		for j in $(seq ${start} $((range_size / 2 + 1)) ${end}); do
+			send_match "${j}" $((j + src_delta)) || return 1
+		done
+
+		range_size=$((range_size + 1))
+		start=$((end + range_size))
+	done
+
+	nft flush ruleset
+}
+
 test_reported_issues() {
 	eval test_bug_"${subtest}"
 }
-- 
2.34.1

