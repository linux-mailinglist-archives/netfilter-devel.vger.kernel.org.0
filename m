Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2709FD2CEF
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Oct 2019 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfJJOwC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Oct 2019 10:52:02 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2391 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJOwC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:52:02 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25d9f4569809-229e5; Thu, 10 Oct 2019 22:51:21 +0800 (CST)
X-RM-TRANSID: 2ee25d9f4569809-229e5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75d9f4566e8f-c4fb8;
        Thu, 10 Oct 2019 22:51:20 +0800 (CST)
X-RM-TRANSID: 2ee75d9f4566e8f-c4fb8
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@verge.net.au>
Cc:     Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH v6 3/3] selftests: netfilter: add ipvs tunnel test case
Date:   Thu, 10 Oct 2019 22:50:55 +0800
Message-Id: <1570719055-25110-4-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570719055-25110-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1570719055-25110-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Test virtual server via ipip tunnel.

Tested:
# selftests: netfilter: ipvs.sh
# Testing DR mode...
# Testing NAT mode...
# Testing Tunnel mode...
# ipvs.sh: PASS
ok 6 selftests: netfilter: ipvs.sh

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
v2: optimize test script
---
 tools/testing/selftests/netfilter/ipvs.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/netfilter/ipvs.sh b/tools/testing/selftests/netfilter/ipvs.sh
index 8b2e618..c3b8f90 100755
--- a/tools/testing/selftests/netfilter/ipvs.sh
+++ b/tools/testing/selftests/netfilter/ipvs.sh
@@ -168,6 +168,30 @@ test_nat() {
 	test_service
 }
 
+test_tun() {
+	ip netns exec ns0 ip route add ${vip_v4} via ${gip_v4} dev br0
+
+	ip netns exec ns1 modprobe ipip
+	ip netns exec ns1 ip link set tunl0 up
+	ip netns exec ns1 sysctl -qw net.ipv4.ip_forward=0
+	ip netns exec ns1 sysctl -qw net.ipv4.conf.all.send_redirects=0
+	ip netns exec ns1 sysctl -qw net.ipv4.conf.default.send_redirects=0
+	ip netns exec ns1 ipvsadm -A -t ${vip_v4}:${port} -s rr
+	ip netns exec ns1 ipvsadm -a -i -t ${vip_v4}:${port} -r ${rip_v4}:${port}
+	ip netns exec ns1 ip addr add ${vip_v4}/32 dev lo:1
+
+	ip netns exec ns2 modprobe ipip
+	ip netns exec ns2 ip link set tunl0 up
+	ip netns exec ns2 sysctl -qw net.ipv4.conf.all.arp_ignore=1
+	ip netns exec ns2 sysctl -qw net.ipv4.conf.all.arp_announce=2
+	ip netns exec ns2 sysctl -qw net.ipv4.conf.all.rp_filter=0
+	ip netns exec ns2 sysctl -qw net.ipv4.conf.tunl0.rp_filter=0
+	ip netns exec ns2 sysctl -qw net.ipv4.conf.veth21.rp_filter=0
+	ip netns exec ns2 ip addr add ${vip_v4}/32 dev lo:1
+
+	test_service
+}
+
 run_tests() {
 	local errors=
 
@@ -183,6 +207,12 @@ run_tests() {
 	test_nat
 	errors=$(( $errors + $? ))
 
+	echo "Testing Tunnel mode..."
+	cleanup
+	setup
+	test_tun
+	errors=$(( $errors + $? ))
+
 	return $errors
 }
 
-- 
1.8.3.1



