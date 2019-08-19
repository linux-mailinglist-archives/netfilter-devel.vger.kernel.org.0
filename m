Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58508921C1
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Aug 2019 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfHSK73 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Aug 2019 06:59:29 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:55798 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbfHSK73 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:59:29 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1hzfNl-0003yn-MC; Mon, 19 Aug 2019 12:59:25 +0200
Date:   Mon, 19 Aug 2019 12:59:25 +0200
From:   Florian Westphal <fw@strlen.de>
To:     wenxu <wenxu@ucloud.cn>
Cc:     Florian Westphal <fw@strlen.de>, pablo@netfilter.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_table_offload: Fix the incorrect
 rcu usage in nft_indr_block_get_and_ing_cmd
Message-ID: <20190819105925.GB2588@breakpoint.cc>
References: <1566208007-22513-1-git-send-email-wenxu@ucloud.cn>
 <20190819102123.GA2588@breakpoint.cc>
 <2bde486e-dfe8-ad2b-8b77-babcad90d82e@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bde486e-dfe8-ad2b-8b77-babcad90d82e@ucloud.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

wenxu <wenxu@ucloud.cn> wrote:
> >> The nft_indr_block_get_and_ing_cmd is called in netdevice notify
> >> It is the incorrect rcu case, To fix it just traverse the list under
> >> the commit mutex.
> > What is an 'incorrect rcu case'?
> >
> > Please clarify, e.g. by including rcu warning/splat backtrace here.

[..]

> flow_block_ing_cmd() needs to call blocking functions while iterating block_ing_cb_list,
> nft_indr_block_get_and_ing_cmd is in the cb_list, So it should also not in rcu for blocking
> cases.

Please submit a v2 that includes this explanation in the commit message.

> >> +	struct nft_ctx ctx = {
> >> +		.net	= dev_net(dev),
> >> +	};
> > Why is this ctx needed?
> >
> >> +	mutex_lock(&ctx.net->nft.commit_mutex);
> > net->nft.commit_mutex?
> 
> When traverse the list, the list is protected under commit_mutex like nf_tables_netdev_event
> do in the netdevice notify callback

Yes, I see that, but why do you need nft_ctx ctx?  Its confusing.

Just use

mutex_lock(&net->nft.commit_mutex);

without adding this 'ctx'.
