Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFA233EFDB
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Mar 2021 12:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhCQLyg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Mar 2021 07:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhCQLyG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:54:06 -0400
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D65DC06175F
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Mar 2021 04:54:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id A295163546
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Mar 2021 12:54:01 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 1/3] netfilter: flowtable: consolidate skb_try_make_writable() call
Date:   Wed, 17 Mar 2021 12:53:52 +0100
Message-Id: <20210317115354.1805-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fetch the layer 4 header size to be mangled by NAT when building the
tuple, then use it to make writable the network and the transport
headers. After this update, the NAT routines now assumes that the skbuff
area is writable. Do the pointer refetch only after the single
skb_try_make_writable() call.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_core.c | 12 -----
 net/netfilter/nf_flow_table_ip.c   | 74 +++++++++++++-----------------
 2 files changed, 31 insertions(+), 55 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 5fa657b8e03d..ff5d94b644ac 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -395,9 +395,6 @@ static int nf_flow_nat_port_tcp(struct sk_buff *skb, unsigned int thoff,
 {
 	struct tcphdr *tcph;
 
-	if (skb_try_make_writable(skb, thoff + sizeof(*tcph)))
-		return -1;
-
 	tcph = (void *)(skb_network_header(skb) + thoff);
 	inet_proto_csum_replace2(&tcph->check, skb, port, new_port, false);
 
@@ -409,9 +406,6 @@ static int nf_flow_nat_port_udp(struct sk_buff *skb, unsigned int thoff,
 {
 	struct udphdr *udph;
 
-	if (skb_try_make_writable(skb, thoff + sizeof(*udph)))
-		return -1;
-
 	udph = (void *)(skb_network_header(skb) + thoff);
 	if (udph->check || skb->ip_summed == CHECKSUM_PARTIAL) {
 		inet_proto_csum_replace2(&udph->check, skb, port,
@@ -447,9 +441,6 @@ int nf_flow_snat_port(const struct flow_offload *flow,
 	struct flow_ports *hdr;
 	__be16 port, new_port;
 
-	if (skb_try_make_writable(skb, thoff + sizeof(*hdr)))
-		return -1;
-
 	hdr = (void *)(skb_network_header(skb) + thoff);
 
 	switch (dir) {
@@ -478,9 +469,6 @@ int nf_flow_dnat_port(const struct flow_offload *flow,
 	struct flow_ports *hdr;
 	__be16 port, new_port;
 
-	if (skb_try_make_writable(skb, thoff + sizeof(*hdr)))
-		return -1;
-
 	hdr = (void *)(skb_network_header(skb) + thoff);
 
 	switch (dir) {
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index a698dbe28ef5..2b8ee5dcef64 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -39,9 +39,6 @@ static int nf_flow_nat_ip_tcp(struct sk_buff *skb, unsigned int thoff,
 {
 	struct tcphdr *tcph;
 
-	if (skb_try_make_writable(skb, thoff + sizeof(*tcph)))
-		return -1;
-
 	tcph = (void *)(skb_network_header(skb) + thoff);
 	inet_proto_csum_replace4(&tcph->check, skb, addr, new_addr, true);
 
@@ -53,9 +50,6 @@ static int nf_flow_nat_ip_udp(struct sk_buff *skb, unsigned int thoff,
 {
 	struct udphdr *udph;
 
-	if (skb_try_make_writable(skb, thoff + sizeof(*udph)))
-		return -1;
-
 	udph = (void *)(skb_network_header(skb) + thoff);
 	if (udph->check || skb->ip_summed == CHECKSUM_PARTIAL) {
 		inet_proto_csum_replace4(&udph->check, skb, addr,
@@ -136,19 +130,17 @@ static int nf_flow_dnat_ip(const struct flow_offload *flow, struct sk_buff *skb,
 }
 
 static int nf_flow_nat_ip(const struct flow_offload *flow, struct sk_buff *skb,
-			  unsigned int thoff, enum flow_offload_tuple_dir dir)
+			  unsigned int thoff, enum flow_offload_tuple_dir dir,
+			  struct iphdr *iph)
 {
-	struct iphdr *iph = ip_hdr(skb);
-
 	if (test_bit(NF_FLOW_SNAT, &flow->flags) &&
 	    (nf_flow_snat_port(flow, skb, thoff, iph->protocol, dir) < 0 ||
-	     nf_flow_snat_ip(flow, skb, ip_hdr(skb), thoff, dir) < 0))
+	     nf_flow_snat_ip(flow, skb, iph, thoff, dir) < 0))
 		return -1;
 
-	iph = ip_hdr(skb);
 	if (test_bit(NF_FLOW_DNAT, &flow->flags) &&
 	    (nf_flow_dnat_port(flow, skb, thoff, iph->protocol, dir) < 0 ||
-	     nf_flow_dnat_ip(flow, skb, ip_hdr(skb), thoff, dir) < 0))
+	     nf_flow_dnat_ip(flow, skb, iph, thoff, dir) < 0))
 		return -1;
 
 	return 0;
@@ -160,10 +152,10 @@ static bool ip_has_options(unsigned int thoff)
 }
 
 static int nf_flow_tuple_ip(struct sk_buff *skb, const struct net_device *dev,
-			    struct flow_offload_tuple *tuple)
+			    struct flow_offload_tuple *tuple, u32 *hdrsize)
 {
-	unsigned int thoff, hdrsize;
 	struct flow_ports *ports;
+	unsigned int thoff;
 	struct iphdr *iph;
 
 	if (!pskb_may_pull(skb, sizeof(*iph)))
@@ -178,10 +170,10 @@ static int nf_flow_tuple_ip(struct sk_buff *skb, const struct net_device *dev,
 
 	switch (iph->protocol) {
 	case IPPROTO_TCP:
-		hdrsize = sizeof(struct tcphdr);
+		*hdrsize = sizeof(struct tcphdr);
 		break;
 	case IPPROTO_UDP:
-		hdrsize = sizeof(struct udphdr);
+		*hdrsize = sizeof(struct udphdr);
 		break;
 	default:
 		return -1;
@@ -191,7 +183,7 @@ static int nf_flow_tuple_ip(struct sk_buff *skb, const struct net_device *dev,
 		return -1;
 
 	thoff = iph->ihl * 4;
-	if (!pskb_may_pull(skb, thoff + hdrsize))
+	if (!pskb_may_pull(skb, thoff + *hdrsize))
 		return -1;
 
 	iph = ip_hdr(skb);
@@ -252,11 +244,12 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	unsigned int thoff;
 	struct iphdr *iph;
 	__be32 nexthop;
+	u32 hdrsize;
 
 	if (skb->protocol != htons(ETH_P_IP))
 		return NF_ACCEPT;
 
-	if (nf_flow_tuple_ip(skb, state->in, &tuple) < 0)
+	if (nf_flow_tuple_ip(skb, state->in, &tuple, &hdrsize) < 0)
 		return NF_ACCEPT;
 
 	tuplehash = flow_offload_lookup(flow_table, &tuple);
@@ -271,11 +264,13 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	if (unlikely(nf_flow_exceeds_mtu(skb, flow->tuplehash[dir].tuple.mtu)))
 		return NF_ACCEPT;
 
-	if (skb_try_make_writable(skb, sizeof(*iph)))
+	iph = ip_hdr(skb);
+	thoff = iph->ihl * 4;
+	if (skb_try_make_writable(skb, thoff + hdrsize))
 		return NF_DROP;
 
-	thoff = ip_hdr(skb)->ihl * 4;
-	if (nf_flow_state_check(flow, ip_hdr(skb)->protocol, skb, thoff))
+	iph = ip_hdr(skb);
+	if (nf_flow_state_check(flow, iph->protocol, skb, thoff))
 		return NF_ACCEPT;
 
 	flow_offload_refresh(flow_table, flow);
@@ -285,10 +280,9 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 	}
 
-	if (nf_flow_nat_ip(flow, skb, thoff, dir) < 0)
+	if (nf_flow_nat_ip(flow, skb, thoff, dir, iph) < 0)
 		return NF_DROP;
 
-	iph = ip_hdr(skb);
 	ip_decrease_ttl(iph);
 	skb->tstamp = 0;
 
@@ -317,9 +311,6 @@ static int nf_flow_nat_ipv6_tcp(struct sk_buff *skb, unsigned int thoff,
 {
 	struct tcphdr *tcph;
 
-	if (skb_try_make_writable(skb, thoff + sizeof(*tcph)))
-		return -1;
-
 	tcph = (void *)(skb_network_header(skb) + thoff);
 	inet_proto_csum_replace16(&tcph->check, skb, addr->s6_addr32,
 				  new_addr->s6_addr32, true);
@@ -333,9 +324,6 @@ static int nf_flow_nat_ipv6_udp(struct sk_buff *skb, unsigned int thoff,
 {
 	struct udphdr *udph;
 
-	if (skb_try_make_writable(skb, thoff + sizeof(*udph)))
-		return -1;
-
 	udph = (void *)(skb_network_header(skb) + thoff);
 	if (udph->check || skb->ip_summed == CHECKSUM_PARTIAL) {
 		inet_proto_csum_replace16(&udph->check, skb, addr->s6_addr32,
@@ -417,31 +405,30 @@ static int nf_flow_dnat_ipv6(const struct flow_offload *flow,
 
 static int nf_flow_nat_ipv6(const struct flow_offload *flow,
 			    struct sk_buff *skb,
-			    enum flow_offload_tuple_dir dir)
+			    enum flow_offload_tuple_dir dir,
+			    struct ipv6hdr *ip6h)
 {
-	struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	unsigned int thoff = sizeof(*ip6h);
 
 	if (test_bit(NF_FLOW_SNAT, &flow->flags) &&
 	    (nf_flow_snat_port(flow, skb, thoff, ip6h->nexthdr, dir) < 0 ||
-	     nf_flow_snat_ipv6(flow, skb, ipv6_hdr(skb), thoff, dir) < 0))
+	     nf_flow_snat_ipv6(flow, skb, ip6h, thoff, dir) < 0))
 		return -1;
 
-	ip6h = ipv6_hdr(skb);
 	if (test_bit(NF_FLOW_DNAT, &flow->flags) &&
 	    (nf_flow_dnat_port(flow, skb, thoff, ip6h->nexthdr, dir) < 0 ||
-	     nf_flow_dnat_ipv6(flow, skb, ipv6_hdr(skb), thoff, dir) < 0))
+	     nf_flow_dnat_ipv6(flow, skb, ip6h, thoff, dir) < 0))
 		return -1;
 
 	return 0;
 }
 
 static int nf_flow_tuple_ipv6(struct sk_buff *skb, const struct net_device *dev,
-			      struct flow_offload_tuple *tuple)
+			      struct flow_offload_tuple *tuple, u32 *hdrsize)
 {
-	unsigned int thoff, hdrsize;
 	struct flow_ports *ports;
 	struct ipv6hdr *ip6h;
+	unsigned int thoff;
 
 	if (!pskb_may_pull(skb, sizeof(*ip6h)))
 		return -1;
@@ -450,10 +437,10 @@ static int nf_flow_tuple_ipv6(struct sk_buff *skb, const struct net_device *dev,
 
 	switch (ip6h->nexthdr) {
 	case IPPROTO_TCP:
-		hdrsize = sizeof(struct tcphdr);
+		*hdrsize = sizeof(struct tcphdr);
 		break;
 	case IPPROTO_UDP:
-		hdrsize = sizeof(struct udphdr);
+		*hdrsize = sizeof(struct udphdr);
 		break;
 	default:
 		return -1;
@@ -463,7 +450,7 @@ static int nf_flow_tuple_ipv6(struct sk_buff *skb, const struct net_device *dev,
 		return -1;
 
 	thoff = sizeof(*ip6h);
-	if (!pskb_may_pull(skb, thoff + hdrsize))
+	if (!pskb_may_pull(skb, thoff + *hdrsize))
 		return -1;
 
 	ip6h = ipv6_hdr(skb);
@@ -493,11 +480,12 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 	struct net_device *outdev;
 	struct ipv6hdr *ip6h;
 	struct rt6_info *rt;
+	u32 hdrsize;
 
 	if (skb->protocol != htons(ETH_P_IPV6))
 		return NF_ACCEPT;
 
-	if (nf_flow_tuple_ipv6(skb, state->in, &tuple) < 0)
+	if (nf_flow_tuple_ipv6(skb, state->in, &tuple, &hdrsize) < 0)
 		return NF_ACCEPT;
 
 	tuplehash = flow_offload_lookup(flow_table, &tuple);
@@ -523,13 +511,13 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 	}
 
-	if (skb_try_make_writable(skb, sizeof(*ip6h)))
+	if (skb_try_make_writable(skb, sizeof(*ip6h) + hdrsize))
 		return NF_DROP;
 
-	if (nf_flow_nat_ipv6(flow, skb, dir) < 0)
+	ip6h = ipv6_hdr(skb);
+	if (nf_flow_nat_ipv6(flow, skb, dir, ip6h) < 0)
 		return NF_DROP;
 
-	ip6h = ipv6_hdr(skb);
 	ip6h->hop_limit--;
 	skb->tstamp = 0;
 
-- 
2.20.1

