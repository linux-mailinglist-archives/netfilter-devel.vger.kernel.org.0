Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6408D3823C
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Jun 2019 02:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfFGAj6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 6 Jun 2019 20:39:58 -0400
Received: from mx1.riseup.net ([198.252.153.129]:59014 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbfFGAj6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 6 Jun 2019 20:39:58 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 8EABF1A322B
        for <netfilter-devel@vger.kernel.org>; Thu,  6 Jun 2019 17:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1559867996; bh=7v28RJaJzmEj9hzSeQVrbs4FXN/Kp/078x9e5kZCzHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajfRa5pgbJLpgXPrcTbgRUza81gswLXvZ3gnLzLrHuVjLkiv8k/pufLJJ+PmQh6V6
         3d+Fti22BfHbZp9u61thDnDq9uT3Xsv0Mu3fQc75qFrwAMVtebEbe10y2QBDSiUbEd
         +SupU29uOJqqxcbr82DXzdIv/nH+E4BRhbQKkhrA=
X-Riseup-User-ID: 54272F5E527C83E6A5BEE967840872488D54D982AAA4B948D1A0F82375F6659A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 3CCB3222229;
        Thu,  6 Jun 2019 17:39:55 -0700 (PDT)
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH nf-next v4 3/3] netfilter: synproxy: extract SYNPROXY infrastructure from {ipt,ip6t}_SYNPROXY
Date:   Fri,  7 Jun 2019 02:36:07 +0200
Message-Id: <20190607003603.7758-4-ffmancera@riseup.net>
In-Reply-To: <20190607003603.7758-1-ffmancera@riseup.net>
References: <20190607003603.7758-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add common functions into nf_synproxy_core.c to prepare for nftables support.
The prototypes of the functions used by {ipt, ip6t}_SYNPROXY are in the new
file nf_synproxy.h

Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 include/net/netfilter/nf_conntrack_synproxy.h |  13 +-
 include/net/netfilter/nf_synproxy.h           |  46 +
 net/ipv4/netfilter/ipt_SYNPROXY.c             | 394 +-------
 net/ipv6/netfilter/ip6t_SYNPROXY.c            | 420 +-------
 net/netfilter/nf_synproxy_core.c              | 897 +++++++++++++++++-
 5 files changed, 923 insertions(+), 847 deletions(-)
 create mode 100644 include/net/netfilter/nf_synproxy.h

diff --git a/include/net/netfilter/nf_conntrack_synproxy.h b/include/net/netfilter/nf_conntrack_synproxy.h
index 2c7559a54092..c5659dcf5b1a 100644
--- a/include/net/netfilter/nf_conntrack_synproxy.h
+++ b/include/net/netfilter/nf_conntrack_synproxy.h
@@ -72,21 +72,12 @@ struct synproxy_options {
 };
 
 struct tcphdr;
-struct xt_synproxy_info;
+struct nf_synproxy_info;
 bool synproxy_parse_options(const struct sk_buff *skb, unsigned int doff,
 			    const struct tcphdr *th,
 			    struct synproxy_options *opts);
-unsigned int synproxy_options_size(const struct synproxy_options *opts);
-void synproxy_build_options(struct tcphdr *th,
-			    const struct synproxy_options *opts);
 
-void synproxy_init_timestamp_cookie(const struct xt_synproxy_info *info,
+void synproxy_init_timestamp_cookie(const struct nf_synproxy_info *info,
 				    struct synproxy_options *opts);
-void synproxy_check_timestamp_cookie(struct synproxy_options *opts);
-
-unsigned int synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
-				    struct tcphdr *th, struct nf_conn *ct,
-				    enum ip_conntrack_info ctinfo,
-				    const struct nf_conn_synproxy *synproxy);
 
 #endif /* _NF_CONNTRACK_SYNPROXY_H */
diff --git a/include/net/netfilter/nf_synproxy.h b/include/net/netfilter/nf_synproxy.h
new file mode 100644
index 000000000000..859945cabc4c
--- /dev/null
+++ b/include/net/netfilter/nf_synproxy.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NF_SYNPROXY_SHARED_H
+#define _NF_SYNPROXY_SHARED_H
+
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <net/ip6_checksum.h>
+#include <net/ip6_route.h>
+#include <net/tcp.h>
+
+#include <net/netfilter/nf_conntrack_seqadj.h>
+#include <net/netfilter/nf_conntrack_synproxy.h>
+
+/* IPv4 support */
+void synproxy_send_client_synack(struct net *net, const struct sk_buff *skb,
+				 const struct tcphdr *th,
+				 const struct synproxy_options *opts);
+
+bool synproxy_recv_client_ack(struct net *net,
+			      const struct sk_buff *skb,
+			      const struct tcphdr *th,
+			      struct synproxy_options *opts, u32 recv_seq);
+
+unsigned int ipv4_synproxy_hook(void *priv, struct sk_buff *skb,
+				const struct nf_hook_state *nhs);
+int nf_synproxy_ipv4_init(struct synproxy_net *snet, struct net *net);
+void nf_synproxy_ipv4_fini(struct synproxy_net *snet, struct net *net);
+
+#if IS_ENABLED(CONFIG_IPV6) /* IPv6 support */
+void synproxy_send_client_synack_ipv6(struct net *net,
+				      const struct sk_buff *skb,
+				      const struct tcphdr *th,
+				      const struct synproxy_options *opts);
+
+bool synproxy_recv_client_ack_ipv6(struct net *net, const struct sk_buff *skb,
+				   const struct tcphdr *th,
+				   struct synproxy_options *opts, u32 recv_seq);
+
+unsigned int ipv6_synproxy_hook(void *priv, struct sk_buff *skb,
+				const struct nf_hook_state *nhs);
+int nf_synproxy_ipv6_init(struct synproxy_net *snet, struct net *net);
+void nf_synproxy_ipv6_fini(struct synproxy_net *snet, struct net *net);
+
+#endif /* IPv6 support */
+
+#endif /* _NF_SYNPROXY_SHARED_H */
diff --git a/net/ipv4/netfilter/ipt_SYNPROXY.c b/net/ipv4/netfilter/ipt_SYNPROXY.c
index 690b17ef6a44..7f7979734fb4 100644
--- a/net/ipv4/netfilter/ipt_SYNPROXY.c
+++ b/net/ipv4/netfilter/ipt_SYNPROXY.c
@@ -6,258 +6,11 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
-#include <linux/skbuff.h>
-#include <net/tcp.h>
-
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter/xt_SYNPROXY.h>
-#include <net/netfilter/nf_conntrack.h>
-#include <net/netfilter/nf_conntrack_seqadj.h>
-#include <net/netfilter/nf_conntrack_synproxy.h>
-#include <net/netfilter/nf_conntrack_ecache.h>
-
-static struct iphdr *
-synproxy_build_ip(struct net *net, struct sk_buff *skb, __be32 saddr,
-		  __be32 daddr)
-{
-	struct iphdr *iph;
-
-	skb_reset_network_header(skb);
-	iph = skb_put(skb, sizeof(*iph));
-	iph->version	= 4;
-	iph->ihl	= sizeof(*iph) / 4;
-	iph->tos	= 0;
-	iph->id		= 0;
-	iph->frag_off	= htons(IP_DF);
-	iph->ttl	= net->ipv4.sysctl_ip_default_ttl;
-	iph->protocol	= IPPROTO_TCP;
-	iph->check	= 0;
-	iph->saddr	= saddr;
-	iph->daddr	= daddr;
-
-	return iph;
-}
-
-static void
-synproxy_send_tcp(struct net *net,
-		  const struct sk_buff *skb, struct sk_buff *nskb,
-		  struct nf_conntrack *nfct, enum ip_conntrack_info ctinfo,
-		  struct iphdr *niph, struct tcphdr *nth,
-		  unsigned int tcp_hdr_size)
-{
-	nth->check = ~tcp_v4_check(tcp_hdr_size, niph->saddr, niph->daddr, 0);
-	nskb->ip_summed   = CHECKSUM_PARTIAL;
-	nskb->csum_start  = (unsigned char *)nth - nskb->head;
-	nskb->csum_offset = offsetof(struct tcphdr, check);
-
-	skb_dst_set_noref(nskb, skb_dst(skb));
-	nskb->protocol = htons(ETH_P_IP);
-	if (ip_route_me_harder(net, nskb, RTN_UNSPEC))
-		goto free_nskb;
-
-	if (nfct) {
-		nf_ct_set(nskb, (struct nf_conn *)nfct, ctinfo);
-		nf_conntrack_get(nfct);
-	}
-
-	ip_local_out(net, nskb->sk, nskb);
-	return;
-
-free_nskb:
-	kfree_skb(nskb);
-}
-
-static void
-synproxy_send_client_synack(struct net *net,
-			    const struct sk_buff *skb, const struct tcphdr *th,
-			    const struct synproxy_options *opts)
-{
-	struct sk_buff *nskb;
-	struct iphdr *iph, *niph;
-	struct tcphdr *nth;
-	unsigned int tcp_hdr_size;
-	u16 mss = opts->mss;
-
-	iph = ip_hdr(skb);
-
-	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
-	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
-			 GFP_ATOMIC);
-	if (nskb == NULL)
-		return;
-	skb_reserve(nskb, MAX_TCP_HEADER);
-
-	niph = synproxy_build_ip(net, nskb, iph->daddr, iph->saddr);
-
-	skb_reset_transport_header(nskb);
-	nth = skb_put(nskb, tcp_hdr_size);
-	nth->source	= th->dest;
-	nth->dest	= th->source;
-	nth->seq	= htonl(__cookie_v4_init_sequence(iph, th, &mss));
-	nth->ack_seq	= htonl(ntohl(th->seq) + 1);
-	tcp_flag_word(nth) = TCP_FLAG_SYN | TCP_FLAG_ACK;
-	if (opts->options & XT_SYNPROXY_OPT_ECN)
-		tcp_flag_word(nth) |= TCP_FLAG_ECE;
-	nth->doff	= tcp_hdr_size / 4;
-	nth->window	= 0;
-	nth->check	= 0;
-	nth->urg_ptr	= 0;
-
-	synproxy_build_options(nth, opts);
-
-	synproxy_send_tcp(net, skb, nskb, skb_nfct(skb),
-			  IP_CT_ESTABLISHED_REPLY, niph, nth, tcp_hdr_size);
-}
-
-static void
-synproxy_send_server_syn(struct net *net,
-			 const struct sk_buff *skb, const struct tcphdr *th,
-			 const struct synproxy_options *opts, u32 recv_seq)
-{
-	struct synproxy_net *snet = synproxy_pernet(net);
-	struct sk_buff *nskb;
-	struct iphdr *iph, *niph;
-	struct tcphdr *nth;
-	unsigned int tcp_hdr_size;
-
-	iph = ip_hdr(skb);
-
-	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
-	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
-			 GFP_ATOMIC);
-	if (nskb == NULL)
-		return;
-	skb_reserve(nskb, MAX_TCP_HEADER);
-
-	niph = synproxy_build_ip(net, nskb, iph->saddr, iph->daddr);
-
-	skb_reset_transport_header(nskb);
-	nth = skb_put(nskb, tcp_hdr_size);
-	nth->source	= th->source;
-	nth->dest	= th->dest;
-	nth->seq	= htonl(recv_seq - 1);
-	/* ack_seq is used to relay our ISN to the synproxy hook to initialize
-	 * sequence number translation once a connection tracking entry exists.
-	 */
-	nth->ack_seq	= htonl(ntohl(th->ack_seq) - 1);
-	tcp_flag_word(nth) = TCP_FLAG_SYN;
-	if (opts->options & XT_SYNPROXY_OPT_ECN)
-		tcp_flag_word(nth) |= TCP_FLAG_ECE | TCP_FLAG_CWR;
-	nth->doff	= tcp_hdr_size / 4;
-	nth->window	= th->window;
-	nth->check	= 0;
-	nth->urg_ptr	= 0;
-
-	synproxy_build_options(nth, opts);
-
-	synproxy_send_tcp(net, skb, nskb, &snet->tmpl->ct_general, IP_CT_NEW,
-			  niph, nth, tcp_hdr_size);
-}
-
-static void
-synproxy_send_server_ack(struct net *net,
-			 const struct ip_ct_tcp *state,
-			 const struct sk_buff *skb, const struct tcphdr *th,
-			 const struct synproxy_options *opts)
-{
-	struct sk_buff *nskb;
-	struct iphdr *iph, *niph;
-	struct tcphdr *nth;
-	unsigned int tcp_hdr_size;
-
-	iph = ip_hdr(skb);
-
-	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
-	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
-			 GFP_ATOMIC);
-	if (nskb == NULL)
-		return;
-	skb_reserve(nskb, MAX_TCP_HEADER);
-
-	niph = synproxy_build_ip(net, nskb, iph->daddr, iph->saddr);
 
