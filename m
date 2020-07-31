Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E1623447D
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 Jul 2020 13:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbgGaLVh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 31 Jul 2020 07:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgGaLVh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:21:37 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9093AC061574
        for <netfilter-devel@vger.kernel.org>; Fri, 31 Jul 2020 04:21:36 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1k1T6U-00015K-JR; Fri, 31 Jul 2020 13:21:34 +0200
Date:   Fri, 31 Jul 2020 13:21:34 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] nft: Eliminate table list from cache
Message-ID: <20200731112134.GA13697@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200730135710.23076-1-phil@nwl.cc>
 <20200730192554.GA5322@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730192554.GA5322@salvia>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Thu, Jul 30, 2020 at 09:25:54PM +0200, Pablo Neira Ayuso wrote:
> On Thu, Jul 30, 2020 at 03:57:10PM +0200, Phil Sutter wrote:
> > The full list of tables in kernel is not relevant, only those used by
> > iptables-nft and for those, knowing if they exist or not is sufficient.
> > For holding that information, the already existing 'table' array in
> > nft_cache suits well.
> > 
> > Consequently, nft_table_find() merely checks if the new 'exists' boolean
> > is true or not and nft_for_each_table() iterates over the builtin_table
> > array in nft_handle, additionally checking the boolean in cache for
> > whether to skip the entry or not.
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> >  iptables/nft-cache.c | 73 +++++++++++---------------------------------
> >  iptables/nft-cache.h |  9 ------
> >  iptables/nft.c       | 55 +++++++++------------------------
> >  iptables/nft.h       |  2 +-
> >  4 files changed, 34 insertions(+), 105 deletions(-)
> 
> This diffstat looks interesting :-)

As promised, I wanted to leverage your change for further optimization,
but ended up optimizing your code out along with the old one. :D

> One question:
> 
>         c->table[i].exists = true;
> 
> then we assume this table is still in the kernel and we don't recheck?

Upon each COMMIT line, nft_action() calls nft_release_cache(). This will
also reset the 'exists' value to false.

> I mean, if you pipe command to an open process running
> iptables-restore (which has been the recommended interface for years
> to avoid of the overhead of system() invocation and to ensure atomic
> updates), is there any cache this new approach might get out of sync?

This is not just a problem of iptables-restore running in a pipe -
restoring a large ruleset (or just pure coincidence) could lead to the
same result.

Playing with 'iptables-nft-restore --noflush' reading from stdin and
calling 'nft flush ruleset' in a second shell right before entering
'COMMIT' leads to funny errors. This is not related to the table list
elimination though. I'll investigate.

Cheers, Phil
