Return-Path: <netfilter-devel+bounces-13670-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mXbbEyugS2r2XAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13670-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 14:31:39 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D557108A8
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 14:31:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13670-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13670-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57E71301B81D
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jul 2026 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399643F8235;
	Mon,  6 Jul 2026 12:31:15 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F763EE1C0
	for <netfilter-devel@vger.kernel.org>; Mon,  6 Jul 2026 12:31:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341075; cv=none; b=eSgz3fEtncAxKeOQhCYy7+IEV/Q8emQOaOzSX2rNPG+MIRjAt4KPz+9ABxXKx0B2WO063ui0w9+hVNH5Q3khXCcIyEfbTNjk53Ip6LIsQ30hyryqgbRw5ISXgmo+sSODfBlMMKn9hIyCZH4xiqO1NG5t/P6hvR99m3YwAeIIOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341075; c=relaxed/simple;
	bh=vDYIrJTrkXgofS+9+kSf6a7zutrm/8RhrspSig5+HPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLuUyAw6GYqh5R7urVszeD/26tT05WowzI5/9h6kLnBS82yeIjZ0+iVo8vy1v0dB0oKG84nr+KiYM1MtVF9YlEmw6dIbGi/nHuOhbuSiVcm1/OfgZTHDRcjzr79OxRHDI2FTH6Xtu45f2ea6BKMI9P3NmyUeD1YTX+1FK5seRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4D3B46064E; Mon, 06 Jul 2026 14:31:11 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: nf_nat_sip: rewind offset when NAT shrinks the packet
Date: Mon,  6 Jul 2026 14:30:55 +0200
Message-ID: <20260706123058.13242-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13670-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,strlen.de:from_mime,strlen.de:email,strlen.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0D557108A8

sashiko says:
 If map_addr() changes the packet length, such as when the public NAT IP
 string is shorter or longer than the internal IP, coff will still point to
 the offset relative to the pre-mangled packet.
 If the packet shrinks, coff could overshoot the correct position,
 potentially causing the next ct_sip_parse_header_uri() call to silently
 skip bytes and miss subsequent Contact headers. Could this lead to a
 failure to NAT those subsequent headers and leak internal network details?

Fixes: c978cd3a9371 ("[NETFILTER]: nf_nat_sip: translate all Contact headers")
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 No bug reports for this, not clear how many uses are left.
 Not urgent, defer to -next.

diff --git a/net/netfilter/nf_nat_sip.c b/net/netfilter/nf_nat_sip.c
index aea02f6aff09..762d7e7bb7c7 100644
--- a/net/netfilter/nf_nat_sip.c
+++ b/net/netfilter/nf_nat_sip.c
@@ -273,12 +273,17 @@ static unsigned int nf_nat_sip(struct sk_buff *skb, unsigned int protoff,
 				       SIP_HDR_CONTACT, &in_header,
 				       &matchoff, &matchlen,
 				       &addr, &port) > 0) {
+		int old_len = skb->len, delta;
+
 		if (!map_addr(skb, protoff, dataoff, dptr, datalen,
 			      matchoff, matchlen,
 			      &addr, port)) {
 			nf_ct_helper_log(skb, ct, "cannot mangle contact");
 			return NF_DROP;
 		}
+
+		delta = (int)skb->len - old_len;
+		coff += delta;
 	}
 
 	if (!map_sip_addr(skb, protoff, dataoff, dptr, datalen, SIP_HDR_FROM) ||
-- 
2.54.0


