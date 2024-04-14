Return-Path: <netfilter-devel+bounces-1799-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ADB8A461C
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Apr 2024 01:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F5F1F21440
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Apr 2024 23:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540DA13849A;
	Sun, 14 Apr 2024 23:04:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D02134433;
	Sun, 14 Apr 2024 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713135892; cv=none; b=HJEb7U4z6y9xbn2Rvf+h69S1WykXWyNdHmKxmxKaEJDEzMHMAPZkl+ZpRoNzmVR5qAGSOWu9Dgo3mVBC/RDIxJxZ0FGscqlmQ6hF99lJnrtioDj4dHq9GARKtoHeVwsTO64wwBwqd6j4Zl9JyLmdzdvzYdrDpVM68EZeHsUlsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713135892; c=relaxed/simple;
	bh=DhyOTEcJ2UDkO/wV834FM+vNAjq1WNMIUJkVEDvTfEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPxnYpg7pN6DrSvUszEYCUJynmhW71JeDFJdoZAsBkOYTRmAVgx5zrCCzzmZqLqfYKIJjFeFTIIfwWtoU5sk0X8PewGcRnapMYsmqAZSt2zjuLvVweF3gzFLQmSgBpnG4BZsMs5swZHWBT4o/EmFcxVZz4eb3xkftoZbqCtHukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rw8ty-0002Xm-WB; Mon, 15 Apr 2024 01:04:47 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 09/12] selftests: netfilter: conntrack_ipip_mtu.sh: shellcheck cleanups
Date: Mon, 15 Apr 2024 00:57:21 +0200
Message-ID: <20240414225729.18451-10-fw@strlen.de>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240414225729.18451-1-fw@strlen.de>
References: <20240414225729.18451-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change intended.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../net/netfilter/conntrack_ipip_mtu.sh       | 74 +++++++++----------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_ipip_mtu.sh b/tools/testing/selftests/net/netfilter/conntrack_ipip_mtu.sh
index ac0dff0f80d7..9832a5d0198a 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_ipip_mtu.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_ipip_mtu.sh
@@ -31,7 +31,7 @@ setup_ns r_a r_b r_w c_a c_b
 
 cleanup() {
 	cleanup_all_ns
-	rm -f ${rx}
+	rm -f "$rx"
 }
 
 trap cleanup EXIT
