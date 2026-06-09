Return-Path: <netfilter-devel+bounces-13168-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yiPmKXiGKGoTFwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13168-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 23:32:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4463D664445
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 23:32:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=GA3kovpd;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13168-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13168-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 749DC301BEC1
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 21:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9D83EB0FC;
	Tue,  9 Jun 2026 21:32:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C003E3C49
	for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2026 21:32:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040741; cv=none; b=L6wg+x3+DSl3S/O6x4yggFORRlRa2OZTqbvSSYCh/dp0n0X8S18xI5crGObnamuZW1tBakDTjcS33Ii070/qA+vYKbKAhaCYp1zkFJ2O9xtSNS/0nP2AkWS7kxqtB8bHM6XH32mYbcYJkHN/b9QWDKdR7q4xxt28ZwQ9V428iuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040741; c=relaxed/simple;
	bh=rrMPvERWsQt9DqAlphxx9vr6COoiGeg4f15qqFAwUWY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=V58lZuttvUtX17eUUlVSltkxxIYwiTglxtaxjiGq2pee2av0++YtbhxjpiK3w0NRpztfpk1egrm9mFSXaFeRuyD/8lnYghPlstGtoz+58kSqxePs1vSimesnwZ32YI8bDzfAD+3XOeKfgYs6SMJ7+DyPXgBcMCJufOqU+gyjhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=GA3kovpd; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 39CBA6017F
	for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2026 23:32:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781040738;
	bh=7ps66Ud0DbkJ7Whn+YCIQvJGveY7zHejA2w+i+LfWY0=;
	h=From:To:Subject:Date:From;
	b=GA3kovpdsDT+F1lwbebLu0ex6Q8ZU7GQTMVhupvs0w2g+Pf12Nftud5UbgrFrQzaJ
	 dHoTBoupPbGkHz0RcSPOrsyaZnW0kKOminCtaHCYeEw1eyImoYgpiTuTOKPn4Fk0GH
	 LKWu0b9wjfiQIjEdkXdiFtT5FHMuliAEWk6z27d2abQf+aW9Umbjv51Ghvnqq4JuCF
	 Ic3KN7khnoZY0n2PtPA1mn2H0d4a6DWQtI4PYT0Jw1J9NJGnXHNaLiBMF/Sc0rbFa2
	 0ILQfVLBtmEXhZVof7FhRk/jMGhJ2Btw99aJv0kYW0GCmuLtcjZfSxnavcnFxT1g8X
	 CUvmav7Jwd9qw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next] netfilter: flowtable: bail out if forward path cannot be discovered
Date: Tue,  9 Jun 2026 23:32:14 +0200
Message-ID: <20260609213214.108632-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13168-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4463D664445

If forward path discovery fails for any reason or netdevice is not
registered for this flowtable, then bail out to classic forwarding path
rather than providing incomplete forwarding path.

Update the existing forward path parser functions to report an error
so the flow_offload expressions gives up on setting up the flowtable
entry.

Link: https://sashiko.dev/#/patchset/20260607094954.48892-15-pablo%40netfilter.org?part=14
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_path.c | 88 +++++++++++++++++-------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index a3e6b82f2f8e..c898e3e2c52a 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -90,9 +90,9 @@ struct nft_forward_info {
 	enum flow_offload_xmit_type xmit_type;
 };
 
-static void nft_dev_path_info(const struct net_device_path_stack *stack,
-			      struct nft_forward_info *info,
-			      unsigned char *ha, struct nf_flowtable *flowtable)
+static int nft_dev_path_info(const struct net_device_path_stack *stack,
+			     struct nft_forward_info *info,
+			     unsigned char *ha, struct nf_flowtable *flowtable)
 {
 	const struct net_device_path *path;
 	int i;
@@ -120,19 +120,17 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 
 			/* DEV_PATH_VLAN, DEV_PATH_PPPOE and DEV_PATH_TUN */
 			if (path->type == DEV_PATH_TUN) {
-				if (info->num_tuns) {
-					info->indev = NULL;
-					break;
-				}
+				if (info->num_tuns)
+					return -1;
+
 				info->tun.src_v6 = path->tun.src_v6;
 				info->tun.dst_v6 = path->tun.dst_v6;
 				info->tun.l3_proto = path->tun.l3_proto;
 				info->num_tuns++;
 			} else {
-				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
-					info->indev = NULL;
-					break;
-				}
+				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX)
+					return -1;
+
 				info->encap[info->num_encaps].id =
 					path->encap.id;
 				info->encap[info->num_encaps].proto =
