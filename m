Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E480343C779
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Oct 2021 12:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhJ0KTs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Oct 2021 06:19:48 -0400
Received: from mail.netfilter.org ([217.70.188.207]:47988 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhJ0KTr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:19:47 -0400
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 35C0363F21;
        Wed, 27 Oct 2021 12:15:33 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     lukas@wunner.de
Subject: [PATCH nft] src: Support netdev egress hook
Date:   Wed, 27 Oct 2021 12:17:15 +0200
Message-Id: <20211027101715.47905-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

Add userspace support for the newly introduced netdev egress hook
with documentation and tests.  Usage is identical to the ingress hook.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Hi Lukas,

This is the rebase I'm using here locally for testing, let me know if
you have more pending updates on your side.

 doc/nft.txt                                   |   19 +-
 doc/statements.txt                            |    4 +-
 include/linux/netfilter.h                     |    1 +
 src/evaluate.c                                |    2 +
 src/rule.c                                    |    3 +
 tests/py/any/dup.t                            |    3 +-
 tests/py/any/icmpX.t.netdev                   |    3 +-
 tests/py/any/limit.t                          |    3 +-
 tests/py/any/meta.t                           |    3 +-
 tests/py/any/objects.t                        |    3 +-
 tests/py/any/quota.t                          |    3 +-
 tests/py/any/rawpayload.t                     |    3 +-
 tests/py/arp/arp.t                            |    3 +-
 tests/py/bridge/vlan.t                        |    3 +-
 tests/py/inet/ah.t                            |    2 +
 tests/py/inet/comp.t                          |    3 +-
 tests/py/inet/dccp.t                          |    3 +-
 tests/py/inet/esp.t                           |    3 +-
 tests/py/inet/ether-ip.t                      |    3 +-
 tests/py/inet/ether.t                         |    3 +-
 tests/py/inet/ip.t                            |    3 +-
 tests/py/inet/ip.t.payload.netdev             |   14 +
 tests/py/inet/ip_tcp.t                        |    3 +-
 tests/py/inet/map.t                           |    3 +-
 tests/py/inet/sctp.t                          |    3 +-
 tests/py/inet/sets.t                          |    3 +-
 tests/py/inet/tcp.t                           |    3 +-
 tests/py/inet/udp.t                           |    3 +-
 tests/py/inet/udplite.t                       |    3 +-
 tests/py/ip/ip.t                              |    3 +-
 tests/py/ip/ip_tcp.t                          |    2 +
 tests/py/ip/ip_tcp.t.payload.netdev           |   93 +
 tests/py/ip/sets.t                            |    3 +-
 tests/py/ip6/frag.t                           |    2 +
 tests/py/ip6/frag.t.payload.netdev            | 2186 +++++++++++++++++
 tests/py/ip6/sets.t                           |    3 +-
 tests/py/ip6/vmap.t                           |    3 +-
 tests/shell/testcases/chains/0021prio_0       |    1 +
 .../shell/testcases/chains/0026prio_netdev_1  |    4 +-
 .../testcases/chains/dumps/0021prio_0.nft     |   20 +
 40 files changed, 2395 insertions(+), 36 deletions(-)
 create mode 100644 tests/py/ip/ip_tcp.t.payload.netdev
 create mode 100644 tests/py/ip6/frag.t.payload.netdev

diff --git a/doc/nft.txt b/doc/nft.txt
index c9bb901b85b9..d11947a5d153 100644
--- a/doc/nft.txt
+++ b/doc/nft.txt
@@ -193,7 +193,7 @@ packet processing paths, which invoke nftables if rules for these hooks exist.
 *inet*:: Internet (IPv4/IPv6) address family.
 *arp*:: ARP address family, handling IPv4 ARP packets.
 *bridge*:: Bridge address family, handling packets which traverse a bridge device.
-*netdev*:: Netdev address family, handling packets from ingress.
+*netdev*:: Netdev address family, handling packets on ingress and egress.
 
 All nftables objects exist in address family specific namespaces, therefore all
 identifiers include an address family. If an identifier is specified without an
@@ -251,9 +251,9 @@ The list of supported hooks is identical to IPv4/IPv6/Inet address families abov
 
 NETDEV ADDRESS FAMILY
 ~~~~~~~~~~~~~~~~~~~~
-The Netdev address family handles packets from the device ingress path. This
-family allows you to filter packets of any ethertype such as ARP, VLAN 802.1q,
-VLAN 802.1ad (Q-in-Q) as well as IPv4 and IPv6 packets.
+The Netdev address family handles packets from the device ingress and egress
+path. This family allows you to filter packets of any ethertype such as ARP,
+VLAN 802.1q, VLAN 802.1ad (Q-in-Q) as well as IPv4 and IPv6 packets.
 
 .Netdev address family hooks
 [options="header"]
@@ -263,6 +263,10 @@ VLAN 802.1ad (Q-in-Q) as well as IPv4 and IPv6 packets.
 All packets entering the system are processed by this hook. It is invoked after
 the network taps (ie. *tcpdump*), right after *tc* ingress and before layer 3
 protocol handlers, it can be used for early filtering and policing.
+|egress |
+All packets leaving the system are processed by this hook. It is invoked after
+layer 3 protocol handlers and after *tc* egress. It can be used for late
+filtering and policing.
 |=================
 
 RULESET
@@ -388,9 +392,10 @@ Apart from the special cases illustrated above (e.g. *nat* type not supporting
 *forward* hook or *route* type only supporting *output* hook), there are three
 further quirks worth noticing:
 
-* The netdev family supports merely a single combination, namely *filter* type and
-  *ingress* hook. Base chains in this family also require the *device* parameter
-  to be present since they exist per incoming interface only.
+* The netdev family supports merely two combinations, namely *filter* type with
+  *ingress* hook and *filter* type with *egress* hook. Base chains in this
+  family also require the *device* parameter to be present since they exist per
+  interface only.
 * The arp family supports only the *input* and *output* hooks, both in chains of type
   *filter*.
 * The inet family also supports the *ingress* hook (since Linux kernel 5.10),
diff --git a/doc/statements.txt b/doc/statements.txt
index d402da7061a1..30abde3788f2 100644
--- a/doc/statements.txt
+++ b/doc/statements.txt
@@ -668,8 +668,8 @@ dup to ip daddr map { 192.168.7.1 : "eth0", 192.168.7.2 : "eth1" }
 FWD STATEMENT
 ~~~~~~~~~~~~~
 The fwd statement is used to redirect a raw packet to another interface. It is
-only available in the netdev family ingress hook. It is similar to the dup
-statement except that no copy is made.
+only available in the netdev family ingress and egress hooks. It is similar to
+the dup statement except that no copy is made.
 
 *fwd to* 'device'
 
diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index feb6287c5979..9e07888013e8 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -54,6 +54,7 @@ enum nf_inet_hooks {
 
 enum nf_dev_hooks {
 	NF_NETDEV_INGRESS,
+	NF_NETDEV_EGRESS,
 	NF_NETDEV_NUMHOOKS
 };
 
diff --git a/src/evaluate.c b/src/evaluate.c
index 0bc799eb8e7c..609e171d8993 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4310,6 +4310,8 @@ static uint32_t str2hooknum(uint32_t family, const char *hook)
 	case NFPROTO_NETDEV:
 		if (!strcmp(hook, "ingress"))
 			return NF_NETDEV_INGRESS;
+		else if (!strcmp(hook, "egress"))
+			return NF_NETDEV_EGRESS;
 		break;
 	default:
 		break;
diff --git a/src/rule.c b/src/rule.c
index 7c048fcc1eee..c7bc6bcf3496 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -675,6 +675,7 @@ static const char * const chain_hookname_str_array[] = {
 	"postrouting",
 	"output",
 	"ingress",
+	"egress",
 	NULL,
 };
 
@@ -832,6 +833,8 @@ const char *hooknum2str(unsigned int family, unsigned int hooknum)
 		switch (hooknum) {
 		case NF_NETDEV_INGRESS:
 			return "ingress";
+		case NF_NETDEV_EGRESS:
+			return "egress";
 		}
 		break;
 	default:
diff --git a/tests/py/any/dup.t b/tests/py/any/dup.t
index 181b4195f7c2..56328022f5ac 100644
--- a/tests/py/any/dup.t
+++ b/tests/py/any/dup.t
@@ -1,6 +1,7 @@
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 dup to "lo";ok
 dup to meta mark map { 0x00000001 : "lo", 0x00000002 : "lo"};ok
diff --git a/tests/py/any/icmpX.t.netdev b/tests/py/any/icmpX.t.netdev
index a327ce6ae307..cf402428650f 100644
--- a/tests/py/any/icmpX.t.netdev
+++ b/tests/py/any/icmpX.t.netdev
@@ -1,6 +1,7 @@
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 ip protocol icmp icmp type echo-request;ok;icmp type echo-request
 icmp type echo-request;ok
diff --git a/tests/py/any/limit.t b/tests/py/any/limit.t
index ef7f93133297..0110e77f2e85 100644
--- a/tests/py/any/limit.t
+++ b/tests/py/any/limit.t
@@ -1,12 +1,13 @@
 :output;type filter hook output priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;output
 *ip6;test-ip6;output
 *inet;test-inet;output
 *arp;test-arp;output
 *bridge;test-bridge;output
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 limit rate 400/minute;ok
 limit rate 20/second;ok
diff --git a/tests/py/any/meta.t b/tests/py/any/meta.t
index 6ec4853eee4f..fcf4292d63c0 100644
--- a/tests/py/any/meta.t
+++ b/tests/py/any/meta.t
@@ -1,12 +1,13 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *ip6;test-ip6;input
 *inet;test-inet;input
 *arp;test-arp;input
 *bridge;test-bridge;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 meta length 1000;ok
 meta length 22;ok
diff --git a/tests/py/any/objects.t b/tests/py/any/objects.t
index 89a9545fe952..7b51f918166b 100644
--- a/tests/py/any/objects.t
+++ b/tests/py/any/objects.t
@@ -1,12 +1,13 @@
 :output;type filter hook output priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;output
 *ip6;test-ip6;output
 *inet;test-inet;output
 *arp;test-arp;output
 *bridge;test-bridge;output
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 %cnt1 type counter;ok
 %qt1 type quota 25 mbytes;ok
diff --git a/tests/py/any/quota.t b/tests/py/any/quota.t
index 9a8db11421dd..79dd76543f5a 100644
--- a/tests/py/any/quota.t
+++ b/tests/py/any/quota.t
@@ -1,12 +1,13 @@
 :output;type filter hook output priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;output
 *ip6;test-ip6;output
 *inet;test-inet;output
 *arp;test-arp;output
 *bridge;test-bridge;output
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 quota 1025 bytes;ok
 quota 1 kbytes;ok
diff --git a/tests/py/any/rawpayload.t b/tests/py/any/rawpayload.t
index c3382a96876c..9687729d610d 100644
--- a/tests/py/any/rawpayload.t
+++ b/tests/py/any/rawpayload.t
@@ -1,8 +1,9 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 meta l4proto { tcp, udp, sctp} @th,16,16 { 22, 23, 80 };ok;meta l4proto { 6, 17, 132} th dport { 22, 23, 80}
 meta l4proto tcp @th,16,16 { 22, 23, 80};ok;tcp dport { 22, 23, 80}
diff --git a/tests/py/arp/arp.t b/tests/py/arp/arp.t
index 178cf82b65ed..222b91cf0845 100644
--- a/tests/py/arp/arp.t
+++ b/tests/py/arp/arp.t
@@ -1,9 +1,10 @@
 # filter chains available are: input, output, forward
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *arp;test-arp;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 arp htype 1;ok
 arp htype != 1;ok
diff --git a/tests/py/bridge/vlan.t b/tests/py/bridge/vlan.t
index b506ee8df6bd..924ed4ed3679 100644
--- a/tests/py/bridge/vlan.t
+++ b/tests/py/bridge/vlan.t
@@ -1,8 +1,9 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *bridge;test-bridge;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 vlan id 4094;ok
 vlan id 0;ok
diff --git a/tests/py/inet/ah.t b/tests/py/inet/ah.t
index 78c454f76bbe..b3bcbcd50a50 100644
--- a/tests/py/inet/ah.t
+++ b/tests/py/inet/ah.t
@@ -1,10 +1,12 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook ingress device lo priority 0
 
 *ip;test-ip4;input
 *ip6;test-ip6;input
 *inet;test-inet;input
 *netdev;test-netdev;ingress
+*netdev;test-netdev;egress
 
 - ah nexthdr esp;ok
 - ah nexthdr ah;ok
diff --git a/tests/py/inet/comp.t b/tests/py/inet/comp.t
index ec9924ff1c71..2ef53820356e 100644
--- a/tests/py/inet/comp.t
+++ b/tests/py/inet/comp.t
@@ -1,10 +1,11 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *ip6;test-ip6;input
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 # BUG: nft: payload.c:88: payload_expr_pctx_update: Assertion `left->payload.base + 1 <= (__PROTO_BASE_MAX - 1)' failed.
 - comp nexthdr esp;ok;comp nexthdr 50
diff --git a/tests/py/inet/dccp.t b/tests/py/inet/dccp.t
index 2216fa2aed6d..90142f53254e 100644
--- a/tests/py/inet/dccp.t
+++ b/tests/py/inet/dccp.t
@@ -1,10 +1,11 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *ip6;test-ip6;input
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 dccp sport 21-35;ok
 dccp sport != 21-35;ok
diff --git a/tests/py/inet/esp.t b/tests/py/inet/esp.t
index 58e9f884724b..536260cf4b3d 100644
--- a/tests/py/inet/esp.t
+++ b/tests/py/inet/esp.t
@@ -1,10 +1,11 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *ip6;test-ip6;input
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 esp spi 100;ok
 esp spi != 100;ok
diff --git a/tests/py/inet/ether-ip.t b/tests/py/inet/ether-ip.t
index 0c8c7f9d60b6..759124ded662 100644
--- a/tests/py/inet/ether-ip.t
+++ b/tests/py/inet/ether-ip.t
@@ -1,8 +1,9 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 tcp dport 22 iiftype ether ip daddr 1.2.3.4 ether saddr 00:0f:54:0c:11:4 accept;ok;tcp dport 22 ether saddr 00:0f:54:0c:11:04 ip daddr 1.2.3.4 accept
 tcp dport 22 ip daddr 1.2.3.4 ether saddr 00:0f:54:0c:11:04;ok
diff --git a/tests/py/inet/ether.t b/tests/py/inet/ether.t
index afdf8b89ca65..c4b1ced7a685 100644
--- a/tests/py/inet/ether.t
+++ b/tests/py/inet/ether.t
@@ -1,11 +1,12 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *ip6;test-ip6;input
 *inet;test-inet;input
 *bridge;test-bridge;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 tcp dport 22 iiftype ether ether saddr 00:0f:54:0c:11:4 accept;ok;tcp dport 22 ether saddr 00:0f:54:0c:11:04 accept
 tcp dport 22 ether saddr 00:0f:54:0c:11:04 accept;ok
diff --git a/tests/py/inet/ip.t b/tests/py/inet/ip.t
index ac5b825e4a34..bdb3330ccb58 100644
--- a/tests/py/inet/ip.t
+++ b/tests/py/inet/ip.t
@@ -1,10 +1,11 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *inet;test-inet;input
 *bridge;test-bridge;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 ip saddr . ip daddr . ether saddr { 1.1.1.1 . 2.2.2.2 . ca:fe:ca:fe:ca:fe };ok
 ip saddr vmap { 10.0.1.0-10.0.1.255 : accept, 10.0.1.1-10.0.2.255 : drop };fail
diff --git a/tests/py/inet/ip.t.payload.netdev b/tests/py/inet/ip.t.payload.netdev
index 95be9194f2fe..38ed0ad316e4 100644
--- a/tests/py/inet/ip.t.payload.netdev
+++ b/tests/py/inet/ip.t.payload.netdev
@@ -12,3 +12,17 @@ netdev test-netdev ingress
   [ payload load 6b @ link header + 6 => reg 10 ]
   [ lookup reg 1 set __set%d ]
 
+# meta protocol ip ip saddr . ip daddr . ether saddr { 1.1.1.1 . 2.2.2.2 . ca:fe:ca:fe:ca:fe }
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 01010101 02020202 fecafeca 0000feca  : 0 [end]
+netdev test-netdev egress 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000008 ]
+  [ meta load iiftype => reg 1 ]
+  [ cmp eq reg 1 0x00000001 ]
+  [ payload load 4b @ network header + 12 => reg 1 ]
+  [ payload load 4b @ network header + 16 => reg 9 ]
+  [ payload load 6b @ link header + 6 => reg 10 ]
+  [ lookup reg 1 set __set%d ]
+
diff --git a/tests/py/inet/ip_tcp.t b/tests/py/inet/ip_tcp.t
index f2a28ebdd531..ab76ffa90a9c 100644
--- a/tests/py/inet/ip_tcp.t
+++ b/tests/py/inet/ip_tcp.t
@@ -1,9 +1,10 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *inet;test-inet;input
 *bridge;test-bridge;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 # must not remove ip dependency -- ONLY ipv4 packets should be matched
 ip protocol tcp tcp dport 22;ok;ip protocol 6 tcp dport 22
diff --git a/tests/py/inet/map.t b/tests/py/inet/map.t
index e83490a8c7ef..5a7161b77ad4 100644
--- a/tests/py/inet/map.t
+++ b/tests/py/inet/map.t
@@ -1,9 +1,10 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 mark set ip saddr map { 10.2.3.2 : 0x0000002a, 10.2.3.1 : 0x00000017};ok;meta mark set ip saddr map { 10.2.3.1 : 0x00000017, 10.2.3.2 : 0x0000002a}
 mark set ip hdrlength map { 5 : 0x00000017, 4 : 0x00000001};ok;meta mark set ip hdrlength map { 4 : 0x00000001, 5 : 0x00000017}
diff --git a/tests/py/inet/sctp.t b/tests/py/inet/sctp.t
index 57b9e67bb74e..016173b93d8a 100644
--- a/tests/py/inet/sctp.t
+++ b/tests/py/inet/sctp.t
@@ -1,10 +1,11 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *ip6;test-ip6;input
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 sctp sport 23;ok
 sctp sport != 23;ok
diff --git a/tests/py/inet/sets.t b/tests/py/inet/sets.t
index 1c6f32355acf..5b22e1fea80d 100644
--- a/tests/py/inet/sets.t
+++ b/tests/py/inet/sets.t
@@ -1,9 +1,10 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *inet;test-inet;input
 *bridge;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 !set1 type ipv4_addr timeout 60s;ok
 ?set1 192.168.3.4 timeout 30s, 10.2.1.1;ok
diff --git a/tests/py/inet/tcp.t b/tests/py/inet/tcp.t
index aa07c3ba8ca7..f51ebd36b503 100644
--- a/tests/py/inet/tcp.t
+++ b/tests/py/inet/tcp.t
@@ -1,10 +1,11 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *ip6;test-ip6;input
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 tcp dport set {1, 2, 3};fail
 
diff --git a/tests/py/inet/udp.t b/tests/py/inet/udp.t
index c434f2edffb1..7f21c8ed289b 100644
--- a/tests/py/inet/udp.t
+++ b/tests/py/inet/udp.t
@@ -1,10 +1,11 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *ip6;test-ip6;input
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 udp sport 80 accept;ok
 udp sport != 60 accept;ok
diff --git a/tests/py/inet/udplite.t b/tests/py/inet/udplite.t
index a8fdc8eae72c..6a54709cd920 100644
--- a/tests/py/inet/udplite.t
+++ b/tests/py/inet/udplite.t
@@ -1,10 +1,11 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *ip6;test-ip6;input
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 udplite sport 80 accept;ok
 udplite sport != 60 accept;ok
diff --git a/tests/py/ip/ip.t b/tests/py/ip/ip.t
index f4a3667ceab5..d5a4d8a5e46e 100644
--- a/tests/py/ip/ip.t
+++ b/tests/py/ip/ip.t
@@ -1,10 +1,11 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *inet;test-inet;input
 *bridge;test-bridge;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 - ip version 2;ok
 
diff --git a/tests/py/ip/ip_tcp.t b/tests/py/ip/ip_tcp.t
index 467da3ef2932..646b0ca50207 100644
--- a/tests/py/ip/ip_tcp.t
+++ b/tests/py/ip/ip_tcp.t
@@ -1,7 +1,9 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip;input
+*netdev;test-netdev;ingress,egress
 
 # can remove ip dependency -- its redundant in ip family
 ip protocol tcp tcp dport 22;ok;tcp dport 22
diff --git a/tests/py/ip/ip_tcp.t.payload.netdev b/tests/py/ip/ip_tcp.t.payload.netdev
new file mode 100644
index 000000000000..74dc1195aeb0
--- /dev/null
+++ b/tests/py/ip/ip_tcp.t.payload.netdev
@@ -0,0 +1,93 @@
+# ip protocol tcp tcp dport 22
+netdev test-netdev ingress 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000008 ]
+  [ payload load 1b @ network header + 9 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+  [ payload load 2b @ transport header + 2 => reg 1 ]
+  [ cmp eq reg 1 0x00001600 ]
+
+# ip protocol tcp meta mark set 1 tcp dport 22
+netdev test-netdev ingress 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000008 ]
+  [ payload load 1b @ network header + 9 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+  [ immediate reg 1 0x00000001 ]
+  [ meta set mark with reg 1 ]
+  [ payload load 2b @ transport header + 2 => reg 1 ]
+  [ cmp eq reg 1 0x00001600 ]
+
+# ip protocol tcp meta mark set 1 tcp dport 22
+netdev test-netdev egress 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000008 ]
+  [ payload load 1b @ network header + 9 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+  [ immediate reg 1 0x00000001 ]
+  [ meta set mark with reg 1 ]
+  [ payload load 2b @ transport header + 2 => reg 1 ]
+  [ cmp eq reg 1 0x00001600 ]
+
+# ip protocol tcp tcp dport 22
+netdev test-netdev ingress 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000008 ]
+  [ payload load 1b @ network header + 9 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+  [ payload load 2b @ transport header + 2 => reg 1 ]
+  [ cmp eq reg 1 0x00001600 ]
+
+# ip protocol tcp meta mark set 1 tcp dport 22
+netdev test-netdev ingress 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000008 ]
+  [ payload load 1b @ network header + 9 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+  [ immediate reg 1 0x00000001 ]
+  [ meta set mark with reg 1 ]
+  [ payload load 2b @ transport header + 2 => reg 1 ]
+  [ cmp eq reg 1 0x00001600 ]
+
+# ip protocol tcp meta mark set 1 tcp dport 22
+netdev test-netdev egress 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000008 ]
+  [ payload load 1b @ network header + 9 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+  [ immediate reg 1 0x00000001 ]
+  [ meta set mark with reg 1 ]
+  [ payload load 2b @ transport header + 2 => reg 1 ]
+  [ cmp eq reg 1 0x00001600 ]
+
+# ip protocol tcp tcp dport 22
+netdev test-netdev ingress 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000008 ]
+  [ payload load 1b @ network header + 9 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+  [ payload load 2b @ transport header + 2 => reg 1 ]
+  [ cmp eq reg 1 0x00001600 ]
+
+# ip protocol tcp meta mark set 1 tcp dport 22
+netdev test-netdev ingress 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000008 ]
+  [ payload load 1b @ network header + 9 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+  [ immediate reg 1 0x00000001 ]
+  [ meta set mark with reg 1 ]
+  [ payload load 2b @ transport header + 2 => reg 1 ]
+  [ cmp eq reg 1 0x00001600 ]
+
+# ip protocol tcp meta mark set 1 tcp dport 22
+netdev test-netdev egress 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000008 ]
+  [ payload load 1b @ network header + 9 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+  [ immediate reg 1 0x00000001 ]
+  [ meta set mark with reg 1 ]
+  [ payload load 2b @ transport header + 2 => reg 1 ]
+  [ cmp eq reg 1 0x00001600 ]
+
diff --git a/tests/py/ip/sets.t b/tests/py/ip/sets.t
index 7dc884fc69f1..a224d0fef13d 100644
--- a/tests/py/ip/sets.t
+++ b/tests/py/ip/sets.t
@@ -1,9 +1,10 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip;test-ip4;input
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 !w type ipv4_addr;ok
 !x type inet_proto;ok
diff --git a/tests/py/ip6/frag.t b/tests/py/ip6/frag.t
index 945398dbc7d1..6bbd6ac08181 100644
--- a/tests/py/ip6/frag.t
+++ b/tests/py/ip6/frag.t
@@ -1,8 +1,10 @@
 :output;type filter hook output priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip6;test-ip6;output
 *inet;test-inet;output
+*netdev;test-netdev;ingress,egress
 
 frag nexthdr tcp;ok;frag nexthdr 6
 frag nexthdr != icmp;ok;frag nexthdr != 1
diff --git a/tests/py/ip6/frag.t.payload.netdev b/tests/py/ip6/frag.t.payload.netdev
new file mode 100644
index 000000000000..821d567902cc
--- /dev/null
+++ b/tests/py/ip6/frag.t.payload.netdev
@@ -0,0 +1,2186 @@
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag nexthdr tcp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+
+# frag nexthdr tcp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+
+# frag nexthdr != icmp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp neq reg 1 0x00000001 ]
+
+# frag nexthdr != icmp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp neq reg 1 0x00000001 ]
+
+# frag nexthdr {esp, ah, comp, udp, udplite, tcp, dccp, sctp}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000032  : 0 [end]	element 00000033  : 0 [end]	element 0000006c  : 0 [end]	element 00000011  : 0 [end]	element 00000088  : 0 [end]	element 00000006  : 0 [end]	element 00000021  : 0 [end]	element 00000084  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag nexthdr {esp, ah, comp, udp, udplite, tcp, dccp, sctp}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000032  : 0 [end]	element 00000033  : 0 [end]	element 0000006c  : 0 [end]	element 00000011  : 0 [end]	element 00000088  : 0 [end]	element 00000006  : 0 [end]	element 00000021  : 0 [end]	element 00000084  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag nexthdr != {esp, ah, comp, udp, udplite, tcp, dccp, sctp}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000032  : 0 [end]	element 00000033  : 0 [end]	element 0000006c  : 0 [end]	element 00000011  : 0 [end]	element 00000088  : 0 [end]	element 00000006  : 0 [end]	element 00000021  : 0 [end]	element 00000084  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag nexthdr != {esp, ah, comp, udp, udplite, tcp, dccp, sctp}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000032  : 0 [end]	element 00000033  : 0 [end]	element 0000006c  : 0 [end]	element 00000011  : 0 [end]	element 00000088  : 0 [end]	element 00000006  : 0 [end]	element 00000021  : 0 [end]	element 00000084  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag nexthdr esp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000032 ]
+
+# frag nexthdr esp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000032 ]
+
+# frag nexthdr ah
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000033 ]
+
+# frag nexthdr ah
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000033 ]
+
+# frag reserved 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp eq reg 1 0x00000016 ]
+
+# frag reserved 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp eq reg 1 0x00000016 ]
+
+# frag reserved != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp neq reg 1 0x000000e9 ]
+
+# frag reserved != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp neq reg 1 0x000000e9 ]
+
+# frag reserved 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp gte reg 1 0x00000021 ]
+  [ cmp lte reg 1 0x0000002d ]
+
+# frag reserved 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp gte reg 1 0x00000021 ]
+  [ cmp lte reg 1 0x0000002d ]
+
+# frag reserved != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ range neq reg 1 0x00000021 0x0000002d ]
+
+# frag reserved != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ range neq reg 1 0x00000021 0x0000002d ]
+
+# frag reserved { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000021  : 0 [end]	element 00000037  : 0 [end]	element 00000043  : 0 [end]	element 00000058  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag reserved { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000021  : 0 [end]	element 00000037  : 0 [end]	element 00000043  : 0 [end]	element 00000058  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag reserved != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000021  : 0 [end]	element 00000037  : 0 [end]	element 00000043  : 0 [end]	element 00000058  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000021  : 0 [end]	element 00000037  : 0 [end]	element 00000043  : 0 [end]	element 00000058  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000021  : 0 [end]	element 00000038  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag reserved { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000021  : 0 [end]	element 00000038  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag reserved != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000021  : 0 [end]	element 00000038  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000021  : 0 [end]	element 00000038  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag id 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp eq reg 1 0x01000000 ]
+
+# frag id 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp eq reg 1 0x01000000 ]
+
+# frag id 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp eq reg 1 0x16000000 ]
+
+# frag id 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp eq reg 1 0x16000000 ]
+
+# frag id != 33
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp neq reg 1 0x21000000 ]
+
+# frag id != 33
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp neq reg 1 0x21000000 ]
+
+# frag id 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp gte reg 1 0x21000000 ]
+  [ cmp lte reg 1 0x2d000000 ]
+
+# frag id 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp gte reg 1 0x21000000 ]
+  [ cmp lte reg 1 0x2d000000 ]
+
+# frag id != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ range neq reg 1 0x21000000 0x2d000000 ]
+
+# frag id != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ range neq reg 1 0x21000000 0x2d000000 ]
+
+# frag id { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 21000000  : 0 [end]	element 37000000  : 0 [end]	element 43000000  : 0 [end]	element 58000000  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag id { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 21000000  : 0 [end]	element 37000000  : 0 [end]	element 43000000  : 0 [end]	element 58000000  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag id != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 21000000  : 0 [end]	element 37000000  : 0 [end]	element 43000000  : 0 [end]	element 58000000  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag id != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 21000000  : 0 [end]	element 37000000  : 0 [end]	element 43000000  : 0 [end]	element 58000000  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag id { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 21000000  : 0 [end]	element 38000000  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag id { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 21000000  : 0 [end]	element 38000000  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag id != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 21000000  : 0 [end]	element 38000000  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag id != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 21000000  : 0 [end]	element 38000000  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag nexthdr tcp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+
+# frag nexthdr tcp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+
+# frag nexthdr != icmp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp neq reg 1 0x00000001 ]
+
+# frag nexthdr != icmp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp neq reg 1 0x00000001 ]
+
+# frag nexthdr {esp, ah, comp, udp, udplite, tcp, dccp, sctp}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000032  : 0 [end]	element 00000033  : 0 [end]	element 0000006c  : 0 [end]	element 00000011  : 0 [end]	element 00000088  : 0 [end]	element 00000006  : 0 [end]	element 00000021  : 0 [end]	element 00000084  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag nexthdr {esp, ah, comp, udp, udplite, tcp, dccp, sctp}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000032  : 0 [end]	element 00000033  : 0 [end]	element 0000006c  : 0 [end]	element 00000011  : 0 [end]	element 00000088  : 0 [end]	element 00000006  : 0 [end]	element 00000021  : 0 [end]	element 00000084  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag nexthdr != {esp, ah, comp, udp, udplite, tcp, dccp, sctp}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000032  : 0 [end]	element 00000033  : 0 [end]	element 0000006c  : 0 [end]	element 00000011  : 0 [end]	element 00000088  : 0 [end]	element 00000006  : 0 [end]	element 00000021  : 0 [end]	element 00000084  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag nexthdr != {esp, ah, comp, udp, udplite, tcp, dccp, sctp}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000032  : 0 [end]	element 00000033  : 0 [end]	element 0000006c  : 0 [end]	element 00000011  : 0 [end]	element 00000088  : 0 [end]	element 00000006  : 0 [end]	element 00000021  : 0 [end]	element 00000084  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag nexthdr esp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000032 ]
+
+# frag nexthdr esp
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000032 ]
+
+# frag nexthdr ah
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000033 ]
+
+# frag nexthdr ah
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000033 ]
+
+# frag reserved 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp eq reg 1 0x00000016 ]
+
+# frag reserved 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp eq reg 1 0x00000016 ]
+
+# frag reserved != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp neq reg 1 0x000000e9 ]
+
+# frag reserved != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp neq reg 1 0x000000e9 ]
+
+# frag reserved 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp gte reg 1 0x00000021 ]
+  [ cmp lte reg 1 0x0000002d ]
+
+# frag reserved 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ cmp gte reg 1 0x00000021 ]
+  [ cmp lte reg 1 0x0000002d ]
+
+# frag reserved != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ range neq reg 1 0x00000021 0x0000002d ]
+
+# frag reserved != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ range neq reg 1 0x00000021 0x0000002d ]
+
+# frag reserved { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000021  : 0 [end]	element 00000037  : 0 [end]	element 00000043  : 0 [end]	element 00000058  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag reserved { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000021  : 0 [end]	element 00000037  : 0 [end]	element 00000043  : 0 [end]	element 00000058  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag reserved != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000021  : 0 [end]	element 00000037  : 0 [end]	element 00000043  : 0 [end]	element 00000058  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000021  : 0 [end]	element 00000037  : 0 [end]	element 00000043  : 0 [end]	element 00000058  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000021  : 0 [end]	element 00000038  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag reserved { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000021  : 0 [end]	element 00000038  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag reserved != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000021  : 0 [end]	element 00000038  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000021  : 0 [end]	element 00000038  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 1 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag id 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp eq reg 1 0x01000000 ]
+
+# frag id 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp eq reg 1 0x01000000 ]
+
+# frag id 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp eq reg 1 0x16000000 ]
+
+# frag id 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp eq reg 1 0x16000000 ]
+
+# frag id != 33
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp neq reg 1 0x21000000 ]
+
+# frag id != 33
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp neq reg 1 0x21000000 ]
+
+# frag id 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp gte reg 1 0x21000000 ]
+  [ cmp lte reg 1 0x2d000000 ]
+
+# frag id 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ cmp gte reg 1 0x21000000 ]
+  [ cmp lte reg 1 0x2d000000 ]
+
+# frag id != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ range neq reg 1 0x21000000 0x2d000000 ]
+
+# frag id != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ range neq reg 1 0x21000000 0x2d000000 ]
+
+# frag id { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 21000000  : 0 [end]	element 37000000  : 0 [end]	element 43000000  : 0 [end]	element 58000000  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag id { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 21000000  : 0 [end]	element 37000000  : 0 [end]	element 43000000  : 0 [end]	element 58000000  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag id != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 21000000  : 0 [end]	element 37000000  : 0 [end]	element 43000000  : 0 [end]	element 58000000  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag id != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 21000000  : 0 [end]	element 37000000  : 0 [end]	element 43000000  : 0 [end]	element 58000000  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag id { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 21000000  : 0 [end]	element 38000000  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag id { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 21000000  : 0 [end]	element 38000000  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag id != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 21000000  : 0 [end]	element 38000000  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag id != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 21000000  : 0 [end]	element 38000000  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 4b @ 44 + 4 => reg 1 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off 22
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x0000b000 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off != 233
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp neq reg 1 0x00004807 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ cmp gte reg 1 0x00000801 ]
+  [ cmp lte reg 1 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off != 33-45
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ range neq reg 1 0x00000801 0x00006801 ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33, 55, 67, 88}
+__set%d test-netdev 3
+__set%d test-netdev 0
+	element 00000801  : 0 [end]	element 0000b801  : 0 [end]	element 00001802  : 0 [end]	element 0000c002  : 0 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag frag-off != { 33-55}
+__set%d test-netdev 7
+__set%d test-netdev 0
+	element 00000000  : 1 [end]	element 00000801  : 0 [end]	element 0000b901  : 1 [end]
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 2b @ 44 + 2 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000f8ff ) ^ 0x00000000 ]
+  [ lookup reg 1 set __set%d 0x1 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag reserved2 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000006 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 0
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000000 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
+# frag more-fragments 1
+netdev 
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x0000dd86 ]
+  [ exthdr load ipv6 1b @ 44 + 3 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000001 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000001 ]
+
diff --git a/tests/py/ip6/sets.t b/tests/py/ip6/sets.t
index add82eb8feb8..3b99d6619df7 100644
--- a/tests/py/ip6/sets.t
+++ b/tests/py/ip6/sets.t
@@ -1,9 +1,10 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip6;test-ip6;input
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 !w type ipv6_addr;ok
 !x type inet_proto;ok
