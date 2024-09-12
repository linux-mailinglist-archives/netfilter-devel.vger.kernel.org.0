Return-Path: <netfilter-devel+bounces-3839-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794CF97697D
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Sep 2024 14:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F183E1F247B0
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Sep 2024 12:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53E1A707B;
	Thu, 12 Sep 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="j58rN+5z"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F81A4E99
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Sep 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145149; cv=none; b=KkgHZsIPN59qUWUNrHjX/coD0XYk87pbh4AhFXzJ7g6vBGvJy+E+ec5AK5QQQ3aXBeG7YnAaZc5vgVmSPYeN7IlpxWPkfC2LyWOrLb/r89XsDG2D8qxVIYMDEuR/ow9AXBPCtRREtu9Q2B+/IPa9tMi5InBsm1XZaVeHz+h1FLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145149; c=relaxed/simple;
	bh=pGvmHzxe8QWE2uDaOUfsyHpAkQBjgL1enHfsRgpANQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BV//YPbP7arwYwWvpyW5/QNEnhU8ihk7nUKqE7jybahUrgp5B9gbbZESsSD3UK54EytWucd/RpQLJ0weIHidwxDrv5YClCM/J0Hm/bWQYUOxAwkeqiwm6YFBT+7m+oDIAH9fL2b36q11EfboDddfOnn4iHNtPgxUNx0L395Lopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=j58rN+5z; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AvURGXYgkc0wxYONbBgoxJfbE5HiJ/COF4wnJ2i4G3Y=; b=j58rN+5zwkNLiAL9QxuodRU1bj
	J+9DeJaXnirYynqOcryGYwt317un/MCo17UCg/lkBkqyDjCfOvwhNHblxkXMZOdQ1A8lLkU4spcdn
	cUqHaFwOVS+Nf/FGp651MKzYCuMeLLzuJ2/HEeoaa7LR6yJEVHYqR6mw9DsE/P32eZpAexnO/F07h
	B+QDToVnV6JAxP/nKUtdbvERth5hbSyT/L2MPc867JNxlYzMWwp947nFWeEgf1KhEAZy+Whe76Wx2
	CZWV76uagSYWPvyy3/hi/WJhhWcBjJR33ZezhXOapFviubzVxZqT7M9G/AOncuUMyRzYqRLriv9t6
	JRM5c6Qg==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1soipi-000000004EK-42fx;
	Thu, 12 Sep 2024 14:21:58 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Eric Garver <e@erig.me>
Subject: [nf-next PATCH v3 16/16] selftests: netfilter: Torture nftables netdev hooks
Date: Thu, 12 Sep 2024 14:21:48 +0200
Message-ID: <20240912122148.12159-17-phil@nwl.cc>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912122148.12159-1-phil@nwl.cc>
References: <20240912122148.12159-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a ruleset which binds to various interface names via netdev-family
chains and flowtables and massage the notifiers by frequently renaming
interfaces to match these names. While doing so:
- Keep an 'nft monitor' running in background to receive the notifications
- Loop over 'nft list ruleset' to exercise ruleset dump codepath
- Have iperf running so the involved chains/flowtables see traffic

If supported, also test interface wildcard support separately by
creating a flowtable with 'wild*' interface spec and quickly add/remove
matching dummy interfaces.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 .../net/netfilter/nft_interface_stress.sh     | 149 ++++++++++++++++++
 2 files changed, 150 insertions(+)
 create mode 100755 tools/testing/selftests/net/netfilter/nft_interface_stress.sh

diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index d13fb5ea3e89..823e0acf7171 100644
--- a/tools/testing/selftests/net/netfilter/Makefile
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -21,6 +21,7 @@ TEST_PROGS += nft_concat_range.sh
 TEST_PROGS += nft_conntrack_helper.sh
 TEST_PROGS += nft_fib.sh
 TEST_PROGS += nft_flowtable.sh
+TEST_PROGS += nft_interface_stress.sh
 TEST_PROGS += nft_meta.sh
 TEST_PROGS += nft_nat.sh
 TEST_PROGS += nft_nat_zones.sh
