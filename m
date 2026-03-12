Return-Path: <netfilter-devel+bounces-11161-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC2nIL0As2mQRQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11161-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 19:06:53 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC976276FE3
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 19:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92AEB3046692
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 18:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826BF3FD15E;
	Thu, 12 Mar 2026 18:06:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3983FEB0A
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Mar 2026 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338776; cv=none; b=BhWABo0D/frRvRp85lIk82uk0Tgy7n3IzN6nyYd5Smp8GlXi/xFmOtJnx9v7ga0ASJUyaTKWez9/uZJUP467pMk9wiM1Jk10iV8f0Fcp0pHkgV6lpL6PWZgELDeu/YHfe7NVYg5WGBjbp55L2TTLB/vdClXxthrWpYK00vuTo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338776; c=relaxed/simple;
	bh=144+/10HwDzpLDdc3al4OBoPW6+3EsmqUNy9WobhsnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9Yel/R15PSPLO1c7NfMMVdToS3J50rsxl97reRRDrVBtuBrEZyhgmrH0jlMFiB9oe0a6GhE8SvlpRJZExHvYi9BbVaD6+soUYeIGIbtV2B4jU31P6L7c3g+mwFJKvhQpj+ca6wEmn+lCqpinR+9YfKD1An3bFVel+4QEXVq0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EE26660345; Thu, 12 Mar 2026 19:06:11 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: add deprecation warning for dccp support
Date: Thu, 12 Mar 2026 19:05:57 +0100
Message-ID: <20260312180606.5751-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11161-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC976276FE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a deprecation warning for the xt_dccp match and the
nft exthdr code.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_exthdr.c | 4 ++++
 net/netfilter/xt_dccp.c    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 5f01269a49bd..1602e4266f34 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -796,6 +796,10 @@ nft_exthdr_select_ops(const struct nft_ctx *ctx,
 		break;
 #ifdef CONFIG_NFT_EXTHDR_DCCP
 	case NFT_EXTHDR_OP_DCCP:
+		pr_warn_once("The dccp option matching is deprecated and scheduled to be removed in 2027, "
+			     "please contact the netfilter-devel mailing list or update your "
+			     "nftables rules\n");
+
 		if (tb[NFTA_EXTHDR_DREG])
 			return &nft_exthdr_dccp_ops;
 		break;
diff --git a/net/netfilter/xt_dccp.c b/net/netfilter/xt_dccp.c
index e5a13ecbe67a..9b8720c57d8d 100644
--- a/net/netfilter/xt_dccp.c
+++ b/net/netfilter/xt_dccp.c
@@ -159,6 +159,10 @@ static int __init dccp_mt_init(void)
 {
 	int ret;
 
+	pr_warn_once("The DCCP match is deprecated and scheduled to be removed in 2027, "
+		     "please contact the netfilter-devel mailing list or update your "
+		     "iptables rules\n");
+
 	/* doff is 8 bits, so the maximum option size is (4*256).  Don't put
 	 * this in BSS since DaveM is worried about locked TLB's for kernel
 	 * BSS. */
-- 
2.52.0


