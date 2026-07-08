Return-Path: <netfilter-devel+bounces-13713-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hwK2DysaTmokDQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13713-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 11:36:43 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A906723CC0
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 11:36:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=iyfdjtY0;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13713-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13713-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478E930103B4
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 09:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F63419302;
	Wed,  8 Jul 2026 09:33:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D03FCB1E
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Jul 2026 09:33:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503188; cv=none; b=lFZJH0dOl4OLBDfPTTkMdO+KS6f5q5ByzeVYmOIzzOHZEYmZznii+4BovUU7YgE3dN5eCc0hUF7MW7ZIWQHQ2huBW26c/1cwCDg4WSbO6C1TZjVxy3vaZbPzDOvan4FRKQ2LMCnCjCFZfFTVX0Jcfw08NtMzNKtAlW8BXggUvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503188; c=relaxed/simple;
	bh=LimfHNhKbzGj41cNpuGnOzVAlvSDxXYFowW8stUMmGo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EJ+Mfe2KA6/QJMmmH+AHnJ+I4e8wh00sfoXzd5bnJFOqgOF67ygG84cF/qGwcSJb0IBSpGgKssdh5WIB0h9Seo2/wN6Iw9ol4rbWq8DalmqspvxmLMJZ+WAR5DjQ7ThhbmcHXO6E1yAktBn3m9PDIdHToCrnaU+XwTo08yA4OFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=iyfdjtY0; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 40AAE6057C
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Jul 2026 11:32:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783503176;
	bh=0mdV7mm6RiiR4cIHSloM9vWmiJg/yyyRgEBQ1G1DsRY=;
	h=From:To:Subject:Date:From;
	b=iyfdjtY0DPmr0uxo7dj/ypPhmNGPtrENT9uLjyrdlphuUbAtfwBaD67cH3A3gAah7
	 xoXWj5PXpYR/gyqcoQkQPTvBhOVKI2WfVKxo74Q5A3fKevoA+ySRF04DpLVFSgTFmm
	 1d1jkesbhAbtYGGeewUyWvONYTMJN+Eyiky5cUCawGnxaRWwYu3ja3WtPXEufsS3tC
	 3TO2K7pVIl24gNa+hChB//wEjF6XMfDvGeFMpa7iRjCTyeL6bD/fhCqhN7qqHCQkle
	 oBnID2qIlLPNZEHVITxCWED7VIYHFEdmj5dYonBKfsazmKsDKbUKNdmnAhPwAfbBtY
	 N+TjI7d7tmkQg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v1 1/4] bridge: Add filling forward path from port to port
Date: Wed,  8 Jul 2026 11:32:47 +0200
Message-ID: <20260708093250.1187068-1-pablo@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13713-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,blackwall.org:email,netfilter.org:from_mime,netfilter.org:email,netfilter.org:mid,netfilter.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A906723CC0

From: Eric Woudstra <ericwouds@gmail.com>

If a port is passed as argument instead of the master, then:

At br_fill_forward_path(): find the master and use it to fill the
forward path.

At br_vlan_fill_forward_path_pvid(): lookup vlan group from port
instead.

Changed call to br_vlan_group() into br_vlan_group_rcu() while at it.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v1: I took this existing patch for the bridge vlan filtering, but
    bridge vlan filtering is untested at this stage at least for me.

 net/bridge/br_device.c  | 19 ++++++++++++++-----
 net/bridge/br_private.h |  2 ++
 net/bridge/br_vlan.c    |  6 +++++-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index e7f343ab22d3..89f4525a7279 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -385,16 +385,25 @@ static int br_del_slave(struct net_device *dev, struct net_device *slave_dev)
 static int br_fill_forward_path(struct net_device_path_ctx *ctx,
 				struct net_device_path *path)
 {
+	struct net_bridge_port *src, *dst;
 	struct net_bridge_fdb_entry *f;
-	struct net_bridge_port *dst;
 	struct net_bridge *br;
 
-	if (netif_is_bridge_port(ctx->dev))
-		return -1;
+	if (netif_is_bridge_port(ctx->dev)) {
+		struct net_device *br_dev;
+
+		br_dev = netdev_master_upper_dev_get_rcu((struct net_device *)ctx->dev);
+		if (!br_dev)
+			return -1;
 
-	br = netdev_priv(ctx->dev);
+		src = br_port_get_rcu(ctx->dev);
+		br = netdev_priv(br_dev);
+	} else {
+		src = NULL;
+		br = netdev_priv(ctx->dev);
+	}
 
-	br_vlan_fill_forward_path_pvid(br, ctx, path);
+	br_vlan_fill_forward_path_pvid(br, src, ctx, path);
 
 	f = br_fdb_find_rcu(br, ctx->daddr, path->bridge.vlan_id);
 	if (!f)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d55ea9516e3e..00f5b72ff42d 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1630,6 +1630,7 @@ bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
 			     const struct net_bridge_vlan *range_end);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path);
 int br_vlan_fill_forward_path_mode(struct net_bridge *br,
@@ -1799,6 +1800,7 @@ static inline int nbp_get_num_vlan_infos(struct net_bridge_port *p,
 }
 
 static inline void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+						  struct net_bridge_port *p,
 						  struct net_device_path_ctx *ctx,
 						  struct net_device_path *path)
 {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 5560afcaaca3..71531499bc73 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1450,6 +1450,7 @@ int br_vlan_get_pvid_rcu(const struct net_device *dev, u16 *p_pvid)
 EXPORT_SYMBOL_GPL(br_vlan_get_pvid_rcu);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path)
 {
@@ -1462,7 +1463,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
 		return;
 
-	vg = br_vlan_group_rcu(br);
+	if (p)
+		vg = nbp_vlan_group_rcu(p);
+	else
+		vg = br_vlan_group_rcu(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
-- 
2.47.3


