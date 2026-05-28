Return-Path: <netfilter-devel+bounces-12914-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APneHY3qF2osVQgAu9opvQ
	(envelope-from <netfilter-devel+bounces-12914-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 09:11:09 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 216655ED892
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 09:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A64993063A80
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79A34EF03;
	Thu, 28 May 2026 07:10:58 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D1233923
	for <netfilter-devel@vger.kernel.org>; Thu, 28 May 2026 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952257; cv=none; b=ZG8QyRJjNuo8xTHjef1zs6VyotA1EwTywVBRUgKoTDvpZTl8oHxjElL/gna5d5KqcymGOF+uYCu6ZgNRmSOYnLIrkf78ePsnqdQENN4Mh6UBvmKmblFYYg6hNg3lFMn97aSKsJ12vkIzKudf+WZnG8ueGhCZm1HW3IexSGxf7AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952257; c=relaxed/simple;
	bh=Y+z0/xk8fXJMI5Ih3o7oQMr/USJm3DqnSZ68SRu6Vis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzAdyh0Ri/KEob/IlQfscsMlUnEyE2Pzs51DQFbJcyZAw7/lxrOSCjm3w71q6ru5LYOu7mbQ16bDg3Iu8Emsu1d2stMhwadOuxw71Qo39hJpDblKtSG9HGkNQkhJ56b/KOcmRI//EMFFzxJN6QzOfejcqez8hKTHMm8qs442PQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4E75660503; Thu, 28 May 2026 09:10:53 +0200 (CEST)
Date: Thu, 28 May 2026 09:10:52 +0200
From: Florian Westphal <fw@strlen.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_ct: fix OOB in NFT_CT_SRC/DST eval
Message-ID: <ahfqfM6xQKZr_xbA@strlen.de>
References: <20260528042620.263828-1-jiayuan.chen@linux.dev>
 <ahfQGCNs8hl6FlHL@strlen.de>
 <ahfV6K6KrG0akLUZ@strlen.de>
 <88abc4d7-8316-4c9e-aca0-351fe0ecb2b0@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88abc4d7-8316-4c9e-aca0-351fe0ecb2b0@linux.dev>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12914-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,strlen.de:mid,linux.dev:email]
X-Rspamd-Queue-Id: 216655ED892
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> > diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
> > --- a/net/netfilter/nft_ct.c
> > +++ b/net/netfilter/nft_ct.c
> > @@ -78,7 +78,7 @@ static void nft_ct_get_eval(const struct nft_expr *expr,
> >   		break;
> >   	}
> > -	if (ct == NULL)
> > +	if (!ct || nf_ct_is_template(ct))
> >   		goto err;
> >   	switch (priv->key) {
> > diff --git a/net/netfilter/nft_ct_fast.c b/net/netfilter/nft_ct_fast.c
> > --- a/net/netfilter/nft_ct_fast.c
> > +++ b/net/netfilter/nft_ct_fast.c
> > @@ -30,7 +30,7 @@ void nft_ct_get_fast_eval(const struct nft_expr *expr,
> >   		break;
> >   	}
> > -	if (!ct) {
> > +	if (!ct || nf_ct_is_template(ct)) {
> >   		regs->verdict.code = NFT_BREAK;
> >   		return;
> >   	}
> > 
> 
> It looks more general and also covers the other GET keys that would equally
> misbehave on a template.

Would you mind sending a v2?

> > .... might also make sense to invert
> > nf_ct_l3num(ct) == NFPROTO_IPV4 ? 4 : 16), i.e.:
> > nf_ct_l3num(ct) == NFPROTO_IPV6 ? 16 : 4);
> 
> As defense-in-depth, IIUC?

Yes, alternatively merge your v1 with the template check. I don't see how
we can ever have nf_ct_l3num(ct) != nft_pf(pkt) outside of the template
bug.

