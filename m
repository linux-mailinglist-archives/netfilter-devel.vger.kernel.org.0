Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B5139F34D
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jun 2021 12:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFHKSv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Jun 2021 06:18:51 -0400
Received: from mail.netfilter.org ([217.70.188.207]:56124 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFHKSv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:18:51 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id B8DF763E3D;
        Tue,  8 Jun 2021 12:15:45 +0200 (CEST)
Date:   Tue, 8 Jun 2021 12:16:55 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH v2] netfilter: nft_exthdr: Fix for unsafe packet
 data read
Message-ID: <20210608101655.GA16424@salvia>
References: <20210608094057.24598-1-phil@nwl.cc>
 <20210608095621.GA15808@salvia>
 <20210608100754.GG20020@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608100754.GG20020@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 08, 2021 at 12:07:54PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > On Tue, Jun 08, 2021 at 11:40:57AM +0200, Phil Sutter wrote:
> > > While iterating through an SCTP packet's chunks, skb_header_pointer() is
> > > called for the minimum expected chunk header size. If (that part of) the
> > > skbuff is non-linear, the following memcpy() may read data past
> > > temporary buffer '_sch'. Use skb_copy_bits() instead which does the
> > > right thing in this situation.
> > > 
> > > Fixes: 133dc203d77df ("netfilter: nft_exthdr: Support SCTP chunks")
> > > Suggested-by: Florian Westphal <fw@strlen.de>
> > > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > > ---
> > > Changes since v1:
> > > - skb_copy_bits() call error handling added
> > > ---
> > >  net/netfilter/nft_exthdr.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
> > > index 1b0579cb62d08..7f705b5c09de8 100644
> > > --- a/net/netfilter/nft_exthdr.c
> > > +++ b/net/netfilter/nft_exthdr.c
> > > @@ -327,7 +327,9 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
> > >  				break;
> > >  
> > >  			dest[priv->len / NFT_REG32_SIZE] = 0;
> > > -			memcpy(dest, (char *)sch + priv->offset, priv->len);
> > > +			if (skb_copy_bits(pkt->skb, offset + priv->offset,
> > > +					  dest, priv->len) < 0)
> > > +				break;
> > 
> > Hm, it looks like tcp exthdt matching has the same problem?
> 
> Tcp exthdr either copies from skb linear area or a on-stack scratch space,
> it looks ok to me.

Indeed, I overlook the nft_tcp_header_pointer() call a few lines before.
