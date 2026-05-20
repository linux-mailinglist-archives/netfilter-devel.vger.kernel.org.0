Return-Path: <netfilter-devel+bounces-12727-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPesAk0eDWoatgUAu9opvQ
	(envelope-from <netfilter-devel+bounces-12727-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 04:37:01 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B65C586E22
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 04:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 863A03024C8E
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 02:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782392DCF46;
	Wed, 20 May 2026 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ED44Utej"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AB302767
	for <netfilter-devel@vger.kernel.org>; Wed, 20 May 2026 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244473; cv=none; b=Et+Zo7er/Cv2A9Twt3RJ+QwCcs9wC1JQXBqJ1tPAF3ePx428F+CtLM7EYKTQYbJiKkiCY65/RYXzF4FG7VBO6S0+t+yTpyNTJOqvXUU13fySyEiEfnEh6N1DjSQAExPDcX1t/2+EKj0/L+nQyje2p3+fT/TGYDtnEh1EpNDGhWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244473; c=relaxed/simple;
	bh=UpDmt7bogyhkI6W7enLWWV5PzH92qOfwfNVX+44o4LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B75NJgYZ3VKJpVxO8iGPBqhA9KQmImL/aqbrlu1BVtlTPsAOJyVv/Z/ov+ZF3xchoO2zWsy18V8KhRPQw3thwG9W+noP5kRxWmL08EgIGQTSInBPHIgNUKtq7GcEeSbJBwsmdBkDT94ZvAthwK+wzEARO9n+eIMKVIhkXAE4vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ED44Utej; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779244469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WqNlMJDthtGSkO5Z1UouiogaywFPCBTru59b+PrKb4=;
	b=ED44Utejwj2k0M3MeGGBPvi+dVoXqmy1fBCQu0ld+B6FmUQdnDLrvDZluivo6StymYNBDv
	XO/JVVjsV6wVwxv5C0TU6E92g3JM3Er8df/7BHt7qqQQLEetL9r4dogo61wHuR++0beaDk
	HHBdYocetcRag5oSD7OVYwW/oPPT5Hs=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org
Subject: [PATCH nf v2 3/3] selftests: netfilter: add nft_fib_nexthop test
Date: Wed, 20 May 2026 10:34:11 +0800
Message-ID: <20260520023411.391233-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260520023411.391233-1-jiayuan.chen@linux.dev>
References: <20260520023411.391233-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12727-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim,strlen.de:email]
X-Rspamd-Queue-Id: 5B65C586E22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Functional coverage of nft_fib6_eval()'s nexthop enumeration over
three route shapes:

  1) single external nexthop (nhid)
  2) external nexthop group (nhid -> group)
  3) old-style multipath (nexthop ... nexthop ...)

Each scenario places one nexthop on the input device (veth0). For
(2) and (3) the matching nexthop is the second member, so the walk
has to traverse beyond the primary nh. Two nft counters on prerouting
verify the data path: one increments only when fib reports veth0 as
the oif, the other counts "missing" results and must stay at zero.

  ./nft_fib_nexthop.sh
  PASS: single external nexthop (nhid -> veth0)
  PASS: nexthop group (dummy0 + veth0)
  PASS: old-style multipath (sibling on veth0)

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 .../net/netfilter/nft_fib_nexthop.sh          | 152 ++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100755 tools/testing/selftests/net/netfilter/nft_fib_nexthop.sh

diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index ee2d1a5254f8..d953ee218c0f 100644
--- a/tools/testing/selftests/net/netfilter/Makefile
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -26,6 +26,7 @@ TEST_PROGS := \
 	nft_concat_range.sh \
 	nft_conntrack_helper.sh \
 	nft_fib.sh \
+	nft_fib_nexthop.sh \
 	nft_flowtable.sh \
 	nft_interface_stress.sh \
 	nft_meta.sh \
