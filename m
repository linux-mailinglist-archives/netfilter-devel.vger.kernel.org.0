Return-Path: <netfilter-devel+bounces-12227-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAhVFHSd72kbDQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12227-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 19:31:32 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88266477A42
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 19:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DEBD303A5F7
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971E3DA7E5;
	Mon, 27 Apr 2026 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="H9y9IaK6"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154BF3DCD8E
	for <netfilter-devel@vger.kernel.org>; Mon, 27 Apr 2026 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310617; cv=none; b=u0Shr9c9UCCCc/b22Fxp9F8togpWXwu2gwnxPypH5BFqi/BGe7s82LglO1BSlaS+DTIllgWZuS9iCxYpI6dOm4QdsSYHTqaPT+Op3E3cVgH97sb3pfheNULChzR1HLr0uhBhSF6Q+qpjaQw2FUMyB47czzufK5zSn8aXP3flcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310617; c=relaxed/simple;
	bh=YuL3x3hXkBGsGf4KWUcUGEgQxWyhk/Gk/vOygvCEJh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4E5Z3dagL2/yI6qHoOKtqLLtSznvNkehpHJjQF+XSRhxsY1t5xv4ulCML1Xj6Li8n/+bCDfTgoJc6KpuBzi2sYci3dhwUnpNgjrS/9ofQWvuiKH6FWTGloByjYlD8KqVl3RcQ4OVXYCCTWzQM6Esg4iHno5OxccRfbCLv3ypBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=H9y9IaK6; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 1639B60181;
	Mon, 27 Apr 2026 19:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777310614;
	bh=MmPY/9ZsFfSnxLjBt22TfxjyPKqFzUnb5mcg7vZsCM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9y9IaK67ThvjKt9eRbj5Wy2/GgGBTRVq3G7wtjH7wr6CdKK1iKU3lLESYYTKyTxd
	 QHDS77UdQ2AQehG7cNz+DaVndMnMrhoEO4hiHL39MytFXQPZISxARbl0gRWsNqOxwR
	 /sy0UzsX0uGBpmFpEEum6X5DK3ISKgoGvxi6jHq5qvXhq0qK1T6odYfrSsITp7rWh1
	 DC1N2Pll9b2LGp111L5uaEUROhx4p7GQtnLNRSjSiuMkWPEnL58ZaCpkPxdIV5ZK7+
	 meybmalGoUrtQRotuUqudaujN57cfa4ESmEpAd0PpQXPhZkiptf4Bo4vG5p7vYY0Yp
	 4JsSlRwHD/WIA==
Date: Mon, 27 Apr 2026 19:23:31 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	phil@nwl.cc
Subject: Re: [PATCH 3/3 nf v4] netfilter: xtables: fix L4 header parsing for
 non-first fragments
Message-ID: <ae-bk_I_8CZyg5qA@chamomile>
References: <20260427112720.5128-1-fmancera@suse.de>
 <20260427112720.5128-3-fmancera@suse.de>
 <ae-MRZ47QurmXY7z@chamomile>
 <ae-P4Sbl-0vpFrUY@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae-P4Sbl-0vpFrUY@strlen.de>
X-Rspamd-Queue-Id: 88266477A42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12227-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 06:33:37PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > -               if (!(pkt->flags & NFT_PKTINFO_L4PROTO))
> > +               if (!(pkt->flags & NFT_PKTINFO_L4PROTO) || pkt->fragoff)
> >                         return false;
> 
> What is NFT_PKTINFO_L4PROTO supposed to mean?

"IP packet has been fully parsed"

> I thought it meant there is an l4 header but its set unconditionally
> for ipv4.

Flag name is a misleading.

See my recent comment in this function:

static void nft_meta_pktinfo_may_update(struct nft_pktinfo *pkt)
{                       
        struct sk_buff *skb = pkt->skb;
        struct vlan_ethhdr *veth;
        __be16 ethertype;
        int nhoff;
                
        /* Is this an IP packet? Then, skip. */
        if (pkt->flags) 
                return;

> Only the ipv6 handling makes sense to me.

Maybe a helper function can be added, eg. nft_ip() then this flag can
be renamed.

