Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE4346ED2
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Mar 2021 02:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhCXBb6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Mar 2021 21:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbhCXBbX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:31:23 -0400
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09DC3C061763;
        Tue, 23 Mar 2021 18:31:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id AEA41630BB;
        Wed, 24 Mar 2021 02:31:14 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net-next,v2 24/24] docs: nf_flowtable: update documentation with enhancements
Date:   Wed, 24 Mar 2021 02:30:55 +0100
Message-Id: <20210324013055.5619-25-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210324013055.5619-1-pablo@netfilter.org>
References: <20210324013055.5619-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch updates the flowtable documentation to describe recent
enhancements:

- Offload action is available after the first packets go through the
  classic forwarding path.
- IPv4 and IPv6 are supported. Only TCP and UDP layer 4 are supported at
  this stage.
- Tuple has been augmented to track VLAN id and PPPoE session id.
- Bridge and IP forwarding integration, including bridge VLAN filtering
  support.
- Hardware offload support.
- Describe the [OFFLOAD] and [HW_OFFLOAD] tags in the conntrack table
  listing.
- Replace 'flow offload' by 'flow add' in example rulesets (preferred
  syntax).
- Describe existing cache limitations.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: not coming in v1. Update documentation including existing limitations.

 Documentation/networking/nf_flowtable.rst | 170 ++++++++++++++++++----
 1 file changed, 143 insertions(+), 27 deletions(-)

diff --git a/Documentation/networking/nf_flowtable.rst b/Documentation/networking/nf_flowtable.rst
index 6cdf9a1724b6..d87f253b9d39 100644
--- a/Documentation/networking/nf_flowtable.rst
+++ b/Documentation/networking/nf_flowtable.rst
@@ -4,35 +4,38 @@
 Netfilter's flowtable infrastructure
 ====================================
 
-This documentation describes the software flowtable infrastructure available in
-Netfilter since Linux kernel 4.16.
+This documentation describes the Netfilter flowtable infrastructure which allows
+you to define a fastpath through the flowtable datapath. This infrastructure
+also provides hardware offload support. The flowtable supports for the layer 3
+IPv4 and IPv6 and the layer 4 TCP and UDP protocols.
 
 Overview
 --------
 
-Initial packets follow the classic forwarding path, once the flow enters the
-established state according to the conntrack semantics (ie. we have seen traffic
-in both directions), then you can decide to offload the flow to the flowtable
-from the forward chain via the 'flow offload' action available in nftables.
+Once the first packet of the flow successfully goes through the IP forwarding
+path, from the second packet on, you might decide to offload the flow to the
+flowtable through your ruleset. The flowtable infrastructure provides a rule
+action that allows you to specify when to add a flow to the flowtable.
 
-Packets that find an entry in the flowtable (ie. flowtable hit) are sent to the
-output netdevice via neigh_xmit(), hence, they bypass the classic forwarding
-path (the visible effect is that you do not see these packets from any of the
-netfilter hooks coming after the ingress). In case of flowtable miss, the packet
-follows the classic forward path.
+A packet that finds a matching entry in the flowtable (ie. flowtable hit) is
+transmitted to the output netdevice via neigh_xmit(), hence, packets bypass the
+classic IP forwarding path (the visible effect is that you do not see these
+packets from any of the Netfilter hooks coming after ingress). In case that
+there is no matching entry in the flowtable (ie. flowtable miss), the packet
+follows the classic IP forwarding path.
 
-The flowtable uses a resizable hashtable, lookups are based on the following
-7-tuple selectors: source, destination, layer 3 and layer 4 protocols, source
-and destination ports and the input interface (useful in case there are several
-conntrack zones in place).
+The flowtable uses a resizable hashtable. Lookups are based on the following
+n-tuple selectors: layer 2 protocol encapsulation (VLAN and PPPoE), layer 3
+source and destination, layer 4 source and destination ports and the input
+interface (useful in case there are several conntrack zones in place).
 
-Flowtables are populated via the 'flow offload' nftables action, so the user can
-selectively specify what flows are placed into the flow table. Hence, packets
-follow the classic forwarding path unless the user explicitly instruct packets
-to use this new alternative forwarding path via nftables policy.
+The 'flow add' action allows you to populate the flowtable, the user selectively
+specifies what flows are placed into the flowtable. Hence, packets follow the
+classic IP forwarding path unless the user explicitly instruct flows to use this
+new alternative forwarding path via policy.
 
-This is represented in Fig.1, which describes the classic forwarding path
-including the Netfilter hooks and the flowtable fastpath bypass.
+The flowtable datapath is represented in Fig.1, which describes the classic IP
+forwarding path including the Netfilter hooks and the flowtable fastpath bypass.
 
 ::
 
@@ -67,11 +70,13 @@ including the Netfilter hooks and the flowtable fastpath bypass.
 	       Fig.1 Netfilter hooks and flowtable interactions
 
 The flowtable entry also stores the NAT configuration, so all packets are
