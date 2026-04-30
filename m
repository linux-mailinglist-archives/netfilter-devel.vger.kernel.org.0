Return-Path: <netfilter-devel+bounces-12339-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHPyCGZ582mt4AEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12339-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 17:46:46 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 776AA4A5136
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 17:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CB363087135
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA33A2575;
	Thu, 30 Apr 2026 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="WsHQu/hF"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5D5376492
	for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2026 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563760; cv=none; b=VNfOPlnPcpt7W+PgqsqI4Z8szJjskLl4cWWYzvvIC3YZZVc98IskYA19AzOh6ZSCDsUQSNUjZeuHyA6il5dAnz97iyW6o8qMmk0KnUiVDT3kt/jrc9kPTY5DtM3+bPzoGzmy0AmG5/eaqBi6DVonAy7ZYCyfQuMx043Qtp/BsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563760; c=relaxed/simple;
	bh=fhC5YgvOQrru0Gn9OMkr4N4o05zWAOaafGPf0yiLYIY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aCmjC+XUkVIy9yRIjxHHOi/BXw8+y8SPcxrXQCdnBomgfqith1dbhGxVsLvEp/mjjAN0tc2wWCIs43fIsOnfInLm9B1krVObAlvFC+YN9q7vNoZUAkQ/o/Fr8tMnCs6IeRaSSIFhojWd7J5k27574ONFoU3d4uTgvAGrY/64blY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=WsHQu/hF; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id EE7056024E
	for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2026 17:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777563756;
	bh=B120GNARbXsfG0kr8qScIJm0en0cRwclFP6IhtwAsxk=;
	h=From:To:Subject:Date:From;
	b=WsHQu/hF0ImoWWCR0I4gu2YfdZMP6tBIDCS/1QeMyAmyvGTF8Y38FZy76VyeSKKjx
	 ZXO3nHNSat37iEaK38lGp1Rqa806eCgWE+UrFOqq/iWTPkfQBr7MBVodUTfd/87bz5
	 BgOTvTguY85B+gZN6CzEL33miFSennODLGwoccEzzXxFX09tnPCqm8JKpGLPg+whHw
	 DkkpF4dad3sSVDhgfM9RaFhjtsYvN9exOO/2meyoPiSoCGAUWUctBSYL+zVdyI0ciU
	 D4NYDp8p0GB3eswxL4hDAXuhItBS7MIVtoqIuvu3g9dBT3+ze8m+DeyTWhxHYuNj6p
	 SqNP8GflMzc4Q==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v6 1/3] netfilter: flowtable: ensure sufficient headroom in xmit path
Date: Thu, 30 Apr 2026 17:42:15 +0200
Message-ID: <20260430154217.260522-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 776AA4A5136
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-12339-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.990];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Check for headroom and call skb_expand_head() like in the IP output
path to ensure there is sufficient headroom for the mac header when
forwarding this packet as suggested by sashiko.

Fixes: b5964aac51e0 ("netfilter: flowtable: consolidate xmit path")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v6: new in this series, suggested by sashiko.

 net/netfilter/nf_flow_table_ip.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index dbd7644fdbeb..8d5fb7e940a1 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -471,8 +471,17 @@ struct nf_flow_xmit {
 static unsigned int nf_flow_queue_xmit(struct net *net, struct sk_buff *skb,
 				       struct nf_flow_xmit *xmit)
 {
-	skb->dev = xmit->outdev;
-	dev_hard_header(skb, skb->dev, ntohs(skb->protocol),
+	struct net_device *dev = xmit->outdev;
+	unsigned int hh_len = LL_RESERVED_SPACE(dev);
+
+	if (unlikely(skb_headroom(skb) < hh_len && dev->header_ops)) {
+		skb = skb_expand_head(skb, hh_len);
+		if (!skb)
+			return NF_STOLEN;
+	}
+
+	skb->dev = dev;
+	dev_hard_header(skb, dev, ntohs(skb->protocol),
 			xmit->dest, xmit->source, skb->len);
 	dev_queue_xmit(skb);
 
-- 
2.47.3


