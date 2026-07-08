Return-Path: <netfilter-devel+bounces-13748-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rFPRHWNgTmpJLgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13748-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 16:36:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92E727749
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 16:36:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13748-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13748-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D820630065CF
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776DD44D696;
	Wed,  8 Jul 2026 14:28:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091F2E7373
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Jul 2026 14:28:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520901; cv=none; b=TdHm5oRCzTmk0zjm4sSXbTvQBy0lFLAoE9/BBVWf6GXAApFY5LXQh8asSO9YGxJsNRVT1415nYNuYIBfRd/Jp6oUtITfyu2OBiKMSCSxy/+q1zZAW+OPDYke5363l3bk8qe4By/S5inTRqMe+grOhoj7aLmsgGJlbfy5jAYyJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520901; c=relaxed/simple;
	bh=KSj+6Z4SQXycioLkKerDbbBuoTCBZUXoc4SHJvE87k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBQ9nPK2fGvWrjnEYAO8BbFy1wFTne8zR1CHYu0JQcVlhVXDDcTY8VFST1hTIzjUA4cWJ0DY+S/SJsNCkfQj0s1RIkzZqFV3uKWwtmj2X5+P8DvscRyGv/TGrI4c9C2SsWJcro5Ji9ix2hNjCu6TQAmPT3IeWr7N4BTxxkDAmWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 113D660F16; Wed, 08 Jul 2026 16:28:18 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: ja@ssi.bg,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] ipvs: reload ip header after head reallocation
Date: Wed,  8 Jul 2026 16:28:07 +0200
Message-ID: <20260708142811.2660-1-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13748-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:ja@ssi.bg,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B92E727749

__ip_vs_get_out_rt() might realloc skb->head due to ttl decrement.

Fixes: 8d8e20e2d7bb ("ipvs: Decrement ttl")
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 LLM assisted find, no real-world bug report behind this.

 net/netfilter/ipvs/ip_vs_xmit.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index ce542ed4b013..9fef4335da13 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -736,13 +736,11 @@ int
 ip_vs_bypass_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 		  struct ip_vs_protocol *pp, struct ip_vs_iphdr *ipvsh)
 {
-	struct iphdr  *iph = ip_hdr(skb);
-
-	if (__ip_vs_get_out_rt(cp->ipvs, cp->af, skb, NULL, iph->daddr,
+	if (__ip_vs_get_out_rt(cp->ipvs, cp->af, skb, NULL, ip_hdr(skb)->daddr,
 			       IP_VS_RT_MODE_NON_LOCAL, NULL, ipvsh) < 0)
 		goto tx_error;
 
-	ip_send_check(iph);
+	ip_send_check(ip_hdr(skb));
 
 	/* Another hack: avoid icmp_send in ip_fragment */
 	skb->ignore_df = 1;
-- 
2.54.0


