Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1173368DE
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Mar 2021 01:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhCKAgq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 Mar 2021 19:36:46 -0500
Received: from correo.us.es ([193.147.175.20]:50086 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhCKAgW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:36:22 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C7B8512E830
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Mar 2021 01:36:21 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B1D6FDA78E
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Mar 2021 01:36:21 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A6D5ADA789; Thu, 11 Mar 2021 01:36:21 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2097EDA704;
        Thu, 11 Mar 2021 01:36:19 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 11 Mar 2021 01:36:19 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id DBC8C42DC6E2;
        Thu, 11 Mar 2021 01:36:18 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH net-next 10/23] netfilter: flowtable: add vlan support
Date:   Thu, 11 Mar 2021 01:35:51 +0100
Message-Id: <20210311003604.22199-11-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210311003604.22199-1-pablo@netfilter.org>
References: <20210311003604.22199-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add the vlan id and protocol to the flow tuple to uniquely identify
flows from the receive path. For the transmit path, dev_hard_header() on
the vlan device push the headers. This patch includes support for two
vlan headers (QinQ) from the ingress path.

Add a generic encap field to the flowtable entry which stores the
protocol and the tag id. This allows to reuse these fields in the PPPoE
support coming in a later patch.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_flow_table.h |  17 +++-
 net/netfilter/nf_flow_table_core.c    |   7 ++
 net/netfilter/nf_flow_table_ip.c      | 123 +++++++++++++++++++++-----
 net/netfilter/nft_flow_offload.c      |  26 +++++-
 4 files changed, 147 insertions(+), 26 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 83110e4705c0..8742b3351150 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -95,6 +95,8 @@ enum flow_offload_xmit_type {
 	FLOW_OFFLOAD_XMIT_DIRECT,
 };
 