-	skb_reset_transport_header(nskb);
-	nth = skb_put(nskb, tcp_hdr_size);
-	nth->source	= th->dest;
-	nth->dest	= th->source;
-	nth->seq	= htonl(ntohl(th->ack_seq));
-	nth->ack_seq	= htonl(ntohl(th->seq) + 1);
-	tcp_flag_word(nth) = TCP_FLAG_ACK;
-	nth->doff	= tcp_hdr_size / 4;
-	nth->window	= htons(state->seen[IP_CT_DIR_ORIGINAL].td_maxwin);
-	nth->check	= 0;
-	nth->urg_ptr	= 0;
-
-	synproxy_build_options(nth, opts);
-
-	synproxy_send_tcp(net, skb, nskb, NULL, 0, niph, nth, tcp_hdr_size);
-}
-
-static void
-synproxy_send_client_ack(struct net *net,
-			 const struct sk_buff *skb, const struct tcphdr *th,
-			 const struct synproxy_options *opts)
-{
-	struct sk_buff *nskb;
-	struct iphdr *iph, *niph;
-	struct tcphdr *nth;
-	unsigned int tcp_hdr_size;
-
-	iph = ip_hdr(skb);
-
-	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
-	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
-			 GFP_ATOMIC);
-	if (nskb == NULL)
-		return;
-	skb_reserve(nskb, MAX_TCP_HEADER);
-
-	niph = synproxy_build_ip(net, nskb, iph->saddr, iph->daddr);
-
-	skb_reset_transport_header(nskb);
-	nth = skb_put(nskb, tcp_hdr_size);
-	nth->source	= th->source;
-	nth->dest	= th->dest;
-	nth->seq	= htonl(ntohl(th->seq) + 1);
-	nth->ack_seq	= th->ack_seq;
-	tcp_flag_word(nth) = TCP_FLAG_ACK;
-	nth->doff	= tcp_hdr_size / 4;
-	nth->window	= htons(ntohs(th->window) >> opts->wscale);
-	nth->check	= 0;
-	nth->urg_ptr	= 0;
-
-	synproxy_build_options(nth, opts);
-
-	synproxy_send_tcp(net, skb, nskb, skb_nfct(skb),
-			  IP_CT_ESTABLISHED_REPLY, niph, nth, tcp_hdr_size);
-}
-
-static bool
-synproxy_recv_client_ack(struct net *net,
-			 const struct sk_buff *skb, const struct tcphdr *th,
-			 struct synproxy_options *opts, u32 recv_seq)
-{
-	struct synproxy_net *snet = synproxy_pernet(net);
-	int mss;
-
-	mss = __cookie_v4_check(ip_hdr(skb), th, ntohl(th->ack_seq) - 1);
-	if (mss == 0) {
-		this_cpu_inc(snet->stats->cookie_invalid);
-		return false;
-	}
-
-	this_cpu_inc(snet->stats->cookie_valid);
-	opts->mss = mss;
-	opts->options |= XT_SYNPROXY_OPT_MSS;
-
-	if (opts->options & XT_SYNPROXY_OPT_TIMESTAMP)
-		synproxy_check_timestamp_cookie(opts);
-
-	synproxy_send_server_syn(net, skb, th, opts, recv_seq);
-	return true;
-}
+#include <net/netfilter/nf_synproxy.h>
 
 static unsigned int
 synproxy_tg4(struct sk_buff *skb, const struct xt_action_param *par)
@@ -309,135 +62,6 @@ synproxy_tg4(struct sk_buff *skb, const struct xt_action_param *par)
 	return XT_CONTINUE;
 }
 