-mangled according to the NAT policy that matches the initial packets that went
-through the classic forwarding path. The TTL is decremented before calling
-neigh_xmit(). Fragmented traffic is passed up to follow the classic forwarding
-path given that the transport selectors are missing, therefore flowtable lookup
-is not possible.
+mangled according to the NAT policy that is specified from the classic IP
+forwarding path. The TTL is decremented before calling neigh_xmit(). Fragmented
+traffic is passed up to follow the classic IP forwarding path given that the
+transport header is missing, in this case, flowtable lookups are not possible.
+TCP RST and FIN packets are also passed up to the classic IP forwarding path to
+release the flow gracefully. Packets that exceed the MTU are also passed up to
+the classic forwarding path to report packet-too-big ICMP errors to the sender.
 
 Example configuration
 ---------------------
@@ -85,7 +90,7 @@ flowtable and add one rule to your forward chain::
 		}
 		chain y {
 			type filter hook forward priority 0; policy accept;
-			ip protocol tcp flow offload @f
+			ip protocol tcp flow add @f
 			counter packets 0 bytes 0
 		}
 	}
@@ -103,6 +108,117 @@ flow is offloaded, you will observe that the counter rule in the example above
 does not get updated for the packets that are being forwarded through the
 forwarding bypass.
 
+You can identify offloaded flows through the [OFFLOAD] tag when listing your
+connection tracking table.
+
+::
+	# conntrack -L
+	tcp      6 src=10.141.10.2 dst=192.168.10.2 sport=52728 dport=5201 src=192.168.10.2 dst=192.168.10.1 sport=5201 dport=52728 [OFFLOAD] mark=0 use=2
+
+
+Layer 2 encapsulation
+---------------------
+
+Since Linux kernel 5.13, the flowtable infrastructure discovers the real
+netdevice behind VLAN and PPPoE netdevices. The flowtable software datapath
+parses the VLAN and PPPoE layer 2 headers to extract the ethertype and the
+VLAN ID / PPPoE session ID which are used for the flowtable lookups. The
+flowtable datapath also deals with layer 2 decapsulation.
+
+You do not need to add the PPPoE and the VLAN devices to your flowtable,
+instead the real device is sufficient for the flowtable to track your flows.
+
+Bridge and IP forwarding
+------------------------
+
+Since Linux kernel 5.13, you can add bridge ports to the flowtable. The
+flowtable infrastructure discovers the topology behind the bridge device. This
+allows the flowtable to define a fastpath bypass between the bridge ports
+(represented as eth1 and eth2 in the example figure below) and the gateway
+device (represented as eth0) in your switch/router.
+
+::
+                      fastpath bypass
+               .-------------------------.
+              /                           \
+              |           IP forwarding   |
+              |          /             \ \/
+              |       br0               eth0 ..... eth0
+              .       / \                          *host B*
+               -> eth1  eth2
+                   .           *switch/router*
+                   .
+                   .
+                 eth0
+               *host A*
+
+The flowtable infrastructure also supports for bridge VLAN filtering actions
+such as PVID and untagged. You can also stack a classic VLAN device on top of
+your bridge port.
+
+If you would like that your flowtable defines a fastpath between your bridge
+ports and your IP forwarding path, you have to add your bridge ports (as
+represented by the real netdevice) to your flowtable definition.
+
+Counters
+--------
+
+The flowtable can synchronize packet and byte counters with the existing
+connection tracking entry by specifying the counter statement in your flowtable
+definition, e.g.
+
+::
+	table inet x {
+		flowtable f {
+			hook ingress priority 0; devices = { eth0, eth1 };
+			counter
+		}
+		...
+	}
+
+Counter support is available since Linux kernel 5.7.
+
+Hardware offload
+----------------
+
+If your network device provides hardware offload support, you can turn it on by
+means of the 'offload' flag in your flowtable definition, e.g.
+
+::
+	table inet x {
+		flowtable f {
+			hook ingress priority 0; devices = { eth0, eth1 };
+			flags offload;
+		}
+		...
+	}
+
+There is a workqueue that adds the flows to the hardware. Note that a few
+packets might still run over the flowtable software path until the workqueue has
+a chance to offload the flow to the network device.
+
+You can identify hardware offloaded flows through the [HW_OFFLOAD] tag when
+listing your connection tracking table. Please, note that the [OFFLOAD] tag
+refers to the software offload mode, so there is a distinction between [OFFLOAD]
+which refers to the software flowtable fastpath and [HW_OFFLOAD] which refers
+to the hardware offload datapath being used by the flow.
+
+The flowtable hardware offload infrastructure also supports for the DSA
+(Distributed Switch Architecture).
+
+Limitations
+-----------
+
+The flowtable behaves like a cache. The flowtable entries might get stale if
+either the destination MAC address or the egress netdevice that is used for
+transmission changes.
+
+This might be a problem if:
+
+- You run the flowtable in software mode and you combine bridge and IP
+  forwarding in your setup.
+- Hardware offload is enabled.
+
 More reading
 ------------
 
-- 
2.20.1