@@ -151,22 +149,23 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 
 			switch (path->bridge.vlan_mode) {
 			case DEV_PATH_BR_VLAN_UNTAG_HW:
+				if (info->num_encaps == 0)
+					return -1;
+
 				info->ingress_vlans |= BIT(info->num_encaps - 1);
 				break;
 			case DEV_PATH_BR_VLAN_TAG:
-				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
-					info->indev = NULL;
-					break;
-				}
+				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX)
+					return -1;
+
 				info->encap[info->num_encaps].id = path->bridge.vlan_id;
 				info->encap[info->num_encaps].proto = path->bridge.vlan_proto;
 				info->num_encaps++;
 				break;
 			case DEV_PATH_BR_VLAN_UNTAG:
-				if (info->num_encaps == 0) {
-					info->indev = NULL;
-					break;
-				}
+				if (info->num_encaps == 0)
+					return -1;
+
 				info->num_encaps--;
 				break;
 			case DEV_PATH_BR_VLAN_KEEP:
@@ -175,8 +174,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
 			break;
 		default:
-			info->indev = NULL;
-			break;
+			return -1;
 		}
 	}
 	info->outdev = info->indev;
@@ -184,6 +182,8 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 	if (nf_flowtable_hw_offload(flowtable) &&
 	    nft_is_valid_ether_device(info->indev))
 		info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
+
+	return 0;
 }
 
 static bool nft_flowtable_find_dev(const struct net_device *dev,
@@ -241,11 +241,11 @@ static int nft_flow_tunnel_update_route(const struct nft_pktinfo *pkt,
 	return 0;
 }
 
-static void nft_dev_forward_path(const struct nft_pktinfo *pkt,
-				 struct nf_flow_route *route,
-				 const struct nf_conn *ct,
-				 enum ip_conntrack_dir dir,
-				 struct nft_flowtable *ft)
+static int nft_dev_forward_path(const struct nft_pktinfo *pkt,
+				struct nf_flow_route *route,
+				const struct nf_conn *ct,
+				enum ip_conntrack_dir dir,
+				struct nft_flowtable *ft)
 {
 	const struct dst_entry *dst = route->tuple[dir].dst;
 	struct net_device_path_stack stack;
@@ -253,15 +253,16 @@ static void nft_dev_forward_path(const struct nft_pktinfo *pkt,
 	unsigned char ha[ETH_ALEN];
 	int i;
 
-	if (nft_dev_fill_forward_path(route, dst, ct, dir, ha, &stack) >= 0)
-		nft_dev_path_info(&stack, &info, ha, &ft->data);
+	if (nft_dev_fill_forward_path(route, dst, ct, dir, ha, &stack) < 0 ||
+	    nft_dev_path_info(&stack, &info, ha, &ft->data) < 0)
+		return -ENOENT;
+
+	if (!nft_flowtable_find_dev(info.indev, ft))
+		return -ENOENT;
 
 	if (info.outdev)
 		route->tuple[dir].out.ifindex = info.outdev->ifindex;
 
-	if (!info.indev || !nft_flowtable_find_dev(info.indev, ft))
-		return;
-
 	route->tuple[!dir].in.ifindex = info.indev->ifindex;
 	for (i = 0; i < info.num_encaps; i++) {
 		route->tuple[!dir].in.encap[i].id = info.encap[i].id;
@@ -285,6 +286,8 @@ static void nft_dev_forward_path(const struct nft_pktinfo *pkt,
 		route->tuple[dir].xmit_type = info.xmit_type;
 	}
 	route->tuple[dir].out.needs_gso_segment = info.needs_gso_segment;
+
+	return 0;
 }
 
 int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
@@ -321,19 +324,26 @@ int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
 		return -ENOENT;
 
 	nf_route(nft_net(pkt), &other_dst, &fl, false, nft_pf(pkt));
-	if (!other_dst) {
-		dst_release(this_dst);
-		return -ENOENT;
-	}
+	if (!other_dst)
+		goto err_this_dst;
 
 	nft_default_forward_path(route, this_dst, dir);
 	nft_default_forward_path(route, other_dst, !dir);
 
-	if (route->tuple[dir].xmit_type	== FLOW_OFFLOAD_XMIT_NEIGH)
-		nft_dev_forward_path(pkt, route, ct, dir, ft);
-	if (route->tuple[!dir].xmit_type == FLOW_OFFLOAD_XMIT_NEIGH)
-		nft_dev_forward_path(pkt, route, ct, !dir, ft);
+	if (route->tuple[dir].xmit_type	== FLOW_OFFLOAD_XMIT_NEIGH &&
+	    nft_dev_forward_path(pkt, route, ct, dir, ft) < 0)
+		goto err_other_dst;
+
+	if (route->tuple[!dir].xmit_type == FLOW_OFFLOAD_XMIT_NEIGH &&
+	    nft_dev_forward_path(pkt, route, ct, !dir, ft) < 0)
+		goto err_other_dst;
 
 	return 0;
+
+err_other_dst:
+	dst_release(other_dst);
+err_this_dst:
+	dst_release(this_dst);
+	return -ENOENT;
 }
 EXPORT_SYMBOL_GPL(nft_flow_route);
-- 
2.47.3