@@ -46,20 +46,20 @@ listener_ready()
 test_path() {
 	msg="$1"
 
-	ip netns exec ${c_b} socat -t 3 - udp4-listen:5000,reuseaddr > ${rx} < /dev/null &
+	ip netns exec "$c_b" socat -t 3 - udp4-listen:5000,reuseaddr > "$rx" < /dev/null &
 
 	busywait $BUSYWAIT_TIMEOUT listener_ready "$c_b" 5000
 
 	for i in 1 2 3; do
 		head -c1400 /dev/zero | tr "\000" "a" | \
-			ip netns exec ${c_a} socat -t 1 -u STDIN UDP:192.168.20.2:5000
+			ip netns exec "$c_a" socat -t 1 -u STDIN UDP:192.168.20.2:5000
 	done
 
 	wait
 
-	bytes=$(wc -c < ${rx})
+	bytes=$(wc -c < "$rx")
 
-	if [ $bytes -eq 1400 ];then
+	if [ "$bytes" -eq 1400 ];then
 		echo "OK: PMTU $msg connection tracking"
 	else
 		echo "FAIL: PMTU $msg connection tracking: got $bytes, expected 1400"
@@ -78,24 +78,24 @@ test_path() {
 # 10.4.4.1 via 10.2.2.254      (Router B via Wanrouter)
 # No iptables rules at all.
 
-ip link add veth0 netns ${r_a} type veth peer name veth0 netns ${r_w}
-ip link add veth1 netns ${r_a} type veth peer name veth0 netns ${c_a}
+ip link add veth0 netns "$r_a" type veth peer name veth0 netns "$r_w"
+ip link add veth1 netns "$r_a" type veth peer name veth0 netns "$c_a"
 
 l_addr="10.2.2.1"
 r_addr="10.4.4.1"
-ip netns exec ${r_a} ip link add ipip0 type ipip local ${l_addr} remote ${r_addr} mode ipip || exit $ksft_skip
+ip netns exec "$r_a" ip link add ipip0 type ipip local "$l_addr" remote "$r_addr" mode ipip || exit $ksft_skip
 
 for dev in lo veth0 veth1 ipip0; do
-    ip -net ${r_a} link set $dev up
+    ip -net "$r_a" link set "$dev" up
 done
 
-ip -net ${r_a} addr add 10.2.2.1/24 dev veth0
-ip -net ${r_a} addr add 192.168.10.1/24 dev veth1
+ip -net "$r_a" addr add 10.2.2.1/24 dev veth0
+ip -net "$r_a" addr add 192.168.10.1/24 dev veth1
 
-ip -net ${r_a} route add 192.168.20.0/24 dev ipip0
-ip -net ${r_a} route add 10.4.4.0/24 via 10.2.2.254
+ip -net "$r_a" route add 192.168.20.0/24 dev ipip0
+ip -net "$r_a" route add 10.4.4.0/24 via 10.2.2.254
 
-ip netns exec ${r_a} sysctl -q net.ipv4.conf.all.forwarding=1 > /dev/null
+ip netns exec "$r_a" sysctl -q net.ipv4.conf.all.forwarding=1 > /dev/null
 
 # Detailed setup for Router B
 # ---------------------------
@@ -108,46 +108,46 @@ ip netns exec ${r_a} sysctl -q net.ipv4.conf.all.forwarding=1 > /dev/null
 # 10.2.2.1 via 10.4.4.254      (Router A via Wanrouter)
 # No iptables rules at all.
 
-ip link add veth0 netns ${r_b} type veth peer name veth1 netns ${r_w}
-ip link add veth1 netns ${r_b} type veth peer name veth0 netns ${c_b}
+ip link add veth0 netns "$r_b" type veth peer name veth1 netns "$r_w"
+ip link add veth1 netns "$r_b" type veth peer name veth0 netns "$c_b"
 
 l_addr="10.4.4.1"
 r_addr="10.2.2.1"
 
-ip netns exec ${r_b} ip link add ipip0 type ipip local ${l_addr} remote ${r_addr} mode ipip || exit $ksft_skip
+ip netns exec "$r_b" ip link add ipip0 type ipip local "${l_addr}" remote "${r_addr}" mode ipip || exit $ksft_skip
 
 for dev in veth0 veth1 ipip0; do
-	ip -net ${r_b} link set $dev up
+	ip -net "$r_b" link set $dev up
 done
 
-ip -net ${r_b} addr add 10.4.4.1/24 dev veth0
-ip -net ${r_b} addr add 192.168.20.1/24 dev veth1
+ip -net "$r_b" addr add 10.4.4.1/24 dev veth0
+ip -net "$r_b" addr add 192.168.20.1/24 dev veth1
 
-ip -net ${r_b} route add 192.168.10.0/24 dev ipip0
-ip -net ${r_b} route add 10.2.2.0/24 via 10.4.4.254
-ip netns exec ${r_b} sysctl -q net.ipv4.conf.all.forwarding=1 > /dev/null
+ip -net "$r_b" route add 192.168.10.0/24 dev ipip0
+ip -net "$r_b" route add 10.2.2.0/24 via 10.4.4.254
+ip netns exec "$r_b" sysctl -q net.ipv4.conf.all.forwarding=1 > /dev/null
 
 # Client A
-ip -net ${c_a} addr add 192.168.10.2/24 dev veth0
-ip -net ${c_a} link set dev veth0 up
-ip -net ${c_a} route add default via 192.168.10.1
+ip -net "$c_a" addr add 192.168.10.2/24 dev veth0
+ip -net "$c_a" link set dev veth0 up
+ip -net "$c_a" route add default via 192.168.10.1
 
 # Client A
-ip -net ${c_b} addr add 192.168.20.2/24 dev veth0
-ip -net ${c_b} link set dev veth0 up
-ip -net ${c_b} route add default via 192.168.20.1
+ip -net "$c_b" addr add 192.168.20.2/24 dev veth0
+ip -net "$c_b" link set dev veth0 up
+ip -net "$c_b" route add default via 192.168.20.1
 
 # Wan
-ip -net ${r_w} addr add 10.2.2.254/24 dev veth0
-ip -net ${r_w} addr add 10.4.4.254/24 dev veth1
+ip -net "$r_w" addr add 10.2.2.254/24 dev veth0
+ip -net "$r_w" addr add 10.4.4.254/24 dev veth1
 
-ip -net ${r_w} link set dev veth0 up mtu 1400
-ip -net ${r_w} link set dev veth1 up mtu 1400
+ip -net "$r_w" link set dev veth0 up mtu 1400
+ip -net "$r_w" link set dev veth1 up mtu 1400
 
-ip -net ${r_a} link set dev veth0 mtu 1400
-ip -net ${r_b} link set dev veth0 mtu 1400
+ip -net "$r_a" link set dev veth0 mtu 1400
+ip -net "$r_b" link set dev veth0 mtu 1400
 
-ip netns exec ${r_w} sysctl -q net.ipv4.conf.all.forwarding=1 > /dev/null
+ip netns exec "$r_w" sysctl -q net.ipv4.conf.all.forwarding=1 > /dev/null
 
 # Path MTU discovery
 # ------------------
@@ -187,5 +187,5 @@ test_path "without"
 #packet is too big (1400) for the tunnel PMTU (1380) to Router B, it is
 #dropped on Router A before sending.
 
-ip netns exec ${r_a} iptables -A FORWARD -m conntrack --ctstate NEW
+ip netns exec "$r_a" iptables -A FORWARD -m conntrack --ctstate NEW
 test_path "with"
-- 
2.43.2


