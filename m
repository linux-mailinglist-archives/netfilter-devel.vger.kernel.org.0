Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD96F092
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jul 2019 22:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfGTUNM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 16:13:12 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:48724 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfGTUNM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 16:13:12 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hovjC-0000wp-NB; Sat, 20 Jul 2019 22:13:10 +0200
Date:   Sat, 20 Jul 2019 22:13:10 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 09/12] xtables-save: Make COMMIT line optional
Message-ID: <20190720201310.5fuxgzlz5xi4kjpe@breakpoint.cc>
References: <20190720163026.15410-1-phil@nwl.cc>
 <20190720163026.15410-10-phil@nwl.cc>
 <20190720192918.ckfbq22si4tundhx@breakpoint.cc>
 <20190720201133.GE32501@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720201133.GE32501@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> On Sat, Jul 20, 2019 at 09:29:18PM +0200, Florian Westphal wrote:
> > Phil Sutter <phil@nwl.cc> wrote:
> > > Change xtables_save_main to support optional printing of COMMIT line as
> > > it is not used in arp- or ebtables.
> > 
> > Why?  Is this so ebt-save dumps are compatible with the
> > old ebt-restore?
> 
> Hmm. I haven't considered deviating in ebtables-nft-save format from
> legacy one yet, but it may actually be no problem given that people
> shouldn't switch between both. The only bummer might be if someone has a
> custom script which then trips over the unknown non-comment line.
> 
> I'm undecided, but not against "breaking" with legacy save dumps per se.
> If you think it's not a problem, we could just simplify things. OTOH
> this is not a big patch, either so maybe not even worth the risk. :)

I'm fine with this, I was just wondering because the changelog explains
whats happening, not why.
