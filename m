Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76A74B47
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 12:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbfGYKOS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 06:14:18 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43794 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389419AbfGYKOR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:14:17 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hqalI-0001Kc-HB; Thu, 25 Jul 2019 12:14:12 +0200
Date:   Thu, 25 Jul 2019 12:14:12 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     wenxu@ucloud.cn, fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 3/7] netfilter: nft_table_offload: Add rtnl for
 chain and rule operations
Message-ID: <20190725101412.ubkqqzjkftrajnmx@breakpoint.cc>
References: <1563886364-11164-1-git-send-email-wenxu@ucloud.cn>
 <1563886364-11164-4-git-send-email-wenxu@ucloud.cn>
 <20190725094826.kv7cvjsiykuwr6em@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725094826.kv7cvjsiykuwr6em@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Tue, Jul 23, 2019 at 08:52:40PM +0800, wenxu@ucloud.cn wrote:
> > From: wenxu <wenxu@ucloud.cn>
> > 
> > The nft_setup_cb_call and ndo_setup_tc callback should be under rtnl lock
> > 
> > or it will report:
> > kernel: RTNL: assertion failed at
> > drivers/net/ethernet/mellanox/mlx5/core/en_rep.c (635)
> > 
> > Signed-off-by: wenxu <wenxu@ucloud.cn>
> > ---
> >  net/netfilter/nf_tables_offload.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> > index 33543f5..3e1a1a8 100644
> > --- a/net/netfilter/nf_tables_offload.c
> > +++ b/net/netfilter/nf_tables_offload.c
> > @@ -115,14 +115,18 @@ static int nft_setup_cb_call(struct nft_base_chain *basechain,
> >  			     enum tc_setup_type type, void *type_data)
> >  {
> >  	struct flow_block_cb *block_cb;
> > -	int err;
> > +	int err = 0;
> >  
> > +	rtnl_lock();
> 
> Please, have a look at 90d2723c6d4cb2ace50fc3b932a2bcc77710450b and
> review if this assumption is correct. Probably nfnl_lock() is missing
> from __nft_release_basechain().

The mlx driver has a ASSERT_RTNL() in the mlx5e_rep_indr_setup_tc_block()
callpath.  Or are you proposing to remove that assertion?  If so, what
lock should protect the callback lists?

