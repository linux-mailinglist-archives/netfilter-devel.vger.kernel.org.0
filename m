Return-Path: <netfilter-devel+bounces-13009-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TSo7JeaWH2oNngAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13009-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 03 Jun 2026 04:52:22 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C82633B86
	for <lists+netfilter-devel@lfdr.de>; Wed, 03 Jun 2026 04:52:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=AiUW4t0H;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13009-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13009-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E2FD3075FC4
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jun 2026 02:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DAE384CCB;
	Wed,  3 Jun 2026 02:50:58 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1853DC87A
	for <netfilter-devel@vger.kernel.org>; Wed,  3 Jun 2026 02:50:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455058; cv=none; b=WeIcy8xLwSG78ERSqyBfJBHVpvmSMcPbMzRnbhXarBKPVsIMac4aB4JnjXwCTZJJ+acVBwcQ8uU9xk+9WToes8PLLRo4ZmtoQ05zPNZ3rpKNCFH4+ZaycyCperxrMznhDze7B3DD9MKdUbPrbgEMS8ddsEx8Io+cwgiPIl/AFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455058; c=relaxed/simple;
	bh=eEq8iNXQCACbV78K62R7s3Cn5kOKlLHTcV5KQZJYgcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEN0UrHkJFASczMFhPH7zs8QmhGww/fc4dJ3vlbalMNURtmUqhEoMkwk56dWEyI8HrpDHMhks4+lbvaNFmaqM1+hPFncjRRIdobqD0fyD4x1tH0lU5cNuayFGlpgHS7bJygOyqMn51/yarwnIK4y9sZQM9APnYmtPo9MijNPYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AiUW4t0H; arc=none smtp.client-ip=91.218.175.185
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780455054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MQLPpaSkYjgDNM6V9ukCVjB+PUc9tCwTjIjPYJtPcK4=;
	b=AiUW4t0HEnL+VMo6ZR1/oy6Nfs0ndz2lo8yfecgsCm7O/jakEFvHqO6Dk68YV5q3g1U9Qa
	8QIwnqtf5VKxa3GH7Fqj/4E99iillce4dd3aUnJU2OPmATaApv0iU4eWTWKyZMxnVu4j+8
	FqcIGvJfHAntZKPRBUVLckMcpKkrx1Y=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qingfang Deng <qingfang.deng@linux.dev>
Subject: [PATCH nf-next] netfilter: flowtable: remove inline segmentation
Date: Wed,  3 Jun 2026 10:50:46 +0800
Message-ID: <20260603025047.32839-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13009-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:qingfang.deng@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[qingfang.deng@linux.dev,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07C82633B86

Now that PPPoE driver has proper GSO support, this is no longer needed.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 include/net/netfilter/nf_flow_table.h |  1 -
 net/netfilter/nf_flow_table_core.c    |  1 -
 net/netfilter/nf_flow_table_ip.c      | 34 ---------------------------
 net/netfilter/nf_flow_table_path.c    |  3 ---
 4 files changed, 39 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 7b23b245a5a8..61ee74e95d2b 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -151,7 +151,6 @@ struct flow_offload_tuple {
 	u16				dir:2,
 					xmit_type:3,
 					encap_num:2,
-					needs_gso_segment:1,
 					tun_num:2,
 					in_vlan_ingress:2;
 	u16				mtu;
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 785d8c244a77..2c4140e6f53c 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -122,7 +122,6 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 
 	flow_tuple->tun = route->tuple[dir].in.tun;
 	flow_tuple->encap_num = route->tuple[dir].in.num_encaps;
-	flow_tuple->needs_gso_segment = route->tuple[dir].out.needs_gso_segment;
 	flow_tuple->tun_num = route->tuple[dir].in.num_tuns;
 
 	switch (route->tuple[dir].xmit_type) {
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 9c05a50d6013..9ec44ea2bcd2 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -771,7 +771,6 @@ struct nf_flow_xmit {
 	const void		*source;
 	struct net_device	*outdev;
 	struct flow_offload_tuple *tuple;
-	bool			needs_gso_segment;
 };
 
 static void __nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
@@ -792,41 +791,10 @@ static void __nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
 	dev_queue_xmit(skb);
 }
 
-static unsigned int nf_flow_encap_gso_xmit(struct net *net, struct sk_buff *skb,
-					   struct nf_flow_xmit *xmit)
-{
-	struct sk_buff *segs, *nskb;
-
-	segs = skb_gso_segment(skb, 0);
-	if (IS_ERR(segs))
-		return NF_DROP;
-
-	if (segs)
-		consume_skb(skb);
-	else
-		segs = skb;
-
-	skb_list_walk_safe(segs, segs, nskb) {
-		skb_mark_not_on_list(segs);
-
-		if (nf_flow_encap_push(segs, xmit->tuple, xmit->outdev) < 0) {
-			kfree_skb(segs);
-			kfree_skb_list(nskb);
-			return NF_STOLEN;
-		}
-		__nf_flow_queue_xmit(net, segs, xmit);
-	}
-
-	return NF_STOLEN;
-}
-
 static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
 				       struct nf_flow_xmit *xmit)
 {
 	if (xmit->tuple->encap_num) {
-		if (skb_is_gso(skb) && xmit->needs_gso_segment)
-			return nf_flow_encap_gso_xmit(net, skb, xmit);
-
 		if (nf_flow_encap_push(skb, xmit->tuple, xmit->outdev) < 0)
 			return NF_DROP;
 	}
@@ -910,7 +878,6 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 		return NF_DROP;
 	}
 	xmit.tuple = other_tuple;
-	xmit.needs_gso_segment = tuplehash->tuple.needs_gso_segment;
 
 	return nf_flow_queue_xmit(state->net, skb, &xmit);
 }
@@ -1231,7 +1198,6 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 		return NF_DROP;
 	}
 	xmit.tuple = other_tuple;
-	xmit.needs_gso_segment = tuplehash->tuple.needs_gso_segment;
 
 	return nf_flow_queue_xmit(state->net, skb, &xmit);
 }
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 9e88ea6a2eef..700a6ae34aa3 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -86,7 +86,6 @@ struct nft_forward_info {
 	u8 ingress_vlans;
 	u8 h_source[ETH_ALEN];
 	u8 h_dest[ETH_ALEN];
-	bool needs_gso_segment;
 	enum flow_offload_xmit_type xmit_type;
 };
 
@@ -142,7 +141,6 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 			if (path->type == DEV_PATH_PPPOE) {
 				memcpy(info->h_dest, path->encap.h_dest, ETH_ALEN);
 				info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
-				info->needs_gso_segment = 1;
 			}
 			break;
 		case DEV_PATH_BRIDGE:
@@ -283,7 +281,6 @@ static void nft_dev_forward_path(const struct nft_pktinfo *pkt,
 		memcpy(route->tuple[dir].out.h_dest, info.h_dest, ETH_ALEN);
 		route->tuple[dir].xmit_type = info.xmit_type;
 	}
-	route->tuple[dir].out.needs_gso_segment = info.needs_gso_segment;
 }
 
 int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
-- 
2.43.0


