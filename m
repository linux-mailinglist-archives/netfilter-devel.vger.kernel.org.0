Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD8686752
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Feb 2023 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjBANpf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Feb 2023 08:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjBANpd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:45:33 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCCA4F36F
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Feb 2023 05:45:32 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pNDQX-0004UC-I3; Wed, 01 Feb 2023 14:45:29 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Russel King <linux@armlinux.org.uk>
Subject: [PATCH nf-next] netfilter: let reset rules clean out conntrack entries
Date:   Wed,  1 Feb 2023 14:45:22 +0100
Message-Id: <20230201134522.13188-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

iptables/nftables support responding to tcp packets with tcp resets.

The generated tcp reset packet passes through both output and postrouting
netfilter hooks, but conntrack will never see them because the generated
skb has its ->nfct pointer copied over from the packet that triggered the
reset rule.

If the reset rule is used for established connections, this
may result in the conntrack entry to be around for a very long
time (default timeout is 5 days).

One way to avoid this would be to not copy the nf_conn pointer
so that the rest packet passes through conntrack too.

Problem is that output rules might not have the same conntrack
zone setup as the prerouting ones, so its possible that the
reset skb won't find the correct entry.  Generating a template
entry for the skb seems error prone as well.

Add an explicit "closing" function that switches a confirmed
conntrack entry to closed state and wire this up for tcp.

If the entry isn't confirmed, no action is needed because
the conntrack entry will never be committed to the table.

Reported-by: Russel King <linux@armlinux.org.uk>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter.h              |  3 +++
 include/net/netfilter/nf_conntrack.h   |  8 ++++++
 net/ipv4/netfilter/nf_reject_ipv4.c    |  1 +
 net/ipv6/netfilter/nf_reject_ipv6.c    |  1 +
 net/netfilter/core.c                   | 16 ++++++++++++
 net/netfilter/nf_conntrack_core.c      | 12 +++++++++
 net/netfilter/nf_conntrack_proto_tcp.c | 35 ++++++++++++++++++++++++++
 7 files changed, 76 insertions(+)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index d8817d381c14..b9ae8427d351 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -437,11 +437,13 @@ nf_nat_decode_session(struct sk_buff *skb, struct flowi *fl, u_int8_t family)
 #include <linux/netfilter/nf_conntrack_zones_common.h>
 
 void nf_ct_attach(struct sk_buff *, const struct sk_buff *);
+void nf_ct_set_closing(struct nf_conntrack *nfct);
 struct nf_conntrack_tuple;
 bool nf_ct_get_tuple_skb(struct nf_conntrack_tuple *dst_tuple,
 			 const struct sk_buff *skb);
 #else
 static inline void nf_ct_attach(struct sk_buff *new, struct sk_buff *skb) {}
+static inline void nf_ct_set_closing(struct nf_conntrack *nfct) {}
 struct nf_conntrack_tuple;
 static inline bool nf_ct_get_tuple_skb(struct nf_conntrack_tuple *dst_tuple,
 				       const struct sk_buff *skb)
@@ -459,6 +461,7 @@ struct nf_ct_hook {
 	bool (*get_tuple_skb)(struct nf_conntrack_tuple *,
 			      const struct sk_buff *);
 	void (*attach)(struct sk_buff *nskb, const struct sk_buff *skb);
+	void (*set_closing)(struct nf_conntrack *nfct);
 };
 extern const struct nf_ct_hook __rcu *nf_ct_hook;
 
diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 6a2019aaa464..3dbf947285be 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -125,6 +125,12 @@ struct nf_conn {
 	union nf_conntrack_proto proto;
 };
 
