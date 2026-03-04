Return-Path: <netfilter-devel+bounces-10954-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHybANEcqGnyoAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10954-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:51:45 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE8A1FF512
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F8A5304352E
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 11:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED823A451A;
	Wed,  4 Mar 2026 11:49:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8C371872;
	Wed,  4 Mar 2026 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624985; cv=none; b=HL1E7pyrU8FbMElnrz5YP1N9bbQUe6KF+OztAoxc4hH7tqroF4+foeiUARRQ6q4h1eA6lS1P2jLLuJWbpfLGB54LjZgIgxVTXbmOVUKPqxyaKPMDqMat4YVGJ8YfGVF3ncH3HCiDg9al58fvN7F0PRBbiCU2Q+piEJHGdRyO2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624985; c=relaxed/simple;
	bh=ZT/EDDkhYgq0ocv2OfM3frKO74Xat+zx8zS7EzsdJkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjN5GB/oRc/7YZLpOq0COASf+3dkx0xTA8giRF3Ie9Fx0lOyyghdUCOZIAdPgHIYUV2caceEftjGOUEUjvhYo92Ox+syc500cJiDGRAhoOaqFQZGx72ovPEOxMjDgT/ZOXpLYdXZ9fZFEWTscPFIOGxLxLH0IHhNfeiKIOQsPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 139ED6026E; Wed, 04 Mar 2026 12:49:43 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 03/14] netfilter: nft_fib_ipv6: switch to fib6_lookup
Date: Wed,  4 Mar 2026 12:49:10 +0100
Message-ID: <20260304114921.31042-4-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304114921.31042-1-fw@strlen.de>
References: <20260304114921.31042-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CE8A1FF512
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10954-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c15:e001:75::12fc:5321:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[91.216.245.30:received,100.90.174.1:received];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,strlen.de:mid,strlen.de:email]
X-Rspamd-Action: no action

Existing code works but it requires a temporary dst object that is
released again right away.

Switch to fib6_lookup + RT6_LOOKUP_F_DST_NOREF: no need for temporary dst
objects and refcount overhead anymore.

