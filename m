Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BAA7D7E3D
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Oct 2023 10:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbjJZIPn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Oct 2023 04:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344552AbjJZIPk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:15:40 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003CEDE
        for <netfilter-devel@vger.kernel.org>; Thu, 26 Oct 2023 01:15:35 -0700 (PDT)
Received: from [78.30.35.151] (port=41428 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qvvWd-001FkA-A9; Thu, 26 Oct 2023 10:15:33 +0200
Date:   Thu, 26 Oct 2023 10:15:30 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [nf-next PATCH v3 3/3] netfilter: nf_tables: Add locking for
 NFT_MSG_GETOBJ_RESET requests
Message-ID: <ZTogIgkfTpZAJy30@calendula>
References: <20231025200828.5482-1-phil@nwl.cc>
 <20231025200828.5482-4-phil@nwl.cc>
 <ZTmB2yBSAa1KVexW@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTmB2yBSAa1KVexW@calendula>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Cc'ing Florian.

On Wed, Oct 25, 2023 at 11:00:14PM +0200, Pablo Neira Ayuso wrote:
> On Wed, Oct 25, 2023 at 10:08:28PM +0200, Phil Sutter wrote:
> > Objects' dump callbacks are not concurrency-safe per-se with reset bit
> > set. If two CPUs perform a reset at the same time, at least counter and
> > quota objects suffer from value underrun.
> > 
> > Prevent this by introducing dedicated locking callbacks for nfnetlink
> > and the asynchronous dump handling to serialize access.
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> >  net/netfilter/nf_tables_api.c | 72 ++++++++++++++++++++++++++++-------
> >  1 file changed, 59 insertions(+), 13 deletions(-)
> > 
> > diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> > index 5f84bdd40c3f..245a2c5be082 100644
> > --- a/net/netfilter/nf_tables_api.c
> > +++ b/net/netfilter/nf_tables_api.c
> [...]
> > @@ -7832,16 +7876,18 @@ static int nf_tables_getobj(struct sk_buff *skb, const struct nfnl_info *info,
> >  		return nft_netlink_dump_start_rcu(info->sk, skb, info->nlh, &c);
> >  	}
> >  
> > -	if (NFNL_MSG_TYPE(info->nlh->nlmsg_type) == NFT_MSG_GETOBJ_RESET)
> > -		reset = true;
> > +	if (!try_module_get(THIS_MODULE))
> > +		return -EINVAL;
> 
> For netlink dump path, __netlink_dump_start() already grabs a
> reference module this via c->module.
> 
> Why is this module reference needed for getting one object? This does
> not follow netlink dump path, it creates the skb and it returns
> inmediately.

nfnetlink callbacks use nfnetlink_get_subsys() which use
rcu_dereference() to fetch the nfnetlink_subsystem callbacks. In
nfnetlink_rcv_batch() the ss pointer is fetched at the beginning of
the batch processing.

But then, if rcu_read_unlock() is released, then:

        const struct nfnetlink_subsystem *ss;

could become stale and refetch is needed because rcu read side lock
was released, so next iteration on the skb to process the next
nlmsghdr could be using stale pointers.

Could you please have a second look to confirm this?

Thanks!
