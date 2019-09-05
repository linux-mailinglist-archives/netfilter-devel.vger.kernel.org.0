Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1763AAF1B
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Sep 2019 01:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbfIEX1h (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Sep 2019 19:27:37 -0400
Received: from correo.us.es ([193.147.175.20]:55002 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731552AbfIEX1h (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Sep 2019 19:27:37 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E4C4ADA3CA
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Sep 2019 01:27:32 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D7389FB362
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Sep 2019 01:27:32 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id CA114DA72F; Fri,  6 Sep 2019 01:27:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 89A10D2B1F;
        Fri,  6 Sep 2019 01:27:30 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 06 Sep 2019 01:27:30 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 661B04265A5A;
        Fri,  6 Sep 2019 01:27:30 +0200 (CEST)
Date:   Fri, 6 Sep 2019 01:27:31 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Eric Garver <eric@garver.life>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] cache: fix --echo with index/position
Message-ID: <20190905232731.5otmb34ykpykyzkh@salvia>
References: <20190905170939.4132-1-pablo@netfilter.org>
 <20190905204432.h2nv4zs5ysxlxhnq@egarver.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905204432.h2nv4zs5ysxlxhnq@egarver.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 05, 2019 at 04:44:32PM -0400, Eric Garver wrote:
> On Thu, Sep 05, 2019 at 07:09:39PM +0200, Pablo Neira Ayuso wrote:
> > Check for the index/position in case the echo flag is set on. Set the
> > NFT_CACHE_UPDATE flag in this case to enable incremental cache updates.
> > 
> > Reported-by: Eric Garver <eric@garver.life>
> > Fixes: 01e5c6f0ed03 ("src: add cache level flags")
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> >  src/cache.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/src/cache.c b/src/cache.c
> > index cffcbb623ced..71d16a0fbeed 100644
> > --- a/src/cache.c
> > +++ b/src/cache.c
> > @@ -106,6 +106,9 @@ unsigned int cache_evaluate(struct nft_ctx *nft, struct list_head *cmds)
> >  		case CMD_CREATE:
> >  			if (nft_output_echo(&nft->output)) {
> >  				flags = NFT_CACHE_FULL;
> > +				if (cmd->handle.index.id ||
> > +				    cmd->handle.position.id)
> > +					flags |= NFT_CACHE_UPDATE;
> >  				break;
> >  			}
> >  			flags = evaluate_cache_add(cmd, flags);
> 
> We can keep the special cases isolated to evaluate_cache_add() by always
> calling it.

That's fine too, yes. Would you formally submit this patch? Thanks.

> diff --git a/src/cache.c b/src/cache.c
> index cffcbb623ced..f7ca8fe9068f 100644
> --- a/src/cache.c
> +++ b/src/cache.c
> @@ -104,11 +104,10 @@ unsigned int cache_evaluate(struct nft_ctx *nft, struct list_head *cmds)
>                 case CMD_ADD:
>                 case CMD_INSERT:
>                 case CMD_CREATE:
> +                       flags = evaluate_cache_add(cmd, flags);
>                         if (nft_output_echo(&nft->output)) {
> -                               flags = NFT_CACHE_FULL;
> -                               break;
> +                               flags |= NFT_CACHE_FULL;
>                         }
> -                       flags = evaluate_cache_add(cmd, flags);
>                         break;
>                 case CMD_REPLACE:
>                         flags = NFT_CACHE_FULL;
