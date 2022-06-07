Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06025338A3
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 May 2022 10:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiEYIiq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 May 2022 04:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiEYIip (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 May 2022 04:38:45 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7486D21E1A
        for <netfilter-devel@vger.kernel.org>; Wed, 25 May 2022 01:38:42 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:60146.350594788
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-101.229.165.113 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id 208B8280105;
        Wed, 25 May 2022 16:38:33 +0800 (CST)
X-189-SAVE-TO-SEND: +wenxu@chinatelecom.cn
Received: from  ([172.18.0.218])
        by app0025 with ESMTP id 4dd6e35138ac4b65b22020db0725b86c for pablo@netfilter.org;
        Wed, 25 May 2022 16:38:37 CST
X-Transaction-ID: 4dd6e35138ac4b65b22020db0725b86c
X-Real-From: wenxu@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: wenxu@chinatelecom.cn
From:   wenxu@chinatelecom.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org, wenxu@chinatelecom.cn
Subject: [PATCH nf-next v2] selftests: netfilter: flowtable vlan filtering bridge support
Date:   Wed, 25 May 2022 04:38:14 -0400
Message-Id: <1653467894-5724-1-git-send-email-wenxu@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@chinatelecom.cn>

Add vlan_filtering enabled bridge and vlan case.
Add a vlan_filtering bridge device to the Router1 (nsr1) container
and attach the veth0 device to the bridge. Set the IP address to
the bridge device to exercise the bridge forwarding path.
The veth0 add in the vlan 10 domain and the br0 also add in the
vlan 10 domain with untaged.

Signed-off-by: wenxu <wenxu@chinatelecom.cn>
---
v2: fix set up the br0
    change iif br0 to iifname br0 for br0 destroy
    All the test PASS
 
 tools/testing/selftests/netfilter/nft_flowtable.sh | 28 +++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/netfilter/nft_flowtable.sh b/tools/testing/selftests/netfilter/nft_flowtable.sh
index d4ffebb..13e03e3 100755
--- a/tools/testing/selftests/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/netfilter/nft_flowtable.sh
@@ -37,6 +37,7 @@ checktool "nft --version" "run test without nft tool"
 checktool "ip -Version" "run test without ip tool"
 checktool "which nc" "run test without nc (netcat)"
 checktool "ip netns add nsr1" "create net namespace"
+checktool "bridge -Version" "run test without bridge tool"
 
 ip netns add ns1
 ip netns add ns2
@@ -388,7 +389,7 @@ flush table ip nat
 table ip nat {
    chain prerouting {
       type nat hook prerouting priority 0; policy accept;
-      meta iif "br0" ip daddr 10.6.6.6 tcp dport 1666 counter dnat ip to 10.0.2.99:12345
+      meta iifname "br0" ip daddr 10.6.6.6 tcp dport 1666 counter dnat ip to 10.0.2.99:12345
    }
 
    chain postrouting {
@@ -431,12 +432,33 @@ else
 	ret=1
 fi
 
-# restore test topology (remove bridge and VLAN)
-ip -net nsr1 link set veth0 nomaster
+# Another test:
+# Add vlan filtering bridge interface br0 to Router1, with NAT and VLAN.
+ip -net nsr1 link set veth0.10 nomaster
 ip -net nsr1 link set veth0 down
 ip -net nsr1 link set veth0.10 down
 ip -net nsr1 link delete veth0.10 type vlan
 ip -net nsr1 link delete br0 type bridge
+ip -net nsr1 link add name br0 type bridge vlan_filtering 1
+ip -net nsr1 link set up dev veth0
+ip -net nsr1 link set veth0 master br0
+ip -net nsr1 link set up dev br0
+ip -net nsr1 addr add 10.0.1.1/24 dev br0
+bridge -n nsr1 vlan add dev veth0 vid 10 pvid
+bridge -n nsr1 vlan add dev br0 vid 10 pvid untagged self
+
+if test_tcp_forwarding_nat ns1 ns2; then
+	echo "PASS: flow offloaded for ns1/ns2 with vlan filtering bridge NAT and VLAN"
+else
+	echo "FAIL: flow offload for ns1/ns2 with vlan filtering bridge NAT and VLAN" 1>&2
+	ip netns exec nsr1 nft list ruleset
+	ret=1
+fi
+
+# restore test topology (remove bridge and VLAN)
+ip -net nsr1 link set veth0 nomaster
+ip -net nsr1 link set veth0 down
+ip -net nsr1 link delete br0 type bridge
 ip -net ns1 addr flush dev eth0.10
 ip -net ns1 link set eth0.10 down
 ip -net ns1 link set eth0 down
-- 
1.8.3.1