diff --git a/tools/testing/selftests/net/netfilter/nft_fib_nexthop.sh b/tools/testing/selftests/net/netfilter/nft_fib_nexthop.sh
new file mode 100755
index 000000000000..c4f203057382
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/nft_fib_nexthop.sh
@@ -0,0 +1,152 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2154
+#
+# Exercise nft_fib6_eval()'s sibling/nh enumeration on three route shapes:
+#   1) route via a single external nexthop (nhid)
+#   2) route via an external nexthop group (nhid -> group, two members)
+#   3) route via old-style multipath (nexthop ... nexthop ...)
+#
+# In each scenario the route's nexthop set contains veth0 (the iif of the
+# test packet). nft_fib6_info_nh_uses_dev() must walk the set and report
+# veth0 as a valid oif. For (2) and (3) the matching nexthop is the second
+# member, so the walk has to traverse beyond the primary nh.
+#
+# After sending $PKTS ICMPv6 echo requests from ns1, check two counters on
+# nsrouter:
+#   nf_ok  -- `fib daddr . iif oif eq "veth0"`  must equal $PKTS
+#   nf_bad -- `fib daddr . iif oif missing`     must stay at 0
+# Both rules also match on iif veth0 and ip6 daddr dead:dead::/64 so that
+# kernel-generated ND/MLD/RA traffic cannot pollute the counters.
+#
+# Topology similar to nft_fib.sh, without ns2; two dummy interfaces on
+# nsrouter host extra nh devices:
+#
+#   dead:1::99             dead:1::1
+#       ns1 <----veth----> nsrouter --- dummy0 dead:2::1
+#                                   \-- dummy1 dead:9::1
+
+source lib.sh
+
+ret=0
+PKTS=3
+
+checktool "nft --version" "run test without nft"
+checktool "ip -V"         "run test without iproute2"
+
+setup_ns nsrouter ns1
+trap cleanup_all_ns EXIT
+
+if ! ip link add veth0 netns "$nsrouter" type veth peer name eth0 netns "$ns1" \
+	> /dev/null 2>&1; then
+	echo "SKIP: No virtual ethernet pair device support in kernel"
+	exit $ksft_skip
+fi
+
+ip -net "$ns1" link set lo up
+ip -net "$ns1" link set eth0 up
+ip -net "$ns1" -6 addr add dead:1::99/64 dev eth0 nodad
+ip -net "$ns1" -6 route add default via dead:1::1
+
+ip -net "$nsrouter" link set lo up
+ip -net "$nsrouter" link set veth0 up
+ip -net "$nsrouter" -6 addr add dead:1::1/64 dev veth0 nodad
+
+if ! ip -net "$nsrouter" link add dummy0 type dummy 2>/dev/null; then
+	echo "SKIP: dummy netdev not available"
+	exit $ksft_skip
+fi
+ip -net "$nsrouter" link set dummy0 up
+ip -net "$nsrouter" -6 addr add dead:2::1/64 dev dummy0 nodad
+
+ip -net "$nsrouter" link add dummy1 type dummy
+ip -net "$nsrouter" link set dummy1 up
+ip -net "$nsrouter" -6 addr add dead:9::1/64 dev dummy1 nodad
+
+ip netns exec "$nsrouter" sysctl -q net.ipv6.conf.all.forwarding=1
+
+load_fib_rule() {
+	# filter on iif + daddr so the counters only see our test packets
+	ip netns exec "$nsrouter" nft -f /dev/stdin <<EOF
+flush ruleset
+table ip6 t {
+	counter nf_ok  { }
+	counter nf_bad { }
+	chain c {
+		type filter hook prerouting priority 0; policy accept;
+		iif "veth0" ip6 daddr dead:dead::/64 fib daddr . iif oif eq "veth0" counter name nf_ok
+		iif "veth0" ip6 daddr dead:dead::/64 fib daddr . iif oif missing    counter name nf_bad
+	}
+}
+EOF
+}
+
+bad_counter() {
+	local counter=$1
+	local expect=$2
+	local tag=$3
+
+	echo "FAIL ($tag): counter $counter has unexpected value (expected \"$expect\")" 1>&2
+	ip netns exec "$nsrouter" nft list counter ip6 t "$counter" 1>&2
+}
+
+run_scenario() {
+	local what="$1"; shift
+	# counter output format is "packets PACKET_NUM bytes BYTES_NUM";
+	# we only care about the packet count
+	local expect_ok="packets $PKTS bytes"
+	local expect_bad="packets 0 bytes"
+	local lret=0
+
+	# reset route + nexthop state between scenarios
+	ip -net "$nsrouter" -6 route del dead:dead::/64 > /dev/null 2>&1 || true
+	ip -net "$nsrouter" nexthop flush               > /dev/null 2>&1 || true
+
+	# run the scenario function passed by the caller
+	"$@" || echo "WARN ($what): scenario setup returned non-zero"
+
+	load_fib_rule || { echo "FAIL ($what): nft load"; ret=1; return; }
+
+	# ping a daddr inside dead:dead::/64 so fib has to walk the nh set
+	ip netns exec "$ns1" ping -6 -c "$PKTS" -i 0.1 -W 1 dead:dead::1 \
+		> /dev/null 2>&1 || true
+
+	# verify the packets went through the expected fib path
+	if ! ip netns exec "$nsrouter" nft list counter ip6 t nf_ok | grep -q "$expect_ok"; then
+		bad_counter nf_ok "$expect_ok" "$what"
+		lret=1
+	fi
+	if ! ip netns exec "$nsrouter" nft list counter ip6 t nf_bad | grep -q "$expect_bad"; then
+		bad_counter nf_bad "$expect_bad" "$what"
+		lret=1
+	fi
+
+	if [ $lret -eq 0 ]; then
+		echo "PASS: $what"
+	else
+		ret=1
+	fi
+}
+
+scenario_single_nh() {
+	ip -net "$nsrouter" nexthop add id 1 via dead:1::99 dev veth0
+	ip -net "$nsrouter" -6 route add dead:dead::/64 nhid 1
+}
+run_scenario "single external nexthop (nhid -> veth0)" scenario_single_nh
+
+scenario_nh_group() {
+	ip -net "$nsrouter" nexthop add id 1   via dead:2::2  dev dummy0
+	ip -net "$nsrouter" nexthop add id 2   via dead:1::99 dev veth0
+	ip -net "$nsrouter" nexthop add id 100 group 1/2
+	ip -net "$nsrouter" -6 route   add dead:dead::/64 nhid 100
+}
+run_scenario "nexthop group (dummy0 + veth0)" scenario_nh_group
+
+scenario_old_multipath() {
+	ip -net "$nsrouter" -6 route add dead:dead::/64 \
+		nexthop via dead:2::2  dev dummy0 \
+		nexthop via dead:1::99 dev veth0
+}
+run_scenario "old-style multipath (sibling on veth0)" scenario_old_multipath
+
+exit $ret
-- 
2.43.0


