Return-Path: <netfilter-devel+bounces-13066-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o6aOKiC5Imr2cgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13066-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 13:55:12 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 359DD647E06
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 13:55:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13066-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13066-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1DFA301BF77
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jun 2026 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24D74D8DAE;
	Fri,  5 Jun 2026 11:47:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED604D98E9
	for <netfilter-devel@vger.kernel.org>; Fri,  5 Jun 2026 11:47:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660045; cv=none; b=LkxQU+IjXSeoa87+cTizfvmCqk+9reyNP1d8Sewu0pexRe7f6NN2HJqg7QcTmv8hNpxoOyriXVo88S263wD/3zfRRMOtm2JdhLJ2Yb7v9wJ+zyxxMQIhY6BPUDeQNmxzn0BdbwNVg7KPc9Vw4jb7to/3Md2Ho1bvQQ4F/WpQeMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660045; c=relaxed/simple;
	bh=nxadXzNo3BTpPHVPs90Z9t5gyVVwnMTxf4Eoo5S+rl0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bNTGXz+kBcdR5OZHA9mdVXBYONYm8INb195exb16h0Ib8n7/77lDOw2n+nM60i/ZPRohgjJsxBeD0jAKtw08phMDR2jSW5o/8c+LWITMqAyxCwQkbp+iTe62wjanG+8j8SIK4RsnDxkgckbyIr61wWqpvv/oJil162ugFzHtTCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id ADD6060425; Fri, 05 Jun 2026 13:47:21 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Subject: [PATCH 1/1] netfilter: nf_tables_offload: drop device refcount on error
Date: Fri,  5 Jun 2026 13:47:12 +0200
Message-ID: <20260605114715.11297-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13066-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,strlen.de:from_mime,strlen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 359DD647E06

Reported by sashiko:
If nft_flow_action_entry_next() returns NULL, dev reference leaks.

Fixes: c6f85577584b ("netfilter: nf_tables_offload: add nft_flow_action_entry_next() and use it")
Reported-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_dup_netdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_dup_netdev.c b/net/netfilter/nf_dup_netdev.c
index 3b0a70e154cd..3d88ef927f31 100644
--- a/net/netfilter/nf_dup_netdev.c
+++ b/net/netfilter/nf_dup_netdev.c
@@ -74,16 +74,18 @@ int nft_fwd_dup_netdev_offload(struct nft_offload_ctx *ctx,
 	struct flow_action_entry *entry;
 	struct net_device *dev;
 
-	/* nft_flow_rule_destroy() releases the reference on this device. */
 	dev = dev_get_by_index(ctx->net, oif);
 	if (!dev)
 		return -EOPNOTSUPP;
 
 	entry = nft_flow_action_entry_next(ctx, flow);
-	if (!entry)
+	if (!entry) {
+		dev_put(dev);
 		return -E2BIG;
+	}
 
 	entry->id = id;
+	/* nft_flow_rule_destroy() releases the reference on this device. */
 	entry->dev = dev;
 
 	return 0;
-- 
2.53.0