-static unsigned int ipv4_synproxy_hook(void *priv,
-				       struct sk_buff *skb,
-				       const struct nf_hook_state *nhs)
-{
-	struct net *net = nhs->net;
-	struct synproxy_net *snet = synproxy_pernet(net);
-	enum ip_conntrack_info ctinfo;
-	struct nf_conn *ct;
-	struct nf_conn_synproxy *synproxy;
-	struct synproxy_options opts = {};
-	const struct ip_ct_tcp *state;
-	struct tcphdr *th, _th;
-	unsigned int thoff;
-
-	ct = nf_ct_get(skb, &ctinfo);
-	if (ct == NULL)
-		return NF_ACCEPT;
-
-	synproxy = nfct_synproxy(ct);
-	if (synproxy == NULL)
-		return NF_ACCEPT;
-
-	if (nf_is_loopback_packet(skb) ||
-	    ip_hdr(skb)->protocol != IPPROTO_TCP)
-		return NF_ACCEPT;
-
-	thoff = ip_hdrlen(skb);
-	th = skb_header_pointer(skb, thoff, sizeof(_th), &_th);
-	if (th == NULL)
-		return NF_DROP;
-
-	state = &ct->proto.tcp;
-	switch (state->state) {
-	case TCP_CONNTRACK_CLOSE:
-		if (th->rst && !test_bit(IPS_SEEN_REPLY_BIT, &ct->status)) {
-			nf_ct_seqadj_init(ct, ctinfo, synproxy->isn -
-						      ntohl(th->seq) + 1);
-			break;
-		}
-
-		if (!th->syn || th->ack ||
-		    CTINFO2DIR(ctinfo) != IP_CT_DIR_ORIGINAL)
-			break;
-
-		/* Reopened connection - reset the sequence number and timestamp
-		 * adjustments, they will get initialized once the connection is
-		 * reestablished.
-		 */
-		nf_ct_seqadj_init(ct, ctinfo, 0);
-		synproxy->tsoff = 0;
-		this_cpu_inc(snet->stats->conn_reopened);
-
-		/* fall through */
-	case TCP_CONNTRACK_SYN_SENT:
-		if (!synproxy_parse_options(skb, thoff, th, &opts))
-			return NF_DROP;
-
-		if (!th->syn && th->ack &&
-		    CTINFO2DIR(ctinfo) == IP_CT_DIR_ORIGINAL) {
-			/* Keep-Alives are sent with SEG.SEQ = SND.NXT-1,
-			 * therefore we need to add 1 to make the SYN sequence
-			 * number match the one of first SYN.
-			 */
-			if (synproxy_recv_client_ack(net, skb, th, &opts,
-						     ntohl(th->seq) + 1)) {
-				this_cpu_inc(snet->stats->cookie_retrans);
-				consume_skb(skb);
-				return NF_STOLEN;
-			} else {
-				return NF_DROP;
-			}
-		}
-
-		synproxy->isn = ntohl(th->ack_seq);
-		if (opts.options & XT_SYNPROXY_OPT_TIMESTAMP)
-			synproxy->its = opts.tsecr;
-
-		nf_conntrack_event_cache(IPCT_SYNPROXY, ct);
-		break;
-	case TCP_CONNTRACK_SYN_RECV:
-		if (!th->syn || !th->ack)
-			break;
-
-		if (!synproxy_parse_options(skb, thoff, th, &opts))
-			return NF_DROP;
-
-		if (opts.options & XT_SYNPROXY_OPT_TIMESTAMP) {
-			synproxy->tsoff = opts.tsval - synproxy->its;
-			nf_conntrack_event_cache(IPCT_SYNPROXY, ct);
-		}
-
-		opts.options &= ~(XT_SYNPROXY_OPT_MSS |
-				  XT_SYNPROXY_OPT_WSCALE |
-				  XT_SYNPROXY_OPT_SACK_PERM);
-
-		swap(opts.tsval, opts.tsecr);
-		synproxy_send_server_ack(net, state, skb, th, &opts);
-
-		nf_ct_seqadj_init(ct, ctinfo, synproxy->isn - ntohl(th->seq));
-		nf_conntrack_event_cache(IPCT_SEQADJ, ct);
-
-		swap(opts.tsval, opts.tsecr);
-		synproxy_send_client_ack(net, skb, th, &opts);
-
-		consume_skb(skb);
-		return NF_STOLEN;
-	default:
-		break;
-	}
-
-	synproxy_tstamp_adjust(skb, thoff, th, ct, ctinfo, synproxy);
-	return NF_ACCEPT;
-}
-
-static const struct nf_hook_ops ipv4_synproxy_ops[] = {
-	{
-		.hook		= ipv4_synproxy_hook,
-		.pf		= NFPROTO_IPV4,
-		.hooknum	= NF_INET_LOCAL_IN,
-		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
-	},
-	{
-		.hook		= ipv4_synproxy_hook,
-		.pf		= NFPROTO_IPV4,
-		.hooknum	= NF_INET_POST_ROUTING,
-		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
-	},
-};
-
 static int synproxy_tg4_check(const struct xt_tgchk_param *par)
 {
 	struct synproxy_net *snet = synproxy_pernet(par->net);
@@ -452,13 +76,10 @@ static int synproxy_tg4_check(const struct xt_tgchk_param *par)
 	if (err)
 		return err;
 
-	if (snet->hook_ref4 == 0) {
-		err = nf_register_net_hooks(par->net, ipv4_synproxy_ops,
-					    ARRAY_SIZE(ipv4_synproxy_ops));
-		if (err) {
-			nf_ct_netns_put(par->net, par->family);
-			return err;
-		}
+	err = nf_synproxy_ipv4_init(snet, par->net);
+	if (err) {
+		nf_ct_netns_put(par->net, par->family);
+		return err;
 	}
 
 	snet->hook_ref4++;
@@ -469,10 +90,7 @@ static void synproxy_tg4_destroy(const struct xt_tgdtor_param *par)
 {
 	struct synproxy_net *snet = synproxy_pernet(par->net);
 
-	snet->hook_ref4--;
-	if (snet->hook_ref4 == 0)
-		nf_unregister_net_hooks(par->net, ipv4_synproxy_ops,
-					ARRAY_SIZE(ipv4_synproxy_ops));
+	nf_synproxy_ipv4_fini(snet, par->net);
 	nf_ct_netns_put(par->net, par->family);
 }
 
diff --git a/net/ipv6/netfilter/ip6t_SYNPROXY.c b/net/ipv6/netfilter/ip6t_SYNPROXY.c
index cb6d42b03cb5..55a9b92d0a1f 100644
--- a/net/ipv6/netfilter/ip6t_SYNPROXY.c
+++ b/net/ipv6/netfilter/ip6t_SYNPROXY.c
@@ -6,272 +6,11 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
-#include <linux/skbuff.h>
-#include <net/ip6_checksum.h>
-#include <net/ip6_route.h>
-#include <net/tcp.h>
-
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter/xt_SYNPROXY.h>
-#include <net/netfilter/nf_conntrack.h>
-#include <net/netfilter/nf_conntrack_seqadj.h>
-#include <net/netfilter/nf_conntrack_synproxy.h>
-#include <net/netfilter/nf_conntrack_ecache.h>
-
-static struct ipv6hdr *
-synproxy_build_ip(struct net *net, struct sk_buff *skb,
-		  const struct in6_addr *saddr,
-		  const struct in6_addr *daddr)
-{
-	struct ipv6hdr *iph;
-
-	skb_reset_network_header(skb);
-	iph = skb_put(skb, sizeof(*iph));
-	ip6_flow_hdr(iph, 0, 0);
-	iph->hop_limit	= net->ipv6.devconf_all->hop_limit;
-	iph->nexthdr	= IPPROTO_TCP;
-	iph->saddr	= *saddr;
-	iph->daddr	= *daddr;
-
-	return iph;
-}
-
-static void
-synproxy_send_tcp(struct net *net,
-		  const struct sk_buff *skb, struct sk_buff *nskb,
-		  struct nf_conntrack *nfct, enum ip_conntrack_info ctinfo,
-		  struct ipv6hdr *niph, struct tcphdr *nth,
-		  unsigned int tcp_hdr_size)
-{
-	struct dst_entry *dst;
-	struct flowi6 fl6;
-
-	nth->check = ~tcp_v6_check(tcp_hdr_size, &niph->saddr, &niph->daddr, 0);
-	nskb->ip_summed   = CHECKSUM_PARTIAL;
-	nskb->csum_start  = (unsigned char *)nth - nskb->head;
-	nskb->csum_offset = offsetof(struct tcphdr, check);
-
-	memset(&fl6, 0, sizeof(fl6));
-	fl6.flowi6_proto = IPPROTO_TCP;
-	fl6.saddr = niph->saddr;
-	fl6.daddr = niph->daddr;
-	fl6.fl6_sport = nth->source;
-	fl6.fl6_dport = nth->dest;
-	security_skb_classify_flow((struct sk_buff *)skb, flowi6_to_flowi(&fl6));
-	dst = ip6_route_output(net, NULL, &fl6);
-	if (dst->error) {
-		dst_release(dst);
-		goto free_nskb;
-	}
-	dst = xfrm_lookup(net, dst, flowi6_to_flowi(&fl6), NULL, 0);
-	if (IS_ERR(dst))
-		goto free_nskb;
-
-	skb_dst_set(nskb, dst);
-
-	if (nfct) {
-		nf_ct_set(nskb, (struct nf_conn *)nfct, ctinfo);
-		nf_conntrack_get(nfct);
-	}
-
-	ip6_local_out(net, nskb->sk, nskb);
-	return;
-
-free_nskb:
-	kfree_skb(nskb);
-}
-
-static void
-synproxy_send_client_synack(struct net *net,
-			    const struct sk_buff *skb, const struct tcphdr *th,
-			    const struct synproxy_options *opts)
-{
-	struct sk_buff *nskb;
-	struct ipv6hdr *iph, *niph;
-	struct tcphdr *nth;
-	unsigned int tcp_hdr_size;
-	u16 mss = opts->mss;
-
-	iph = ipv6_hdr(skb);
-
-	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
-	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
-			 GFP_ATOMIC);
-	if (nskb == NULL)
-		return;
-	skb_reserve(nskb, MAX_TCP_HEADER);
-
-	niph = synproxy_build_ip(net, nskb, &iph->daddr, &iph->saddr);
-
-	skb_reset_transport_header(nskb);
-	nth = skb_put(nskb, tcp_hdr_size);
-	nth->source	= th->dest;
-	nth->dest	= th->source;
-	nth->seq	= htonl(__cookie_v6_init_sequence(iph, th, &mss));
-	nth->ack_seq	= htonl(ntohl(th->seq) + 1);
-	tcp_flag_word(nth) = TCP_FLAG_SYN | TCP_FLAG_ACK;
-	if (opts->options & XT_SYNPROXY_OPT_ECN)
-		tcp_flag_word(nth) |= TCP_FLAG_ECE;
-	nth->doff	= tcp_hdr_size / 4;
-	nth->window	= 0;
-	nth->check	= 0;
-	nth->urg_ptr	= 0;
-
-	synproxy_build_options(nth, opts);
-
-	synproxy_send_tcp(net, skb, nskb, skb_nfct(skb),
-			  IP_CT_ESTABLISHED_REPLY, niph, nth, tcp_hdr_size);
-}
 
-static void
-synproxy_send_server_syn(struct net *net,
-			 const struct sk_buff *skb, const struct tcphdr *th,
-			 const struct synproxy_options *opts, u32 recv_seq)
-{
-	struct synproxy_net *snet = synproxy_pernet(net);
-	struct sk_buff *nskb;
-	struct ipv6hdr *iph, *niph;
-	struct tcphdr *nth;
-	unsigned int tcp_hdr_size;
-
-	iph = ipv6_hdr(skb);
-
-	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
-	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
-			 GFP_ATOMIC);
-	if (nskb == NULL)
-		return;
-	skb_reserve(nskb, MAX_TCP_HEADER);
-
-	niph = synproxy_build_ip(net, nskb, &iph->saddr, &iph->daddr);
-
-	skb_reset_transport_header(nskb);
-	nth = skb_put(nskb, tcp_hdr_size);
-	nth->source	= th->source;
-	nth->dest	= th->dest;
-	nth->seq	= htonl(recv_seq - 1);
-	/* ack_seq is used to relay our ISN to the synproxy hook to initialize
-	 * sequence number translation once a connection tracking entry exists.
-	 */
-	nth->ack_seq	= htonl(ntohl(th->ack_seq) - 1);
-	tcp_flag_word(nth) = TCP_FLAG_SYN;
-	if (opts->options & XT_SYNPROXY_OPT_ECN)
-		tcp_flag_word(nth) |= TCP_FLAG_ECE | TCP_FLAG_CWR;
-	nth->doff	= tcp_hdr_size / 4;
-	nth->window	= th->window;
-	nth->check	= 0;
-	nth->urg_ptr	= 0;
-
-	synproxy_build_options(nth, opts);
-
-	synproxy_send_tcp(net, skb, nskb, &snet->tmpl->ct_general, IP_CT_NEW,
-			  niph, nth, tcp_hdr_size);
-}
-
-static void
-synproxy_send_server_ack(struct net *net,
-			 const struct ip_ct_tcp *state,
-			 const struct sk_buff *skb, const struct tcphdr *th,
-			 const struct synproxy_options *opts)
-{
-	struct sk_buff *nskb;
-	struct ipv6hdr *iph, *niph;
-	struct tcphdr *nth;
-	unsigned int tcp_hdr_size;
-
-	iph = ipv6_hdr(skb);
-
-	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
-	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
-			 GFP_ATOMIC);
-	if (nskb == NULL)
-		return;
-	skb_reserve(nskb, MAX_TCP_HEADER);
-
-	niph = synproxy_build_ip(net, nskb, &iph->daddr, &iph->saddr);
-
-	skb_reset_transport_header(nskb);
-	nth = skb_put(nskb, tcp_hdr_size);
-	nth->source	= th->dest;
-	nth->dest	= th->source;
-	nth->seq	= htonl(ntohl(th->ack_seq));
-	nth->ack_seq	= htonl(ntohl(th->seq) + 1);
-	tcp_flag_word(nth) = TCP_FLAG_ACK;
-	nth->doff	= tcp_hdr_size / 4;
-	nth->window	= htons(state->seen[IP_CT_DIR_ORIGINAL].td_maxwin);
-	nth->check	= 0;
-	nth->urg_ptr	= 0;
-
-	synproxy_build_options(nth, opts);
-
-	synproxy_send_tcp(net, skb, nskb, NULL, 0, niph, nth, tcp_hdr_size);
-}
-
-static void
-synproxy_send_client_ack(struct net *net,
-			 const struct sk_buff *skb, const struct tcphdr *th,
-			 const struct synproxy_options *opts)
-{
-	struct sk_buff *nskb;
-	struct ipv6hdr *iph, *niph;
-	struct tcphdr *nth;
-	unsigned int tcp_hdr_size;
-
-	iph = ipv6_hdr(skb);
-
-	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
-	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
-			 GFP_ATOMIC);
-	if (nskb == NULL)
-		return;
-	skb_reserve(nskb, MAX_TCP_HEADER);
-
-	niph = synproxy_build_ip(net, nskb, &iph->saddr, &iph->daddr);
-
-	skb_reset_transport_header(nskb);
-	nth = skb_put(nskb, tcp_hdr_size);
-	nth->source	= th->source;
-	nth->dest	= th->dest;
-	nth->seq	= htonl(ntohl(th->seq) + 1);
-	nth->ack_seq	= th->ack_seq;
-	tcp_flag_word(nth) = TCP_FLAG_ACK;
-	nth->doff	= tcp_hdr_size / 4;
-	nth->window	= htons(ntohs(th->window) >> opts->wscale);
-	nth->check	= 0;
-	nth->urg_ptr	= 0;
-
-	synproxy_build_options(nth, opts);
-
-	synproxy_send_tcp(net, skb, nskb, skb_nfct(skb),
-			  IP_CT_ESTABLISHED_REPLY, niph, nth, tcp_hdr_size);
-}
-
-static bool
-synproxy_recv_client_ack(struct net *net,
-			 const struct sk_buff *skb, const struct tcphdr *th,
-			 struct synproxy_options *opts, u32 recv_seq)
-{
-	struct synproxy_net *snet = synproxy_pernet(net);
-	int mss;
-
-	mss = __cookie_v6_check(ipv6_hdr(skb), th, ntohl(th->ack_seq) - 1);
-	if (mss == 0) {
-		this_cpu_inc(snet->stats->cookie_invalid);
-		return false;
-	}
-
-	this_cpu_inc(snet->stats->cookie_valid);
-	opts->mss = mss;
-	opts->options |= XT_SYNPROXY_OPT_MSS;
-
-	if (opts->options & XT_SYNPROXY_OPT_TIMESTAMP)
-		synproxy_check_timestamp_cookie(opts);
-
-	synproxy_send_server_syn(net, skb, th, opts, recv_seq);
-	return true;
-}
+#include <net/netfilter/nf_synproxy.h>
 
 static unsigned int
 synproxy_tg6(struct sk_buff *skb, const struct xt_action_param *par)
