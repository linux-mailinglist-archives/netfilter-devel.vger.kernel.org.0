Return-Path: <netfilter-devel+bounces-1793-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE188A4610
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Apr 2024 01:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA34228197F
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Apr 2024 23:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2484C137914;
	Sun, 14 Apr 2024 23:04:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB2137905;
	Sun, 14 Apr 2024 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713135886; cv=none; b=quqqSszXUIOlXHOeiRx4XnyV4PyMPVjQdbawD76gemZ7Ur/qe8CY4g5qe+r6RCo2i/MGoDkv9STgCUleBXfshJB1l0ju/IB4Mga6WNMGRmXnFt3hNC+bGGIfGraL8AQCgU4isQfRJHyT8UbO0JTiFRHxnOTlxV5/3sfkmewCrH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713135886; c=relaxed/simple;
	bh=z6821y4fkGeBW4sfK6ErF1Uzf5GMRLmD5sThSz81oTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYa1mOkTgHw1b68L6RAJEVVjUwiLzHXXpq9C8g7wVs/U54mUiFfF711l/CVNPu7wp/plkAtusIUWmQuSAiKVUmcaYS3NUF2+6T8nlNo/rVMWIAxydABtS82K63ZR/1QrnyRFCSWk9IijaaO8BP+2i/g9GFVneUK76Hh44Inrv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rw8ts-0002Wb-NU; Mon, 15 Apr 2024 01:04:40 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 06/12] selftests: netfilter: xt_string.sh: move to lib.sh infra
Date: Mon, 15 Apr 2024 00:57:18 +0200
Message-ID: <20240414225729.18451-7-fw@strlen.de>
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

Intentional changes:
- Use socat instead of netcat
- Use a temporary file instead of pipe, else packets do not match
  "-m string" rules, multiple writes to the pipe cause multiple packets,
  but this needs only one to work.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/net/netfilter/xt_string.sh      | 55 ++++++++++---------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/xt_string.sh b/tools/testing/selftests/net/netfilter/xt_string.sh
index 1802653a4728..ec7042b502e4 100755
--- a/tools/testing/selftests/net/netfilter/xt_string.sh
+++ b/tools/testing/selftests/net/netfilter/xt_string.sh
@@ -5,43 +5,45 @@
 ksft_skip=4
 rc=0
 
-if ! iptables --version >/dev/null 2>&1; then
-	echo "SKIP: Test needs iptables"
-	exit $ksft_skip
-fi
-if ! ip -V >/dev/null 2>&1; then
-	echo "SKIP: Test needs iproute2"
-	exit $ksft_skip
-fi
-if ! nc -h >/dev/null 2>&1; then
-	echo "SKIP: Test needs netcat"
-	exit $ksft_skip
-fi
+source lib.sh
+
+checktool "socat -h" "run test without socat"
+checktool "iptables --version" "test needs iptables"
+
+infile=$(mktemp)
+
+cleanup()
+{
+	ip netns del "$netns"
+	rm -f "$infile"
+}
+
+trap cleanup EXIT
+
+setup_ns netns
+
+ip -net "$netns" link add d0 type dummy
+ip -net "$netns" link set d0 up
+ip -net "$netns" addr add 10.1.2.1/24 dev d0
 
 pattern="foo bar baz"
 patlen=11
 hdrlen=$((20 + 8)) # IPv4 + UDP
-ns="ns-$(mktemp -u XXXXXXXX)"
-trap 'ip netns del $ns' EXIT
-ip netns add "$ns"
-ip -net "$ns" link add d0 type dummy
-ip -net "$ns" link set d0 up
-ip -net "$ns" addr add 10.1.2.1/24 dev d0
-
-#ip netns exec "$ns" tcpdump -npXi d0 &
+
+#ip netns exec "$netns" tcpdump -npXi d0 &
 #tcpdump_pid=$!
-#trap 'kill $tcpdump_pid; ip netns del $ns' EXIT
+#trap 'kill $tcpdump_pid; ip netns del $netns' EXIT
 
 add_rule() { # (alg, from, to)
-	ip netns exec "$ns" \
+	ip netns exec "$netns" \
 		iptables -A OUTPUT -o d0 -m string \
 			--string "$pattern" --algo $1 --from $2 --to $3
 }
 showrules() { # ()
-	ip netns exec "$ns" iptables -v -S OUTPUT | grep '^-A'
+	ip netns exec "$netns" iptables -v -S OUTPUT | grep '^-A'
 }
 zerorules() {
-	ip netns exec "$ns" iptables -Z OUTPUT
+	ip netns exec "$netns" iptables -Z OUTPUT
 }
 countrule() { # (pattern)
 	showrules | grep -c -- "$*"
@@ -51,7 +53,9 @@ send() { # (offset)
 		printf " "
 	  done
 	  printf "$pattern"
-	) | ip netns exec "$ns" nc -w 1 -u 10.1.2.2 27374
+	) > "$infile"
+
+	ip netns exec "$netns" socat -t 1 -u STDIN UDP-SENDTO:10.1.2.2:27374 < "$infile"
 }
 
 add_rule bm 1000 1500
@@ -125,4 +129,5 @@ if [ $(countrule -c 1) -ne 0 ]; then
 	((rc--))
 fi
 
+[ $rc -eq 0 ] && echo "PASS: string match tests"
 exit $rc
-- 
2.43.2


