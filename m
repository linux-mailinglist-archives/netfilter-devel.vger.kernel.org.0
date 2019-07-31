Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1927C2FA
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Jul 2019 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbfGaNKq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Jul 2019 09:10:46 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:49476 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387696AbfGaNKq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:10:46 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hsoNQ-00049o-P4; Wed, 31 Jul 2019 15:10:44 +0200
Date:   Wed, 31 Jul 2019 15:10:44 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] src: store expr, not dtype to track data in sets
Message-ID: <20190731131044.ntk6lzwe5uniku7p@breakpoint.cc>
References: <20190730143732.2126-1-fw@strlen.de>
 <20190730143732.2126-2-fw@strlen.de>
 <20190731130230.nc5fj437st7ejkne@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731130230.nc5fj437st7ejkne@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > +static struct expr *concat_expr_alloc_by_type_FIXME(uint32_t type)
> > +{
> > +	struct expr *concat_expr = concat_expr_alloc(&netlink_location);
> > +	unsigned int n;
> > +	int size = 0;
> > +
> > +	n = div_round_up(fls(type), TYPE_BITS);
> > +	while (n > 0 && concat_subtype_id(type, --n)) {
> > +		const struct datatype *i;
> > +		struct expr *expr;
> > +
> > +		i = concat_subtype_lookup(type, n);
> > +		if (i == NULL)
> > +			return NULL;
> > +
> > +		if (i->size == 0)
> > +			size = -1;
> > +		else if (size >= 0)
> > +			size += i->size;
> > +
> > +		expr = constant_expr_alloc(&netlink_location, i, i->byteorder,
> > +					   i->size, NULL);
> > +
> > +		compound_expr_add(concat_expr, expr);
> > +	}
> > +
> > +	/* can be incorrect in case of i->size being 0 (variable length). */
> > +	concat_expr->len = size > 0 ? size : 0;
> > +
> > +	return concat_expr;
> > +}
> > +
> > +static struct expr *
> > +data_expr_alloc_by_type_FIXME(enum nft_data_types type, enum byteorder keybyteorder)
> 
> There is no support for concatenations from the right hand side of the
> mapping, so I would just calloc a constant expression itself.

Excellent.  This is what I concluded when I was working on this, but at
that point i was already backed into a corner, hence the function name
:-)

> will be more simple. Same comment applies to dtype_map_from_kernel().

Oh, right.

> In general, I agree in the direction where this is going, that is,
> turn the datatype field in the set object into an expression.

Perfect.
