Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC4335331C
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Apr 2021 10:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhDCItv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 3 Apr 2021 04:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhDCItv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 3 Apr 2021 04:49:51 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B02C0613E6
        for <netfilter-devel@vger.kernel.org>; Sat,  3 Apr 2021 01:49:48 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1lSbyO-0004aS-O4; Sat, 03 Apr 2021 10:49:40 +0200
Date:   Sat, 3 Apr 2021 10:49:40 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] nft: Increase BATCH_PAGE_SIZE to support huge
 rulesets
Message-ID: <20210403084940.GA3158@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20210401145307.29927-1-phil@nwl.cc>
 <20210402053810.GI13699@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402053810.GI13699@breakpoint.cc>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Fri, Apr 02, 2021 at 07:38:10AM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > In order to support the same ruleset sizes as legacy iptables, the
> > kernel's limit of 1024 iovecs has to be overcome. Therefore increase
> > each iovec's size from 256KB to 4MB.
> > 
> > While being at it, add a log message for failing sendmsg() call. This is
> > not supposed to happen, even if the transaction fails. Yet if it does,
> > users are left with only a "line XXX failed" message (with line number
> > being the COMMIT line).
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> >  iptables/nft.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/iptables/nft.c b/iptables/nft.c
> > index bd840e75f83f4..e19c88ece6c2a 100644
> > --- a/iptables/nft.c
> > +++ b/iptables/nft.c
> > @@ -88,11 +88,11 @@ int mnl_talk(struct nft_handle *h, struct nlmsghdr *nlh,
> >  
> >  #define NFT_NLMSG_MAXSIZE (UINT16_MAX + getpagesize())
> >  
> > -/* selected batch page is 256 Kbytes long to load ruleset of
> > - * half a million rules without hitting -EMSGSIZE due to large
> > - * iovec.
> > +/* Selected batch page is 4 Mbytes long to support loading a ruleset of 3.5M
> > + * rules matching on source and destination address as well as input and output
> > + * interfaces. This is what legacy iptables supports.
> >   */
> > -#define BATCH_PAGE_SIZE getpagesize() * 32
> > +#define BATCH_PAGE_SIZE getpagesize() * 512
> 
> Why not remove getpagesize() altogether?

Yes, why not. At least I couldn't find a reason in git log why it's
there in the first place.

> The comment assumes getpagesize returns 4096 so might as well just use
> "#define BATCH_PAGE_SIZE  (4 * 1024 * 1024)" or similar?
> 
> On my system getpagesize() * 512 yields 2097152 ...

Thanks for digging deeper, my comment was wrong. I believed the old
comment and assumed getpagesize() would return 256k / 32 = 8k but indeed
it returns 4k.

> >  static struct nftnl_batch *mnl_batch_init(void)
> >  {
> > @@ -220,8 +220,10 @@ static int mnl_batch_talk(struct nft_handle *h, int numcmds)
> >  	int err = 0;
> >  
> >  	ret = mnl_nft_socket_sendmsg(h, numcmds);
> > -	if (ret == -1)
> > +	if (ret == -1) {
> > +		fprintf(stderr, "sendmsg() failed: %s\n", strerror(errno));
> >  		return -1;
> > +	}
> 
> Isn't that library code?  At the very least this should use
> nft_print().

Good point, but for the upcoming identical change to nftables! ;)
There I'm still undecided about the best way to handle it. For iptables,
I guess this minimal error reporting to stderr for a case that shouldn't
happen is fine. ACK?

Thanks, Phil
