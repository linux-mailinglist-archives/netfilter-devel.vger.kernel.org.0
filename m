Return-Path: <netfilter-devel+bounces-10387-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMdKIjtocmnckQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10387-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Jan 2026 19:11:07 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C76C10A
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Jan 2026 19:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D0DB303C8BD
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Jan 2026 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA97344D83;
	Thu, 22 Jan 2026 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV/5P/Bj"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AF30F547;
	Thu, 22 Jan 2026 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103997; cv=none; b=F1e/czg6bWcLlyV8neoy/n/KM8D7t0f3jrENia9x4OkACBY2m9XAmVsyVe9nv/tXWDCSUbaHcD4ev4kgUeT3SXDQynsDosl4BXjlMWkt91ZyrJUUstnmLLxqQVTAkRVED+x/mSaFqOEBf3RjeRKtBIbVHjDIYyg1EqFbwdCAykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103997; c=relaxed/simple;
	bh=Vb0BDsIkdF+pAP1UDkQuPP/llPkZVJAR7tMLh1xpciI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdqfEYxSY3afdWEbfUdwP6XgsIlAdiX1XH3bwW+HZZJrjjNkNEKoiDmxsP8+ZVPIvPsqadgGjSfDXea0O0mOrTSRo1O7Af7TDpzPPdlv+iAOs3q6SRId6Qxaht3ymMnEXiC6VqmoqhLAIrTuE0jpUhx0DgAczLw9vsYVESXjUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV/5P/Bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C31C116C6;
	Thu, 22 Jan 2026 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769103995;
	bh=Vb0BDsIkdF+pAP1UDkQuPP/llPkZVJAR7tMLh1xpciI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gV/5P/BjPDm2/3dx8fHwESKu9Tu63HKJEB0O0t8WwLB5GL96hb8Su4Ep1LjREBS/J
	 lXn3dD09x7A9H3OlPv43nCqA35nf7JAqth6y3HRfEJW1TVCNL8/7YmLs9epXy+cp5K
	 NZtb9L3OhaE/Xe+9+hLkC0IPz72UTvvHQVjYAobZTiOudWOVVexOdlEUCVkCBfEBIW
	 Ydi+Dn1a4iBJiw1TOZQo+tOxCnsoYyM2Xwx98E0stGFgFZKrjvDip7T1uT9j7v6Sfs
	 2Aic/yaGU+6utKEagn90FfeE6XUtSA2TiE910xa0HGCuQl7wBZ5q/zswKuPyGszE/E
	 N29lxnwg9p9dA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 18:46:13 +0100
Subject: [PATCH nf-next v4 1/5] netfilter: Add ctx pointer in
 nf_flow_skb_encap_protocol/nf_flow_ip4_tunnel_proto signature
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-b4-flowtable-offload-ip6ip6-v4-1-ea3dd826c23b@kernel.org>
References: <20260122-b4-flowtable-offload-ip6ip6-v4-0-ea3dd826c23b@kernel.org>
In-Reply-To: <20260122-b4-flowtable-offload-ip6ip6-v4-0-ea3dd826c23b@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10387-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C2C76C10A
X-Rspamd-Action: no action

Rely on nf_flowtable_ctx struct pointer in nf_flow_ip4_tunnel_proto and
nf_flow_skb_encap_protocol routine signature. This is a preliminary patch
to introduce IP6IP6 flowtable acceleration since nf_flowtable_ctx will
be used to store IP6IP6 tunnel info.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/netfilter/nf_flow_table_ip.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index e128b0fe9a7bf50b458df9940d629ea08c521871..8d3fbeaca2df110180414d44b28475adce8724ae 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -293,15 +293,16 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
 	return NF_STOLEN;
 }
 
-static bool nf_flow_ip4_tunnel_proto(struct sk_buff *skb, u32 *psize)
+static bool nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
+				     struct sk_buff *skb)
 {
 	struct iphdr *iph;
 	u16 size;
 
-	if (!pskb_may_pull(skb, sizeof(*iph) + *psize))
+	if (!pskb_may_pull(skb, sizeof(*iph) + ctx->offset))
 		return false;
 
-	iph = (struct iphdr *)(skb_network_header(skb) + *psize);
+	iph = (struct iphdr *)(skb_network_header(skb) + ctx->offset);
 	size = iph->ihl << 2;
 
 	if (ip_is_fragment(iph) || unlikely(ip_has_options(size)))
@@ -311,7 +312,7 @@ static bool nf_flow_ip4_tunnel_proto(struct sk_buff *skb, u32 *psize)
 		return false;
 
 	if (iph->protocol == IPPROTO_IPIP)
-		*psize += size;
+		ctx->offset += size;
 
 	return true;
 }
@@ -327,8 +328,8 @@ static void nf_flow_ip4_tunnel_pop(struct sk_buff *skb)
 	skb_reset_network_header(skb);
 }
 
-static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
-				       u32 *offset)
+static bool nf_flow_skb_encap_protocol(struct nf_flowtable_ctx *ctx,
+				       struct sk_buff *skb, __be16 proto)
 {
 	__be16 inner_proto = skb->protocol;
 	struct vlan_ethhdr *veth;
@@ -341,7 +342,7 @@ static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 
 		veth = (struct vlan_ethhdr *)skb_mac_header(skb);
 		if (veth->h_vlan_encapsulated_proto == proto) {
-			*offset += VLAN_HLEN;
+			ctx->offset += VLAN_HLEN;
 			inner_proto = proto;
 			ret = true;
 		}
@@ -349,14 +350,14 @@ static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 	case htons(ETH_P_PPP_SES):
 		if (nf_flow_pppoe_proto(skb, &inner_proto) &&
 		    inner_proto == proto) {
-			*offset += PPPOE_SES_HLEN;
+			ctx->offset += PPPOE_SES_HLEN;
 			ret = true;
 		}
 		break;
 	}
 
 	if (inner_proto == htons(ETH_P_IP))
-		ret = nf_flow_ip4_tunnel_proto(skb, offset);
+		ret = nf_flow_ip4_tunnel_proto(ctx, skb);
 
 	return ret;
 }
@@ -414,7 +415,7 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 {
 	struct flow_offload_tuple tuple = {};
 
-	if (!nf_flow_skb_encap_protocol(skb, htons(ETH_P_IP), &ctx->offset))
+	if (!nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IP)))
 		return NULL;
 
 	if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0)
@@ -895,7 +896,7 @@ nf_flow_offload_ipv6_lookup(struct nf_flowtable_ctx *ctx,
 	struct flow_offload_tuple tuple = {};
 
 	if (skb->protocol != htons(ETH_P_IPV6) &&
-	    !nf_flow_skb_encap_protocol(skb, htons(ETH_P_IPV6), &ctx->offset))
+	    !nf_flow_skb_encap_protocol(ctx, skb, htons(ETH_P_IPV6)))
 		return NULL;
 
 	if (nf_flow_tuple_ipv6(ctx, skb, &tuple) < 0)

-- 
2.52.0


