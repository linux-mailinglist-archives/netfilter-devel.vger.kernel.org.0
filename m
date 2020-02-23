Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA9169A6C
	for <lists+netfilter-devel@lfdr.de>; Sun, 23 Feb 2020 23:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBWWOi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 23 Feb 2020 17:14:38 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:45740 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgBWWOi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 23 Feb 2020 17:14:38 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1j5zWF-0004Bw-B8; Sun, 23 Feb 2020 23:14:35 +0100
Date:   Sun, 23 Feb 2020 23:14:35 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 3/5] nft_set_pipapo: Prepare for vectorised
 implementation: alignment
Message-ID: <20200223221435.GX19559@breakpoint.cc>
References: <cover.1582488826.git.sbrivio@redhat.com>
 <2723f85da2cd9d6b7158c7a2514c6b22f044b1b6.1582488826.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2723f85da2cd9d6b7158c7a2514c6b22f044b1b6.1582488826.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Stefano Brivio <sbrivio@redhat.com> wrote:
>  struct nft_pipapo_field {
> @@ -439,6 +456,9 @@ struct nft_pipapo_field {
>  	unsigned long rules;
>  	size_t bsize;
>  	int bb;
> +#ifdef NFT_PIPAPO_ALIGN
> +	unsigned long *lt_aligned;
> +#endif
>  	unsigned long *lt;
>  	union nft_pipapo_map_bucket *mt;
>  };

I wonder if these structs can be compressed.
AFAICS bsize is in sizes of longs, so when this number is
large then we also need to kvmalloc a large blob of memory.

I think u32 would be enough?

nft_pipapo_field is probably the most relevant one wrt. to size.

>  struct nft_pipapo_match {
>  	int field_count;
> +#ifdef NFT_PIPAPO_ALIGN
> +	unsigned long * __percpu *scratch_aligned;
> +#endif
>  	unsigned long * __percpu *scratch;
>  	size_t bsize_max;

Same here (bsize_max -- could fit with hole after field_count)?

Also, since you know the size of nft_pipapo_match (including the
dynamically allocated array at the end), you could store the
original memory (*scratch) and the rcu_head at the end, since
they are not needed at lookup time and a little overhead to calculate
their storage offset is fine.

Not sure its worth it, just an idea.
