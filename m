Return-Path: <netfilter-devel+bounces-12682-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHPjN9bjC2qdQAUAu9opvQ
	(envelope-from <netfilter-devel+bounces-12682-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 06:15:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3D577286
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 06:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E20300CC0A
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 04:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2272F8E90;
	Tue, 19 May 2026 04:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y8tFqlsR"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25C2FF65B
	for <netfilter-devel@vger.kernel.org>; Tue, 19 May 2026 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779164116; cv=none; b=DZ3qizTv02E3WG44O95VlvbeIThRptMOOPorIziR8tl1w1AgTIfLub4Mhig1ryY8WPRes5PI6ZO3e7dGsGuGl1pKsY/1944gH9p1k2HwxRjKnSb9OlaKzbuVhLhtHhIaoBH2ZvOfF9ZElwBvcQSC2hSO+FL/MazmRvlQfBMMFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779164116; c=relaxed/simple;
	bh=Sf9bbVTZpG+pdkKlTqThofWNQkna9lnAEdsTj91H43c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcCERVAGfQVNZ3LFKDabX+E3HdsiPKbUnZIDWBgnsUXQEwdY/Q3qAl9P19JFPnKO32EMZSoPJTJCHa2K6Ggue2DSjApkEafAjvvX9aqgKIqLeFQCnTI8nBqnHOKYMy20NQPHI2U0RNucuJBGTeCYVdqGgGT8bh6wU7bQTQPO4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y8tFqlsR; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779164110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Do6zrR+QCRCa03DBuIngJ+DACoNKvi76GciQato3NDI=;
	b=Y8tFqlsR2PAVGEl3bZVPZQdc19XDI2TACA5o+d1kr6ZCUbI27AYz4X6VrTQXvtOztA0OF+
	WCrw2r9RMd4e10ZWAM7+OuQFa0j8Uhb/aQiYjIgC24DxlwonbIQ58NA2mfuI8sNH4deaUK
	slPgxPGqHxeIHmi5Y5sxFY3dQLoFo7I=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH nf 2/2] selftests: netfilter: add nft_fib_nexthop test
Date: Tue, 19 May 2026 12:14:31 +0800
Message-ID: <20260519041431.396218-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260519041431.396218-1-jiayuan.chen@linux.dev>
References: <20260519041431.396218-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12682-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lib.sh:url,nft_fib_nexthop.sh:url]
X-Rspamd-Queue-Id: 3EB3D577286
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Cover nft_fib6_eval() over three route shapes and reproduce the OOB
caused by the blind &rt->fib6_siblings walk:

  1) single external nexthop (nhid)
  2) external nexthop group (nhid -> group)
  3) old-style multipath (nexthop ... nexthop ...)

After the fix:

  ./nft_fib_nexthop.sh
  Nothing to flush
  PASS: single external nexthop (nhid)
  Flushed 1 nexthops
  PASS: nexthop group (nhid group 1/2)
  Flushed 2 nexthops
  PASS: old-style multipath (fib6_siblings)

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 .../net/netfilter/nft_fib_nexthop.sh          | 104 ++++++++++++++++++
 2 files changed, 105 insertions(+)
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
index 000000000000..76f934156c8c
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/nft_fib_nexthop.sh
@@ -0,0 +1,104 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2154
+#
+# Exercise nft_fib6_eval()'s sibling/nh enumeration on three route shapes:
+#   1) route via a single external nexthop (nhid)
+#   2) route via an external nexthop group (nhid -> group)
+#   3) route via old-style multipath (nexthop ... nexthop ...)
+#
+# Topology similar to nft_fib.sh, without ns2; two dummy interfaces on
+# nsrouter host the nh devices:
+#
+#   dead:1::99           dead:1::1     dummy0 dead:2::1
+#   ns1 <-----veth----->         nsrouter
+#                                       dummy1 dead:9::1
+
+source lib.sh
+
+ret=0
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
+	ip netns exec "$nsrouter" nft -f /dev/stdin <<EOF
+flush ruleset
+table ip6 t {
+	chain c {
+		type filter hook prerouting priority 0; policy accept;
+		fib daddr . iif oif missing counter
+	}
+}
+EOF
+}
+
+run_scenario() {
+	local what="$1"; shift
+
+	ip -net "$nsrouter" -6 route del dead:dead::/64 2>/dev/null || true
+	ip -net "$nsrouter" -6 nexthop flush 2>/dev/null || true
+
+	"$@" || { echo "SKIP ($what): could not configure route"; return; }
+
+	load_fib_rule || { echo "FAIL ($what): nft load"; ret=1; return; }
+
+	ip netns exec "$ns1" ping -6 -c 1 -W 1 dead:dead::1 \
+		> /dev/null 2>&1 || true
+
+	echo "PASS: $what"
+}
+
+scenario_single_nh() {
+	ip -net "$nsrouter" nexthop add id 1 via dead:2::2 dev dummy0
+	ip -net "$nsrouter" -6 route add dead:dead::/64 nhid 1
+}
+run_scenario "single external nexthop (nhid)" scenario_single_nh
+
+scenario_nh_group() {
+	ip -net "$nsrouter" nexthop add id 1   via dead:2::2 dev dummy0
+	ip -net "$nsrouter" nexthop add id 2   via dead:9::2 dev dummy1
+	ip -net "$nsrouter" nexthop add id 100 group 1/2
+	ip -net "$nsrouter" -6 route   add dead:dead::/64 nhid 100
+}
+run_scenario "nexthop group (nhid group 1/2)" scenario_nh_group
+
+scenario_old_multipath() {
+	ip -net "$nsrouter" -6 route add dead:dead::/64 \
+		nexthop via dead:2::2 dev dummy0 \
+		nexthop via dead:9::2 dev dummy1
+}
+run_scenario "old-style multipath (fib6_siblings)" scenario_old_multipath
+
+exit $ret
-- 
2.43.0


