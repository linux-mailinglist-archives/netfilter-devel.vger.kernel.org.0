Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C46D3F08
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 Apr 2023 10:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjDCIdk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 Apr 2023 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjDCId0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:33:26 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B47B558A
        for <netfilter-devel@vger.kernel.org>; Mon,  3 Apr 2023 01:33:14 -0700 (PDT)
Date:   Mon, 3 Apr 2023 10:33:08 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Sven Auhagen <Sven.Auhagen@voleatech.de>,
        netfilter-devel@vger.kernel.org, abdelrahmanhesham94@gmail.com,
        ja@ssi.bg
Subject: Re: [PATCH v5] netfilter: nf_flow_table: count offloaded flows
Message-ID: <ZCqPRPaHuXXhjb66@salvia>
References: <20230317163300.gary4wtvrbyyhyow@Svens-MacBookPro.local>
 <ZCqOewgq0z9tGXi7@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZCqOewgq0z9tGXi7@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:29:47AM +0200, Florian Westphal wrote:
> Sven Auhagen <Sven.Auhagen@voleatech.de> wrote:
> > Change from v4:
> > 	* use per cpu counters instead of an atomic variable
> 
> > diff --git a/include/net/netns/flow_table.h b/include/net/netns/flow_table.h
> > index 1c5fc657e267..1496a6af6ac4 100644
> > --- a/include/net/netns/flow_table.h
> > +++ b/include/net/netns/flow_table.h
> > @@ -6,6 +6,8 @@ struct nf_flow_table_stat {
> >  	unsigned int count_wq_add;
> >  	unsigned int count_wq_del;
> >  	unsigned int count_wq_stats;
> > +	unsigned int count_flowoffload_add;
> > +	unsigned int count_flowoffload_del;
> 
> Do we really need new global stats for this?
> 
> Would it be possible to instead expose the existing ht->nelems during
> flowtable netlink dumps?
> 
> This way we do not need any new counters.

I would prefer a netlink interface for this too.
