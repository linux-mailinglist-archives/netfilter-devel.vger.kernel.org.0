Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02DE1C7F2
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 May 2019 13:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfENLpG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 May 2019 07:45:06 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48012 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfENLpG (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 May 2019 07:45:06 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hQVrj-0007KG-Kc; Tue, 14 May 2019 13:45:03 +0200
Date:   Tue, 14 May 2019 13:45:03 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] xtables: Fix typo in nft_rebuild_cache()
Message-ID: <20190514114503.GV4851@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190514085133.32674-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514085133.32674-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Tue, May 14, 2019 at 10:51:33AM +0200, Phil Sutter wrote:
> Conditional cache flush logic was inverted.
> 
> Fixes: 862818ac3a0de ("xtables: add and use nft_build_cache")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  iptables/nft.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/iptables/nft.c b/iptables/nft.c
> index 6354b7e8e72fe..83e0d9a69b37c 100644
> --- a/iptables/nft.c
> +++ b/iptables/nft.c
> @@ -1541,7 +1541,7 @@ void nft_build_cache(struct nft_handle *h)
>  
>  void nft_rebuild_cache(struct nft_handle *h)
>  {
> -	if (!h->have_cache)
> +	if (h->have_cache)
>  		flush_chain_cache(h, NULL);
>  
>  	__nft_build_cache(h);

So with this change I broke your transaction reload logic. The problem
is that data in h->obj_list potentially sits in cache, too. At least
rules have to be there so insert with index works correctly. If the
cache is flushed before regenerating the batch, use-after-free occurs
which crashes the program.

We need to either keep the old cache around or keep locally generated
entries when flushing (which might require more intelligent cache
update, too).

I also have a fix for your testcase, will submit that in a minute as
well.

Cheers, Phil
