Return-Path: <netfilter-devel+bounces-13315-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yG10KImPM2qCDQYAu9opvQ
	(envelope-from <netfilter-devel+bounces-13315-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 08:26:17 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE9069DD6A
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 08:26:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13315-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13315-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB68A3002FAB
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 06:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EEA331A48;
	Thu, 18 Jun 2026 06:26:15 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411532C316
	for <netfilter-devel@vger.kernel.org>; Thu, 18 Jun 2026 06:26:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763975; cv=none; b=QNYXieNqI1WUuRhcmpEJhOnBb4NKYjO6Q5K5JxuQ77iJkXw6E+H2ejLN90Wr7CxpV7EOwRjQeHQNUWrPEC/wq+dYIVi1zMLd9blcrOsLDFsAuSTSwSYKjOl3eol1ZdYGsk2c4ZHlmHkPdFivKyWvutJYbQpuUaKwM36Fd9QSAi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763975; c=relaxed/simple;
	bh=oqoZQgSnpNni9jDGwGS3YkdEPt2ppDRNGfhiPV/pCrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JRVv9+TCFo5OrB1E42uulCeZMEA0M1ZZBIro1I1I6+9tCkygFaQFEze0+SbHpyMbJETY1IrhRwt+BSUziqsq3sEVlekRXAen7xQcUTpNFEB6hDG2b21RlE71a2zvBCcv7j2cy+4+txNkjORpaDYlfS2Lv/WAswVBg82O85wUeNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D4D1E602B9; Thu, 18 Jun 2026 08:26:11 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH nf] netfilter: nft_flow_offload: zero device address for non-ether case
Date: Thu, 18 Jun 2026 08:25:47 +0200
Message-ID: <20260618062552.30006-1-fw@strlen.de>
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
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13315-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,m:nbd@nbd.name,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:email,strlen.de:mid,strlen.de:from_mime,vger.kernel.org:from_smtp,nbd.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CE9069DD6A

LLM points out that the skip causes unitialised stack array to
propagate down into dev_fill_forward_path().  Its not clear to me that
there is a guarantee that a later ctx.dev->netdev_ops->ndo_fill_forward_path()
would always fix this up.

Cc: Felix Fietkau <nbd@nbd.name>
Fixes: 45ca3e61999e ("netfilter: nft_flow_offload: skip dst neigh lookup for ppp devices")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Please consider this a bug report, its possible this patch is junk.
 net/netfilter/nf_flow_table_path.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 9e88ea6a2eef..c0b07dde0434 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -53,8 +53,10 @@ static int nft_dev_fill_forward_path(const struct nf_flow_route *route,
 	struct neighbour *n;
 	u8 nud_state;
 
-	if (!nft_is_valid_ether_device(dev))
+	if (!nft_is_valid_ether_device(dev)) {
+		eth_zero_addr(ha);
 		goto out;
+	}
 
 	n = dst_neigh_lookup(dst_cache, daddr);
 	if (!n)
-- 
2.53.0


