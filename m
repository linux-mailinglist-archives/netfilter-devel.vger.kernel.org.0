Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A866CF79
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jul 2019 16:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfGROMA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Jul 2019 10:12:00 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35562 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbfGROMA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:12:00 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1ho78X-0005Yh-HQ; Thu, 18 Jul 2019 16:11:57 +0200
Date:   Thu, 18 Jul 2019 16:11:57 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: json_cmd_assoc and cmd
Message-ID: <20190718141157.GH1628@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Jeremy Sowden <jeremy@azazel.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190716183101.pev5gcmk3agqwpsm@salvia>
 <20190716190224.GB31548@orbyte.nwl.cc>
 <20190716193903.44zquiylov2p452g@salvia>
 <20190718123704.GA31345@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718123704.GA31345@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Thu, Jul 18, 2019 at 01:37:04PM +0100, Jeremy Sowden wrote:
> On 2019-07-16, at 21:39:03 +0200, Pablo Neira Ayuso wrote:
> > BTW, not directly related to this, but isn't this strange?
> >
> >         list_for_each_entry(cmd, cmds, list) {
> >                 memset(&ctx, 0, sizeof(ctx));
> >                 ctx.msgs = msgs;
> >                 ctx.seqnum = cmd->seqnum = mnl_seqnum_alloc(&seqnum);
> >                 ctx.batch = batch;
> >                 ctx.nft = nft;
> >                 init_list_head(&ctx.list);
> >                 ret = do_command(&ctx, cmd);
> >                 ...
> >
> > ctx is reset over and over again. Then, recycled here:
> >
> >                 ret = mnl_batch_talk(&ctx, &err_list, num_cmds);
> >
> > I wonder if we can get this better.
> 
> Something like this?
> 
>         ...
> 	struct netlink_ctx ctx = { .msgs = msgs, .nft = nft };
>         ...
> 
> 	ctx.batch = batch = mnl_batch_init();
> 	batch_seqnum = mnl_batch_begin(batch, mnl_seqnum_alloc(&seqnum));
> 	list_for_each_entry(cmd, cmds, list) {
> 		ctx.seqnum = cmd->seqnum = mnl_seqnum_alloc(&seqnum);
> 		init_list_head(&ctx.list);
> 		ret = do_command(&ctx, cmd);
> 		...
> 	}

Yes, that at least simplifies the foreach loop a bit. I wonder though
if we could eliminate struct netlink_ctx altogether by moving pointers
into struct nft_ctx.

Pablo, do you think that's feasible?

Cheers, Phil
