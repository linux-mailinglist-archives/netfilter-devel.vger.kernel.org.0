Return-Path: <netfilter-devel+bounces-12892-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP0ZMt6eFmq1ngcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12892-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 09:35:58 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA05E084E
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 09:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C62A3029255
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2026 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2413B4E8C;
	Wed, 27 May 2026 07:35:02 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2C3C9897
	for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2026 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867301; cv=none; b=qLzg87Ukyb7furHSiR50PcCs3WorkHTGG1OUn3Vefi6cW47EGMcxGHXQhcIZpgiQrNPfitOReU1ygGXve0FW+30yK5Y7rn+xMtA8dj9NE7TEmrOAaqIrD9cnH88GApn8GCMt5hbG9TkbSkWhByOQb61Bj0ahEs1pKebzPaessIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867301; c=relaxed/simple;
	bh=hW6j4hN8cGxvVKEEAj6S04YXPzv8OkPA7XEXDYD3g/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF5XUqCNx+DB5gnjhcwaG6OBeTw1aBWKbib/roY4q+JgmRqxHf7s2E7Ox3DXxWWy8V7Hp8C6slB8b6EMSNoZNqSuxjuhL6OwMHwvWGAvHV0EaF37GPggpgWjL0rJ0VEUBlMlUBpgBfJkFDgnC3Y4e3ZtwglzstSBccEmsvXh3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3DA5C60551; Wed, 27 May 2026 09:34:50 +0200 (CEST)
Date: Wed, 27 May 2026 09:34:49 +0200
From: Florian Westphal <fw@strlen.de>
To: Adrian Bente <adibente@gmail.com>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org, phil@nwl.cc,
	nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
	andrew+netdev@lunn.ch, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
	coreteam@netfilter.org, linux-mediatek@lists.infradead.org
Subject: Re: [RFC PATCH net] netfilter: flowtable: fix offloaded ct timeout
 never being extended
Message-ID: <ahaek23tB7D8tQUe@strlen.de>
References: <20260526060138.3924-1-adibente@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526060138.3924-1-adibente@gmail.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12892-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,vger.kernel.org,nwl.cc,nbd.name,mediatek.com,kernel.org,lunn.ch,gmail.com,collabora.com,makrotopia.org,lists.infradead.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.902];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 2BCA05E084E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adrian Bente <adibente@gmail.com> wrote:

[ trimming CCs .. ]

> OpenWrt has recently migrated many platforms to kernel 6.18. On the
> MediaTek platform, which supports hardware network offloading, WiFi
> connections accelerated via the WED path were observed to drop after
> roughly 300 seconds.
> 
> After several debugging sessions, assisted by the Claude LLM, the
> problem was narrowed down as follows:
> 
> nf_flow_table_extend_ct_timeout() extends ct->timeout for offloaded
> flows using:
> 
> 	cmpxchg(&ct->timeout, expires, new_timeout);
> 
> 'expires' comes from nf_ct_expires(ct) and is a relative value, while
> ct->timeout holds an absolute timestamp. The two are never equal, so
> the cmpxchg always fails and the timeout is never extended.
> 
> This goes unnoticed for most flows, but a long-lived hardware (WED)
> offloaded flow on MediaTek MT7986 eventually has ct->timeout decay to
> zero, the conntrack entry is reaped and the connection breaks.
> 
> Compare against the current ct->timeout value instead.
> 
> This patch is sent as RFC: the diagnosis is verified on hardware and
> the fix resolves the drop, but review of the chosen approach is
> welcome.

I guess we need to open-code expires, something like this (not even
compile tested). Also see https://sashiko.dev/#/patchset/20260526060138.3924-1-adibente%40gmail.com

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -506,7 +506,12 @@ static u32 nf_flow_table_tcp_timeout(const struct nf_conn *ct)
 static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 {
 	static const u32 min_timeout = 5 * 60 * HZ;
-	u32 expires = nf_ct_expires(ct);
+	u32 ct_timeout = READ_ONCE(ct->timeout);
+	s32 expires;
+
+	expires = ct_timeout - nfct_time_stamp;
+	if (expires <= 0) /* already expired */
+		return;
 
 	/* normal case: large enough timeout, nothing to do. */
 	if (likely(expires >= min_timeout))
@@ -524,7 +529,7 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 	if (nf_ct_is_confirmed(ct) &&
 	    test_bit(IPS_OFFLOAD_BIT, &ct->status)) {
 		u8 l4proto = nf_ct_protonum(ct);
-		u32 new_timeout = true;
+		u32 new_timeout = 1;
 
 		switch (l4proto) {
 		case IPPROTO_UDP:
@@ -549,7 +554,7 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 		 */
 		if (new_timeout) {
 			new_timeout += nfct_time_stamp;
-			cmpxchg(&ct->timeout, expires, new_timeout);
+			cmpxchg(&ct->timeout, ct_timeout, new_timeout);
 		}
 	}
 

