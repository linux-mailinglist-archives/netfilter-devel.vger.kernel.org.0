Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0AE1385D4
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jan 2020 11:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbgALK2I (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 12 Jan 2020 05:28:08 -0500
Received: from correo.us.es ([193.147.175.20]:42022 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732588AbgALK2I (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 12 Jan 2020 05:28:08 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A085CF2587
        for <netfilter-devel@vger.kernel.org>; Sun, 12 Jan 2020 11:28:05 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 92184DA705
        for <netfilter-devel@vger.kernel.org>; Sun, 12 Jan 2020 11:28:05 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 87C8ADA712; Sun, 12 Jan 2020 11:28:05 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6BE48DA70E;
        Sun, 12 Jan 2020 11:28:03 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 12 Jan 2020 11:28:03 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4D53C4251481;
        Sun, 12 Jan 2020 11:28:03 +0100 (CET)
Date:   Sun, 12 Jan 2020 11:28:03 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 1/3] libnftables: add nft_ctx_set_netns()
Message-ID: <20200112102802.7bvwieqaza3zdbza@salvia>
References: <20200109172115.229723-1-pablo@netfilter.org>
 <20200109172115.229723-2-pablo@netfilter.org>
 <20200110125311.GP20229@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110125311.GP20229@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jan 10, 2020 at 01:53:11PM +0100, Phil Sutter wrote:
> Hi Pablo,
> 
> On Thu, Jan 09, 2020 at 06:21:13PM +0100, Pablo Neira Ayuso wrote:
> [...]
> > diff --git a/include/nftables/libnftables.h b/include/nftables/libnftables.h
> > index 765b20dd71ee..887628959ac6 100644
> > --- a/include/nftables/libnftables.h
> > +++ b/include/nftables/libnftables.h
> > @@ -34,10 +34,13 @@ enum nft_debug_level {
> >   * Possible flags to pass to nft_ctx_new()
> >   */
> >  #define NFT_CTX_DEFAULT		0
> > +#define NFT_CTX_NETNS		1
> 
> What is this needed for?

The socket is initialized from nft_ctx_init(), and such initialization
needs to happen after the netns switch.

> >  struct nft_ctx *nft_ctx_new(uint32_t flags);
> >  void nft_ctx_free(struct nft_ctx *ctx);
> >  
> > +int nft_ctx_set_netns(struct nft_ctx *ctx, const char *netns);
> 
> Is there a way to select init ns again?

AFAIK, setns() does not let you go back to init ns once set.
