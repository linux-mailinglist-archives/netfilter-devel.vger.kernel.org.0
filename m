Return-Path: <netfilter-devel+bounces-10473-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Or2Dhcyemlo4gEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10473-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 16:58:15 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBDDA4D3A
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 16:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 181BD302C388
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235492F744C;
	Wed, 28 Jan 2026 15:42:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A82D9EFB;
	Wed, 28 Jan 2026 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614930; cv=none; b=FV8N4UiU4VbBbZbP23Ot0LPupcvr36XGlEl0kfdjnkvg7qH4i6/4MhQc899AAVEWY1fz/+kUMX1eqTXJrlsNaCsID7ya7MWMNqnu2K1rNb6TEVib2aGNmPQrjTFDys+EXOAcDbrEc3ei6OqVr0bku358gpeczT3uPCL35CTI6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614930; c=relaxed/simple;
	bh=wSGFSN1nQHmQTTeW7+DBe1vH+md+OrxzQ1xLStgYkzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oO1gjZVAbSgb2N6PIsdKq8wbtmRFPqwdsKw1MuSvpIfbfJYIuYeprH3rzBoZyf8mN0F+CMFV63RoC6atotAQqgWrgArjwymqogwaVk9CT0iEr6/hkGG+e8T7g53cZSyayYlrNV/p2Pgf+yWXHY3WlONng6+7zPnC2AHOZ/P9EJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 266EE60520; Wed, 28 Jan 2026 16:42:07 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 2/9] netfilter: Introduce tunnel metadata info in nf_flowtable_ctx struct
Date: Wed, 28 Jan 2026 16:41:48 +0100
Message-ID: <20260128154155.32143-3-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128154155.32143-1-fw@strlen.de>
References: <20260128154155.32143-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10473-lists,netfilter-devel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 5DBDDA4D3A
X-Rspamd-Action: no action

From: Lorenzo Bianconi <lorenzo@kernel.org>

Add tunnel hdr_size and tunnel proto fields in nf_flowtable_ctx struct
in order to store IP tunnel header size and protocol used during IPIP
and IP6IP6 tunnel sw offloading decapsulation and avoid recomputing them
during tunnel header pop since this is constant for IPv6.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_flow_table_ip.c | 41 +++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 283b3fe61919..ddfaddfa57be 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -144,6 +144,18 @@ static bool ip_has_options(unsigned int thoff)
 	return thoff != sizeof(struct iphdr);
 }
 
+struct nf_flowtable_ctx {
+	const struct net_device	*in;
+	u32			offset;
+	u32			hdrsize;
+	struct {
+		/* Tunnel IP header size */
+		u32 hdr_size;
+		/* IP tunnel protocol */
+		u8 proto;
+	} tun;
+};
+
 static void nf_flow_tuple_encap(struct sk_buff *skb,
 				struct flow_offload_tuple *tuple)
 {
@@ -186,12 +198,6 @@ static void nf_flow_tuple_encap(struct sk_buff *skb,
 	}
 }
 
-struct nf_flowtable_ctx {
-	const struct net_device	*in;
-	u32			offset;
-	u32			hdrsize;
-};
-
 static int nf_flow_tuple_ip(struct nf_flowtable_ctx *ctx, struct sk_buff *skb,
 			    struct flow_offload_tuple *tuple)
 {
@@ -313,20 +319,22 @@ static bool nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
 	if (iph->ttl <= 1)
 		return false;
 
-	if (iph->protocol == IPPROTO_IPIP)
+	if (iph->protocol == IPPROTO_IPIP) {
+		ctx->tun.proto = IPPROTO_IPIP;
+		ctx->tun.hdr_size = size;
 		ctx->offset += size;
+	}
 
 	return true;
 }
 
-static void nf_flow_ip4_tunnel_pop(struct sk_buff *skb)
+static void nf_flow_ip4_tunnel_pop(struct nf_flowtable_ctx *ctx,
+				   struct sk_buff *skb)
 {
-	struct iphdr *iph = (struct iphdr *)skb_network_header(skb);
-
-	if (iph->protocol != IPPROTO_IPIP)
+	if (ctx->tun.proto != IPPROTO_IPIP)
 		return;
 
-	skb_pull(skb, iph->ihl << 2);
+	skb_pull(skb, ctx->tun.hdr_size);
 	skb_reset_network_header(skb);
 }
 
@@ -364,7 +372,8 @@ static bool nf_flow_skb_encap_protocol(struct nf_flowtable_ctx *ctx,
 	return ret;
 }
 
-static void nf_flow_encap_pop(struct sk_buff *skb,
+static void nf_flow_encap_pop(struct nf_flowtable_ctx *ctx,
+			      struct sk_buff *skb,
 			      struct flow_offload_tuple_rhash *tuplehash)
 {
 	struct vlan_hdr *vlan_hdr;
@@ -391,7 +400,7 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 	}
 
 	if (skb->protocol == htons(ETH_P_IP))
-		nf_flow_ip4_tunnel_pop(skb);
+		nf_flow_ip4_tunnel_pop(ctx, skb);
 }
 
 struct nf_flow_xmit {
@@ -461,7 +470,7 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 
 	flow_offload_refresh(flow_table, flow, false);
 
-	nf_flow_encap_pop(skb, tuplehash);
+	nf_flow_encap_pop(ctx, skb, tuplehash);
 	thoff -= ctx->offset;
 
 	iph = ip_hdr(skb);
@@ -876,7 +885,7 @@ static int nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
 
 	flow_offload_refresh(flow_table, flow, false);
 
-	nf_flow_encap_pop(skb, tuplehash);
+	nf_flow_encap_pop(ctx, skb, tuplehash);
 
 	ip6h = ipv6_hdr(skb);
 	nf_flow_nat_ipv6(flow, skb, dir, ip6h);
-- 
2.52.0


