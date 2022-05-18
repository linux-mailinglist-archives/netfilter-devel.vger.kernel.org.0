Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7543852B937
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbiERLsL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 07:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiERLsL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 07:48:11 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421BB179C19
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 04:48:09 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nrI9v-0000PD-CZ; Wed, 18 May 2022 13:48:07 +0200
Date:   Wed, 18 May 2022 13:48:07 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH] netfilter: nf_tables: restrict expression reduction to
 first expression
Message-ID: <20220518114807.GE4316@breakpoint.cc>
References: <20220518100842.1950-1-pablo@netfilter.org>
 <YoTPlIBany/aRvtK@orbyte.nwl.cc>
 <YoTSHls/on1S+/4N@salvia>
 <YoTbJTDxuQ131EDG@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoTbJTDxuQ131EDG@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> > > | reduce = reduce && expr->ops->type->reduce;
> > 
> > Could you elaborate?
> 
> Well, an expression which may set verdict register to NFT_BREAK should
> prevent reduction of later expressions in same rule as it may stop rule
> evaluation at run-time. This is obvious for nft_cmp, but nft_meta is
> also a candidate: NFT_META_IFTYPE causes NFT_BREAK if pkt->skb->dev is
> NULL. The optimizer must not assume later expressions are evaluated.

This all seems fragile to me, with huge potential to add subtle bugs
that will be hard to track down.