diff --git a/tests/py/ip6/vmap.t b/tests/py/ip6/vmap.t
index 434f5d92e904..2d54b8226e42 100644
--- a/tests/py/ip6/vmap.t
+++ b/tests/py/ip6/vmap.t
@@ -1,9 +1,10 @@
 :input;type filter hook input priority 0
 :ingress;type filter hook ingress device lo priority 0
+:egress;type filter hook egress device lo priority 0
 
 *ip6;test-ip6;input
 *inet;test-inet;input
-*netdev;test-netdev;ingress
+*netdev;test-netdev;ingress,egress
 
 ip6 saddr vmap { abcd::3 : accept };ok
 ip6 saddr 1234:1234:1234:1234:1234:1234:1234:1234:1234;fail
diff --git a/tests/shell/testcases/chains/0021prio_0 b/tests/shell/testcases/chains/0021prio_0
index e761297492ba..d450dc0b6c34 100755
--- a/tests/shell/testcases/chains/0021prio_0
+++ b/tests/shell/testcases/chains/0021prio_0
@@ -69,6 +69,7 @@ done
 family=netdev
 echo "add table $family x"
 gen_chains $family ingress filter lo
+gen_chains $family egress filter lo
 
 family=bridge
 echo "add table $family x"
diff --git a/tests/shell/testcases/chains/0026prio_netdev_1 b/tests/shell/testcases/chains/0026prio_netdev_1
index aa902e9b3a23..b6fa3db5d54d 100755
--- a/tests/shell/testcases/chains/0026prio_netdev_1
+++ b/tests/shell/testcases/chains/0026prio_netdev_1
@@ -1,7 +1,8 @@
 #!/bin/bash
 
 family=netdev