+static inline struct nf_conn *
+nf_ct_to_nf_conn(const struct nf_conntrack *nfct)
+{
+	return container_of(nfct, struct nf_conn, ct_general);
+}
+
 static inline struct nf_conn *
 nf_ct_tuplehash_to_ctrack(const struct nf_conntrack_tuple_hash *hash)
 {
@@ -175,6 +181,8 @@ nf_ct_get(const struct sk_buff *skb, enum ip_conntrack_info *ctinfo)
 
 void nf_ct_destroy(struct nf_conntrack *nfct);
 
+void nf_conntrack_tcp_set_closing(struct nf_conn *ct);
+
 /* decrement reference count on a conntrack */
 static inline void nf_ct_put(struct nf_conn *ct)
 {
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index d640adcaf1b1..f33aeab9424f 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -280,6 +280,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		goto free_nskb;
 
 	nf_ct_attach(nskb, oldskb);
+	nf_ct_set_closing(skb_nfct(oldskb));
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	/* If we use ip_local_out for bridged traffic, the MAC source on
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index f61d4f18e1cf..58ccdb08c0fd 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -345,6 +345,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	nf_reject_ip6_tcphdr_put(nskb, oldskb, otcph, otcplen);
 
 	nf_ct_attach(nskb, oldskb);
+	nf_ct_set_closing(skb_nfct(oldskb));
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	/* If we use ip6_local_out for bridged traffic, the MAC source on
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 5a6705a0e4ec..b2fdbbed2b4b 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -702,6 +702,22 @@ void nf_conntrack_destroy(struct nf_conntrack *nfct)
 }
 EXPORT_SYMBOL(nf_conntrack_destroy);
 
+void nf_ct_set_closing(struct nf_conntrack *nfct)
+{
+	const struct nf_ct_hook *ct_hook;
+
+	if (!nfct)
+		return;
+
+	rcu_read_lock();
+	ct_hook = rcu_dereference(nf_ct_hook);
+	if (ct_hook)
+		ct_hook->set_closing(nfct);
+
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(nf_ct_set_closing);
+
 bool nf_ct_get_tuple_skb(struct nf_conntrack_tuple *dst_tuple,
 			 const struct sk_buff *skb)
 {
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index c00858344f02..430bb52b6454 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2747,11 +2747,23 @@ int nf_conntrack_init_start(void)
 	return ret;
 }
 
+static void nf_conntrack_set_closing(struct nf_conntrack *nfct)
+{
+	struct nf_conn *ct = nf_ct_to_nf_conn(nfct);
+
+	switch (nf_ct_protonum(ct)) {
+	case IPPROTO_TCP:
+		nf_conntrack_tcp_set_closing(ct);
+		break;
+	}
+}
+
 static const struct nf_ct_hook nf_conntrack_hook = {
 	.update		= nf_conntrack_update,
 	.destroy	= nf_ct_destroy,
 	.get_tuple_skb  = nf_conntrack_get_tuple_skb,
 	.attach		= nf_conntrack_attach,
+	.set_closing	= nf_conntrack_set_closing,
 };
 
 void nf_conntrack_init_end(void)
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 16ee5ebe1ce1..e765f4cb7d3d 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -911,6 +911,41 @@ static bool tcp_can_early_drop(const struct nf_conn *ct)
 	return false;
 }
 
+void nf_conntrack_tcp_set_closing(struct nf_conn *ct)
+{
+	enum tcp_conntrack old_state;
+	const unsigned int *timeouts;
+	u32 timeout;
+
+	if (!nf_ct_is_confirmed(ct))
+		return;
+
+	spin_lock_bh(&ct->lock);
+	old_state = ct->proto.tcp.state;
+	ct->proto.tcp.state = TCP_CONNTRACK_CLOSE;
+
+	if (old_state == TCP_CONNTRACK_CLOSE ||
+	    test_bit(IPS_FIXED_TIMEOUT_BIT, &ct->status)) {
+		spin_unlock_bh(&ct->lock);
+		return;
+	}
+
+	timeouts = nf_ct_timeout_lookup(ct);
+	if (!timeouts) {
+		const struct nf_tcp_net *tn;
+
+		tn = nf_tcp_pernet(nf_ct_net(ct));
+		timeouts = tn->timeouts;
+	}
+
+	timeout = timeouts[TCP_CONNTRACK_CLOSE];
+	WRITE_ONCE(ct->timeout, timeout + nfct_time_stamp);
+
+	spin_unlock_bh(&ct->lock);
+
+	nf_conntrack_event_cache(IPCT_PROTOINFO, ct);
+}
+
 static void nf_ct_tcp_state_reset(struct ip_ct_tcp_state *state)
 {
 	state->td_end		= 0;
-- 
2.39.1

