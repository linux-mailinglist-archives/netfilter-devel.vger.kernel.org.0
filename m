Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B051C2BFD41
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Nov 2020 01:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKWANX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 22 Nov 2020 19:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgKWANX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 22 Nov 2020 19:13:23 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64218C0613CF
        for <netfilter-devel@vger.kernel.org>; Sun, 22 Nov 2020 16:13:23 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kgzTt-0007zY-Ve; Mon, 23 Nov 2020 01:13:22 +0100
Date:   Mon, 23 Nov 2020 01:13:21 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] tests: shell: Stabilize
 nft-only/0009-needless-bitwise_0
Message-ID: <20201123001321.GQ11766@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20201120175757.8063-1-phil@nwl.cc>
 <20201120185000.GA17769@salvia>
 <20201120193723.GN11766@orbyte.nwl.cc>
 <20201121121154.GA21180@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121121154.GA21180@salvia>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Sat, Nov 21, 2020 at 01:11:54PM +0100, Pablo Neira Ayuso wrote:
> On Fri, Nov 20, 2020 at 08:37:23PM +0100, Phil Sutter wrote:
> > Hi,
> > 
> > On Fri, Nov 20, 2020 at 07:50:00PM +0100, Pablo Neira Ayuso wrote:
> > > On Fri, Nov 20, 2020 at 06:57:57PM +0100, Phil Sutter wrote:
> > > > Netlink debug output varies depending on host's endianness and therefore
> > > > the test fails on Big Endian machines. Since for the sake of asserting
> > > > no needless bitwise expressions in output the actual data values are not
> > > > relevant, simply crop the output to just the expression names.
> > > 
> > > Probably we can fix this in libnftnl before we apply patches like this
> > > to nft as well?
> > 
> > You're right, ignoring the problems in nft testsuite is pretty
> > inconsistent. OTOH this is the first test that breaks iptables testsuite
> > on Big Endian while nft testsuite is entirely broken. ;)
> 
> Do you think we can fix this from the testsuite site? It would require
> to replicate payload files. The snprintf printing is used for
> debugging only at this stage. That would fix nft and this specific case.
> 
> > I had a look at libnftnl and it seems like even kernel support is needed
> > to carry the endianness info from input to output. IMHO data should be
> > in a consistent format in netlink messages, but I fear we can't change
> > this anymore. I tried to print the data byte-by-byte, but we obviously
> > still get problems with any data in host byte order. Do you see an
> > easier way to fix this than adding extra info to all expressions
> > containing data?
> 
> Probably we can make assumptions based on context, such as payload
> expression always express things in network byte order, and annotate
> that such register stores something in network byteorder. For meta,
> assume host byte order. Unless there is an explicit byteorder
> expression.

I like this simple approach, but it's not easy to implement: libnftnl
doesn't know about other expressions, so 'cmp' for instance doesn't know
which expression stored data in reg 1 and therefore can't deduce the
likely endianness of its stored data.

Any idea how to solve that?

Thanks, Phil
