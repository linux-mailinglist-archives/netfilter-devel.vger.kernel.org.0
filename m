Return-Path: <netfilter-devel+bounces-5829-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F329A16337
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Jan 2025 18:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E231645C2
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Jan 2025 17:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA4C1DE3C0;
	Sun, 19 Jan 2025 17:21:06 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6CB4502A;
	Sun, 19 Jan 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307266; cv=none; b=SnO5e4HslrPMMBRzBb1shvvYJEn9GmhHPtivxlrg9l53rYms4KFbFC/5OoZybbi/C00VccWWyoUWzfjDSWqw8BMyXwnfn8yszgZvONE7zV8QHXMixc1oAOOTP/kCqMJ6vWAaTULXl84q+pGDgxkCSiQ5gw/OosNkR5jP/Meg7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307266; c=relaxed/simple;
	bh=x457vClxdXwyX0BUMXFilhpbcmdZI8gmCMn1+4QaMCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htgy/h9kp8wU7IM7n9OUov3g4TlQEl8q4cJEGS4yEdpOCja0tNoloXswM+2S1kEfGvLF/NV5hJPoWseWTROPSBlWPu/WciPAW/7tuPKSAYZbPcECjL5h80ohkktgfps/Ma7Pv15ijJmI8317SO8JbnuGow9k0pHdZVFreB45Zes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 02/14] netfilter: br_netfilter: remove unused conditional and dead code
Date: Sun, 19 Jan 2025 18:20:39 +0100
Message-Id: <20250119172051.8261-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250119172051.8261-1-pablo@netfilter.org>
References: <20250119172051.8261-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Antoine Tenart <atenart@kernel.org>

The SKB_DROP_REASON_IP_INADDRERRORS drop reason is never returned from
any function, as such it cannot be returned from the ip_route_input call
tree. The 'reason != SKB_DROP_REASON_IP_INADDRERRORS' conditional is
thus always true.

Looking back at history, commit 50038bf38e65 ("net: ip: make
ip_route_input() return drop reasons") changed the ip_route_input
returned value check in br_nf_pre_routing_finish from -EHOSTUNREACH to
SKB_DROP_REASON_IP_INADDRERRORS. It turns out -EHOSTUNREACH could not be
returned either from the ip_route_input call tree and this since commit
251da4130115 ("ipv4: Cache ip_error() routes even when not
forwarding.").

Not a fix as this won't change the behavior. While at it use
kfree_skb_reason.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/bridge/br_netfilter_hooks.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 451e45b9a6a5..94cbe967d1c1 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -393,38 +393,10 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 		reason = ip_route_input(skb, iph->daddr, iph->saddr,
 					ip4h_dscp(iph), dev);
 		if (reason) {
-			struct in_device *in_dev = __in_dev_get_rcu(dev);
-
-			/* If err equals -EHOSTUNREACH the error is due to a
-			 * martian destination or due to the fact that
-			 * forwarding is disabled. For most martian packets,
-			 * ip_route_output_key() will fail. It won't fail for 2 types of
-			 * martian destinations: loopback destinations and destination
-			 * 0.0.0.0. In both cases the packet will be dropped because the
-			 * destination is the loopback device and not the bridge. */
-			if (reason != SKB_DROP_REASON_IP_INADDRERRORS || !in_dev ||
-			    IN_DEV_FORWARD(in_dev))
-				goto free_skb;
-
-			rt = ip_route_output(net, iph->daddr, 0,
-					     ip4h_dscp(iph), 0,
-					     RT_SCOPE_UNIVERSE);
-			if (!IS_ERR(rt)) {
-				/* - Bridged-and-DNAT'ed traffic doesn't
-				 *   require ip_forwarding. */
-				if (rt->dst.dev == dev) {
-					skb_dst_drop(skb);
-					skb_dst_set(skb, &rt->dst);
-					goto bridged_dnat;
-				}
-				ip_rt_put(rt);
-			}
-free_skb:
-			kfree_skb(skb);
+			kfree_skb_reason(skb, reason);
 			return 0;
 		} else {
 			if (skb_dst(skb)->dev == dev) {
-bridged_dnat:
 				skb->dev = br_indev;
 				nf_bridge_update_protocol(skb);
 				nf_bridge_push_encap_header(skb);
-- 
2.30.2


