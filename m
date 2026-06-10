Return-Path: <netfilter-devel+bounces-13200-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HHxKFWmTKWq7ZwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13200-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 18:40:09 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF466B937
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 18:40:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=gBYa9uHj;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13200-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13200-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A7233C6BE2
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4367A3093DD;
	Wed, 10 Jun 2026 16:16:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8F2D877A;
	Wed, 10 Jun 2026 16:16:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108199; cv=none; b=uGBBC1vMzxpAXD8dN6e+6jLQXr1mxkEUrwB0mQ9Spmz6sRGeqbik1DnkLipNHwIC1ZBe40qSfE9uciORSiMrw/72GL5Ptqf49rJPRlgI9BJxCfc1IxwJK3G47z72Q65o0hrYSDKYbs9bmk4slKrr7MK+jJeOxjz6nwQHldfkx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108199; c=relaxed/simple;
	bh=zQ/gtcRUgNTLMbxojjmxcZlJvAss/i6Tv65StmTyrBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyTvfMjzsUZZfC3Yz0wieK0+N3hYzG+6WXgg1hWbuyI7HaV0MejJUhgYnaniBdHcWBinA+qI/til6kyB/9PM0TWnHkWhhrPDYZTtUWtIokPvTuM1pAMg2SFOvvfYgOHaim+4zdcKYOjWLQ/ZzPDTStuk85PWWVgQsJ936oCDO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=gBYa9uHj; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id B7B4E601BD;
	Wed, 10 Jun 2026 18:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781108196;
	bh=Y56sZ6oRlT62ETdu0hwz7Ce/xM3Ief31yEXajHM2cP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gBYa9uHjCLIAL90coUtU/1W+U4y/lLbA/bF3JP/pLIUiNAjlhl2VUhFiNyl5y5VsU
	 vCniWiaOBcuZo6JNJ00nBDkD/q3bfYEyqkbgsX2QXoTeRw9yDPxiUBHihloptnDG65
	 j4/WSFQ+Yp8AGWFfJKUVMHH3K/uijysL8FXCotzJ77o6Y2g+eArDCd9hP7JyPSq69K
	 uZprNmikBIcoBFnZQDLVzwEXvFLby5XZwIlSBSdANZj6+tvdm1XuWJrnfyMXk0TEKY
	 I6XppgxOAo/sL2D9NW4K32cPN+JJAL8O0kbDpAQGYhhYV6V6xYmBFgsnFc1A+lnKam
	 OY20Gg9gccQBQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 2/8] netfilter: nf_tables_offload: drop device refcount on error
Date: Wed, 10 Jun 2026 18:16:22 +0200
Message-ID: <20260610161629.214092-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610161629.214092-1-pablo@netfilter.org>
References: <20260610161629.214092-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13200-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:email,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCEF466B937

From: Florian Westphal <fw@strlen.de>

Reported by sashiko:
If nft_flow_action_entry_next() returns NULL, dev reference leaks.

Fixes: c6f85577584b ("netfilter: nf_tables_offload: add nft_flow_action_entry_next() and use it")
Reported-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
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
2.47.3


