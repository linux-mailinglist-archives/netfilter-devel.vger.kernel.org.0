Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3091F30A96B
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Feb 2021 15:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhBAOOO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Feb 2021 09:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhBAOOE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:14:04 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A7FC061573
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Feb 2021 06:13:23 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1l6ZxC-00023k-42; Mon, 01 Feb 2021 15:13:22 +0100
Date:   Mon, 1 Feb 2021 15:13:22 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nftables: introduce table ownership
Message-ID: <20210201141322.GH12443@breakpoint.cc>
References: <20210127021928.2444-1-pablo@netfilter.org>
 <20210201122455.GE12443@breakpoint.cc>
 <20210201134813.GA24566@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201134813.GA24566@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > At least for systemd use case, there would be a need to allow
> > add/removal of set elements from other user.
> 
> Then, probably a flag for this? Such flag would work like this?
> 
> - Allow for set element updates (from any process, no ownership).
> - nft flush ruleset skips flushing the set.
> - nft flush set x y flushes the content of this set.

Right, i'd suggest some permission set that tells what is (dis)allowed.

> Would this work for the scenario you describe below?

I think so.  We can add this later.

> > > +		    nft_active_genmask(table, genmask)) {
> > > +			if (nlpid && table->nlpid && table->nlpid != nlpid)
> > > +				return ERR_PTR(-EPERM);
> > > +
> > 
> > i.e., (table->flags & OWNED) && table->nlpid != nlpid)?
> > 
> > On netlink sk destruction the owner flag could be cleared or table
> > could be auto-zapped.
> 
> Default behaviour right now is: table is released if owner is gone.

I think thats fine.
