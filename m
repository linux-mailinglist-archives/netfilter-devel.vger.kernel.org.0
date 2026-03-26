Return-Path: <netfilter-devel+bounces-11459-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMIdKPSTxWmq/gQAu9opvQ
	(envelope-from <netfilter-devel+bounces-11459-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 21:15:48 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CD233B513
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 21:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B39163033D23
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 20:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331323537D3;
	Thu, 26 Mar 2026 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="QWIG77za"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552271A9FB7
	for <netfilter-devel@vger.kernel.org>; Thu, 26 Mar 2026 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555785; cv=none; b=WsTuDFUvkknSyEJucxUFl+Dv0NJ1dND/D83l3RIVusmmGMtsnN+zfQ6aOl9xhisHC/ma3sza+FDO3pZPIHrmcK8l+bOlSXcnyZzoNlUBd6HpHZTAZvZkUJ582kc6mnTCuHORs1bEmBxKjBLEiJZzXPy18e67LOc01EPAhHaK4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555785; c=relaxed/simple;
	bh=EojgAT4QJNvbg5uKJdPlZJrZCgGKojCB5w0AGESIK94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAhKl5dfLp5olAcIuLFbqKkxeehvMaZ3F7ltVHM+OQ/TPvDePRNL5+NhFCMHbCDOtEs0de30/ny7IiXNoRBiesj6/8er7y6O8f8B+qdWEDpm6FooU99PSETg65axj5gJaNV0AcJcAGSlbODYdqQjIxov8ldtcXdPm8NtzRxZg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=QWIG77za; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 946DA600B9;
	Thu, 26 Mar 2026 21:09:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1774555779;
	bh=60ksNI8F8ohIhwyua0icaAg02psqdMpkQrcIdgkLNH4=;
	h=From:To:Cc:Subject:Date:From;
	b=QWIG77zaUR5OqvdleKxSVKmou0RQMzYWmWGXb0wOdG3IdWr1887Mal/EnLbiQBPDK
	 6lAk1UUELASVWfrkA8G/ih7aL7A7oCve7VWAV1yl0Dfly6xfxdoKQl4a+IHaXsT3Z4
	 Z7Do85VxMPJmsxJumVBgg6m+iWTbi3DaAnee4MvBxUgeb/siev3zgU5jDNdxoIsqMX
	 fevHyGiMTAvsFq8s2dt87GIB6eR9hSKL3EToaDlqOwvhJpCceUxKqzcz/bqRLY3blD
	 NKj3WP/br4TwtzdDZKXP1yn802SetlFPWG3QgEcdF0L3Jb+0X6mCkVhl3K+EAxVNIo
	 yRfL4QJ8AZqyw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf] netfilter: flowtable: strictly check for maximum number of actions
Date: Thu, 26 Mar 2026 21:09:35 +0100
Message-ID: <20260326200935.729750-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-11459-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid]
X-Rspamd-Queue-Id: 04CD233B513
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The maximum number of flowtable hardware offload actions in IPv6 is:

* ethernet mangling (4 payload actions, 2 for each ethernet address)
* SNAT (4 payload actions)
* DNAT (4 payload actions)
* Double VLAN (4 vlan actions, 2 for popping vlan, and 2 for pushing)
  for QinQ.
* Redirect (1 action)

Which makes 17, while the maximum is 16. But act_ct supports for tunnels
actions too. Note that payload action operates at 32-bit word level, so
mangling an IPv6 address take 4 payload actions.

Update flow_action_entry_next() calls to check for the maximum number of
supported actions.