-	hook=ingress
+	for hook in ingress egress
+	do
 		for prioname in raw mangle dstnat security srcnat
 		do
 			$NFT add table $family x || exit 1
@@ -12,4 +13,5 @@ family=netdev
 				exit 1
 			fi
 		done
+	done
 exit 0
diff --git a/tests/shell/testcases/chains/dumps/0021prio_0.nft b/tests/shell/testcases/chains/dumps/0021prio_0.nft
index ca94d4417bae..4297d246703c 100644
--- a/tests/shell/testcases/chains/dumps/0021prio_0.nft
+++ b/tests/shell/testcases/chains/dumps/0021prio_0.nft
@@ -1382,6 +1382,26 @@ table netdev x {
 	chain ingressfilterp11 {
 		type filter hook ingress device "lo" priority 11; policy accept;
 	}
+
+	chain egressfilterm11 {
+		type filter hook egress device "lo" priority -11; policy accept;
+	}
+
+	chain egressfilterm10 {
+		type filter hook egress device "lo" priority filter - 10; policy accept;
+	}
+
+	chain egressfilter {
+		type filter hook egress device "lo" priority filter; policy accept;
+	}
+
+	chain egressfilterp10 {
+		type filter hook egress device "lo" priority filter + 10; policy accept;
+	}
+
+	chain egressfilterp11 {
+		type filter hook egress device "lo" priority 11; policy accept;
+	}
 }
 table bridge x {
 	chain preroutingfilterm11 {
-- 
2.30.2

