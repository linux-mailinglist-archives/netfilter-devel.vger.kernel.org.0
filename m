Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A795B39F330
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jun 2021 12:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhFHKJt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Jun 2021 06:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhFHKJt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:09:49 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6347AC061574
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Jun 2021 03:07:56 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lqYeI-00004u-L8; Tue, 08 Jun 2021 12:07:54 +0200
Date:   Tue, 8 Jun 2021 12:07:54 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [nf-next PATCH v2] netfilter: nft_exthdr: Fix for unsafe packet
 data read
Message-ID: <20210608100754.GG20020@breakpoint.cc>
References: <20210608094057.24598-1-phil@nwl.cc>
 <20210608095621.GA15808@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608095621.GA15808@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Tue, Jun 08, 2021 at 11:40:57AM +0200, Phil Sutter wrote:
> > While iterating through an SCTP packet's chunks, skb_header_pointer() is
> > called for the minimum expected chunk header size. If (that part of) the
> > skbuff is non-linear, the following memcpy() may read data past
> > temporary buffer '_sch'. Use skb_copy_bits() instead which does the
> > right thing in this situation.
> > 
> > Fixes: 133dc203d77df ("netfilter: nft_exthdr: Support SCTP chunks")
> > Suggested-by: Florian Westphal <fw@strlen.de>
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> > Changes since v1:
> > - skb_copy_bits() call error handling added
> > ---
> >  net/netfilter/nft_exthdr.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
> > index 1b0579cb62d08..7f705b5c09de8 100644
> > --- a/net/netfilter/nft_exthdr.c
> > +++ b/net/netfilter/nft_exthdr.c
> > @@ -327,7 +327,9 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
> >  				break;
> >  
> >  			dest[priv->len / NFT_REG32_SIZE] = 0;
> > -			memcpy(dest, (char *)sch + priv->offset, priv->len);
> > +			if (skb_copy_bits(pkt->skb, offset + priv->offset,
> > +					  dest, priv->len) < 0)
> > +				break;
> 
> Hm, it looks like tcp exthdt matching has the same problem?

Tcp exthdr either copies from skb linear area or a on-stack scratch space,
it looks ok to me.
