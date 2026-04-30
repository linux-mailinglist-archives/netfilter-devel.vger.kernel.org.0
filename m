Return-Path: <netfilter-devel+bounces-12318-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNtvGR728mnNvwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12318-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 08:26:38 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D56549E0F3
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 08:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AAFD3003D0D
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 06:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B537648F;
	Thu, 30 Apr 2026 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="p+M+Ds8T"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DDD72622
	for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2026 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777530394; cv=none; b=YsX7ffU0kb8y9Fqf6cvHjD4SUu+KQEQE/11DsLfse5/DDojkoO3e+/3N5pBs/Z2vP/HxSwaE4Uf1wyD3TZAQQxTPUUm0R5pY21CALyCZbExGD+xSkXO2ynR+SQOfCet3lUWcEEDawlgh99zNnTEXXkoKHjQSA9dfEdKld3o+Zr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777530394; c=relaxed/simple;
	bh=VljmIqNxeJXJa/sC5OTRHndcZXFcJTxg94hicXg4+IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovENzposaJuWq6vRMGyKJB+KuoWLzO0hs5zbnInLTw4KFeoLWVBOujZBMnZ8s2ZG9IhPqOKdOqgrLLqLPXfAOa49QeepnYdPeKMy83Ob1nK6Z2jtp4THJJtYXebgDEsruR1bQ+q2fY5WIfib6cO1TcX2jkVAfkx2SIm8LmJ9X2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=p+M+Ds8T; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 761D160177;
	Thu, 30 Apr 2026 08:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777530391;
	bh=m16fJVWDMuCExRHgffvQMnG+4NUslTtgmMa4kRR8oHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+M+Ds8T4uQh0SzxiG2E5k0RutI3UPQYDu8PQoPB46mzk+XEcNx6xjS3aUn4UPNs2
	 e7NqsLwPwL4DE5viBURQIdBDG60lw8m9gyHlCwk09kD+UbWQI3KpK53NrN9pJzcMe9
	 jIKjq3Vdl9ymIvHr2L1fjPHGtGswg0k7TzSvkNbXLgX5VFUNyxdg6oyZz5h+0p8cpy
	 qgWJAlvjwIWGa49bqBe4EwYka+h4uyc5tVMZJeRjuAKXWuIOunD1wTLUfkHEQ+1nMN
	 58Qqu61P0kHLgyTNq/d7Ln8G31efZKcxAZeu8QxxP1ctwMqenQp7JtkB/jhrnYm0jq
	 waQ8AHGjEAgww==
Date: Thu, 30 Apr 2026 08:26:29 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	jeremy@azazel.net, phil@nwl.cc, fw@strlen.de
Subject: Re: [PATCH nf v4] netfilter: nft_bitwise: fix dst corruption in same
 register shifts
Message-ID: <afL2FYLNtqESyEPh@chamomile>
References: <20260427092117.4160-2-fmancera@suse.de>
 <afLye0knzKl5IdrY@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afLye0knzKl5IdrY@chamomile>
X-Rspamd-Queue-Id: 0D56549E0F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-12318-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,netfilter.org:dkim]

On Thu, Apr 30, 2026 at 08:11:07AM +0200, Pablo Neira Ayuso wrote:
> On Mon, Apr 27, 2026 at 11:21:18AM +0200, Fernando Fernandez Mancera wrote:
> > For lshift and rshift, the shift operations are performed in a loop over
> > 32-bit words. The loop calculates the shifted value and write it to dst,
> > and then immediately reads from src to calculate the carry for the next
> > iteration. Because src and dst could point to the same memory location,
> > the carry is incorrectly calculated using the newly modified dst value
> > instead of the original src value.
> > 
> > Adding a temporary local variable to cache the original value before
> > writing to dst and using it for the carry calculation solves the
> > problem. In addition, partial overlap is rejected from control plane for
> > all kind of operations. This was tested with the following bytecode:
> > 
> > table test_table ip flags 0 use 1 handle 1
> > ip test_table test_chain use 3 type filter hook input prio 0 policy accept packets 0 bytes 0 flags 1
> > ip test_table test_chain 2
> >   [ immediate reg 1 0x44332211 0x88776655 ]
> >   [ bitwise reg 1 = ( reg 1 << 0x08000000 ) ]
> >   [ cmp eq reg 1 0x66443322 0x00887766 ]
> >   [ counter pkts 0 bytes 0 ]
> > ip test_table test_chain 4 3
> >   [ immediate reg 1 0x44332211 0x88776655 ]
> >   [ bitwise reg 1 = ( reg 1 << 0x08000000 ) ]
> >   [ cmp eq reg 1 0x55443322 0x00887766 ]
> >   [ counter pkts 21794 bytes 1917798 ]
> > 
> > Fixes: 567d746b55bc ("netfilter: bitwise: add support for shifts.")
> > Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> > ---
> > v2: handled partially register overlap
> > v3: reject partially overlap from control plane
> > v4: applied the partial overlap check to all operations
> > ---
> >  net/netfilter/nft_bitwise.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
> > index 13808e9cd999..76e7ae96429d 100644
> > --- a/net/netfilter/nft_bitwise.c
> > +++ b/net/netfilter/nft_bitwise.c
[...]
> > @@ -264,6 +269,12 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
> >  	if (err < 0)
> >  		return err;
> >  
> > +	n = DIV_ROUND_UP(priv->len, sizeof(u32));
> > +	if (priv->sreg != priv->dreg &&
> > +	    priv->dreg < priv->sreg + n &&
> > +	    priv->sreg < priv->dreg + n)
> > +		return -EINVAL;
> 
> In some cases, there is also sreg2 that probably needs to be handled
> too.

And probably nft_byteorder needs something similar to check for
partial overlaps too for sreg and dreg. Also nft_lookup.

Maybe add this to a helper function and use it from there?

