Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457737B2015
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Sep 2023 16:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjI1Otg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Sep 2023 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjI1Otf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:49:35 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348F11AC;
        Thu, 28 Sep 2023 07:49:33 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qlsKX-0005UV-1j; Thu, 28 Sep 2023 16:49:29 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netdev@vger.kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        <netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 2/4] selftests: netfilter: test nat source port clash resolution interaction with tcp early demux
Date:   Thu, 28 Sep 2023 16:48:59 +0200
Message-ID: <20230928144916.18339-3-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928144916.18339-1-fw@strlen.de>
References: <20230928144916.18339-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Test that nat engine resolves the source port clash and tcp packet
is passed to the correct socket.

While at it, get rid of the iperf3 dependency, just use socat for
listener side too.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/netfilter/nf_nat_edemux.sh      | 46 +++++++++++++++----
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/netfilter/nf_nat_edemux.sh b/tools/testing/selftests/netfilter/nf_nat_edemux.sh
index 1092bbcb1fba..a1aa8f4a5828 100755
--- a/tools/testing/selftests/netfilter/nf_nat_edemux.sh
+++ b/tools/testing/selftests/netfilter/nf_nat_edemux.sh
@@ -11,16 +11,18 @@ ret=0
 sfx=$(mktemp -u "XXXXXXXX")
 ns1="ns1-$sfx"
 ns2="ns2-$sfx"
+socatpid=0
 
 cleanup()
 {
+	[ $socatpid -gt 0 ] && kill $socatpid
 	ip netns del $ns1
 	ip netns del $ns2
 }
 
-iperf3 -v > /dev/null 2>&1
+socat -h > /dev/null 2>&1
 if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without iperf3"
+	echo "SKIP: Could not run test without socat"
 	exit $ksft_skip
 fi
 
@@ -60,8 +62,8 @@ ip netns exec $ns2 ip link set up dev veth2
 ip netns exec $ns2 ip addr add 192.168.1.2/24 dev veth2
 
 # Create a server in one namespace
-ip netns exec $ns1 iperf3 -s > /dev/null 2>&1 &
-iperfs=$!
+ip netns exec $ns1 socat -u TCP-LISTEN:5201,fork OPEN:/dev/null,wronly=1 &
+socatpid=$!
 
 # Restrict source port to just one so we don't have to exhaust
 # all others.
@@ -83,17 +85,43 @@ sleep 1
 # ip daddr:dport will be rewritten to 192.168.1.1 5201
 # NAT must reallocate source port 10000 because
 # 192.168.1.2:10000 -> 192.168.1.1:5201 is already in use
-echo test | ip netns exec $ns2 socat -t 3 -u STDIN TCP:10.96.0.1:443 >/dev/null
+echo test | ip netns exec $ns2 socat -t 3 -u STDIN TCP:10.96.0.1:443,connect-timeout=3 >/dev/null
 ret=$?
 
-kill $iperfs
-
 # Check socat can connect to 10.96.0.1:443 (aka 192.168.1.1:5201).
 if [ $ret -eq 0 ]; then
 	echo "PASS: socat can connect via NAT'd address"
 else
 	echo "FAIL: socat cannot connect via NAT'd address"
-	exit 1
 fi
 
-exit 0
+# check sport clashres.
+ip netns exec $ns1 iptables -t nat -A PREROUTING -p tcp --dport 5202 -j REDIRECT --to-ports 5201
+ip netns exec $ns1 iptables -t nat -A PREROUTING -p tcp --dport 5203 -j REDIRECT --to-ports 5201
+
+sleep 5 | ip netns exec $ns2 socat -t 5 -u STDIN TCP:192.168.1.1:5202,connect-timeout=5 >/dev/null &
+cpid1=$!
+sleep 1
+
+# if connect succeeds, client closes instantly due to EOF on stdin.
+# if connect hangs, it will time out after 5s.
+echo | ip netns exec $ns2 socat -t 3 -u STDIN TCP:192.168.1.1:5203,connect-timeout=5 >/dev/null &
+cpid2=$!
+
+time_then=$(date +%s)
+wait $cpid2
+rv=$?
+time_now=$(date +%s)
+
+# Check how much time has elapsed, expectation is for
+# 'cpid2' to connect and then exit (and no connect delay).
+delta=$((time_now - time_then))
+
+if [ $delta -lt 2 -a $rv -eq 0 ]; then
+	echo "PASS: could connect to service via redirected ports"
+else
+	echo "FAIL: socat cannot connect to service via redirect ($delta seconds elapsed, returned $rv)"
+	ret=1
+fi
+
+exit $ret
-- 
2.41.0

