Return-Path: <netfilter-devel+bounces-1688-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAAE89D6DF
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Apr 2024 12:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD59EB24E43
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Apr 2024 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98FB839F1;
	Tue,  9 Apr 2024 10:18:09 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A458C7F482;
	Tue,  9 Apr 2024 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657889; cv=none; b=Xoh0XDxI61VlijK91+iPj5Hp2VbooTncJ8tLp36X1Mp6KXZ0iDlUvbdz8XrncYOFf36qwZoDZ9OQAXKuw8Ut1dMxQoGpQ1TTYejagss7CNo2wvzPLRk1V67WbA6E0FhPF+g+VHAWVz2LTB/bU6J052wm8obrb9BdoegI6VrhW9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657889; c=relaxed/simple;
	bh=rGMncj0+ve7nfZSZf1usFk4SQASbxKQpvrs5SCfE+po=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFmplg3urlGvWnfsLlEeTg8/EuZsqsDx4C4c2mJgTymtS0yz+GCZvv3D/XmQWboYpxKSbppC/4h+OmcIAIhVqKtAZvMV/KW6ES2jmVjwD7ZrcV6JtSt6TtkTH9BkPBfQtsKrzthxWbbE1oWWyHFW5Evuc5mADyJ11vZd3qctSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	fw@strlen.de,
	jianbol@nvidia.com,
	roopa@nvidia.com,
	razor@blackwall.org
Subject: [PATCH nf] netfilter: br_netfilter: skip conntrack input hook for promisc packets
Date: Tue,  9 Apr 2024 12:17:59 +0200
Message-Id: <20240409101759.320519-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For historical reasons, when bridge device is in promisc mode, packets
that are directed to the taps follow bridge input hook path. This patch
adds a workaround to reset conntrack for these packets.

Jianbo Liu reports warning splats in their test infrastructure where
cloned packets reach the br_netfilter input hook to confirm the
conntrack object.

Scratch one bit from BR_INPUT_SKB_CB to annotate that this packet has
reached the input hook because it is passed up to the bridge device to
reach the taps.

Promisc flag is unsed for link-local traffic that follows input hook to
make sure bridge input conntrack hook does not access unset control
buffer fields.

[   57.571874] WARNING: CPU: 1 PID: 0 at net/bridge/br_netfilter_hooks.c:616 br_nf_local_in+0x157/0x180 [br_netfilter]
[   57.572749] Modules linked in: xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat xt_addrtype xt_conntrack nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_isc si ib_umad rdma_cm ib_ipoib iw_cm ib_cm mlx5_ib ib_uverbs ib_core mlx5ctl mlx5_core
[   57.575158] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0+ #19
[   57.575700] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[   57.576662] RIP: 0010:br_nf_local_in+0x157/0x180 [br_netfilter]
[   57.577195] Code: fe ff ff 41 bd 04 00 00 00 be 04 00 00 00 e9 4a ff ff ff be 04 00 00 00 48 89 ef e8 f3 a9 3c e1 66 83 ad b4 00 00 00 04 eb 91 <0f> 0b e9 f1 fe ff ff 0f 0b e9 df fe ff ff 48 89 df e8 b3 53 47 e1
[   57.578722] RSP: 0018:ffff88885f845a08 EFLAGS: 00010202
[   57.579207] RAX: 0000000000000002 RBX: ffff88812dfe8000 RCX: 0000000000000000
[   57.579830] RDX: ffff88885f845a60 RSI: ffff8881022dc300 RDI: 0000000000000000
[   57.580454] RBP: ffff88885f845a60 R08: 0000000000000001 R09: 0000000000000003
[   57.581076] R10: 00000000ffff1300 R11: 0000000000000002 R12: 0000000000000000
[   57.581695] R13: ffff8881047ffe00 R14: ffff888108dbee00 R15: ffff88814519b800
[   57.582313] FS:  0000000000000000(0000) GS:ffff88885f840000(0000) knlGS:0000000000000000
[   57.583040] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.583564] CR2: 000000c4206aa000 CR3: 0000000103847001 CR4: 0000000000370eb0
[   57.584194] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   57.584820] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   57.585440] Call Trace:
[   57.585721]  <IRQ>
[   57.585976]  ? __warn+0x7d/0x130
[   57.586323]  ? br_nf_local_in+0x157/0x180 [br_netfilter]
[   57.586811]  ? report_bug+0xf1/0x1c0
[   57.587177]  ? handle_bug+0x3f/0x70
[   57.587539]  ? exc_invalid_op+0x13/0x60
[   57.587929]  ? asm_exc_invalid_op+0x16/0x20
[   57.588336]  ? br_nf_local_in+0x157/0x180 [br_netfilter]
[   57.588825]  nf_hook_slow+0x3d/0xd0
[   57.589188]  ? br_handle_vlan+0x4b/0x110
[   57.589579]  br_pass_frame_up+0xfc/0x150
[   57.589970]  ? br_port_flags_change+0x40/0x40
[   57.590396]  br_handle_frame_finish+0x346/0x5e0
[   57.590837]  ? ipt_do_table+0x32e/0x430
[   57.591221]  ? br_handle_local_finish+0x20/0x20
[   57.591656]  br_nf_hook_thresh+0x4b/0xf0 [br_netfilter]
[   57.592286]  ? br_handle_local_finish+0x20/0x20
[   57.592802]  br_nf_pre_routing_finish+0x178/0x480 [br_netfilter]
[   57.593348]  ? br_handle_local_finish+0x20/0x20
[   57.593782]  ? nf_nat_ipv4_pre_routing+0x25/0x60 [nf_nat]
[   57.594279]  br_nf_pre_routing+0x24c/0x550 [br_netfilter]
[   57.594780]  ? br_nf_hook_thresh+0xf0/0xf0 [br_netfilter]
[   57.595280]  br_handle_frame+0x1f3/0x3d0
[   57.595676]  ? br_handle_local_finish+0x20/0x20
[   57.596118]  ? br_handle_frame_finish+0x5e0/0x5e0
[   57.596566]  __netif_receive_skb_core+0x25b/0xfc0
[   57.597017]  ? __napi_build_skb+0x37/0x40
[   57.597418]  __netif_receive_skb_list_core+0xfb/0x220

