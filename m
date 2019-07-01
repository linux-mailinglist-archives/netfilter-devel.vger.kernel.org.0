Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B05A4ED6D
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Jun 2019 18:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfFUQum (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Jun 2019 12:50:42 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43964 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbfFUQum (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:50:42 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1heMkK-00012M-E1; Fri, 21 Jun 2019 18:50:40 +0200
Date:   Fri, 21 Jun 2019 18:50:40 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft,v2] ct: support for NFT_CT_{SRC,DST}_{IP,IP6}
Message-ID: <20190621165040.vnfdupelj2riwz37@breakpoint.cc>
References: <20190621162934.6953-1-pablo@netfilter.org>
 <20190621164514.o4ljon5nqvkgjy52@breakpoint.cc>
 <20190621164853.aq42prnxia6h3qvs@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621164853.aq42prnxia6h3qvs@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Fri, Jun 21, 2019 at 06:45:14PM +0200, Florian Westphal wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > diff --git a/tests/py/inet/ct.t.json.output b/tests/py/inet/ct.t.json.output
> > > index 8b71519e9be7..74c436a3a79e 100644
> > > --- a/tests/py/inet/ct.t.json.output
> > > +++ b/tests/py/inet/ct.t.json.output
> > > @@ -5,7 +5,6 @@
> > >              "left": {
> > >                  "ct": {
> > >                      "dir": "original",
> > > -                    "family": "ip",
> > >                      "key": "saddr"
> > 
> > Should that be "ip saddr"?
> > Or is a plain "saddr" without family now implicitly ipv4?
> 
> In this patch, the old way (NFT_CT_SRC) still works via dependency:
> 
> # meta nfproto ipv4 ct original saddr 1.2.3.4
> 
> If someone with kernel < 4.17 needs to match on ct address, it can
> still use it this way.
> 
> set, map and concatenations are broken anyway, so I would just expect
> users with simple rules that refer to something like this.

Oh, sorry, I should have checked the .t.json context.

All is good then.
