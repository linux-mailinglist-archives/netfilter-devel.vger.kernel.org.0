Return-Path: <netfilter-devel+bounces-11824-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIZSCFKy2mnl5QgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11824-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Apr 2026 22:42:58 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F4A3E1A93
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Apr 2026 22:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC5023075865
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Apr 2026 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291632EBB84;
	Sat, 11 Apr 2026 20:41:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCE23C8C7
	for <netfilter-devel@vger.kernel.org>; Sat, 11 Apr 2026 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775940097; cv=none; b=p/BNg8gQiVJCcXF6ADyAED/l7NOMbPYqtV58EMVU07rC1nstRujpXMW4zMxKnlHFohjLj1MLE6/NFYPiNpU0fhTLKSSN6geRTQgrUz9VK/UqlHdwAmv9M/WBVs9OjNkeGhw9DtCaaSnQVwhweoWAcAX8jQOru5r9uyvpNZtor4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775940097; c=relaxed/simple;
	bh=k3uSAKgJ5e+kSEYFPOzcdC5jfSTGDfjv4S4sFkIOF+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJTK1Fhgx6xahjF/jJCIh+L9vDWccgjzQWQhLKmWVLWrio8hgu4pRIk1bMoSv4MNiC+HkG7xHUK1j83c0uWhez75g5jMBquToIehD3Sd9lvTmDSvkfvEOoGLF5JBS3msbB1Y/IYYxaFQV0KPA7lgK4vWkzRH38wuulgvT0ePWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id AA40D60491; Sat, 11 Apr 2026 22:41:32 +0200 (CEST)
Date: Sat, 11 Apr 2026 22:41:32 +0200
From: Florian Westphal <fw@strlen.de>
To: Xiang Mei <xmei5@asu.edu>
Cc: netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	coreteam@netfilter.org, Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH nf] netfilter: nfnetlink_osf: fix divide-by-zero in
 OSF_WSS_MODULO
Message-ID: <adqx_IBgoyAMIJ5I@strlen.de>
References: <20260410204843.64259-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410204843.64259-1-xmei5@asu.edu>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11824-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78F4A3E1A93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Xiang Mei <xmei5@asu.edu> wrote:
> The OSF_WSS_MODULO branch in nf_osf_match_one() performs:
> 
>   ctx->window % f->wss.val
> 
> without guarding against f->wss.val == 0.  A user with CAP_NET_ADMIN
> can add an OSF fingerprint with wss.wc = OSF_WSS_MODULO and wss.val = 0
> via nfnetlink.  When a matching TCP SYN packet arrives, the kernel
> executes a division by zero and panics.
> 
> The OSF_WSS_PLAIN case already treats val == 0 as a wildcard (match
> everything).  Apply the same semantics to OSF_WSS_MODULO: if val is 0,
> any window value matches rather than dividing by zero.
> 
> Crash:
>  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
>  RIP: 0010:nf_osf_match_one (net/netfilter/nfnetlink_osf.c:98)
>  Call Trace:
>  <IRQ>
>   nf_osf_match (net/netfilter/nfnetlink_osf.c:220 (discriminator 6))
>   xt_osf_match_packet (net/netfilter/xt_osf.c:32)
>   ipt_do_table (net/ipv4/netfilter/ip_tables.c:348)
>   nf_hook_slow (net/netfilter/core.c:622 (discriminator 1))
>   ip_local_deliver (net/ipv4/ip_input.c:265)
>   ip_rcv (include/linux/skbuff.h:1162)
>   __netif_receive_skb_one_core (net/core/dev.c:6181)
>   process_backlog (.include/linux/skbuff.h:2502 net/core/dev.c:6642)
>   __napi_poll (net/core/dev.c:7710)
>   net_rx_action (net/core/dev.c:7945)
>   handle_softirqs (kernel/softirq.c:622)
> 
> Fixes: 31a9c29210e2 ("netfilter: nf_osf: add struct nf_osf_hdr_ctx")

Hmm, why?  AFAICS the bug was there from start:

11eeef41d5f63 case OSF_WSS_MODULO:
11eeef41d5f63    if ((window % f->wss.val) == 0)
11eeef41d5f63        fmatch = FMATCH_OK;

So:
Fixes: 11eeef41d5f6 ("netfilter: passive OS fingerprint xtables match")

> diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
> index 45d9ad231..193436aa9 100644
> --- a/net/netfilter/nfnetlink_osf.c
> +++ b/net/netfilter/nfnetlink_osf.c
> @@ -150,7 +150,7 @@ static bool nf_osf_match_one(const struct sk_buff *skb,
>  				fmatch = FMATCH_OK;
>  			break;
>  		case OSF_WSS_MODULO:
> -			if ((ctx->window % f->wss.val) == 0)
> +			if (f->wss.val == 0 || (ctx->window % f->wss.val) == 0)

Could you send a v2 that rejects this from control plane instead?
Nobody is using a 0 value, else we'd have gotted such crash reports by
now.

