Return-Path: <netfilter-devel+bounces-10875-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ2CEycCoGl/fQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10875-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 09:19:51 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C011A26F8
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 09:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D02D30417A9
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6F137880E;
	Thu, 26 Feb 2026 08:19:47 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344E21257F;
	Thu, 26 Feb 2026 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093987; cv=none; b=hTRFSRtA6zrk9K7JzZwFzVm3TbAk210f6pM4cCnwBo2fsg9hLEc15Hru/aLOVFK6D3F6SE3zezbEm13LHX0FIBXlb61TRG9XEd8robqPrX/yytlKUn3PjGzUaqZo+4fzStaWLiaT6d8uGZjCOHV5g99o5tI78dWb5qSUorph/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093987; c=relaxed/simple;
	bh=UOdr0YdySebAL3nUGKP+jYMkmSYHSLg1dq+rJa8mkI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3P5DNwZ1lqAfo60A8SG9gkL+eb3+fW/BDsGYpy4Gac2invLfs+swwTRmKsBXumok3GB4BppsMhgMdQXOjFZAMKl6c0dK96jQo3L9yGXSR3MX4B1ZjPGCTnY2pL4wtx66+PDL1sjRI295BEmAKb41//VXdKiqzEkbz6l7b8BcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3579160516; Thu, 26 Feb 2026 09:19:38 +0100 (CET)
Date: Thu, 26 Feb 2026 09:19:37 +0100
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, netfilter-devel@vger.kernel.org, pabeni@redhat.com,
	pablo@netfilter.org, davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [net,2/2] netfilter: nf_tables: unconditionally bump set->nelems
 before insertion
Message-ID: <aaACGbUnAyQiV3ut@strlen.de>
References: <20260225130619.1248-3-fw@strlen.de>
 <20260226035628.1827287-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226035628.1827287-1-kuba@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10875-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: E8C011A26F8
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Is this legit?"

Looks legit to me.

> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> netfilter: nf_tables: unconditionally bump set->nelems before insertion
> 
> This commit addresses a race condition where a new element gets published
> then removed without waiting for the RCU grace period when the set is full.
> The fix moves the nelems increment before insertion and adds cleanup logic
> using the abort path to safely unwind the set.
> 
> > diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> > index 0c5a4855b97d..834736237b09 100644
> > --- a/net/netfilter/nf_tables_api.c
> > +++ b/net/netfilter/nf_tables_api.c
> > @@ -7171,6 +7171,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> >  	struct nft_data_desc desc;
> >  	enum nft_registers dreg;
> >  	struct nft_trans *trans;
> > +	bool set_full = false;
> >  	u64 expiration;
> >  	u64 timeout;
> >  	int err, i;
> > @@ -7462,10 +7463,18 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> >  	if (err < 0)
> >  		goto err_elem_free;
> >
> > +	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
> > +		unsigned int max = nft_set_maxsize(set), nelems;
> > +
> > +		nelems = atomic_inc_return(&set->nelems);
> > +		if (nelems > max)
> > +			set_full = true;
> > +	}
> > +
> >  	trans = nft_trans_elem_alloc(ctx, NFT_MSG_NEWSETELEM, set);
> >  	if (trans == NULL) {
> >  		err = -ENOMEM;
> > -		goto err_elem_free;
> > +		goto err_set_size;
> >  	}
> >
> >  	ext->genmask = nft_genmask_cur(ctx->net);
> > @@ -7517,7 +7526,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> >
> >  					ue->priv = elem_priv;
> >  					nft_trans_commit_list_add_elem(ctx->net, trans);
> > -					goto err_elem_free;
> > +					goto err_set_size;
> >  				}
> >  			}
> >  		}
> > @@ -7535,23 +7544,16 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> >  		goto err_element_clash;
> >  	}
> >
> > -	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
> > -		unsigned int max = nft_set_maxsize(set);
> > -
> > -		if (!atomic_add_unless(&set->nelems, 1, max)) {
> > -			err = -ENFILE;
> > -			goto err_set_full;
> > -		}
> > -	}
> > -
> >  	nft_trans_container_elem(trans)->elems[0].priv = elem.priv;
> >  	nft_trans_commit_list_add_elem(ctx->net, trans);
> > -	return 0;
> >
> > -err_set_full:
> > -	nft_setelem_remove(ctx->net, set, elem.priv);
> > +	return set_full ? -ENFILE : 0;
> > +
> >  err_element_clash:
> >  	kfree(trans);
> > +err_set_size:
> > +	if (!(flags & NFT_SET_ELEM_CATCHALL) && !set_full)
> > +		atomic_dec(&set->nelems);
> 
> Does this properly handle the element update path when the set is full?

Pablo, why does that check !set_full?  The increment is unconditional,
so why is the decrement asymmetric?

err_set_size:
        if (!(flags & NFT_SET_ELEM_CATCHALL))
                atomic_dec(&set->nelems);

?

