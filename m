Return-Path: <netfilter-devel+bounces-13714-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +GD5DmYZTmrRDAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13714-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 11:33:26 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE4E723C56
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 11:33:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=berYGJRj;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13714-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13714-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 498883014863
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 09:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B1A416D12;
	Wed,  8 Jul 2026 09:33:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A540B6D9
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Jul 2026 09:33:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503192; cv=none; b=lltCkuQeojUbfP9eI8VB39Rr6vE8HGZV+k0g6qNxX34fBUwbbJkRAuDfArHLTae50nc1+0H/Md79uWDhj9MU4bzy17bNFGf7tYREQwQEWnEe3CAS/gZAsGjmqlVd7NMxbjA9sFSx/6mj5xO1BU1cAbDXQQjvB89sEdYAE0eROuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503192; c=relaxed/simple;
	bh=/9n6elf9/QQyUIYk6CFJr+wuZ0dhotKnak9tKLwKfGw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQN2wF+cC1f3nY5xQXCW2vrGbmDwTM5S1/iWWXh3pmVysQ3UyK/uOQRJ5Pj1/isbF3W1fSaeBpn4eP2QoGMxr+OpEzWG2NJMXOvndkJPlCLM8TdvUR0Xt45KUNs5fdhVPQQsP2Q/3QNypNLPWRVA8WZjZoqEbGH5oXSD0JCF2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=berYGJRj; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 8E82B6057E
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Jul 2026 11:32:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783503177;
	bh=4m0Pf/sAFsxmsWuLaEObSKxzqCHTbZXeK3abW83sgd4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=berYGJRjNw65HYjlbLlY+NozsLVbV1JNUx4qSa3xR0AiV308+gJPEw8r1IYCV8Uj5
	 JLKV/lH7eLHUTFjLsJunP98qR9Yfto1yzZ5vJclIAmBWvanflGv9apX85E28ziNnMf
	 2vUFj++eXDt4KYFhXASCjbVdoHXTZY6ehLxU1abFaTko6lvKzr9MyKqsqofT4XOnSi
	 qv7QuKZSqme7dAdlbGIzAqCVs/72JLYY+gxoDQhldQ0t4bw5kPfFJgKO3tDBTq+PTp
	 8MR1IU4hcjL0guvTbyCy9E177gtAnTLE8L2eAeoI/g89/dzYxlki5zLbXtsxVhcgT7
	 JeOEXeA3uo0gg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v1 2/4] net: pass net_device_path_ctx struct to dev_fill_forward_path()
Date: Wed,  8 Jul 2026 11:32:48 +0200
Message-ID: <20260708093250.1187068-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708093250.1187068-1-pablo@netfilter.org>
References: <20260708093250.1187068-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13714-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ctx.dev:url,netfilter.org:from_mime,netfilter.org:email,netfilter.org:mid,netfilter.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AE4E723C56

Generalize dev_fill_forward_path() so it can be used by the bridge
family to retrieve the bridge vlan filtering information from the
bridge port when discovering the bridge flowtable path.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v1: A different approach compared to Eric Woudstra's proposal to
    add another function to the net core for the bridge case.
    I am leaning towards making a simple generalization and keep
    the bridge vlan filtering path discovery special case under
    the flowtable at this stage.

 include/linux/netdevice.h          |  2 +-
 net/core/dev.c                     | 18 +++++++-----------
 net/netfilter/nf_flow_table_path.c | 12 +++++++++++-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 07bf265d0295..41cd092b032c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3420,7 +3420,7 @@ void dev_remove_offload(struct packet_offload *po);
 
 int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
-int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
+int dev_fill_forward_path(struct net_device_path_ctx *ctx,
 			  struct net_device_path_stack *stack);
 struct net_device *dev_get_by_name(struct net *net, const char *name);
 struct net_device *dev_get_by_name_rcu(struct net *net, const char *name);
diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..9a065c286d92 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -750,41 +750,37 @@ static struct net_device_path *dev_fwd_path(struct net_device_path_stack *stack)
 	return &stack->path[k];
 }
 
-int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
+int dev_fill_forward_path(struct net_device_path_ctx *ctx,
 			  struct net_device_path_stack *stack)
 {
 	const struct net_device *last_dev;
-	struct net_device_path_ctx ctx = {
-		.dev	= dev,
-	};
 	struct net_device_path *path;
 	int ret = 0;
 
-	memcpy(ctx.daddr, daddr, sizeof(ctx.daddr));
 	stack->num_paths = 0;
-	while (ctx.dev && ctx.dev->netdev_ops->ndo_fill_forward_path) {
-		last_dev = ctx.dev;
+	while (ctx->dev && ctx->dev->netdev_ops->ndo_fill_forward_path) {
+		last_dev = ctx->dev;
 		path = dev_fwd_path(stack);
 		if (!path)
 			return -1;
 
 		memset(path, 0, sizeof(struct net_device_path));
-		ret = ctx.dev->netdev_ops->ndo_fill_forward_path(&ctx, path);
+		ret = ctx->dev->netdev_ops->ndo_fill_forward_path(ctx, path);
 		if (ret < 0)
 			return -1;
 
-		if (WARN_ON_ONCE(last_dev == ctx.dev))
+		if (WARN_ON_ONCE(last_dev == ctx->dev))
 			return -1;
 	}
 
-	if (!ctx.dev)
+	if (!ctx->dev)
 		return ret;
 
 	path = dev_fwd_path(stack);
 	if (!path)
 		return -1;
 	path->type = DEV_PATH_ETHERNET;
-	path->dev = ctx.dev;
+	path->dev = ctx->dev;
 
 	return ret;
 }
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 98c03b487f52..007e9781902a 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -42,6 +42,14 @@ static bool nft_is_valid_ether_device(const struct net_device *dev)
 	return true;
 }
 
+static void nft_dev_fill_forward_path_init(struct net_device_path_ctx *ctx,
+					   const struct net_device *dev, const u8 *daddr)
+{
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->dev	= dev;
+	memcpy(ctx->daddr, daddr, sizeof(ctx->daddr));
+}
+
 static int nft_dev_fill_forward_path(const struct nf_flow_route *route,
 				     const struct dst_entry *dst_cache,
 				     const struct nf_conn *ct,
@@ -50,6 +58,7 @@ static int nft_dev_fill_forward_path(const struct nf_flow_route *route,
 {
 	const void *daddr = &ct->tuplehash[!dir].tuple.src.u3;
 	struct net_device *dev = dst_cache->dev;
+	struct net_device_path_ctx ctx;
 	struct neighbour *n;
 	u8 nud_state;
 
@@ -71,8 +80,9 @@ static int nft_dev_fill_forward_path(const struct nf_flow_route *route,
 	if (!(nud_state & NUD_VALID))
 		return -1;
 
+	nft_dev_fill_forward_path_init(&ctx, dev, ha);
 out:
-	return dev_fill_forward_path(dev, ha, stack);
+	return dev_fill_forward_path(&ctx, stack);
 }
 
 struct nft_forward_info {
-- 
2.47.3


