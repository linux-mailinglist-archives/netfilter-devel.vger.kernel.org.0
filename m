Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35794D0930
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Mar 2022 22:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiCGVJu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Mar 2022 16:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiCGVJt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:09:49 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33EE85A148
        for <netfilter-devel@vger.kernel.org>; Mon,  7 Mar 2022 13:08:53 -0800 (PST)
Received: from netfilter.org (unknown [87.190.248.243])
        by mail.netfilter.org (Postfix) with ESMTPSA id EC1E963002;
        Mon,  7 Mar 2022 22:07:00 +0100 (CET)
Date:   Mon, 7 Mar 2022 22:08:47 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] misspell: Avoid segfault with anonymous chains
Message-ID: <YiZz9PkLxH/MTQoq@salvia>
References: <20220304103711.23355-1-phil@nwl.cc>
 <YiHz+bNsLvFjkPit@salvia>
 <YiIC/zbFfMTcsuNb@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YiIC/zbFfMTcsuNb@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 04, 2022 at 01:15:59PM +0100, Phil Sutter wrote:
> On Fri, Mar 04, 2022 at 12:11:53PM +0100, Pablo Neira Ayuso wrote:
> > Hi Phil,
> > 
> > On Fri, Mar 04, 2022 at 11:37:11AM +0100, Phil Sutter wrote:
> > > When trying to add a rule which contains an anonymous chain to a
> > > non-existent chain, string_misspell_update() is called with a NULL
> > > string because the anonymous chain has no name. Avoid this by making the
> > > function NULL-pointer tolerant.
> > > 
> > > c330152b7f777 ("src: support for implicit chain bindings")
> > > 
> > > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > > ---
> > >  src/misspell.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/src/misspell.c b/src/misspell.c
> > > index 6536d7557a445..f213a240005e6 100644
> > > --- a/src/misspell.c
> > > +++ b/src/misspell.c
> > > @@ -80,8 +80,8 @@ int string_misspell_update(const char *a, const char *b,
> > >  {
> > >  	unsigned int len_a, len_b, max_len, min_len, distance, threshold;
> > >  
> > > -	len_a = strlen(a);
> > > -	len_b = strlen(b);
> > > +	len_a = a ? strlen(a) : 0;
> > > +	len_b = b ? strlen(b) : 0;
> > 
> > string_distance() assumes non-NULL too.
> 
> Which is called from string_misspell_update() only which with my patch
> returns early due to 'max_len <= 1'.
> 
> > probably shortcircuit chain_lookup_fuzzy() earlier since h->chain.name
> > is always NULL, to avoid the useless loop.
> 
> Fine with me, too! What about allocating a name for the anonymous chain
> instead?

A dummy name could be allocated, but the kernel does not need the
chain name at this stage (it uses the ephemeral 32-bit chain ID
instead which is only valid in the netlink batch).

Probably set_lookup_fuzzy() should also short-circuit early the
misspell logic for anonymous sets.

> I guess similar treatment as with sets would make sense. Might
> also help with netlink debug output:
>
> | # nft --debug=netlink insert rule inet x y 'goto { accept; }'
> | inet (null) (null) use 0

# nft add table x
# nft --debug=netlink add chain x y
ip (null) (null) use 0

table is null, at least this one should be set on, but this is
a partially different issue.

> | inet x
> |   [ immediate reg 0 accept ]
> | 
> |   inet x y
> |     [ immediate reg 0 goto ]
> | [...]
> 
> Thanks, Phil
