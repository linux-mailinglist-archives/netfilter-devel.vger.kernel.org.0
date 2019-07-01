Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D770823B92
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfETPGa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 11:06:30 -0400
Received: from mail.us.es ([193.147.175.20]:47898 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfETPG3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 11:06:29 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 082E5C04A0
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 17:06:28 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EBE69DA70E
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 17:06:27 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E1784DA702; Mon, 20 May 2019 17:06:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E24F5DA703;
        Mon, 20 May 2019 17:06:25 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 20 May 2019 17:06:25 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BAF724265A32;
        Mon, 20 May 2019 17:06:25 +0200 (CEST)
Date:   Mon, 20 May 2019 17:06:25 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, phil@nwl.cc
Subject: Re: [PATCH iptables RFC 4/4] nft: don't care about previous state in
 RESTART
Message-ID: <20190520150625.orluik4il46mgu2x@salvia>
References: <20190520144115.29732-1-pablo@netfilter.org>
 <20190520144115.29732-5-pablo@netfilter.org>
 <20190520144938.gqjakvfck6v4akq3@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520144938.gqjakvfck6v4akq3@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, May 20, 2019 at 04:49:38PM +0200, Pablo Neira Ayuso wrote:
> On Mon, May 20, 2019 at 04:41:15PM +0200, Pablo Neira Ayuso wrote:
> > We need to re-evalute based on the existing cache generation.
> >
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> >  iptables/nft.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/iptables/nft.c b/iptables/nft.c
> > index c1a079b734cf..bc3847d7ea47 100644
> > --- a/iptables/nft.c
> > +++ b/iptables/nft.c
> > @@ -2782,10 +2782,10 @@ static void nft_refresh_transaction(struct nft_handle *h)
> >  			if (!tablename)
> >  				continue;
> >  			exists = nft_table_find(h, tablename);
> > -			if (n->skip && exists)
> > -				n->skip = 0;
> > -			else if (!n->skip && !exists)
> > +			if (exists)
> >  				n->skip = 1;
> > +			else
> > +				n->skip = 0;
>
> Actually, this should be the opposite:
>
>  			if (exists)
>  				n->skip = 0;
> 			else
> 				n->skip = 1;
>
> So we only skip the flush if the table does not exist.
>
> Still not working though, hitting EEXIST on CHAIN_USER_ADD.

The nfnl_unlock(subsys_id); is released after check the generation ID
in nfnetlink.

This is rendering the generation ID useless. We need a kernel fix for
this.

The per-netns mutex net->nft.commit_mutex should be handled from the
nfnetlink core.
