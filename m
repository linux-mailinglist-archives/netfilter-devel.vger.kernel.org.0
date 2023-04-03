Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD96D3F6F
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 Apr 2023 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjDCIuy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 Apr 2023 04:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjDCIux (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:50:53 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 316F183FC
        for <netfilter-devel@vger.kernel.org>; Mon,  3 Apr 2023 01:50:51 -0700 (PDT)
Date:   Mon, 3 Apr 2023 10:50:47 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Sven Auhagen <Sven.Auhagen@voleatech.de>,
        netfilter-devel@vger.kernel.org, abdelrahmanhesham94@gmail.com,
        ja@ssi.bg
Subject: Re: [PATCH v5] netfilter: nf_flow_table: count offloaded flows
Message-ID: <ZCqTZ6XK/vb87Hyt@salvia>
References: <20230317163300.gary4wtvrbyyhyow@Svens-MacBookPro.local>
 <ZCqOewgq0z9tGXi7@strlen.de>
 <ZCqPRPaHuXXhjb66@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZCqPRPaHuXXhjb66@salvia>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:33:11AM +0200, Pablo Neira Ayuso wrote:
> On Mon, Apr 03, 2023 at 10:29:47AM +0200, Florian Westphal wrote:
> > Sven Auhagen <Sven.Auhagen@voleatech.de> wrote:
> > > Change from v4:
> > > 	* use per cpu counters instead of an atomic variable
> > 
> > > diff --git a/include/net/netns/flow_table.h b/include/net/netns/flow_table.h
> > > index 1c5fc657e267..1496a6af6ac4 100644
> > > --- a/include/net/netns/flow_table.h
> > > +++ b/include/net/netns/flow_table.h
> > > @@ -6,6 +6,8 @@ struct nf_flow_table_stat {
> > >  	unsigned int count_wq_add;
> > >  	unsigned int count_wq_del;
> > >  	unsigned int count_wq_stats;
> > > +	unsigned int count_flowoffload_add;
> > > +	unsigned int count_flowoffload_del;
> > 
> > Do we really need new global stats for this?
> > 
> > Would it be possible to instead expose the existing ht->nelems during
> > flowtable netlink dumps?
> > 
> > This way we do not need any new counters.
> 
> I would prefer a netlink interface for this too.

I can post a sketch code to make it easier for v6.
