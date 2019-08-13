Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14BA8C195
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Aug 2019 21:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfHMTgC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Aug 2019 15:36:02 -0400
Received: from correo.us.es ([193.147.175.20]:39358 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfHMTgB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:36:01 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 46AF9DA708
        for <netfilter-devel@vger.kernel.org>; Tue, 13 Aug 2019 21:35:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 39256DA704
        for <netfilter-devel@vger.kernel.org>; Tue, 13 Aug 2019 21:35:59 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2EDCBDA730; Tue, 13 Aug 2019 21:35:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1EB96DA704;
        Tue, 13 Aug 2019 21:35:57 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 13 Aug 2019 21:35:57 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.218.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E6BFA4265A2F;
        Tue, 13 Aug 2019 21:35:56 +0200 (CEST)
Date:   Tue, 13 Aug 2019 21:35:56 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables 1/4] src: fix jumps on bigendian arches
Message-ID: <20190813193556.2ykbmzndqat6qnai@salvia>
References: <20190813184409.10757-1-fw@strlen.de>
 <20190813184409.10757-2-fw@strlen.de>
 <20190813192049.enr7yczyngth4s4o@salvia>
 <20190813193439.domojznfkzp3g7ih@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813193439.domojznfkzp3g7ih@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:34:39PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > >  	char chain[NFT_CHAIN_MAXNAMELEN];
> > 
> > Probably:
> > 
> >         chat chain[NFT_CHAIN_MAXNAMELEN + 1] = {};
> 
> 
> > to ensure space for \0.
> 
> Not sure thats needed, the policy is:
> 
> [NFTA_CHAIN_NAME] = { .type = NLA_STRING,
> 		      .len = NFT_CHAIN_MAXNAMELEN - 1 },

Right.

> > > +	unsigned int len;
> > > +
> > > +	memset(chain, 0, sizeof(chain));
> > 
> > remove this memset then.
> > 
> > > +	len = e->len / BITS_PER_BYTE;
> > 
> >         div_round_up() ?
> 
> Do we have strings that are not divisible by BITS_PER_BYTE?

Nope.

> > > +	if (len >= sizeof(chain))
> > > +		len = sizeof(chain) - 1;
> > 
> > Probably BUG() here instead if e->len > NFT_CHAIN_MAXNAMELEN? This
> > should not happen.
> 
> Yes, I can change this.

Thanks.
