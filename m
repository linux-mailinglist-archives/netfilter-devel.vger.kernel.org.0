Return-Path: <netfilter-devel+bounces-2094-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9248BCA6A
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 May 2024 11:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FC52841C8
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 May 2024 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6731422AC;
	Mon,  6 May 2024 09:20:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614F1422BF
	for <netfilter-devel@vger.kernel.org>; Mon,  6 May 2024 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714987201; cv=none; b=E+EtJ5YidlGSYh6IjDqMt0SYQnE7CF59RcwGk2IlzBCYc8XV6JMxO93C9SXagCHsoJleWl7K0OBOy7+nmabgmVL6TtCU6lmyZU4ntdc8wYGgaAKKHmkq4E1+JQIg0wGRkhaC+xHNiBJSC/IUcH4YDkC4lPzG0pL50BSC/AWNrno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714987201; c=relaxed/simple;
	bh=5N9v9tPbYlj/zVVAhwt849ws8ifN3N5iUrM/ZDxK9SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+ZVYwTLXD9L8zA5n15MUVNHRXZcnqxYT7Xr2Pb5QsrozuxHnIFm/MSidbKcrbYcF/lj4xlffP4gn7HVyVVALWoxtc92wPKTu1W29Q1/G1EXRQGk+At5yKcm+0MFdVORkiaQEbEBPQ5giSi/Ffj2tLULZArvMK0OXehQdICJ4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Mon, 6 May 2024 11:10:44 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [netfilter-nf:under-review 14/18]
 net/netfilter/nft_set_pipapo.c:2122: warning: expecting prototype for
 __nft_pipapo_walk(). Prototype was for nft_pipapo_do_walk() instead
Message-ID: <ZjielNW_OUxZuj3V@calendula>
References: <202405031522.nDHvTzEz-lkp@intel.com>
 <20240503104143.GA9734@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240503104143.GA9734@breakpoint.cc>

On Fri, May 03, 2024 at 12:41:43PM +0200, Florian Westphal wrote:
> kernel test robot <lkp@intel.com> wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git under-review
> > head:   7ab960ad3bd958ddbeabe9ab2287ac5d0a673f23
> > commit: cd491237776df450e99904b9408bfad35366a73f [14/18] netfilter: nft_set_pipapo: prepare walk function for on-demand clone
> > config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240503/202405031522.nDHvTzEz-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405031522.nDHvTzEz-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202405031522.nDHvTzEz-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> net/netfilter/nft_set_pipapo.c:2122: warning: expecting prototype for __nft_pipapo_walk(). Prototype was for nft_pipapo_do_walk() instead
> 
> Sigh.  Pablo, can you squash this to
> "netfilter: nft_set_pipapo: prepare walk function for on-demand clone"?

Done!

> diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
> index be5c554ca4d3..1a1dcb646af5 100644
> --- a/net/netfilter/nft_set_pipapo.c
> +++ b/net/netfilter/nft_set_pipapo.c
> @@ -2100,7 +2100,7 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
>  }
>  
>  /**
> - * __nft_pipapo_walk() - Walk over elements in m
> + * nft_pipapo_do_walk() - Walk over elements in m
>   * @ctx:       nftables API context
>   * @set:       nftables API set representation
>   * @m:         matching data pointing to key mapping array
> 

