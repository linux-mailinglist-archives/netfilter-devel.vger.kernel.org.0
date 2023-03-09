Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986066B2C1F
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Mar 2023 18:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCIRfE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Mar 2023 12:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjCIReu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:34:50 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6348FFA098
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Mar 2023 09:34:49 -0800 (PST)
Date:   Thu, 9 Mar 2023 18:34:45 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] doc: nft.8: Document lower priority limit for nat
 type chains
Message-ID: <ZAoYtSqnEw+RCqtY@salvia>
References: <20230309135246.18143-1-phil@nwl.cc>
 <ZAn57dCJmPkoBns/@salvia>
 <ZAn8F+e8qwLApaNM@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAn8F+e8qwLApaNM@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 09, 2023 at 04:32:39PM +0100, Phil Sutter wrote:
> On Thu, Mar 09, 2023 at 04:23:25PM +0100, Pablo Neira Ayuso wrote:
> > On Thu, Mar 09, 2023 at 02:52:46PM +0100, Phil Sutter wrote:
> > > Users can't know the magic limit.
> > >
> > > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > > ---
> > >  doc/nft.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/doc/nft.txt b/doc/nft.txt
> > > index 7de4935b4b375..0d60c7520d31e 100644
> > > --- a/doc/nft.txt
> > > +++ b/doc/nft.txt
> > > @@ -439,6 +439,9 @@ name which specifies the order in which chains with the same *hook* value are
> > >  traversed. The ordering is ascending, i.e. lower priority values have precedence
> > >  over higher ones.
> > >  
> > > +With *nat* type chains, there's a lower excluding limit of -200 for *priority*
> > > +values, because conntrack hooks at this priority and NAT requires it.
> > 
> > prerouting, output 		-200 	NF_IP_PRI_CONNTRACK
> > 
> > this should only apply in these two hooks, it should be possible to
> > relax this in input and postrouting in the kernel.
> 
> So far nobody has complained, right? Motivation for my patch came from a
> question in IRC, I don't think there was a real need for more priority
> "space" in nat type chains. So while we may relax the restriction, I
> don't see the motivation to do so. :)

It is fine, this can be updated later. Please push it out because
release is coming.

It should be also possible to warn user via error reporting from
userspace.
