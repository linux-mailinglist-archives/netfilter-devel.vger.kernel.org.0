Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C24316F094
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jul 2019 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfGTUPQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 16:15:16 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:41368 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfGTUPQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 16:15:16 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hovlC-0007hv-G5; Sat, 20 Jul 2019 22:15:14 +0200
Date:   Sat, 20 Jul 2019 22:15:14 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 09/12] xtables-save: Make COMMIT line optional
Message-ID: <20190720201514.GG32501@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190720163026.15410-1-phil@nwl.cc>
 <20190720163026.15410-10-phil@nwl.cc>
 <20190720192918.ckfbq22si4tundhx@breakpoint.cc>
 <20190720201133.GE32501@orbyte.nwl.cc>
 <20190720201310.5fuxgzlz5xi4kjpe@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720201310.5fuxgzlz5xi4kjpe@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jul 20, 2019 at 10:13:10PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > On Sat, Jul 20, 2019 at 09:29:18PM +0200, Florian Westphal wrote:
> > > Phil Sutter <phil@nwl.cc> wrote:
> > > > Change xtables_save_main to support optional printing of COMMIT line as
> > > > it is not used in arp- or ebtables.
> > > 
> > > Why?  Is this so ebt-save dumps are compatible with the
> > > old ebt-restore?
> > 
> > Hmm. I haven't considered deviating in ebtables-nft-save format from
> > legacy one yet, but it may actually be no problem given that people
> > shouldn't switch between both. The only bummer might be if someone has a
> > custom script which then trips over the unknown non-comment line.
> > 
> > I'm undecided, but not against "breaking" with legacy save dumps per se.
> > If you think it's not a problem, we could just simplify things. OTOH
> > this is not a big patch, either so maybe not even worth the risk. :)
> 
> I'm fine with this, I was just wondering because the changelog explains
> whats happening, not why.

Yes, typical pitfall for me. Maybe I should put a sticky note somewhere.
:)

Thanks, Phil
