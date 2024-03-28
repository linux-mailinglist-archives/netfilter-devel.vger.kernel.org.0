Return-Path: <netfilter-devel+bounces-1430-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E96880E87
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF6E1F23116
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 09:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C00039FFF;
	Wed, 20 Mar 2024 09:26:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B2D3BB23
	for <netfilter-devel@vger.kernel.org>; Wed, 20 Mar 2024 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926806; cv=none; b=IpgKJiPSVwQydHpf8FvIkkx2BMeNIOIa6zG5ac78EuaqpLhNTy+ptaeqCOhDTUgymTSCW4nAG/O4OshSaspxe0uf7lY5HGkPfXMDuZPNNzZN1DJk6YGLQNMMs8SyYGQQfk1lTV3Quc+ER+Ugj4sopGuZWb31nh0awCfbdh3TXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926806; c=relaxed/simple;
	bh=8YzZTG9Qt3yxDO205DwPaoxvNvAvXQOE3e7+/PHjD9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RTTHqt7j1k/JPsewiS2dFWlghi4NlPBpkwqYdhtDgRPtqQzf38ipyuTLIYeqYYFMhuqYPPvP2AAZB3buIyr8c+SP/himUfW5d7KozILK4aDkctQn6uuAxXniyd9tQxvCDV9P1vSpJsZxH/0GNKU/40BSZEuM/KPiBk+1248RBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: sven.auhagen@voleatech.de,
	cratiu@nvidia.com,
	ozsh@nvidia.com,
	vladbu@nvidia.com,
	gal@nvidia.com
Subject: [PATCH nf 1/2] netfilter: flowtable: infer TCP state and timeout before flow teardown
Date: Wed, 20 Mar 2024 10:26:37 +0100
Message-Id: <20240320092638.798076-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case that either FIN or RST packet is seen, infer current TCP state
based on the TCP packet flags before setting the _TEARDOWN flag:

- FIN packets result in TCP_CONNTRACK_FIN_WAIT which uses a default
  timeout of 2 minutes.
- RST packets lead to tcp_state TCP_CONNTRACK_CLOSE of 10 seconds.

Therefore, TCP established state with a low timeout is not used anymore
when handing over the flow to the classic conntrack path, otherwise a
FIN packet coming in the reply direction could re-offload this flow
again.

Fixes: e5eaac2beb54 ("netfilter: flowtable: fix TCP flow teardown")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: leave things as is for the flow timeout expiration case.
    No established state and _unack timeout is assumed per Sven.

 include/net/netfilter/nf_flow_table.h |  1 +
 net/netfilter/nf_flow_table_core.c    | 38 ++++++++++++++++++++-------
 net/netfilter/nf_flow_table_ip.c      |  2 +-
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index a763dd327c6e..924f3720143f 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -293,6 +293,7 @@ int nf_flow_table_init(struct nf_flowtable *flow_table);
 void nf_flow_table_free(struct nf_flowtable *flow_table);
 
 void flow_offload_teardown(struct flow_offload *flow);
+void flow_offload_teardown_tcp(struct flow_offload *flow, bool fin);
 
 void nf_flow_snat_port(const struct flow_offload *flow,
 		       struct sk_buff *skb, unsigned int thoff,
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index a0571339239c..bd880c58bfab 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -165,10 +165,16 @@ void flow_offload_route_init(struct flow_offload *flow,
 }
 EXPORT_SYMBOL_GPL(flow_offload_route_init);
 
-static void flow_offload_fixup_tcp(struct ip_ct_tcp *tcp)
+static s32 flow_offload_fixup_tcp(struct net *net, struct nf_conn *ct,
+				  enum tcp_conntrack tcp_state)
 {
-	tcp->seen[0].td_maxwin = 0;
-	tcp->seen[1].td_maxwin = 0;
+	struct nf_tcp_net *tn = nf_tcp_pernet(net);
+
+	ct->proto.tcp.state = tcp_state;
+	ct->proto.tcp.seen[0].td_maxwin = 0;
+	ct->proto.tcp.seen[1].td_maxwin = 0;
+
+	return tn->timeouts[tcp_state];
 }
 
 static void flow_offload_fixup_ct(struct nf_conn *ct)
@@ -178,12 +184,7 @@ static void flow_offload_fixup_ct(struct nf_conn *ct)
 	s32 timeout;
 
 	if (l4num == IPPROTO_TCP) {
-		struct nf_tcp_net *tn = nf_tcp_pernet(net);
-
-		flow_offload_fixup_tcp(&ct->proto.tcp);
-
-		timeout = tn->timeouts[ct->proto.tcp.state];
-		timeout -= tn->offload_timeout;
+		timeout = flow_offload_fixup_tcp(net, ct, ct->proto.tcp.state);
 	} else if (l4num == IPPROTO_UDP) {
 		struct nf_udp_net *tn = nf_udp_pernet(net);
 		enum udp_conntrack state =
@@ -346,12 +347,29 @@ static void flow_offload_del(struct nf_flowtable *flow_table,
 
 void flow_offload_teardown(struct flow_offload *flow)
 {
+	flow_offload_fixup_ct(flow->ct);
+	smp_mb__before_atomic();
 	clear_bit(IPS_OFFLOAD_BIT, &flow->ct->status);
 	set_bit(NF_FLOW_TEARDOWN, &flow->flags);
-	flow_offload_fixup_ct(flow->ct);
 }
 EXPORT_SYMBOL_GPL(flow_offload_teardown);
 
+void flow_offload_teardown_tcp(struct flow_offload *flow, bool fin)
+{
+	enum tcp_conntrack tcp_state;
+
+	if (fin)
+		tcp_state = TCP_CONNTRACK_FIN_WAIT;
+	else /* rst */
+		tcp_state = TCP_CONNTRACK_CLOSE;
+
+	flow_offload_fixup_tcp(nf_ct_net(flow->ct), flow->ct, tcp_state);
+	smp_mb__before_atomic();
+	clear_bit(IPS_OFFLOAD_BIT, &flow->ct->status);
+	set_bit(NF_FLOW_TEARDOWN, &flow->flags);
+}
+EXPORT_SYMBOL_GPL(flow_offload_teardown_tcp);
+
 struct flow_offload_tuple_rhash *
 flow_offload_lookup(struct nf_flowtable *flow_table,
 		    struct flow_offload_tuple *tuple)
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index e45fade76409..13b6c453d8bc 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -29,7 +29,7 @@ static int nf_flow_state_check(struct flow_offload *flow, int proto,
 
 	tcph = (void *)(skb_network_header(skb) + thoff);
 	if (unlikely(tcph->fin || tcph->rst)) {
-		flow_offload_teardown(flow);
+		flow_offload_teardown_tcp(flow, tcph->fin);
 		return -1;
 	}
 
-- 
2.30.2