diff --git a/tools/testing/selftests/net/netfilter/nft_interface_stress.sh b/tools/testing/selftests/net/netfilter/nft_interface_stress.sh
new file mode 100755
index 000000000000..92ce1d35ec19
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/nft_interface_stress.sh
@@ -0,0 +1,149 @@
+#!/bin/bash -e
+#
+# SPDX-License-Identifier: GPL-2.0
+#
+# Torture nftables' netdevice notifier callbacks and related code by frequent
+# renaming of interfaces which netdev-family chains and flowtables hook into.
+
+source lib.sh
+
+checktool "nft --version" "run test without nft tool"
+checktool "iperf3 --version" "run test without iperf3 tool"
+
+# how many seconds to torture the kernel, default to 80% of max run time
+TEST_RUNTIME=$((${kselftest_timeout:-60} * 8 / 10))
+
+trap "cleanup_all_ns" EXIT
+
+setup_ns nsc nsr nss
+
+ip -net $nsc link add cr0 type veth peer name rc0 netns $nsr
+ip -net $nsc addr add 10.0.0.1/24 dev cr0
+ip -net $nsc link set cr0 up
+ip -net $nsc route add default via 10.0.0.2
+
+ip -net $nss link add sr0 type veth peer name rs0 netns $nsr
+ip -net $nss addr add 10.1.0.1/24 dev sr0
+ip -net $nss link set sr0 up
+ip -net $nss route add default via 10.1.0.2
+
+ip -net $nsr addr add 10.0.0.2/24 dev rc0
+ip -net $nsr link set rc0 up
+ip -net $nsr addr add 10.1.0.2/24 dev rs0
+ip -net $nsr link set rs0 up
+ip netns exec $nsr sysctl -q net.ipv4.ip_forward=1
+ip netns exec $nsr sysctl -q net.ipv4.conf.all.forwarding=1
+
+{
+	echo "table netdev t {"
+	for ((i = 0; i < 10; i++)); do
+		cat <<-EOF
+		chain chain_rc$i {
+			type filter hook ingress device rc$i priority 0
+			counter
+		}
+		chain chain_rs$i {
+			type filter hook ingress device rs$i priority 0
+			counter
+		}
+		EOF
+	done
+	echo "}"
+	echo "table ip t {"
+	for ((i = 0; i < 10; i++)); do
+		cat <<-EOF
+		flowtable ft_${i} {
+			hook ingress priority 0
+			devices = { rc$i, rs$i }
+		}
+		EOF
+	done
+	echo "chain c {"
+	echo "type filter hook forward priority 0"
+	for ((i = 0; i < 10; i++)); do
+		echo -n "iifname rc$i oifname rs$i "
+		echo    "ip protocol tcp counter flow add @ft_${i}"
+	done
+	echo "counter"
+	echo "}"
+	echo "}"
+} | ip netns exec $nsr nft -f - || {
+	echo "SKIP: Could not load nft ruleset"
+	exit $ksft_skip
+}
+
+for ((o=0, n=1; ; o=n, n++, n %= 10)); do
+	ip -net $nsr link set rc$o name rc$n
+	ip -net $nsr link set rs$o name rs$n
+done &
+rename_loop_pid=$!
+
+while true; do ip netns exec $nsr nft list ruleset >/dev/null 2>&1; done &
+nft_list_pid=$!
+
+ip netns exec $nsr nft monitor >/dev/null &
+nft_monitor_pid=$!
+
+ip netns exec $nss iperf3 --server --daemon -1
+summary_expr='s,^\[SUM\] .* \([0-9]\+\) Mbits/sec .* receiver,\1,p'
+rate=$(ip netns exec $nsc iperf3 \
+	--format m -c 10.1.0.1 --time $TEST_RUNTIME \
+	--length 56 --parallel 10 -i 0 | sed -n "$summary_expr")
+
+kill $nft_list_pid
+kill $nft_monitor_pid
+kill $rename_loop_pid
+wait
+
+ip netns exec $nsr nft -f - <<EOF
+table ip t {
+	flowtable ft_wild {
+		hook ingress priority 0
+		devices = { wild* }
+	}
+}
+EOF
+if [[ $? -ne 0 ]]; then
+	echo "SKIP wildcard tests: not supported by host's nft?"
+else
+	for ((i = 0; i < 100; i++)); do
+		ip -net $nsr link add wild$i type dummy &
+	done
+	wait
+	for ((i = 80; i < 100; i++)); do
+		ip -net $nsr link del wild$i &
+	done
+	for ((i = 0; i < 80; i++)); do
+		ip -net $nsr link del wild$i &
+	done
+	wait
+	for ((i = 0; i < 100; i += 10)); do
+		(
+		for ((j = 0; j < 10; j++)); do
+			ip -net $nsr link add wild$((i + j)) type dummy
+		done
+		for ((j = 0; j < 10; j++)); do
+			ip -net $nsr link del wild$((i + j))
+		done
+		) &
+	done
+	wait
+fi
+
+[[ $(</proc/sys/kernel/tainted) -eq 0 ]] || {
+	echo "FAIL: Kernel is tainted!"
+	exit $ksft_fail
+}
+
+[[ $rate -gt 0 ]] || {
+	echo "FAIL: Zero throughput in iperf3"
+	exit $ksft_fail
+}
+
+[[ -f /sys/kernel/debug/kmemleak && \
+   -n $(</sys/kernel/debug/kmemleak) ]] && {
+	echo "FAIL: non-empty kmemleak report"
+	exit $ksft_fail
+}
+
+exit $ksft_pass
-- 
2.43.0


