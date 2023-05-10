Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D737A6FD8E1
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 May 2023 10:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbjEJIGk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 May 2023 04:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbjEJIGg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 May 2023 04:06:36 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE3A1FC7
        for <netfilter-devel@vger.kernel.org>; Wed, 10 May 2023 01:06:34 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pweqG-0004sK-8O; Wed, 10 May 2023 10:06:32 +0200
Date:   Wed, 10 May 2023 10:06:32 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/3] netfilter: nf_tables: reject loads from
 uninitialized registers
Message-ID: <20230510080632.GB21949@breakpoint.cc>
References: <20230505111656.32238-1-fw@strlen.de>
 <ZFUTfE/u4q34TTDY@calendula>
 <20230505145113.GD6126@breakpoint.cc>
 <ZFUh6r8BrMefU7G6@calendula>
 <20230507112254.GA18570@breakpoint.cc>
 <ZFtOQEZmKEZ2VHPE@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFtOQEZmKEZ2VHPE@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Hmm, this will get messy.
> > 
> > I only see two alternatives:
> > 
> > - place the bitmask in the pernet structure.
> > - add struct nft_expr_ctx as a container structure, which has
> >   nft_ctx as first member and the bitmask as second member, to
> >   be used for NEWRULE and NEWSETELEM instead of nft_ctx.
> 
> Can the 'level' field be moved to this nft_expr_ctx structure? This
> field is only used from the preparation phase (not in the commit
> phase).
> 
> Probably we need to rename nft_ctx to nft_trans_ctx, so it contains
> the fields that are needed from the commit phase. Then, re-add a
> nft_ctx again which contains nft_trans_ctx at the beginning, then the
> register bitmap and the level field. Thus, any future fields only
> required by preparation phase only will go in nft_ctx, and fields that
> are specifically are set up from preparation phase and consumed from
> commit step go in nft_trans_ctx.
> 
> It is a bit of churn, but it is probably good to tidy up this for
> future extensions?

Yes, its a lot of churn, I can have a look at how intrusive this will
be.  Problem is that we have a bunch of helpers that take
'struct nft_ctx *', which are fed via '&trans->ctx'.

I'd like to avoid 'union nf_ctx_any *' tricks...