While at it, rise the maximum number of actions per flow from 16 to 24
so this works fine with IPv6 setups.

Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload support")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
This is the large version of this fix, it should be possible to make a
much smaller workaround patch. This codebase did not change much since
2019, backports should be not too complicated.

 net/netfilter/nf_flow_table_offload.c | 190 +++++++++++++++++---------
 1 file changed, 125 insertions(+), 65 deletions(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 9b677e116487..eea77e0d1416 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -14,6 +14,8 @@
 #include <net/netfilter/nf_conntrack_core.h>
 #include <net/netfilter/nf_conntrack_tuple.h>
 
+#define NF_FLOW_RULE_ACTION_MAX	24
+
 static struct workqueue_struct *nf_flow_offload_add_wq;
 static struct workqueue_struct *nf_flow_offload_del_wq;
 static struct workqueue_struct *nf_flow_offload_stats_wq;
@@ -218,6 +220,9 @@ flow_action_entry_next(struct nf_flow_rule *flow_rule)
 {
 	int i = flow_rule->rule->action.num_entries++;
 
+	if (unlikely(i >= NF_FLOW_RULE_ACTION_MAX))
+		return NULL;
+
 	return &flow_rule->rule->action.entries[i];
 }
 
@@ -234,6 +239,9 @@ static int flow_offload_eth_src(struct net *net,
 	u32 mask, val;
 	u16 val16;
 
+	if (!entry0 || !entry1)
+		return -E2BIG;
+
 	this_tuple = &flow->tuplehash[dir].tuple;
 
 	switch (this_tuple->xmit_type) {
@@ -284,6 +292,9 @@ static int flow_offload_eth_dst(struct net *net,
 	u8 nud_state;
 	u16 val16;
 
+	if (!entry0 || !entry1)
+		return -E2BIG;
+
 	this_tuple = &flow->tuplehash[dir].tuple;
 
 	switch (this_tuple->xmit_type) {
@@ -325,16 +336,19 @@ static int flow_offload_eth_dst(struct net *net,
 	return 0;
 }
 
-static void flow_offload_ipv4_snat(struct net *net,
-				   const struct flow_offload *flow,
-				   enum flow_offload_tuple_dir dir,
-				   struct nf_flow_rule *flow_rule)
+static int flow_offload_ipv4_snat(struct net *net,
+				  const struct flow_offload *flow,
+				  enum flow_offload_tuple_dir dir,
+				  struct nf_flow_rule *flow_rule)
 {
 	struct flow_action_entry *entry = flow_action_entry_next(flow_rule);
 	u32 mask = ~htonl(0xffffffff);
 	__be32 addr;
 	u32 offset;
 
+	if (!entry)
+		return -E2BIG;
+
 	switch (dir) {
 	case FLOW_OFFLOAD_DIR_ORIGINAL:
 		addr = flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.dst_v4.s_addr;
@@ -345,23 +359,27 @@ static void flow_offload_ipv4_snat(struct net *net,
 		offset = offsetof(struct iphdr, daddr);
 		break;
 	default:
-		return;
+		return -EOPNOTSUPP;
 	}
 
 	flow_offload_mangle(entry, FLOW_ACT_MANGLE_HDR_TYPE_IP4, offset,
 			    &addr, &mask);
+	return 0;
 }
 
-static void flow_offload_ipv4_dnat(struct net *net,
-				   const struct flow_offload *flow,
-				   enum flow_offload_tuple_dir dir,
-				   struct nf_flow_rule *flow_rule)
+static int flow_offload_ipv4_dnat(struct net *net,
+				  const struct flow_offload *flow,
+				  enum flow_offload_tuple_dir dir,
+				  struct nf_flow_rule *flow_rule)
 {
 	struct flow_action_entry *entry = flow_action_entry_next(flow_rule);
 	u32 mask = ~htonl(0xffffffff);
 	__be32 addr;
 	u32 offset;
 
+	if (!entry)
+		return -E2BIG;
+
 	switch (dir) {
 	case FLOW_OFFLOAD_DIR_ORIGINAL:
 		addr = flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.src_v4.s_addr;
@@ -372,14 +390,15 @@ static void flow_offload_ipv4_dnat(struct net *net,
 		offset = offsetof(struct iphdr, saddr);
 		break;
 	default:
-		return;
+		return -EOPNOTSUPP;
 	}
 
 	flow_offload_mangle(entry, FLOW_ACT_MANGLE_HDR_TYPE_IP4, offset,
 			    &addr, &mask);
+	return 0;
 }
 
-static void flow_offload_ipv6_mangle(struct nf_flow_rule *flow_rule,
+static int flow_offload_ipv6_mangle(struct nf_flow_rule *flow_rule,
 				     unsigned int offset,
 				     const __be32 *addr, const __be32 *mask)
 {
@@ -388,15 +407,20 @@ static void flow_offload_ipv6_mangle(struct nf_flow_rule *flow_rule,
 
 	for (i = 0; i < sizeof(struct in6_addr) / sizeof(u32); i++) {
 		entry = flow_action_entry_next(flow_rule);
+		if (!entry)
+			return -E2BIG;
+
 		flow_offload_mangle(entry, FLOW_ACT_MANGLE_HDR_TYPE_IP6,
 				    offset + i * sizeof(u32), &addr[i], mask);
 	}
+
+	return 0;
 }
 
-static void flow_offload_ipv6_snat(struct net *net,
-				   const struct flow_offload *flow,
-				   enum flow_offload_tuple_dir dir,
-				   struct nf_flow_rule *flow_rule)
+static int flow_offload_ipv6_snat(struct net *net,
+				  const struct flow_offload *flow,
+				  enum flow_offload_tuple_dir dir,
+				  struct nf_flow_rule *flow_rule)
 {
 	u32 mask = ~htonl(0xffffffff);
 	const __be32 *addr;
@@ -412,16 +436,16 @@ static void flow_offload_ipv6_snat(struct net *net,
 		offset = offsetof(struct ipv6hdr, daddr);
 		break;
 	default:
-		return;
+		return -EOPNOTSUPP;
 	}
 
-	flow_offload_ipv6_mangle(flow_rule, offset, addr, &mask);
+	return flow_offload_ipv6_mangle(flow_rule, offset, addr, &mask);
 }
 
-static void flow_offload_ipv6_dnat(struct net *net,
-				   const struct flow_offload *flow,
-				   enum flow_offload_tuple_dir dir,
-				   struct nf_flow_rule *flow_rule)
+static int flow_offload_ipv6_dnat(struct net *net,
+				  const struct flow_offload *flow,
+				  enum flow_offload_tuple_dir dir,
+				  struct nf_flow_rule *flow_rule)
 {
 	u32 mask = ~htonl(0xffffffff);
 	const __be32 *addr;
@@ -437,10 +461,10 @@ static void flow_offload_ipv6_dnat(struct net *net,
 		offset = offsetof(struct ipv6hdr, saddr);
 		break;
 	default:
-		return;
+		return -EOPNOTSUPP;
 	}
 
-	flow_offload_ipv6_mangle(flow_rule, offset, addr, &mask);
+	return flow_offload_ipv6_mangle(flow_rule, offset, addr, &mask);
 }
 
 static int flow_offload_l4proto(const struct flow_offload *flow)
@@ -462,15 +486,18 @@ static int flow_offload_l4proto(const struct flow_offload *flow)
 	return type;
 }
 
-static void flow_offload_port_snat(struct net *net,
-				   const struct flow_offload *flow,
-				   enum flow_offload_tuple_dir dir,
-				   struct nf_flow_rule *flow_rule)
+static int flow_offload_port_snat(struct net *net,
+				  const struct flow_offload *flow,
+				  enum flow_offload_tuple_dir dir,
+				  struct nf_flow_rule *flow_rule)
 {
 	struct flow_action_entry *entry = flow_action_entry_next(flow_rule);
 	u32 mask, port;
 	u32 offset;
 
+	if (!entry)
+		return -E2BIG;
+
 	switch (dir) {
 	case FLOW_OFFLOAD_DIR_ORIGINAL:
 		port = ntohs(flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.dst_port);
@@ -485,22 +512,26 @@ static void flow_offload_port_snat(struct net *net,
 		mask = ~htonl(0xffff);
 		break;
 	default:
-		return;
+		return -EOPNOTSUPP;
 	}
 
 	flow_offload_mangle(entry, flow_offload_l4proto(flow), offset,
 			    &port, &mask);
+	return 0;
 }
 
-static void flow_offload_port_dnat(struct net *net,
-				   const struct flow_offload *flow,
-				   enum flow_offload_tuple_dir dir,
-				   struct nf_flow_rule *flow_rule)
+static int flow_offload_port_dnat(struct net *net,
+				  const struct flow_offload *flow,
+				  enum flow_offload_tuple_dir dir,
+				  struct nf_flow_rule *flow_rule)
 {
 	struct flow_action_entry *entry = flow_action_entry_next(flow_rule);
 	u32 mask, port;
 	u32 offset;
 
+	if (!entry)
+		return -E2BIG;
+
 	switch (dir) {
 	case FLOW_OFFLOAD_DIR_ORIGINAL:
 		port = ntohs(flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.src_port);
@@ -515,20 +546,24 @@ static void flow_offload_port_dnat(struct net *net,
 		mask = ~htonl(0xffff0000);
 		break;
 	default:
-		return;
+		return -EOPNOTSUPP;
 	}
 
 	flow_offload_mangle(entry, flow_offload_l4proto(flow), offset,
 			    &port, &mask);
+	return 0;
 }
 
-static void flow_offload_ipv4_checksum(struct net *net,
-				       const struct flow_offload *flow,
-				       struct nf_flow_rule *flow_rule)
+static int flow_offload_ipv4_checksum(struct net *net,
+				      const struct flow_offload *flow,
+				      struct nf_flow_rule *flow_rule)
 {
 	u8 protonum = flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.l4proto;
 	struct flow_action_entry *entry = flow_action_entry_next(flow_rule);
 
+	if (!entry)
+		return E2BIG;
+
 	entry->id = FLOW_ACTION_CSUM;
 	entry->csum_flags = TCA_CSUM_UPDATE_FLAG_IPV4HDR;
 
@@ -540,12 +575,14 @@ static void flow_offload_ipv4_checksum(struct net *net,
 		entry->csum_flags |= TCA_CSUM_UPDATE_FLAG_UDP;
 		break;
 	}
+
+	return 0;
 }
 
-static void flow_offload_redirect(struct net *net,
-				  const struct flow_offload *flow,
-				  enum flow_offload_tuple_dir dir,
-				  struct nf_flow_rule *flow_rule)
+static int flow_offload_redirect(struct net *net,
+				 const struct flow_offload *flow,
+				 enum flow_offload_tuple_dir dir,
+				 struct nf_flow_rule *flow_rule)
 {
 	const struct flow_offload_tuple *this_tuple, *other_tuple;
 	struct flow_action_entry *entry;
@@ -563,21 +600,26 @@ static void flow_offload_redirect(struct net *net,
 		ifindex = other_tuple->iifidx;
 		break;
 	default:
-		return;
+		return -EOPNOTSUPP;
 	}
 
 	dev = dev_get_by_index(net, ifindex);
 	if (!dev)
-		return;
+		return -ENODEV;
 
 	entry = flow_action_entry_next(flow_rule);
+	if (!entry)
+		return -E2BIG;
+
 	entry->id = FLOW_ACTION_REDIRECT;
 	entry->dev = dev;
+
+	return 0;
 }
 
-static void flow_offload_encap_tunnel(const struct flow_offload *flow,
-				      enum flow_offload_tuple_dir dir,
-				      struct nf_flow_rule *flow_rule)
+static int flow_offload_encap_tunnel(const struct flow_offload *flow,
+				     enum flow_offload_tuple_dir dir,
+				     struct nf_flow_rule *flow_rule)
 {
 	const struct flow_offload_tuple *this_tuple;
 	struct flow_action_entry *entry;
@@ -585,7 +627,7 @@ static void flow_offload_encap_tunnel(const struct flow_offload *flow,
 
 	this_tuple = &flow->tuplehash[dir].tuple;
 	if (this_tuple->xmit_type == FLOW_OFFLOAD_XMIT_DIRECT)
-		return;
+		return 0;
 
 	dst = this_tuple->dst_cache;
 	if (dst && dst->lwtstate) {
@@ -594,15 +636,19 @@ static void flow_offload_encap_tunnel(const struct flow_offload *flow,
 		tun_info = lwt_tun_info(dst->lwtstate);
 		if (tun_info && (tun_info->mode & IP_TUNNEL_INFO_TX)) {
 			entry = flow_action_entry_next(flow_rule);
+			if (!entry)
+				return -E2BIG;
 			entry->id = FLOW_ACTION_TUNNEL_ENCAP;
 			entry->tunnel = tun_info;
 		}
 	}
+
+	return 0;
 }
 
-static void flow_offload_decap_tunnel(const struct flow_offload *flow,
-				      enum flow_offload_tuple_dir dir,
-				      struct nf_flow_rule *flow_rule)
+static int flow_offload_decap_tunnel(const struct flow_offload *flow,
+				     enum flow_offload_tuple_dir dir,
+				     struct nf_flow_rule *flow_rule)
 {
 	const struct flow_offload_tuple *other_tuple;
 	struct flow_action_entry *entry;
@@ -610,7 +656,7 @@ static void flow_offload_decap_tunnel(const struct flow_offload *flow,
 
 	other_tuple = &flow->tuplehash[!dir].tuple;
 	if (other_tuple->xmit_type == FLOW_OFFLOAD_XMIT_DIRECT)
-		return;
+		return 0;
 
 	dst = other_tuple->dst_cache;
 	if (dst && dst->lwtstate) {
@@ -619,9 +665,13 @@ static void flow_offload_decap_tunnel(const struct flow_offload *flow,
 		tun_info = lwt_tun_info(dst->lwtstate);
 		if (tun_info && (tun_info->mode & IP_TUNNEL_INFO_TX)) {
 			entry = flow_action_entry_next(flow_rule);
+			if (!entry)
+				return -E2BIG;
 			entry->id = FLOW_ACTION_TUNNEL_DECAP;
 		}
 	}
+
+	return 0;
 }
 
 static int
@@ -633,8 +683,9 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
 	const struct flow_offload_tuple *tuple;
 	int i;
 
-	flow_offload_decap_tunnel(flow, dir, flow_rule);
-	flow_offload_encap_tunnel(flow, dir, flow_rule);
+	if (flow_offload_decap_tunnel(flow, dir, flow_rule) < 0 ||
+	    flow_offload_encap_tunnel(flow, dir, flow_rule) < 0)
+		return -1;
 
 	if (flow_offload_eth_src(net, flow, dir, flow_rule) < 0 ||
 	    flow_offload_eth_dst(net, flow, dir, flow_rule) < 0)
@@ -650,6 +701,8 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
 
 		if (tuple->encap[i].proto == htons(ETH_P_8021Q)) {
 			entry = flow_action_entry_next(flow_rule);
+			if (!entry)
+				return -1;
 			entry->id = FLOW_ACTION_VLAN_POP;
 		}
 	}
@@ -663,6 +716,8 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
 			continue;
 
 		entry = flow_action_entry_next(flow_rule);
+		if (!entry)
+			return -1;
 
 		switch (other_tuple->encap[i].proto) {
 		case htons(ETH_P_PPP_SES):
@@ -688,18 +743,22 @@ int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 		return -1;
 
 	if (test_bit(NF_FLOW_SNAT, &flow->flags)) {
-		flow_offload_ipv4_snat(net, flow, dir, flow_rule);
-		flow_offload_port_snat(net, flow, dir, flow_rule);
+		if (flow_offload_ipv4_snat(net, flow, dir, flow_rule) < 0 ||
+		    flow_offload_port_snat(net, flow, dir, flow_rule) < 0)
+			return -1;
 	}
 	if (test_bit(NF_FLOW_DNAT, &flow->flags)) {
-		flow_offload_ipv4_dnat(net, flow, dir, flow_rule);
-		flow_offload_port_dnat(net, flow, dir, flow_rule);
+		if (flow_offload_ipv4_dnat(net, flow, dir, flow_rule) < 0 ||
+		    flow_offload_port_dnat(net, flow, dir, flow_rule) < 0)
+			return -1;
 	}
 	if (test_bit(NF_FLOW_SNAT, &flow->flags) ||
 	    test_bit(NF_FLOW_DNAT, &flow->flags))
-		flow_offload_ipv4_checksum(net, flow, flow_rule);
+		if (flow_offload_ipv4_checksum(net, flow, flow_rule) < 0)
+			return -1;
 
-	flow_offload_redirect(net, flow, dir, flow_rule);
+	if (flow_offload_redirect(net, flow, dir, flow_rule) < 0)
+		return -1;
 
 	return 0;
 }
@@ -713,22 +772,23 @@ int nf_flow_rule_route_ipv6(struct net *net, struct flow_offload *flow,
 		return -1;
 
 	if (test_bit(NF_FLOW_SNAT, &flow->flags)) {
-		flow_offload_ipv6_snat(net, flow, dir, flow_rule);
-		flow_offload_port_snat(net, flow, dir, flow_rule);
+		if (flow_offload_ipv6_snat(net, flow, dir, flow_rule) < 0 ||
+		    flow_offload_port_snat(net, flow, dir, flow_rule) < 0)
+			return -1;
 	}
 	if (test_bit(NF_FLOW_DNAT, &flow->flags)) {
-		flow_offload_ipv6_dnat(net, flow, dir, flow_rule);
-		flow_offload_port_dnat(net, flow, dir, flow_rule);
+		if (flow_offload_ipv6_dnat(net, flow, dir, flow_rule) < 0 ||
+		    flow_offload_port_dnat(net, flow, dir, flow_rule) < 0)
+			return -1;
 	}
 
-	flow_offload_redirect(net, flow, dir, flow_rule);
+	if (flow_offload_redirect(net, flow, dir, flow_rule) < 0)
+		return -1;
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nf_flow_rule_route_ipv6);
 
-#define NF_FLOW_RULE_ACTION_MAX	16
-
 static struct nf_flow_rule *
 nf_flow_offload_rule_alloc(struct net *net,
 			   const struct flow_offload_work *offload,
-- 
2.47.3


