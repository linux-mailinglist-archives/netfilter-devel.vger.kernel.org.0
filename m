Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43435C0EE
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jul 2019 18:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfGAQLo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Jul 2019 12:11:44 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:41288 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfGAQLl (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:11:41 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hhyu3-00061o-B5; Mon, 01 Jul 2019 18:11:39 +0200
Date:   Mon, 1 Jul 2019 18:11:39 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2] parser_bison: Accept arbitrary user-defined names
 by quoting
Message-ID: <20190701161139.GQ31548@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190624163608.17348-1-phil@nwl.cc>
 <20190628180051.47o27vbgqrsjpwab@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628180051.47o27vbgqrsjpwab@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Fri, Jun 28, 2019 at 08:00:51PM +0200, Pablo Neira Ayuso wrote:
> On Mon, Jun 24, 2019 at 06:36:08PM +0200, Phil Sutter wrote:
> > Parser already allows to quote user-defined strings in some places to
> > avoid clashing with defined keywords, but not everywhere. Extend this
> > support further and add a test case for it.
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> > Changes since v1:
> > - Fix testcase, I forgot to commit adjustments done to it.
> > 
> > Note: This is a reduced variant of "src: Quote user-defined names" sent
> >       back in January. Discussion was not conclusive regarding whether
> >       to quote these names on output or not, but I assume allowing for
> >       users to specify them by adding quotes is a step forward without
> >       drawbacks.
> 
> So this will fail later on, right?
> 
>         nft list ruleset > file.nft
>         nft -f file.nft

Yes, that's right. I sent a complete version which does the necessary
quoting on output in January[1], but discussion wasn't conclusive. You
had a different approach which accepts the quotes as part of the name
but you weren't happy with it, either. I *think* you wanted to search
for ways to solve this from within bison but we never got back to it
anymore.

This simplified patch is merely trying to make things consistent
regarding user-defined names. IIRC, I can already have an interface
named "month", use that in a netdev family chain declaration (quoted)
and 'nft list ruleset' will print it unquoted, so it can't be applied
anymore. Without my patch, it is simply impossible to use certain
recognized keywords as names for tables, chains, etc., even if one
accepted the implications it has.

Cheers, Phil

[1] Message-Id: <20190116184613.31698-1-phil@nwl.cc>