Fixes: 62e7151ae3eb ("netfilter: bridge: confirm multicast packets before passing them up the stack")
Reported-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Slightly different version, where promisc flag in BR_INPUT_SKB_CB is set on
later to make sure previous patch is not papering the real problem.

 net/bridge/br_input.c                      | 15 +++++++++++----
 net/bridge/br_netfilter_hooks.c            |  6 ++++++
 net/bridge/br_private.h                    |  1 +
 net/bridge/netfilter/nf_conntrack_bridge.c | 14 ++++++++++----
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index f21097e73482..ceaa5a89b947 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -30,7 +30,7 @@ br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
 	return netif_receive_skb(skb);
 }
 
-static int br_pass_frame_up(struct sk_buff *skb)
+static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
 {
 	struct net_device *indev, *brdev = BR_INPUT_SKB_CB(skb)->brdev;
 	struct net_bridge *br = netdev_priv(brdev);
@@ -65,6 +65,8 @@ static int br_pass_frame_up(struct sk_buff *skb)
 	br_multicast_count(br, NULL, skb, br_multicast_igmp_type(skb),
 			   BR_MCAST_DIR_TX);
 
+	BR_INPUT_SKB_CB(skb)->promisc = promisc;
+
 	return NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
 		       dev_net(indev), NULL, skb, indev, NULL,
 		       br_netif_receive_skb);
@@ -82,6 +84,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	struct net_bridge_mcast *brmctx;
 	struct net_bridge_vlan *vlan;
 	struct net_bridge *br;
+	bool promisc;
 	u16 vid = 0;
 	u8 state;
 
@@ -137,7 +140,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (p->flags & BR_LEARNING)
 		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
 
-	local_rcv = !!(br->dev->flags & IFF_PROMISC);
+	promisc = !!(br->dev->flags & IFF_PROMISC);
+	local_rcv = promisc;
+
 	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest)) {
 		/* by definition the broadcast is also a multicast address */
 		if (is_broadcast_ether_addr(eth_hdr(skb)->h_dest)) {
@@ -200,7 +205,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		unsigned long now = jiffies;
 
 		if (test_bit(BR_FDB_LOCAL, &dst->flags))
-			return br_pass_frame_up(skb);
+			return br_pass_frame_up(skb, false);
 
 		if (now != dst->used)
 			dst->used = now;
@@ -213,7 +218,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	}
 
 	if (local_rcv)
-		return br_pass_frame_up(skb);
+		return br_pass_frame_up(skb, promisc);
 
 out:
 	return 0;
@@ -386,6 +391,8 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 				goto forward;
 		}
 
+		BR_INPUT_SKB_CB(skb)->promisc = false;
+
 		/* The else clause should be hit when nf_hook():
 		 *   - returns < 0 (drop/error)
 		 *   - returns = 0 (stolen/nf_queue)
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 35e10c5a766d..22e35623c148 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -600,11 +600,17 @@ static unsigned int br_nf_local_in(void *priv,
 				   struct sk_buff *skb,
 				   const struct nf_hook_state *state)
 {
+	bool promisc = BR_INPUT_SKB_CB(skb)->promisc;
 	struct nf_conntrack *nfct = skb_nfct(skb);
 	const struct nf_ct_hook *ct_hook;
 	struct nf_conn *ct;
 	int ret;
 
+	if (promisc) {
+		nf_reset_ct(skb);
+		return NF_ACCEPT;
+	}
+
 	if (!nfct || skb->pkt_type == PACKET_HOST)
 		return NF_ACCEPT;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 86ea5e6689b5..d4bedc87b1d8 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -589,6 +589,7 @@ struct br_input_skb_cb {
 #endif
 	u8 proxyarp_replied:1;
 	u8 src_port_isolated:1;
+	u8 promisc:1;
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 	u8 vlan_filtered:1;
 #endif
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6f877e31709b..c3c51b9a6826 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -294,18 +294,24 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
 				    const struct nf_hook_state *state)
 {
-	enum ip_conntrack_info ctinfo;
+	bool promisc = BR_INPUT_SKB_CB(skb)->promisc;
+	struct nf_conntrack *nfct = skb_nfct(skb);
 	struct nf_conn *ct;
 
-	if (skb->pkt_type == PACKET_HOST)
+	if (promisc) {
+		nf_reset_ct(skb);
+		return NF_ACCEPT;
+	}
+
+	if (!nfct || skb->pkt_type == PACKET_HOST)
 		return NF_ACCEPT;
 
 	/* nf_conntrack_confirm() cannot handle concurrent clones,
 	 * this happens for broad/multicast frames with e.g. macvlan on top
 	 * of the bridge device.
 	 */
-	ct = nf_ct_get(skb, &ctinfo);
-	if (!ct || nf_ct_is_confirmed(ct) || nf_ct_is_template(ct))
+	ct = container_of(nfct, struct nf_conn, ct_general);
+	if (nf_ct_is_confirmed(ct) || nf_ct_is_template(ct))
 		return NF_ACCEPT;
 
 	/* let inet prerouting call conntrack again */
-- 
2.30.2


