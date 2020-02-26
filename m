Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B016FCD4
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Feb 2020 12:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgBZLBy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Feb 2020 06:01:54 -0500
Received: from correo.us.es ([193.147.175.20]:38454 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgBZLBy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:01:54 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 055276CB78
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Feb 2020 12:01:46 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id ECC314E73B
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Feb 2020 12:01:45 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E1CD5DA3B6; Wed, 26 Feb 2020 12:01:45 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 019AAFC5F8;
        Wed, 26 Feb 2020 12:01:39 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 26 Feb 2020 12:01:38 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D1F2542EF42A;
        Wed, 26 Feb 2020 12:01:38 +0100 (CET)
Date:   Wed, 26 Feb 2020 12:01:46 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH nf 0/2] nft_set_pipapo: Fix crash due to dangling entries
 in mapping table
Message-ID: <20200226110146.ljggljt4oibvkd3f@salvia>
References: <20200222011933.GO20005@orbyte.nwl.cc>
 <20200223222258.2bb7516a@redhat.com>
 <20200225123934.p3vru3tmbsjj2o7y@salvia>
 <20200225141346.7406e06b@redhat.com>
 <20200225134236.sdz5ujufvxm2in3h@salvia>
 <20200225153435.17319874@redhat.com>
 <20200225202143.tqsfhggvklvhnsvs@salvia>
 <20200225213815.3c0a1caa@redhat.com>
 <20200225205847.s5pjjp652unj6u7v@salvia>
 <20200226105804.xramr6duqkvrtop3@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226105804.xramr6duqkvrtop3@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:58:04AM +0100, Pablo Neira Ayuso wrote:
> On Tue, Feb 25, 2020 at 09:58:47PM +0100, Pablo Neira Ayuso wrote:
> > On Tue, Feb 25, 2020 at 09:38:15PM +0100, Stefano Brivio wrote:
> > > On Tue, 25 Feb 2020 21:21:43 +0100
> > > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > 
> > > > Hi Stefano,
> > > > 
> > > > On Tue, Feb 25, 2020 at 03:34:35PM +0100, Stefano Brivio wrote:
> > > > [...]
> > > > > This is the problem Phil reported:  
> > > > [...]
> > > > > Or also simply with:
> > > > > 
> > > > > # nft add element t s '{ 20-30 . 40 }'
> > > > > # nft add element t s '{ 25-35 . 40 }'
> > > > > 
> > > > > the second element is silently ignored. I'm returning -EEXIST from
> > > > > nft_pipapo_insert(), but nft_add_set_elem() clears it because NLM_F_EXCL
> > > > > is not set.
> > > > > 
> > > > > Are you suggesting that this is consistent and therefore not a problem?  
> > > > 
> > > >                         NLM_F_EXCL      !NLM_F_EXCL
> > > >         exact match       EEXIST             0 [*]
> > > >         partial match     EEXIST           EEXIST
> > > > 
> > > > The [*] case would allow for element timeout/expiration updates from
> > > > the control plane for exact matches.
> > > 
> > > A-ha. I didn't even consider that.
> > > 
> > > > Note that element updates are not
> > > > supported yet, so this check for !NLM_F_EXCL is a stub. I don't think
> > > > we should allow for updates on partial matches
> > > > 
> > > > I think what it is missing is a error to report "partial match" from
> > > > pipapo. Then, the core translates this "partial match" error to EEXIST
> > > > whether NLM_F_EXCL is set or not.
> > > 
> > > Yes, given what you explained, I also think it's the case.
> > > 
> > > > Would this work for you?
> > > 
> > > It would. I need to write a few more lines in nft_pipapo_insert(),
> > > because right now I don't have a special case for "entirely
> > > overlapping". Something on the lines of:
> > > 
> > > 	dup = pipapo_get(net, set, start, genmask);
> > > 	if (PTR_ERR(dup) == -ENOENT) {
> > > 
> > > -->		compare start and end key for this entry with
> > > 		start and end key from 'ext'
> > > 
> > > Let me know if you want me to post a patch with a placeholder for
> > > whatever you have in mind, or if I can help implementing this, etc.
> > 
> > Please, go ahead with the placeholder, it might be faster. I'll jump
> > on it.
> 
> Sorry, I just realized I can be probably quicker on the core side.
> Here is my proposal.
> 
> I'm attaching a patch for the core. This is handling -ENOTEMPTY which
> is (ab)used to report the partial element matching.
> 
> if NLM_F_EXCL is set off, then -EEXIST becomes 0.
>                           then -ENOTEMPTY becomes -EEXIST.
> 
> Would this work for you?
> 
> Thanks.

> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index d1318bdf49ca..0bbe36e731b8 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -5059,7 +5059,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
>  	ext->genmask = nft_genmask_cur(ctx->net) | NFT_SET_ELEM_BUSY_MASK;
>  	err = set->ops->insert(ctx->net, set, &elem, &ext2);
>  	if (err) {
> -		if (err == -EEXIST) {
> +		/* ENOTEMPTY reports partial element matching. */
> +		if (err == -EEXIST || err == -ENOTEMPTY) {
>  			if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA) ^
>  			    nft_set_ext_exists(ext2, NFT_SET_EXT_DATA) ||
>  			    nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF) ^
> @@ -5075,8 +5076,12 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
>  			     nft_set_ext_exists(ext2, NFT_SET_EXT_OBJREF) &&
>  			     *nft_set_ext_obj(ext) != *nft_set_ext_obj(ext2)))
>  				err = -EBUSY;
> -			else if (!(nlmsg_flags & NLM_F_EXCL))
> -				err = 0;
> +			else if (!(nlmsg_flags & NLM_F_EXCL)) {
> +				if (err == -EEXIST)
> +					err = 0;
> +				else if (err == -ENOTEMPTY)
> +					err = -EEXIST;

BTW, this could be simplified to:

                                if (err == -ENOTEMPTY)
                                        err = -EEXIST;
                                else
                                        err = 0;

instead of:

				if (err == -EEXIST)
					err = 0;
				else if (err == -ENOTEMPTY)
					err = -EEXIST;

> +			}
>  		}
>  		goto err_element_clash;
>  	}

