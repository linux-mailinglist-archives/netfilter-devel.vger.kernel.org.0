Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003996D3EF7
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 Apr 2023 10:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjDCI3y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 Apr 2023 04:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjDCI3w (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:29:52 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C845149C2
        for <netfilter-devel@vger.kernel.org>; Mon,  3 Apr 2023 01:29:50 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pjFZT-0002LZ-6d; Mon, 03 Apr 2023 10:29:47 +0200
Date:   Mon, 3 Apr 2023 10:29:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Sven Auhagen <Sven.Auhagen@voleatech.de>
Cc:     netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        abdelrahmanhesham94@gmail.com, ja@ssi.bg
Subject: Re: [PATCH v5] netfilter: nf_flow_table: count offloaded flows
Message-ID: <ZCqOewgq0z9tGXi7@strlen.de>
References: <20230317163300.gary4wtvrbyyhyow@Svens-MacBookPro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317163300.gary4wtvrbyyhyow@Svens-MacBookPro.local>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sven Auhagen <Sven.Auhagen@voleatech.de> wrote:
> Change from v4:
> 	* use per cpu counters instead of an atomic variable

> diff --git a/include/net/netns/flow_table.h b/include/net/netns/flow_table.h
> index 1c5fc657e267..1496a6af6ac4 100644
> --- a/include/net/netns/flow_table.h
> +++ b/include/net/netns/flow_table.h
> @@ -6,6 +6,8 @@ struct nf_flow_table_stat {
>  	unsigned int count_wq_add;
>  	unsigned int count_wq_del;
>  	unsigned int count_wq_stats;
> +	unsigned int count_flowoffload_add;
> +	unsigned int count_flowoffload_del;

Do we really need new global stats for this?

Would it be possible to instead expose the existing ht->nelems during
flowtable netlink dumps?

This way we do not need any new counters.
