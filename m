Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D08E24FDF0
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Aug 2020 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgHXMjm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Aug 2020 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXMjl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:39:41 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E77C061573
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Aug 2020 05:39:40 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kABl9-0002uZ-UK; Mon, 24 Aug 2020 14:39:35 +0200
Date:   Mon, 24 Aug 2020 14:39:35 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
Subject: Re: nfnetlink: Busy-loop in nfnetlink_rcv_msg()
Message-ID: <20200824123935.GJ15804@breakpoint.cc>
References: <20200821230615.GW23632@orbyte.nwl.cc>
 <20200822184621.GH15804@breakpoint.cc>
 <20200824104746.GA22845@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824104746.GA22845@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > We can of course also intercept -EAGAIN in nf_tables_api.c and translate
> > it to -ENOBUFS like in nft_get_set_elem().
> > 
> > But I think a generic solution it better.  The call_rcu backends should
> > not result in changes to nf_tables internal state so they do not load
> > modules and therefore don't need a restart.
> 
> Handling this from the core would be better, so people don't have to
> remember to use the nfnetlink_unicast() that I'm proposing.

Your patch looks good to me.

> Looking at the tree, call_rcu is not enough to assume this: there are
> several nfnetlink subsystems calling netlink_unicast() that translate
> EAGAIN to ENOBUFS, from .call and .call_rcu. The way to identify this
> would be to decorate callbacks to know what are specifically GET
> commands.

?  Which .call_rcu is NOT "passive" (does not just peek at things) and,
more specifically, which .call_rcu depends on -EAGAIN requiring a
tansaction replay?