@@ -307,13 +46,14 @@ synproxy_tg6(struct sk_buff *skb, const struct xt_action_param *par)
 					  XT_SYNPROXY_OPT_SACK_PERM |
 					  XT_SYNPROXY_OPT_ECN);
 
-		synproxy_send_client_synack(net, skb, th, &opts);
+		synproxy_send_client_synack_ipv6(net, skb, th, &opts);
 		consume_skb(skb);
 		return NF_STOLEN;
 
 	} else if (th->ack && !(th->fin || th->rst || th->syn)) {
 		/* ACK from client */
-		if (synproxy_recv_client_ack(net, skb, th, &opts, ntohl(th->seq))) {
+		if (synproxy_recv_client_ack_ipv6(net, skb, th, &opts,
+						  ntohl(th->seq))) {
 			consume_skb(skb);
 			return NF_STOLEN;
 		} else {
@@ -324,141 +64,6 @@ synproxy_tg6(struct sk_buff *skb, const struct xt_action_param *par)
 	return XT_CONTINUE;
 }
 
-static unsigned int ipv6_synproxy_hook(void *priv,
-				       struct sk_buff *skb,
-				       const struct nf_hook_state *nhs)
-{
-	struct net *net = nhs->net;
-	struct synproxy_net *snet = synproxy_pernet(net);
-	enum ip_conntrack_info ctinfo;
-	struct nf_conn *ct;
-	struct nf_conn_synproxy *synproxy;
-	struct synproxy_options opts = {};
-	const struct ip_ct_tcp *state;
-	struct tcphdr *th, _th;
-	__be16 frag_off;
-	u8 nexthdr;
-	int thoff;
-
-	ct = nf_ct_get(skb, &ctinfo);
-	if (ct == NULL)
-		return NF_ACCEPT;
-
-	synproxy = nfct_synproxy(ct);
-	if (synproxy == NULL)
-		return NF_ACCEPT;
-
-	if (nf_is_loopback_packet(skb))
-		return NF_ACCEPT;
-
-	nexthdr = ipv6_hdr(skb)->nexthdr;
-	thoff = ipv6_skip_exthdr(skb, sizeof(struct ipv6hdr), &nexthdr,
-				 &frag_off);
-	if (thoff < 0 || nexthdr != IPPROTO_TCP)
-		return NF_ACCEPT;
-
-	th = skb_header_pointer(skb, thoff, sizeof(_th), &_th);
-	if (th == NULL)
-		return NF_DROP;
-
-	state = &ct->proto.tcp;
-	switch (state->state) {
-	case TCP_CONNTRACK_CLOSE:
-		if (th->rst && !test_bit(IPS_SEEN_REPLY_BIT, &ct->status)) {
-			nf_ct_seqadj_init(ct, ctinfo, synproxy->isn -
-						      ntohl(th->seq) + 1);
-			break;
-		}
-
-		if (!th->syn || th->ack ||
-		    CTINFO2DIR(ctinfo) != IP_CT_DIR_ORIGINAL)
-			break;
-
-		/* Reopened connection - reset the sequence number and timestamp
-		 * adjustments, they will get initialized once the connection is
-		 * reestablished.
-		 */
-		nf_ct_seqadj_init(ct, ctinfo, 0);
-		synproxy->tsoff = 0;
-		this_cpu_inc(snet->stats->conn_reopened);
-
-		/* fall through */
-	case TCP_CONNTRACK_SYN_SENT:
-		if (!synproxy_parse_options(skb, thoff, th, &opts))
-			return NF_DROP;
-
-		if (!th->syn && th->ack &&
-		    CTINFO2DIR(ctinfo) == IP_CT_DIR_ORIGINAL) {
-			/* Keep-Alives are sent with SEG.SEQ = SND.NXT-1,
-			 * therefore we need to add 1 to make the SYN sequence
-			 * number match the one of first SYN.
-			 */
-			if (synproxy_recv_client_ack(net, skb, th, &opts,
-						     ntohl(th->seq) + 1)) {
-				this_cpu_inc(snet->stats->cookie_retrans);
-				consume_skb(skb);
-				return NF_STOLEN;
-			} else {
-				return NF_DROP;
-			}
-		}
-
-		synproxy->isn = ntohl(th->ack_seq);
-		if (opts.options & XT_SYNPROXY_OPT_TIMESTAMP)
-			synproxy->its = opts.tsecr;
-
-		nf_conntrack_event_cache(IPCT_SYNPROXY, ct);
-		break;
-	case TCP_CONNTRACK_SYN_RECV:
-		if (!th->syn || !th->ack)
-			break;
-
-		if (!synproxy_parse_options(skb, thoff, th, &opts))
-			return NF_DROP;
-
-		if (opts.options & XT_SYNPROXY_OPT_TIMESTAMP) {
-			synproxy->tsoff = opts.tsval - synproxy->its;
-			nf_conntrack_event_cache(IPCT_SYNPROXY, ct);
-		}
-
-		opts.options &= ~(XT_SYNPROXY_OPT_MSS |
-				  XT_SYNPROXY_OPT_WSCALE |
-				  XT_SYNPROXY_OPT_SACK_PERM);
-
-		swap(opts.tsval, opts.tsecr);
-		synproxy_send_server_ack(net, state, skb, th, &opts);
-
-		nf_ct_seqadj_init(ct, ctinfo, synproxy->isn - ntohl(th->seq));
-		nf_conntrack_event_cache(IPCT_SEQADJ, ct);
-
-		swap(opts.tsval, opts.tsecr);
-		synproxy_send_client_ack(net, skb, th, &opts);
-
-		consume_skb(skb);
-		return NF_STOLEN;
-	default:
-		break;
-	}
-
-	synproxy_tstamp_adjust(skb, thoff, th, ct, ctinfo, synproxy);
-	return NF_ACCEPT;
-}
-
-static const struct nf_hook_ops ipv6_synproxy_ops[] = {
-	{
-		.hook		= ipv6_synproxy_hook,
-		.pf		= NFPROTO_IPV6,
-		.hooknum	= NF_INET_LOCAL_IN,
-		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
-	},
-	{
-		.hook		= ipv6_synproxy_hook,
-		.pf		= NFPROTO_IPV6,
-		.hooknum	= NF_INET_POST_ROUTING,
-		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
-	},
-};
-
 static int synproxy_tg6_check(const struct xt_tgchk_param *par)
 {
 	struct synproxy_net *snet = synproxy_pernet(par->net);
@@ -474,16 +79,12 @@ static int synproxy_tg6_check(const struct xt_tgchk_param *par)
 	if (err)
 		return err;
 
-	if (snet->hook_ref6 == 0) {
-		err = nf_register_net_hooks(par->net, ipv6_synproxy_ops,
-					    ARRAY_SIZE(ipv6_synproxy_ops));
-		if (err) {
-			nf_ct_netns_put(par->net, par->family);
-			return err;
-		}
+	err = nf_synproxy_ipv6_init(snet, par->net);
+	if (err) {
+		nf_ct_netns_put(par->net, par->family);
+		return err;
 	}
 
-	snet->hook_ref6++;
 	return err;
 }
 
@@ -491,10 +92,7 @@ static void synproxy_tg6_destroy(const struct xt_tgdtor_param *par)
 {
 	struct synproxy_net *snet = synproxy_pernet(par->net);
 
-	snet->hook_ref6--;
-	if (snet->hook_ref6 == 0)
-		nf_unregister_net_hooks(par->net, ipv6_synproxy_ops,
-					ARRAY_SIZE(ipv6_synproxy_ops));
+	nf_synproxy_ipv6_fini(snet, par->net);
 	nf_ct_netns_put(par->net, par->family);
 }
 
diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 3d58a9e93e5a..ff3c01707d11 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -13,16 +13,16 @@
 #include <net/netns/generic.h>
 #include <linux/proc_fs.h>
 
-#include <linux/netfilter_ipv4/ip_tables.h>
-#include <linux/netfilter/x_tables.h>
-#include <linux/netfilter/xt_tcpudp.h>
-#include <linux/netfilter/xt_SYNPROXY.h>
+#include <linux/netfilter_ipv6.h>
+#include <linux/netfilter/nf_SYNPROXY.h>
 
 #include <net/netfilter/nf_conntrack.h>
+#include <net/netfilter/nf_conntrack_ecache.h>
 #include <net/netfilter/nf_conntrack_extend.h>
 #include <net/netfilter/nf_conntrack_seqadj.h>
 #include <net/netfilter/nf_conntrack_synproxy.h>
 #include <net/netfilter/nf_conntrack_zones.h>
+#include <net/netfilter/nf_synproxy.h>
 
 unsigned int synproxy_net_id;
 EXPORT_SYMBOL_GPL(synproxy_net_id);
@@ -60,7 +60,7 @@ synproxy_parse_options(const struct sk_buff *skb, unsigned int doff,
 			case TCPOPT_MSS:
 				if (opsize == TCPOLEN_MSS) {
 					opts->mss = get_unaligned_be16(ptr);
-					opts->options |= XT_SYNPROXY_OPT_MSS;
+					opts->options |= NF_SYNPROXY_OPT_MSS;
 				}
 				break;
 			case TCPOPT_WINDOW:
@@ -68,19 +68,19 @@ synproxy_parse_options(const struct sk_buff *skb, unsigned int doff,
 					opts->wscale = *ptr;
 					if (opts->wscale > TCP_MAX_WSCALE)
 						opts->wscale = TCP_MAX_WSCALE;
-					opts->options |= XT_SYNPROXY_OPT_WSCALE;
+					opts->options |= NF_SYNPROXY_OPT_WSCALE;
 				}
 				break;
 			case TCPOPT_TIMESTAMP:
 				if (opsize == TCPOLEN_TIMESTAMP) {
 					opts->tsval = get_unaligned_be32(ptr);
 					opts->tsecr = get_unaligned_be32(ptr + 4);
-					opts->options |= XT_SYNPROXY_OPT_TIMESTAMP;
+					opts->options |= NF_SYNPROXY_OPT_TIMESTAMP;
 				}
 				break;
 			case TCPOPT_SACK_PERM:
 				if (opsize == TCPOLEN_SACK_PERM)
-					opts->options |= XT_SYNPROXY_OPT_SACK_PERM;
+					opts->options |= NF_SYNPROXY_OPT_SACK_PERM;
 				break;
 			}
 
@@ -92,36 +92,36 @@ synproxy_parse_options(const struct sk_buff *skb, unsigned int doff,
 }
 EXPORT_SYMBOL_GPL(synproxy_parse_options);
 
-unsigned int synproxy_options_size(const struct synproxy_options *opts)
+static unsigned int
+synproxy_options_size(const struct synproxy_options *opts)
 {
 	unsigned int size = 0;
 
-	if (opts->options & XT_SYNPROXY_OPT_MSS)
+	if (opts->options & NF_SYNPROXY_OPT_MSS)
 		size += TCPOLEN_MSS_ALIGNED;
-	if (opts->options & XT_SYNPROXY_OPT_TIMESTAMP)
+	if (opts->options & NF_SYNPROXY_OPT_TIMESTAMP)
 		size += TCPOLEN_TSTAMP_ALIGNED;
-	else if (opts->options & XT_SYNPROXY_OPT_SACK_PERM)
+	else if (opts->options & NF_SYNPROXY_OPT_SACK_PERM)
 		size += TCPOLEN_SACKPERM_ALIGNED;
-	if (opts->options & XT_SYNPROXY_OPT_WSCALE)
+	if (opts->options & NF_SYNPROXY_OPT_WSCALE)
 		size += TCPOLEN_WSCALE_ALIGNED;
 
 	return size;
 }
-EXPORT_SYMBOL_GPL(synproxy_options_size);
 
-void
+static void
 synproxy_build_options(struct tcphdr *th, const struct synproxy_options *opts)
 {
 	__be32 *ptr = (__be32 *)(th + 1);
 	u8 options = opts->options;
 
-	if (options & XT_SYNPROXY_OPT_MSS)
+	if (options & NF_SYNPROXY_OPT_MSS)
 		*ptr++ = htonl((TCPOPT_MSS << 24) |
 			       (TCPOLEN_MSS << 16) |
 			       opts->mss);
 
-	if (options & XT_SYNPROXY_OPT_TIMESTAMP) {
-		if (options & XT_SYNPROXY_OPT_SACK_PERM)
+	if (options & NF_SYNPROXY_OPT_TIMESTAMP) {
+		if (options & NF_SYNPROXY_OPT_SACK_PERM)
 			*ptr++ = htonl((TCPOPT_SACK_PERM << 24) |
 				       (TCPOLEN_SACK_PERM << 16) |
 				       (TCPOPT_TIMESTAMP << 8) |
@@ -134,58 +134,56 @@ synproxy_build_options(struct tcphdr *th, const struct synproxy_options *opts)
 
 		*ptr++ = htonl(opts->tsval);
 		*ptr++ = htonl(opts->tsecr);
-	} else if (options & XT_SYNPROXY_OPT_SACK_PERM)
+	} else if (options & NF_SYNPROXY_OPT_SACK_PERM)
 		*ptr++ = htonl((TCPOPT_NOP << 24) |
 			       (TCPOPT_NOP << 16) |
 			       (TCPOPT_SACK_PERM << 8) |
 			       TCPOLEN_SACK_PERM);
 
-	if (options & XT_SYNPROXY_OPT_WSCALE)
+	if (options & NF_SYNPROXY_OPT_WSCALE)
 		*ptr++ = htonl((TCPOPT_NOP << 24) |
 			       (TCPOPT_WINDOW << 16) |
 			       (TCPOLEN_WINDOW << 8) |
 			       opts->wscale);
 }
-EXPORT_SYMBOL_GPL(synproxy_build_options);
 
-void synproxy_init_timestamp_cookie(const struct xt_synproxy_info *info,
+void synproxy_init_timestamp_cookie(const struct nf_synproxy_info *info,
 				    struct synproxy_options *opts)
 {
 	opts->tsecr = opts->tsval;
 	opts->tsval = tcp_time_stamp_raw() & ~0x3f;
 
-	if (opts->options & XT_SYNPROXY_OPT_WSCALE) {
+	if (opts->options & NF_SYNPROXY_OPT_WSCALE) {
 		opts->tsval |= opts->wscale;
 		opts->wscale = info->wscale;
 	} else
 		opts->tsval |= 0xf;
 
-	if (opts->options & XT_SYNPROXY_OPT_SACK_PERM)
+	if (opts->options & NF_SYNPROXY_OPT_SACK_PERM)
 		opts->tsval |= 1 << 4;
 
-	if (opts->options & XT_SYNPROXY_OPT_ECN)
+	if (opts->options & NF_SYNPROXY_OPT_ECN)
 		opts->tsval |= 1 << 5;
 }
 EXPORT_SYMBOL_GPL(synproxy_init_timestamp_cookie);
 
-void synproxy_check_timestamp_cookie(struct synproxy_options *opts)
+static void
+synproxy_check_timestamp_cookie(struct synproxy_options *opts)
 {
 	opts->wscale = opts->tsecr & 0xf;
 	if (opts->wscale != 0xf)
-		opts->options |= XT_SYNPROXY_OPT_WSCALE;
+		opts->options |= NF_SYNPROXY_OPT_WSCALE;
 
-	opts->options |= opts->tsecr & (1 << 4) ? XT_SYNPROXY_OPT_SACK_PERM : 0;
+	opts->options |= opts->tsecr & (1 << 4) ? NF_SYNPROXY_OPT_SACK_PERM : 0;
 
-	opts->options |= opts->tsecr & (1 << 5) ? XT_SYNPROXY_OPT_ECN : 0;
+	opts->options |= opts->tsecr & (1 << 5) ? NF_SYNPROXY_OPT_ECN : 0;
 }
-EXPORT_SYMBOL_GPL(synproxy_check_timestamp_cookie);
 
-unsigned int synproxy_tstamp_adjust(struct sk_buff *skb,
-				    unsigned int protoff,
-				    struct tcphdr *th,
-				    struct nf_conn *ct,
-				    enum ip_conntrack_info ctinfo,
-				    const struct nf_conn_synproxy *synproxy)
+static unsigned int
+synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
+		       struct tcphdr *th, struct nf_conn *ct,
+		       enum ip_conntrack_info ctinfo,
+		       const struct nf_conn_synproxy *synproxy)
 {
 	unsigned int optoff, optend;
 	__be32 *ptr, old;
@@ -235,7 +233,6 @@ unsigned int synproxy_tstamp_adjust(struct sk_buff *skb,
 	}
 	return 1;
 }
-EXPORT_SYMBOL_GPL(synproxy_tstamp_adjust);
 
 static struct nf_ct_ext_type nf_ct_synproxy_extend __read_mostly = {
 	.len		= sizeof(struct nf_conn_synproxy),
@@ -416,5 +413,831 @@ static void __exit synproxy_core_exit(void)
 module_init(synproxy_core_init);
 module_exit(synproxy_core_exit);
 
+static struct iphdr *
+synproxy_build_ip(struct net *net, struct sk_buff *skb, __be32 saddr,
+		  __be32 daddr)
+{
+	struct iphdr *iph;
+
+	skb_reset_network_header(skb);
+	iph = skb_put(skb, sizeof(*iph));
+	iph->version	= 4;
+	iph->ihl	= sizeof(*iph) / 4;
+	iph->tos	= 0;
+	iph->id		= 0;
+	iph->frag_off	= htons(IP_DF);
+	iph->ttl	= net->ipv4.sysctl_ip_default_ttl;
+	iph->protocol	= IPPROTO_TCP;
+	iph->check	= 0;
+	iph->saddr	= saddr;
+	iph->daddr	= daddr;
+
+	return iph;
+}
+
+static void
+synproxy_send_tcp(struct net *net,
+		  const struct sk_buff *skb, struct sk_buff *nskb,
+		  struct nf_conntrack *nfct, enum ip_conntrack_info ctinfo,
+		  struct iphdr *niph, struct tcphdr *nth,
+		  unsigned int tcp_hdr_size)
+{
+	nth->check = ~tcp_v4_check(tcp_hdr_size, niph->saddr, niph->daddr, 0);
+	nskb->ip_summed   = CHECKSUM_PARTIAL;
+	nskb->csum_start  = (unsigned char *)nth - nskb->head;
+	nskb->csum_offset = offsetof(struct tcphdr, check);
+
+	skb_dst_set_noref(nskb, skb_dst(skb));
+	nskb->protocol = htons(ETH_P_IP);
+	if (ip_route_me_harder(net, nskb, RTN_UNSPEC))
+		goto free_nskb;
+
+	if (nfct) {
+		nf_ct_set(nskb, (struct nf_conn *)nfct, ctinfo);
+		nf_conntrack_get(nfct);
+	}
+
+	ip_local_out(net, nskb->sk, nskb);
+	return;
+
+free_nskb:
+	kfree_skb(nskb);
+}
+
+void
+synproxy_send_client_synack(struct net *net,
+			    const struct sk_buff *skb, const struct tcphdr *th,
+			    const struct synproxy_options *opts)
+{
+	struct sk_buff *nskb;
+	struct iphdr *iph, *niph;
+	struct tcphdr *nth;
+	unsigned int tcp_hdr_size;
+	u16 mss = opts->mss;
+
+	iph = ip_hdr(skb);
+
+	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
+	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
+			 GFP_ATOMIC);
+	if (!nskb)
+		return;
+	skb_reserve(nskb, MAX_TCP_HEADER);
+
+	niph = synproxy_build_ip(net, nskb, iph->daddr, iph->saddr);
+
+	skb_reset_transport_header(nskb);
+	nth = skb_put(nskb, tcp_hdr_size);
+	nth->source	= th->dest;
+	nth->dest	= th->source;
+	nth->seq	= htonl(__cookie_v4_init_sequence(iph, th, &mss));
+	nth->ack_seq	= htonl(ntohl(th->seq) + 1);
+	tcp_flag_word(nth) = TCP_FLAG_SYN | TCP_FLAG_ACK;
+	if (opts->options & NF_SYNPROXY_OPT_ECN)
+		tcp_flag_word(nth) |= TCP_FLAG_ECE;
+	nth->doff	= tcp_hdr_size / 4;
+	nth->window	= 0;
+	nth->check	= 0;
+	nth->urg_ptr	= 0;
+
+	synproxy_build_options(nth, opts);
+
+	synproxy_send_tcp(net, skb, nskb, skb_nfct(skb),
+			  IP_CT_ESTABLISHED_REPLY, niph, nth, tcp_hdr_size);
+}
+EXPORT_SYMBOL_GPL(synproxy_send_client_synack);
+
+static void
+synproxy_send_server_syn(struct net *net,
+			 const struct sk_buff *skb, const struct tcphdr *th,
+			 const struct synproxy_options *opts, u32 recv_seq)
+{
+	struct synproxy_net *snet = synproxy_pernet(net);
+	struct sk_buff *nskb;
+	struct iphdr *iph, *niph;
+	struct tcphdr *nth;
+	unsigned int tcp_hdr_size;
+
+	iph = ip_hdr(skb);
+
+	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
+	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
+			 GFP_ATOMIC);
+	if (!nskb)
+		return;
+	skb_reserve(nskb, MAX_TCP_HEADER);
+
+	niph = synproxy_build_ip(net, nskb, iph->saddr, iph->daddr);
+
+	skb_reset_transport_header(nskb);
+	nth = skb_put(nskb, tcp_hdr_size);
+	nth->source	= th->source;
+	nth->dest	= th->dest;
+	nth->seq	= htonl(recv_seq - 1);
+	/* ack_seq is used to relay our ISN to the synproxy hook to initialize
+	 * sequence number translation once a connection tracking entry exists.
+	 */
+	nth->ack_seq	= htonl(ntohl(th->ack_seq) - 1);
+	tcp_flag_word(nth) = TCP_FLAG_SYN;
+	if (opts->options & NF_SYNPROXY_OPT_ECN)
+		tcp_flag_word(nth) |= TCP_FLAG_ECE | TCP_FLAG_CWR;
+	nth->doff	= tcp_hdr_size / 4;
+	nth->window	= th->window;
+	nth->check	= 0;
+	nth->urg_ptr	= 0;
+
+	synproxy_build_options(nth, opts);
+
+	synproxy_send_tcp(net, skb, nskb, &snet->tmpl->ct_general, IP_CT_NEW,
+			  niph, nth, tcp_hdr_size);
+}
+
+static void
+synproxy_send_server_ack(struct net *net,
+			 const struct ip_ct_tcp *state,
+			 const struct sk_buff *skb, const struct tcphdr *th,
+			 const struct synproxy_options *opts)
+{
+	struct sk_buff *nskb;
+	struct iphdr *iph, *niph;
+	struct tcphdr *nth;
+	unsigned int tcp_hdr_size;
+
+	iph = ip_hdr(skb);
+
+	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
+	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
+			 GFP_ATOMIC);
+	if (!nskb)
+		return;
+	skb_reserve(nskb, MAX_TCP_HEADER);
+
+	niph = synproxy_build_ip(net, nskb, iph->daddr, iph->saddr);
+
+	skb_reset_transport_header(nskb);
+	nth = skb_put(nskb, tcp_hdr_size);
+	nth->source	= th->dest;
+	nth->dest	= th->source;
+	nth->seq	= htonl(ntohl(th->ack_seq));
+	nth->ack_seq	= htonl(ntohl(th->seq) + 1);
+	tcp_flag_word(nth) = TCP_FLAG_ACK;
+	nth->doff	= tcp_hdr_size / 4;
+	nth->window	= htons(state->seen[IP_CT_DIR_ORIGINAL].td_maxwin);
+	nth->check	= 0;
+	nth->urg_ptr	= 0;
+
+	synproxy_build_options(nth, opts);
+
+	synproxy_send_tcp(net, skb, nskb, NULL, 0, niph, nth, tcp_hdr_size);
+}
+
+static void
+synproxy_send_client_ack(struct net *net,
+			 const struct sk_buff *skb, const struct tcphdr *th,
+			 const struct synproxy_options *opts)
+{
+	struct sk_buff *nskb;
+	struct iphdr *iph, *niph;
+	struct tcphdr *nth;
+	unsigned int tcp_hdr_size;
+
+	iph = ip_hdr(skb);
+
+	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
+	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
+			 GFP_ATOMIC);
+	if (!nskb)
+		return;
+	skb_reserve(nskb, MAX_TCP_HEADER);
+
+	niph = synproxy_build_ip(net, nskb, iph->saddr, iph->daddr);
+
+	skb_reset_transport_header(nskb);
+	nth = skb_put(nskb, tcp_hdr_size);
+	nth->source	= th->source;
+	nth->dest	= th->dest;
+	nth->seq	= htonl(ntohl(th->seq) + 1);
+	nth->ack_seq	= th->ack_seq;
+	tcp_flag_word(nth) = TCP_FLAG_ACK;
+	nth->doff	= tcp_hdr_size / 4;
+	nth->window	= htons(ntohs(th->window) >> opts->wscale);
+	nth->check	= 0;
+	nth->urg_ptr	= 0;
+
+	synproxy_build_options(nth, opts);
+
+	synproxy_send_tcp(net, skb, nskb, skb_nfct(skb),
+			  IP_CT_ESTABLISHED_REPLY, niph, nth, tcp_hdr_size);
+}
+
+bool
+synproxy_recv_client_ack(struct net *net,
+			 const struct sk_buff *skb, const struct tcphdr *th,
+			 struct synproxy_options *opts, u32 recv_seq)
+{
+	struct synproxy_net *snet = synproxy_pernet(net);
+	int mss;
+
+	mss = __cookie_v4_check(ip_hdr(skb), th, ntohl(th->ack_seq) - 1);
+	if (mss == 0) {
+		this_cpu_inc(snet->stats->cookie_invalid);
+		return false;
+	}
+
+	this_cpu_inc(snet->stats->cookie_valid);
+	opts->mss = mss;
+	opts->options |= NF_SYNPROXY_OPT_MSS;
+
+	if (opts->options & NF_SYNPROXY_OPT_TIMESTAMP)
+		synproxy_check_timestamp_cookie(opts);
+
+	synproxy_send_server_syn(net, skb, th, opts, recv_seq);
+	return true;
+}
+EXPORT_SYMBOL_GPL(synproxy_recv_client_ack);
+
+unsigned int
+ipv4_synproxy_hook(void *priv, struct sk_buff *skb,
+		   const struct nf_hook_state *nhs)
+{
+	struct net *net = nhs->net;
+	struct synproxy_net *snet = synproxy_pernet(net);
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct;
+	struct nf_conn_synproxy *synproxy;
+	struct synproxy_options opts = {};
+	const struct ip_ct_tcp *state;
+	struct tcphdr *th, _th;
+	unsigned int thoff;
+
+	ct = nf_ct_get(skb, &ctinfo);
+	if (!ct)
+		return NF_ACCEPT;
+
+	synproxy = nfct_synproxy(ct);
+	if (!synproxy)
+		return NF_ACCEPT;
+
+	if (nf_is_loopback_packet(skb) ||
+	    ip_hdr(skb)->protocol != IPPROTO_TCP)
+		return NF_ACCEPT;
+
+	thoff = ip_hdrlen(skb);
+	th = skb_header_pointer(skb, thoff, sizeof(_th), &_th);
+	if (!th)
+		return NF_DROP;
+
+	state = &ct->proto.tcp;
+	switch (state->state) {
+	case TCP_CONNTRACK_CLOSE:
+		if (th->rst && !test_bit(IPS_SEEN_REPLY_BIT, &ct->status)) {
+			nf_ct_seqadj_init(ct, ctinfo, synproxy->isn -
+						      ntohl(th->seq) + 1);
+			break;
+		}
+
+		if (!th->syn || th->ack ||
+		    CTINFO2DIR(ctinfo) != IP_CT_DIR_ORIGINAL)
+			break;
+
+		/* Reopened connection - reset the sequence number and timestamp
+		 * adjustments, they will get initialized once the connection is
+		 * reestablished.
+		 */
+		nf_ct_seqadj_init(ct, ctinfo, 0);
+		synproxy->tsoff = 0;
+		this_cpu_inc(snet->stats->conn_reopened);
+
+		/* fall through */
+	case TCP_CONNTRACK_SYN_SENT:
+		if (!synproxy_parse_options(skb, thoff, th, &opts))
+			return NF_DROP;
+
+		if (!th->syn && th->ack &&
+		    CTINFO2DIR(ctinfo) == IP_CT_DIR_ORIGINAL) {
+			/* Keep-Alives are sent with SEG.SEQ = SND.NXT-1,
+			 * therefore we need to add 1 to make the SYN sequence
+			 * number match the one of first SYN.
+			 */
+			if (synproxy_recv_client_ack(net, skb, th, &opts,
+						     ntohl(th->seq) + 1)) {
+				this_cpu_inc(snet->stats->cookie_retrans);
+				consume_skb(skb);
+				return NF_STOLEN;
+			} else {
+				return NF_DROP;
+			}
+		}
+
+		synproxy->isn = ntohl(th->ack_seq);
+		if (opts.options & NF_SYNPROXY_OPT_TIMESTAMP)
+			synproxy->its = opts.tsecr;
+
+		nf_conntrack_event_cache(IPCT_SYNPROXY, ct);
+		break;
+	case TCP_CONNTRACK_SYN_RECV:
+		if (!th->syn || !th->ack)
+			break;
+
+		if (!synproxy_parse_options(skb, thoff, th, &opts))
+			return NF_DROP;
+
+		if (opts.options & NF_SYNPROXY_OPT_TIMESTAMP) {
+			synproxy->tsoff = opts.tsval - synproxy->its;
+			nf_conntrack_event_cache(IPCT_SYNPROXY, ct);
+		}
+
+		opts.options &= ~(NF_SYNPROXY_OPT_MSS |
+				  NF_SYNPROXY_OPT_WSCALE |
+				  NF_SYNPROXY_OPT_SACK_PERM);
+
+		swap(opts.tsval, opts.tsecr);
+		synproxy_send_server_ack(net, state, skb, th, &opts);
+
+		nf_ct_seqadj_init(ct, ctinfo, synproxy->isn - ntohl(th->seq));
+		nf_conntrack_event_cache(IPCT_SEQADJ, ct);
+
+		swap(opts.tsval, opts.tsecr);
+		synproxy_send_client_ack(net, skb, th, &opts);
+
+		consume_skb(skb);
+		return NF_STOLEN;
+	default:
+		break;
+	}
+
+	synproxy_tstamp_adjust(skb, thoff, th, ct, ctinfo, synproxy);
+	return NF_ACCEPT;
+}
+EXPORT_SYMBOL_GPL(ipv4_synproxy_hook);
+
+static const struct nf_hook_ops ipv4_synproxy_ops[] = {
+	{
+		.hook		= ipv4_synproxy_hook,
+		.pf		= NFPROTO_IPV4,
+		.hooknum	= NF_INET_LOCAL_IN,
+		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
+	},
+	{
+		.hook		= ipv4_synproxy_hook,
+		.pf		= NFPROTO_IPV4,
+		.hooknum	= NF_INET_POST_ROUTING,
+		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
+	},
+};
+
+int nf_synproxy_ipv4_init(struct synproxy_net *snet, struct net *net)
+{
+	int err;
+
+	if (snet->hook_ref4 == 0) {
+		err = nf_register_net_hooks(net, ipv4_synproxy_ops,
+					    ARRAY_SIZE(ipv4_synproxy_ops));
+		if (err)
+			return err;
+	}
+
+	snet->hook_ref4++;
+	return err;
+}
+EXPORT_SYMBOL_GPL(nf_synproxy_ipv4_init);
+
+void nf_synproxy_ipv4_fini(struct synproxy_net *snet, struct net *net)
+{
+	snet->hook_ref4--;
+	if (snet->hook_ref4 == 0)
+		nf_unregister_net_hooks(net, ipv4_synproxy_ops,
+					ARRAY_SIZE(ipv4_synproxy_ops));
+}
+EXPORT_SYMBOL_GPL(nf_synproxy_ipv4_fini);
+
+#if IS_ENABLED(CONFIG_IPV6) /* IPv6 support */
+
+static struct ipv6hdr *
+synproxy_build_ip_ipv6(struct net *net, struct sk_buff *skb,
+		       const struct in6_addr *saddr,
+		       const struct in6_addr *daddr)
+{
+	struct ipv6hdr *iph;
+
+	skb_reset_network_header(skb);
+	iph = skb_put(skb, sizeof(*iph));
+	ip6_flow_hdr(iph, 0, 0);
+	iph->hop_limit	= net->ipv6.devconf_all->hop_limit;
+	iph->nexthdr	= IPPROTO_TCP;
+	iph->saddr	= *saddr;
+	iph->daddr	= *daddr;
+
+	return iph;
+}
+
+static void
+synproxy_send_tcp_ipv6(struct net *net,
+		       const struct sk_buff *skb, struct sk_buff *nskb,
+		       struct nf_conntrack *nfct, enum ip_conntrack_info ctinfo,
+		       struct ipv6hdr *niph, struct tcphdr *nth,
+		       unsigned int tcp_hdr_size)
+{
+	struct dst_entry *dst;
+	struct flowi6 fl6;
+	int err;
+
+	nth->check = ~tcp_v6_check(tcp_hdr_size, &niph->saddr, &niph->daddr, 0);
+	nskb->ip_summed   = CHECKSUM_PARTIAL;
+	nskb->csum_start  = (unsigned char *)nth - nskb->head;
+	nskb->csum_offset = offsetof(struct tcphdr, check);
+
+	memset(&fl6, 0, sizeof(fl6));
+	fl6.flowi6_proto = IPPROTO_TCP;
+	fl6.saddr = niph->saddr;
+	fl6.daddr = niph->daddr;
+	fl6.fl6_sport = nth->source;
+	fl6.fl6_dport = nth->dest;
+	security_skb_classify_flow((struct sk_buff *)skb,
+				   flowi6_to_flowi(&fl6));
+	err = nf_ip6_route(net, &dst, flowi6_to_flowi(&fl6), false);
+	if (err) {
+		goto free_nskb;
+	}
+
+	dst = xfrm_lookup(net, dst, flowi6_to_flowi(&fl6), NULL, 0);
+	if (IS_ERR(dst))
+		goto free_nskb;
+
+	skb_dst_set(nskb, dst);
+
+	if (nfct) {
+		nf_ct_set(nskb, (struct nf_conn *)nfct, ctinfo);
+		nf_conntrack_get(nfct);
+	}
+
+	ip6_local_out(net, nskb->sk, nskb);
+	return;
+
+free_nskb:
+	kfree_skb(nskb);
+}
+
+void
+synproxy_send_client_synack_ipv6(struct net *net,
+				 const struct sk_buff *skb,
+				 const struct tcphdr *th,
+				 const struct synproxy_options *opts)
+{
+	struct sk_buff *nskb;
+	struct ipv6hdr *iph, *niph;
+	struct tcphdr *nth;
+	unsigned int tcp_hdr_size;
+	u16 mss = opts->mss;
+
+	iph = ipv6_hdr(skb);
+
+	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
+	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
+			 GFP_ATOMIC);
+	if (!nskb)
+		return;
+	skb_reserve(nskb, MAX_TCP_HEADER);
+
+	niph = synproxy_build_ip_ipv6(net, nskb, &iph->daddr, &iph->saddr);
+
+	skb_reset_transport_header(nskb);
+	nth = skb_put(nskb, tcp_hdr_size);
+	nth->source	= th->dest;
+	nth->dest	= th->source;
+	nth->seq	= htonl(nf_ipv6_cookie_init_sequence(iph, th, &mss));
+	nth->ack_seq	= htonl(ntohl(th->seq) + 1);
+	tcp_flag_word(nth) = TCP_FLAG_SYN | TCP_FLAG_ACK;
+	if (opts->options & NF_SYNPROXY_OPT_ECN)
+		tcp_flag_word(nth) |= TCP_FLAG_ECE;
+	nth->doff	= tcp_hdr_size / 4;
+	nth->window	= 0;
+	nth->check	= 0;
+	nth->urg_ptr	= 0;
+
+	synproxy_build_options(nth, opts);
+
+	synproxy_send_tcp_ipv6(net, skb, nskb, skb_nfct(skb),
+			       IP_CT_ESTABLISHED_REPLY, niph, nth,
+			       tcp_hdr_size);
+}
+EXPORT_SYMBOL_GPL(synproxy_send_client_synack_ipv6);
+
+static void
+synproxy_send_server_syn_ipv6(struct net *net, const struct sk_buff *skb,
+			      const struct tcphdr *th,
+			      const struct synproxy_options *opts, u32 recv_seq)
+{
+	struct synproxy_net *snet = synproxy_pernet(net);
+	struct sk_buff *nskb;
+	struct ipv6hdr *iph, *niph;
+	struct tcphdr *nth;
+	unsigned int tcp_hdr_size;
+
+	iph = ipv6_hdr(skb);
+
+	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
+	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
+			 GFP_ATOMIC);
+	if (!nskb)
+		return;
+	skb_reserve(nskb, MAX_TCP_HEADER);
+
+	niph = synproxy_build_ip_ipv6(net, nskb, &iph->saddr, &iph->daddr);
+
+	skb_reset_transport_header(nskb);
+	nth = skb_put(nskb, tcp_hdr_size);
+	nth->source	= th->source;
+	nth->dest	= th->dest;
+	nth->seq	= htonl(recv_seq - 1);
+	/* ack_seq is used to relay our ISN to the synproxy hook to initialize
+	 * sequence number translation once a connection tracking entry exists.
+	 */
+	nth->ack_seq	= htonl(ntohl(th->ack_seq) - 1);
+	tcp_flag_word(nth) = TCP_FLAG_SYN;
+	if (opts->options & NF_SYNPROXY_OPT_ECN)
+		tcp_flag_word(nth) |= TCP_FLAG_ECE | TCP_FLAG_CWR;
+	nth->doff	= tcp_hdr_size / 4;
+	nth->window	= th->window;
+	nth->check	= 0;
+	nth->urg_ptr	= 0;
+
+	synproxy_build_options(nth, opts);
+
+	synproxy_send_tcp_ipv6(net, skb, nskb, &snet->tmpl->ct_general,
+			       IP_CT_NEW, niph, nth, tcp_hdr_size);
+}
+
+static void
+synproxy_send_server_ack_ipv6(struct net *net, const struct ip_ct_tcp *state,
+			      const struct sk_buff *skb,
+			      const struct tcphdr *th,
+			      const struct synproxy_options *opts)
+{
+	struct sk_buff *nskb;
+	struct ipv6hdr *iph, *niph;
+	struct tcphdr *nth;
+	unsigned int tcp_hdr_size;
+
+	iph = ipv6_hdr(skb);
+
+	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
+	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
+			 GFP_ATOMIC);
+	if (!nskb)
+		return;
+	skb_reserve(nskb, MAX_TCP_HEADER);
+
+	niph = synproxy_build_ip_ipv6(net, nskb, &iph->daddr, &iph->saddr);
+
+	skb_reset_transport_header(nskb);
+	nth = skb_put(nskb, tcp_hdr_size);
+	nth->source	= th->dest;
+	nth->dest	= th->source;
+	nth->seq	= htonl(ntohl(th->ack_seq));
+	nth->ack_seq	= htonl(ntohl(th->seq) + 1);
+	tcp_flag_word(nth) = TCP_FLAG_ACK;
+	nth->doff	= tcp_hdr_size / 4;
+	nth->window	= htons(state->seen[IP_CT_DIR_ORIGINAL].td_maxwin);
+	nth->check	= 0;
+	nth->urg_ptr	= 0;
+
+	synproxy_build_options(nth, opts);
+
+	synproxy_send_tcp_ipv6(net, skb, nskb, NULL, 0, niph, nth,
+			       tcp_hdr_size);
+}
+
+static void
+synproxy_send_client_ack_ipv6(struct net *net, const struct sk_buff *skb,
+			      const struct tcphdr *th,
+			      const struct synproxy_options *opts)
+{
+	struct sk_buff *nskb;
+	struct ipv6hdr *iph, *niph;
+	struct tcphdr *nth;
+	unsigned int tcp_hdr_size;
+
+	iph = ipv6_hdr(skb);
+
+	tcp_hdr_size = sizeof(*nth) + synproxy_options_size(opts);
+	nskb = alloc_skb(sizeof(*niph) + tcp_hdr_size + MAX_TCP_HEADER,
+			 GFP_ATOMIC);
+	if (!nskb)
+		return;
+	skb_reserve(nskb, MAX_TCP_HEADER);
+
+	niph = synproxy_build_ip_ipv6(net, nskb, &iph->saddr, &iph->daddr);
+
+	skb_reset_transport_header(nskb);
+	nth = skb_put(nskb, tcp_hdr_size);
+	nth->source	= th->source;
+	nth->dest	= th->dest;
+	nth->seq	= htonl(ntohl(th->seq) + 1);
+	nth->ack_seq	= th->ack_seq;
+	tcp_flag_word(nth) = TCP_FLAG_ACK;
+	nth->doff	= tcp_hdr_size / 4;
+	nth->window	= htons(ntohs(th->window) >> opts->wscale);
+	nth->check	= 0;
+	nth->urg_ptr	= 0;
+
+	synproxy_build_options(nth, opts);
+
+	synproxy_send_tcp_ipv6(net, skb, nskb, skb_nfct(skb),
+			       IP_CT_ESTABLISHED_REPLY, niph, nth,
+			       tcp_hdr_size);
+}
+
+bool
+synproxy_recv_client_ack_ipv6(struct net *net,
+			      const struct sk_buff *skb,
+			      const struct tcphdr *th,
+			      struct synproxy_options *opts, u32 recv_seq)
+{
+	struct synproxy_net *snet = synproxy_pernet(net);
+	int mss;
+
+	mss = __cookie_v6_check(ipv6_hdr(skb), th, ntohl(th->ack_seq) - 1);
+	if (mss == 0) {
+		this_cpu_inc(snet->stats->cookie_invalid);
+		return false;
+	}
+
+	this_cpu_inc(snet->stats->cookie_valid);
+	opts->mss = mss;
+	opts->options |= NF_SYNPROXY_OPT_MSS;
+
+	if (opts->options & NF_SYNPROXY_OPT_TIMESTAMP)
+		synproxy_check_timestamp_cookie(opts);
+
+	synproxy_send_server_syn_ipv6(net, skb, th, opts, recv_seq);
+	return true;
+}
+EXPORT_SYMBOL_GPL(synproxy_recv_client_ack_ipv6);
+
+unsigned int
+ipv6_synproxy_hook(void *priv, struct sk_buff *skb,
+		   const struct nf_hook_state *nhs)
+{
+	struct net *net = nhs->net;
+	struct synproxy_net *snet = synproxy_pernet(net);
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct;
+	struct nf_conn_synproxy *synproxy;
+	struct synproxy_options opts = {};
+	const struct ip_ct_tcp *state;
+	struct tcphdr *th, _th;
+	__be16 frag_off;
+	u8 nexthdr;
+	int thoff;
+
+	ct = nf_ct_get(skb, &ctinfo);
+	if (!ct)
+		return NF_ACCEPT;
+
+	synproxy = nfct_synproxy(ct);
+	if (!synproxy)
+		return NF_ACCEPT;
+
+	if (nf_is_loopback_packet(skb))
+		return NF_ACCEPT;
+
+	nexthdr = ipv6_hdr(skb)->nexthdr;
+	thoff = ipv6_skip_exthdr(skb, sizeof(struct ipv6hdr), &nexthdr,
+				 &frag_off);
+	if (thoff < 0 || nexthdr != IPPROTO_TCP)
+		return NF_ACCEPT;
+
+	th = skb_header_pointer(skb, thoff, sizeof(_th), &_th);
+	if (!th)
+		return NF_DROP;
+
+	state = &ct->proto.tcp;
+	switch (state->state) {
+	case TCP_CONNTRACK_CLOSE:
+		if (th->rst && !test_bit(IPS_SEEN_REPLY_BIT, &ct->status)) {
+			nf_ct_seqadj_init(ct, ctinfo, synproxy->isn -
+						      ntohl(th->seq) + 1);
+			break;
+		}
+
+		if (!th->syn || th->ack ||
+		    CTINFO2DIR(ctinfo) != IP_CT_DIR_ORIGINAL)
+			break;
+
+		/* Reopened connection - reset the sequence number and timestamp
+		 * adjustments, they will get initialized once the connection is
+		 * reestablished.
+		 */
+		nf_ct_seqadj_init(ct, ctinfo, 0);
+		synproxy->tsoff = 0;
+		this_cpu_inc(snet->stats->conn_reopened);
+
+		/* fall through */
+	case TCP_CONNTRACK_SYN_SENT:
+		if (!synproxy_parse_options(skb, thoff, th, &opts))
+			return NF_DROP;
+
+		if (!th->syn && th->ack &&
+		    CTINFO2DIR(ctinfo) == IP_CT_DIR_ORIGINAL) {
+			/* Keep-Alives are sent with SEG.SEQ = SND.NXT-1,
+			 * therefore we need to add 1 to make the SYN sequence
+			 * number match the one of first SYN.
+			 */
+			if (synproxy_recv_client_ack_ipv6(net, skb, th, &opts,
+							  ntohl(th->seq) + 1)) {
+				this_cpu_inc(snet->stats->cookie_retrans);
+				consume_skb(skb);
+				return NF_STOLEN;
+			} else {
+				return NF_DROP;
+			}
+		}
+
+		synproxy->isn = ntohl(th->ack_seq);
+		if (opts.options & NF_SYNPROXY_OPT_TIMESTAMP)
+			synproxy->its = opts.tsecr;
+
+		nf_conntrack_event_cache(IPCT_SYNPROXY, ct);
+		break;
+	case TCP_CONNTRACK_SYN_RECV:
+		if (!th->syn || !th->ack)
+			break;
+
+		if (!synproxy_parse_options(skb, thoff, th, &opts))
+			return NF_DROP;
+
+		if (opts.options & NF_SYNPROXY_OPT_TIMESTAMP) {
+			synproxy->tsoff = opts.tsval - synproxy->its;
+			nf_conntrack_event_cache(IPCT_SYNPROXY, ct);
+		}
+
+		opts.options &= ~(NF_SYNPROXY_OPT_MSS |
+				  NF_SYNPROXY_OPT_WSCALE |
+				  NF_SYNPROXY_OPT_SACK_PERM);
+
+		swap(opts.tsval, opts.tsecr);
+		synproxy_send_server_ack_ipv6(net, state, skb, th, &opts);
+
+		nf_ct_seqadj_init(ct, ctinfo, synproxy->isn - ntohl(th->seq));
+		nf_conntrack_event_cache(IPCT_SEQADJ, ct);
+
+		swap(opts.tsval, opts.tsecr);
+		synproxy_send_client_ack_ipv6(net, skb, th, &opts);
+
+		consume_skb(skb);
+		return NF_STOLEN;
+	default:
+		break;
+	}
+
+	synproxy_tstamp_adjust(skb, thoff, th, ct, ctinfo, synproxy);
+	return NF_ACCEPT;
+}
+EXPORT_SYMBOL_GPL(ipv6_synproxy_hook);
+
+static const struct nf_hook_ops ipv6_synproxy_ops[] = {
+	{
+		.hook		= ipv6_synproxy_hook,
+		.pf		= NFPROTO_IPV6,
+		.hooknum	= NF_INET_LOCAL_IN,
+		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
+	},
+	{
+		.hook		= ipv6_synproxy_hook,
+		.pf		= NFPROTO_IPV6,
+		.hooknum	= NF_INET_POST_ROUTING,
+		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
+	},
+};
+
+int
+nf_synproxy_ipv6_init(struct synproxy_net *snet, struct net *net)
+{
+	int err;
+
+	if (snet->hook_ref6 == 0) {
+		err = nf_register_net_hooks(net, ipv6_synproxy_ops,
+					    ARRAY_SIZE(ipv6_synproxy_ops));
+		if (err)
+			return err;
+	}
+
+	snet->hook_ref6++;
+	return err;
+}
+EXPORT_SYMBOL_GPL(nf_synproxy_ipv6_init);
+
+void
+nf_synproxy_ipv6_fini(struct synproxy_net *snet, struct net *net)
+{
+	snet->hook_ref6--;
+	if (snet->hook_ref6 == 0)
+		nf_unregister_net_hooks(net, ipv6_synproxy_ops,
+					ARRAY_SIZE(ipv6_synproxy_ops));
+}
+EXPORT_SYMBOL_GPL(nf_synproxy_ipv6_fini);
+#endif /* IPv6 support */
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Patrick McHardy <kaber@trash.net>");
-- 
2.20.1

