Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EA66F8514
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 May 2023 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjEEOvc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 May 2023 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjEEOvb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 May 2023 10:51:31 -0400
Received: from Chamillionaire.breakpoint.cc (unknown [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08731635B
        for <netfilter-devel@vger.kernel.org>; Fri,  5 May 2023 07:51:29 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1puwm9-0006cb-EO; Fri, 05 May 2023 16:51:13 +0200
Date:   Fri, 5 May 2023 16:51:13 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/3] netfilter: nf_tables: reject loads from
 uninitialized registers
Message-ID: <20230505145113.GD6126@breakpoint.cc>
References: <20230505111656.32238-1-fw@strlen.de>
 <ZFUTfE/u4q34TTDY@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFUTfE/u4q34TTDY@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Fri, May 05, 2023 at 01:16:53PM +0200, Florian Westphal wrote:
> > Keep a per-rule bitmask that tracks registers that have seen a store,
> > then reject loads when the accessed registers haven't been flagged.
> > 
> > This changes uabi contract, because we previously allowed this.
> > Neither nftables nor iptables-nft create such rules.
> > 
> > In case there is breakage, we could insert an 'store 0 to x'
> > immediate expression into the ruleset automatically, but this
> > isn't done here.
> > 
> > Let me know if you think the "refuse" approach is too risky.
> 
> Might the NFT_BREAK case defeat this approach? Sequence is:
> 
> 1) expression that writes on register hits NFT_BREAK (nothing is written)
> 2) expression that read from register, it reads uninitialized data.
>
> From ruleset load step, we cannot know if the write fails, because it
> is subject to NFT_BREAK.

Yes, but its irrelevant: If 1) issues NFT_BREAK, 2) won't execute.
