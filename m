Return-Path: <netfilter-devel+bounces-13157-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s6P3H7UnKGrc/AIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13157-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 16:48:21 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60F766152F
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 16:48:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13157-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13157-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60EE23115BAB
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E7340405;
	Tue,  9 Jun 2026 14:28:55 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139822E040E;
	Tue,  9 Jun 2026 14:28:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015335; cv=none; b=bUsRPV03rqRcKcX7E1xKS3WfishVqVmPvvHeWBNp7J5TowfNL7wPH4icoPArjv/M3BBf+j9W3ayrn8tntuL91s8/XdUHEXw5CtcMZ4pn59fB94hGx1FxQM70uMo4eCfvquau5ikHq6ly+n82NsKeVDoBJNsPolMUySrqcSYjy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015335; c=relaxed/simple;
	bh=eNbb17mTmXYnjebF51hz5UKrnfCmGfpbSUvg72eGB4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T82M7DTIJ5OAeF0sENUu5PlQI5Gw8frm5atrb2P7HICkKi9oVeDmrlbMMZRWnjd6whZu8D7seUFHExjrxaMze+LM2yM/Kk/QGejWrp9HSDOjk/onChJMFlwCKUoqLNU6a/FPdZDJ7/lCsFGRoFapXygZpYOfP9CDzmTgWQztkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 369AA609B9; Tue, 09 Jun 2026 16:28:46 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: <netfilter-devel@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next] net: dummy: add phony ndo_setup_tc stub
Date: Tue,  9 Jun 2026 16:28:09 +0200
Message-ID: <20260609142813.9197-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13157-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:email,strlen.de:mid,strlen.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C60F766152F

Allow to use dummy driver to test offload control plane code.

Unlike netdevsim, dummy is a data sink so no capabilities (e.g.
u32-style matcher, vport device redirects, PPPoE header push/pop etc).
have to be implemented.

Tag the offload callback to permit error injection to test rollback/abort
code in nf_tables.

At this time, nf_tables has an upfront check for offload capabilities to
avoid exposure of offload code paths on machines that lack capable
hardware.  With this patch, dummy can always "offload" which exposes this
functionality.  Given real hardware will normally live in the initial
namespace, restrict the offload to initial user ns instead.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 drivers/net/dummy.c               | 10 ++++++++++
 net/netfilter/nf_tables_offload.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index f6732eab5923..b31ad10eb958 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -85,6 +85,15 @@ static int dummy_change_carrier(struct net_device *dev, bool new_carrier)
 	return 0;
 }
 
+static int dummy_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
+{
+	if (dev_net(dev)->user_ns != &init_user_ns)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+ALLOW_ERROR_INJECTION(dummy_setup_tc, ERRNO);
+
 static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_init		= dummy_dev_init,
 	.ndo_start_xmit		= dummy_xmit,
@@ -93,6 +102,7 @@ static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= dummy_get_stats64,
 	.ndo_change_carrier	= dummy_change_carrier,
+	.ndo_setup_tc		= dummy_setup_tc,
 };
 
 static const struct ethtool_ops dummy_ethtool_ops = {
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 9101b1703b52..26e7ed5a8575 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -234,6 +234,9 @@ bool nft_chain_offload_support(const struct nft_base_chain *basechain)
 				return false;
 
 			dev = ops->dev;
+			if (dev_net(dev)->user_ns != &init_user_ns)
+				return false;
+
 			if (!dev->netdev_ops->ndo_setup_tc &&
 			    !flow_indr_dev_exists())
 				return false;
-- 
2.53.0