Provides ~13% improvement in match performance.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv6/netfilter/nft_fib_ipv6.c | 79 +++++++++++++++++++------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index dc375b725b28..8b2dba88ee96 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -52,7 +52,13 @@ static int nft_fib6_flowi_init(struct flowi6 *fl6, const struct nft_fib *priv,
 	fl6->flowlabel = (*(__be32 *)iph) & IPV6_FLOWINFO_MASK;
 	fl6->flowi6_l3mdev = nft_fib_l3mdev_master_ifindex_rcu(pkt, dev);
 
-	return lookup_flags;
+	return lookup_flags | RT6_LOOKUP_F_DST_NOREF;
+}
+
+static int nft_fib6_lookup(struct net *net, struct flowi6 *fl6,
+			   struct fib6_result *res, int flags)
+{
+	return fib6_lookup(net, fl6->flowi6_oif, fl6, res, flags);
 }
 
 static u32 __nft_fib6_eval_type(const struct nft_fib *priv,
@@ -60,13 +66,14 @@ static u32 __nft_fib6_eval_type(const struct nft_fib *priv,
 				struct ipv6hdr *iph)
 {
 	const struct net_device *dev = NULL;
+	struct fib6_result res = {};
 	int route_err, addrtype;
-	struct rt6_info *rt;
 	struct flowi6 fl6 = {
 		.flowi6_iif = LOOPBACK_IFINDEX,
 		.flowi6_proto = pkt->tprot,
 		.flowi6_uid = sock_net_uid(nft_net(pkt), NULL),
 	};
+	int lookup_flags;
 	u32 ret = 0;
 
 	if (priv->flags & NFTA_FIB_F_IIF)
@@ -74,29 +81,23 @@ static u32 __nft_fib6_eval_type(const struct nft_fib *priv,
 	else if (priv->flags & NFTA_FIB_F_OIF)
 		dev = nft_out(pkt);
 
-	nft_fib6_flowi_init(&fl6, priv, pkt, dev, iph);
+	lookup_flags = nft_fib6_flowi_init(&fl6, priv, pkt, dev, iph);
 
 	if (dev && nf_ipv6_chk_addr(nft_net(pkt), &fl6.daddr, dev, true))
 		ret = RTN_LOCAL;
 
-	route_err = nf_ip6_route(nft_net(pkt), (struct dst_entry **)&rt,
-				 flowi6_to_flowi(&fl6), false);
+	route_err = nft_fib6_lookup(nft_net(pkt), &fl6, &res, lookup_flags);
 	if (route_err)
 		goto err;
 
-	if (rt->rt6i_flags & RTF_REJECT) {
-		route_err = rt->dst.error;
-		dst_release(&rt->dst);
-		goto err;
-	}
+	if (res.fib6_flags & RTF_REJECT)
+		return res.fib6_type;
 
-	if (ipv6_anycast_destination((struct dst_entry *)rt, &fl6.daddr))
+	if (__ipv6_anycast_destination(&res.f6i->fib6_dst, res.fib6_flags, &fl6.daddr))
 		ret = RTN_ANYCAST;
-	else if (!dev && rt->rt6i_flags & RTF_LOCAL)
+	else if (!dev && res.fib6_flags & RTF_LOCAL)
 		ret = RTN_LOCAL;
 
-	dst_release(&rt->dst);
-
 	if (ret)
 		return ret;
 
@@ -152,6 +153,33 @@ static bool nft_fib_v6_skip_icmpv6(const struct sk_buff *skb, u8 next, const str
 	return ipv6_addr_type(&iph->daddr) & IPV6_ADDR_LINKLOCAL;
 }
 
+static bool nft_fib6_info_nh_dev_match(const struct net_device *nh_dev,
+				       const struct net_device *dev)
+{
+	return nh_dev == dev ||
+	       l3mdev_master_ifindex_rcu(nh_dev) == dev->ifindex;
+}
+
+static bool nft_fib6_info_nh_uses_dev(struct fib6_info *rt,
+				      const struct net_device *dev)
+{
+	const struct net_device *nh_dev;
+	struct fib6_info *iter;
+
+	nh_dev = fib6_info_nh_dev(rt);
+	if (nft_fib6_info_nh_dev_match(nh_dev, dev))
+		return true;
+
+	list_for_each_entry(iter, &rt->fib6_siblings, fib6_siblings) {
+		nh_dev = fib6_info_nh_dev(iter);
+
+		if (nft_fib6_info_nh_dev_match(nh_dev, dev))
+			return true;
+	}
+
+	return false;
+}
+
 void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		   const struct nft_pktinfo *pkt)
 {
@@ -160,14 +188,14 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	const struct net_device *found = NULL;
 	const struct net_device *oif = NULL;
 	u32 *dest = &regs->data[priv->dreg];
+	struct fib6_result res = {};
 	struct ipv6hdr *iph, _iph;
 	struct flowi6 fl6 = {
 		.flowi6_iif = LOOPBACK_IFINDEX,
 		.flowi6_proto = pkt->tprot,
 		.flowi6_uid = sock_net_uid(nft_net(pkt), NULL),
 	};
-	struct rt6_info *rt;
-	int lookup_flags;
+	int lookup_flags, ret;
 
 	if (nft_fib_can_skip(pkt)) {
 		nft_fib_store_result(dest, priv, nft_in(pkt));
@@ -193,26 +221,17 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	lookup_flags = nft_fib6_flowi_init(&fl6, priv, pkt, oif, iph);
 
 	*dest = 0;
-	rt = (void *)ip6_route_lookup(nft_net(pkt), &fl6, pkt->skb,
-				      lookup_flags);
-	if (rt->dst.error)
-		goto put_rt_err;
-
-	/* Should not see RTF_LOCAL here */
-	if (rt->rt6i_flags & (RTF_REJECT | RTF_ANYCAST | RTF_LOCAL))
-		goto put_rt_err;
+	ret = nft_fib6_lookup(nft_net(pkt), &fl6, &res, lookup_flags);
+	if (ret || res.fib6_flags & (RTF_REJECT | RTF_ANYCAST | RTF_LOCAL))
+		return;
 
 	if (!oif) {
-		found = rt->rt6i_idev->dev;
+		found = fib6_info_nh_dev(res.f6i);
 	} else {
-		if (oif == rt->rt6i_idev->dev ||
-		    l3mdev_master_ifindex_rcu(rt->rt6i_idev->dev) == oif->ifindex)
+		if (nft_fib6_info_nh_uses_dev(res.f6i, oif))
 			found = oif;
 	}
-
 	nft_fib_store_result(dest, priv, found);
- put_rt_err:
-	ip6_rt_put(rt);
 }
 EXPORT_SYMBOL_GPL(nft_fib6_eval);
 
-- 
2.52.0