+#define NF_FLOW_TABLE_ENCAP_MAX		2
+
 struct flow_offload_tuple {
 	union {
 		struct in_addr		src_v4;
@@ -113,13 +115,17 @@ struct flow_offload_tuple {
 
 	u8				l3proto;
 	u8				l4proto;
+	struct {
+		u16			id;
+		__be16			proto;
+	} encap[NF_FLOW_TABLE_ENCAP_MAX];
 
 	/* All members above are keys for lookups, see flow_offload_hash(). */
 	struct { }			__hash;
 
-	u8				dir:6,
-					xmit_type:2;
-
+	u8				dir:4,
+					xmit_type:2,
+					encap_num:2;
 	u16				mtu;
 	union {
 		struct dst_entry	*dst_cache;
@@ -174,6 +180,11 @@ struct nf_flow_route {
 		struct dst_entry		*dst;
 		struct {
 			u32			ifindex;
+			struct {
+				u16		id;
+				__be16		proto;
+			} encap[NF_FLOW_TABLE_ENCAP_MAX];
+			u8			num_encaps;
 		} in;
 		struct {
 			u32			ifindex;
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index a4cfbefbb6da..d4aec1c988d0 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -80,6 +80,7 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 {
 	struct flow_offload_tuple *flow_tuple = &flow->tuplehash[dir].tuple;
 	struct dst_entry *dst = route->tuple[dir].dst;
+	int i, j = 0;
 
 	switch (flow_tuple->l3proto) {
 	case NFPROTO_IPV4:
@@ -91,6 +92,12 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 	}
 
 	flow_tuple->iifidx = route->tuple[dir].in.ifindex;
+	for (i = route->tuple[dir].in.num_encaps - 1; i >= 0; i--) {
+		flow_tuple->encap[j].id = route->tuple[dir].in.encap[i].id;
+		flow_tuple->encap[j].proto = route->tuple[dir].in.encap[i].proto;
+		j++;
+	}
+	flow_tuple->encap_num = route->tuple[dir].in.num_encaps;
 
 	switch (route->tuple[dir].xmit_type) {
 	case FLOW_OFFLOAD_XMIT_DIRECT:
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index ae0b008c639a..127e9b9ffe10 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -159,17 +159,38 @@ static bool ip_has_options(unsigned int thoff)
 	return thoff != sizeof(struct iphdr);
 }
 
+static void nf_flow_tuple_encap(struct sk_buff *skb,
+				struct flow_offload_tuple *tuple)
+{
+	int i = 0;
+
+	if (skb_vlan_tag_present(skb)) {
+		tuple->encap[i].id = skb_vlan_tag_get(skb);
+		tuple->encap[i].proto = skb->vlan_proto;
+		i++;
+	}
+	if (skb->protocol == htons(ETH_P_8021Q)) {
+		struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb_mac_header(skb);
+
+		tuple->encap[i].id = ntohs(veth->h_vlan_TCI);
+		tuple->encap[i].proto = skb->protocol;
+	}
+}
+
 static int nf_flow_tuple_ip(struct sk_buff *skb, const struct net_device *dev,
 			    struct flow_offload_tuple *tuple)
 {
-	unsigned int thoff, hdrsize;
+	unsigned int thoff, hdrsize, offset = 0;
 	struct flow_ports *ports;
 	struct iphdr *iph;
 
-	if (!pskb_may_pull(skb, sizeof(*iph)))
+	if (skb->protocol == htons(ETH_P_8021Q))
+		offset += VLAN_HLEN;
+
+	if (!pskb_may_pull(skb, sizeof(*iph) + offset))
 		return -1;
 
-	iph = ip_hdr(skb);
+	iph = (struct iphdr *)(skb_network_header(skb) + offset);
 	thoff = iph->ihl * 4;
 
 	if (ip_is_fragment(iph) ||
@@ -191,11 +212,11 @@ static int nf_flow_tuple_ip(struct sk_buff *skb, const struct net_device *dev,
 		return -1;
 
 	thoff = iph->ihl * 4;
-	if (!pskb_may_pull(skb, thoff + hdrsize))
+	if (!pskb_may_pull(skb, thoff + hdrsize + offset))
 		return -1;
 
-	iph = ip_hdr(skb);
-	ports = (struct flow_ports *)(skb_network_header(skb) + thoff);
+	iph = (struct iphdr *)(skb_network_header(skb) + offset);
+	ports = (struct flow_ports *)(skb_network_header(skb) + thoff + offset);
 
 	tuple->src_v4.s_addr	= iph->saddr;
 	tuple->dst_v4.s_addr	= iph->daddr;
@@ -204,6 +225,7 @@ static int nf_flow_tuple_ip(struct sk_buff *skb, const struct net_device *dev,
 	tuple->l3proto		= AF_INET;
 	tuple->l4proto		= iph->protocol;
 	tuple->iifidx		= dev->ifindex;
+	nf_flow_tuple_encap(skb, tuple);
 
 	return 0;
 }
@@ -248,6 +270,40 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
 	return NF_STOLEN;
 }
 
+static bool nf_flow_skb_encap_protocol(const struct sk_buff *skb, __be16 proto)
+{
+	if (skb->protocol == htons(ETH_P_8021Q)) {
+		struct vlan_ethhdr *veth;
+
+		veth = (struct vlan_ethhdr *)skb_mac_header(skb);
+		if (veth->h_vlan_encapsulated_proto == proto)
+			return true;
+	}
+
+	return false;
+}
+
+static void nf_flow_encap_pop(struct sk_buff *skb,
+			      struct flow_offload_tuple_rhash *tuplehash)
+{
+	struct vlan_hdr *vlan_hdr;
+	int i;
+
+	for (i = 0; i < tuplehash->tuple.encap_num; i++) {
+		if (skb_vlan_tag_present(skb)) {
+			__vlan_hwaccel_clear_tag(skb);
+			continue;
+		}
+		if (skb->protocol == htons(ETH_P_8021Q)) {
+			vlan_hdr = (struct vlan_hdr *)skb->data;
+			__skb_pull(skb, VLAN_HLEN);
+			vlan_set_encap_proto(skb, vlan_hdr);
+			skb_reset_network_header(skb);
+			break;
+		}
+	}
+}
+
 static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
 				       const struct flow_offload_tuple_rhash *tuplehash,
 				       unsigned short type)
@@ -276,13 +332,15 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	enum flow_offload_tuple_dir dir;
 	struct flow_offload *flow;
 	struct net_device *outdev;
+	unsigned int thoff, mtu;
 	struct rtable *rt;
-	unsigned int thoff;
 	struct iphdr *iph;
 	__be32 nexthop;
+	u32 offset = 0;
 	int ret;
 
-	if (skb->protocol != htons(ETH_P_IP))
+	if (skb->protocol != htons(ETH_P_IP) &&
+	    !nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP)))
 		return NF_ACCEPT;
 
 	if (nf_flow_tuple_ip(skb, state->in, &tuple) < 0)
@@ -295,14 +353,19 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
-	if (unlikely(nf_flow_exceeds_mtu(skb, flow->tuplehash[dir].tuple.mtu)))
+	mtu = flow->tuplehash[dir].tuple.mtu + offset;
+	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
 		return NF_ACCEPT;
 
-	if (skb_try_make_writable(skb, sizeof(*iph)))
+	if (skb->protocol == htons(ETH_P_8021Q))
+		offset += VLAN_HLEN;
+
+	if (skb_try_make_writable(skb, sizeof(*iph) + offset))
 		return NF_DROP;
 
-	thoff = ip_hdr(skb)->ihl * 4;
-	if (nf_flow_state_check(flow, ip_hdr(skb)->protocol, skb, thoff))
+	iph = (struct iphdr *)(skb_network_header(skb) + offset);
+	thoff = (iph->ihl * 4) + offset;
+	if (nf_flow_state_check(flow, iph->protocol, skb, thoff))
 		return NF_ACCEPT;
 
 	flow_offload_refresh(flow_table, flow);
@@ -312,6 +375,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 	}
 
+	nf_flow_encap_pop(skb, tuplehash);
+	thoff -= offset;
+
 	if (nf_flow_nat_ip(flow, skb, thoff, dir) < 0)
 		return NF_DROP;
 
@@ -479,14 +545,17 @@ static int nf_flow_nat_ipv6(const struct flow_offload *flow,
 static int nf_flow_tuple_ipv6(struct sk_buff *skb, const struct net_device *dev,
 			      struct flow_offload_tuple *tuple)
 {
-	unsigned int thoff, hdrsize;
+	unsigned int thoff, hdrsize, offset = 0;
 	struct flow_ports *ports;
 	struct ipv6hdr *ip6h;
 
-	if (!pskb_may_pull(skb, sizeof(*ip6h)))
+	if (skb->protocol == htons(ETH_P_8021Q))
+		offset += VLAN_HLEN;
+
+	if (!pskb_may_pull(skb, sizeof(*ip6h) + offset))
 		return -1;
 
-	ip6h = ipv6_hdr(skb);
+	ip6h = (struct ipv6hdr *)(skb_network_header(skb) + offset);
 
 	switch (ip6h->nexthdr) {
 	case IPPROTO_TCP:
@@ -503,11 +572,11 @@ static int nf_flow_tuple_ipv6(struct sk_buff *skb, const struct net_device *dev,
 		return -1;
 
 	thoff = sizeof(*ip6h);
-	if (!pskb_may_pull(skb, thoff + hdrsize))
+	if (!pskb_may_pull(skb, thoff + hdrsize + offset))
 		return -1;
 
-	ip6h = ipv6_hdr(skb);
-	ports = (struct flow_ports *)(skb_network_header(skb) + thoff);
+	ip6h = (struct ipv6hdr *)(skb_network_header(skb) + offset);
+	ports = (struct flow_ports *)(skb_network_header(skb) + thoff + offset);
 
 	tuple->src_v6		= ip6h->saddr;
 	tuple->dst_v6		= ip6h->daddr;
@@ -516,6 +585,7 @@ static int nf_flow_tuple_ipv6(struct sk_buff *skb, const struct net_device *dev,
 	tuple->l3proto		= AF_INET6;
 	tuple->l4proto		= ip6h->nexthdr;
 	tuple->iifidx		= dev->ifindex;
+	nf_flow_tuple_encap(skb, tuple);
 
 	return 0;
 }
@@ -533,9 +603,12 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 	struct net_device *outdev;
 	struct ipv6hdr *ip6h;
 	struct rt6_info *rt;
+	unsigned int mtu;
+	u32 offset = 0;
 	int ret;
 
-	if (skb->protocol != htons(ETH_P_IPV6))
+	if (skb->protocol != htons(ETH_P_IPV6) &&
+	    !nf_flow_skb_encap_protocol(skb, htons(ETH_P_IPV6)))
 		return NF_ACCEPT;
 
 	if (nf_flow_tuple_ipv6(skb, state->in, &tuple) < 0)
@@ -548,11 +621,15 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
-	if (unlikely(nf_flow_exceeds_mtu(skb, flow->tuplehash[dir].tuple.mtu)))
+	mtu = flow->tuplehash[dir].tuple.mtu + offset;
+	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
 		return NF_ACCEPT;
 
-	if (nf_flow_state_check(flow, ipv6_hdr(skb)->nexthdr, skb,
-				sizeof(*ip6h)))
+	if (skb->protocol == htons(ETH_P_8021Q))
+		offset += VLAN_HLEN;
+
+	ip6h = (struct ipv6hdr *)(skb_network_header(skb) + offset);
+	if (nf_flow_state_check(flow, ip6h->nexthdr, skb, sizeof(*ip6h)))
 		return NF_ACCEPT;
 
 	flow_offload_refresh(flow_table, flow);
@@ -562,6 +639,8 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 	}
 
+	nf_flow_encap_pop(skb, tuplehash);
+
 	if (skb_try_make_writable(skb, sizeof(*ip6h)))
 		return NF_DROP;
 
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index a6595dca1b1f..8392b1a8108b 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -66,6 +66,11 @@ static int nft_dev_fill_forward_path(const struct nf_flow_route *route,
 struct nft_forward_info {
 	const struct net_device *indev;
 	const struct net_device *outdev;
+	struct id {
+		__u16	id;
+		__be16	proto;
+	} encap[NF_FLOW_TABLE_ENCAP_MAX];
+	u8 num_encaps;
 	u8 h_source[ETH_ALEN];
 	u8 h_dest[ETH_ALEN];
 	enum flow_offload_xmit_type xmit_type;
@@ -84,9 +89,23 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 		path = &stack->path[i];
 		switch (path->type) {
 		case DEV_PATH_ETHERNET:
+		case DEV_PATH_VLAN:
 			info->indev = path->dev;
 			if (is_zero_ether_addr(info->h_source))
 				memcpy(info->h_source, path->dev->dev_addr, ETH_ALEN);
+
+			if (path->type == DEV_PATH_ETHERNET)
+				break;
+
+			/* DEV_PATH_VLAN */
+			if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
+				info->indev = NULL;
+				break;
+			}
+			info->outdev = path->dev;
+			info->encap[info->num_encaps].id = path->encap.id;
+			info->encap[info->num_encaps].proto = path->encap.proto;
+			info->num_encaps++;
 			break;
 		case DEV_PATH_BRIDGE:
 			if (is_zero_ether_addr(info->h_source))
@@ -94,7 +113,6 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 
 			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
 			break;
-		case DEV_PATH_VLAN:
 		default:
 			info->indev = NULL;
 			break;
@@ -130,6 +148,7 @@ static void nft_dev_forward_path(struct nf_flow_route *route,
 	struct net_device_path_stack stack;
 	struct nft_forward_info info = {};
 	unsigned char ha[ETH_ALEN];
+	int i;
 
 	if (nft_dev_fill_forward_path(route, dst, ct, dir, ha, &stack) >= 0)
 		nft_dev_path_info(&stack, &info, ha);
@@ -138,6 +157,11 @@ static void nft_dev_forward_path(struct nf_flow_route *route,
 		return;
 
 	route->tuple[!dir].in.ifindex = info.indev->ifindex;
+	for (i = 0; i < info.num_encaps; i++) {
+		route->tuple[!dir].in.encap[i].id = info.encap[i].id;
+		route->tuple[!dir].in.encap[i].proto = info.encap[i].proto;
+	}
+	route->tuple[!dir].in.num_encaps = info.num_encaps;
 
 	if (info.xmit_type == FLOW_OFFLOAD_XMIT_DIRECT) {
 		memcpy(route->tuple[dir].out.h_source, info.h_source, ETH_ALEN);
-- 
2.20.1

