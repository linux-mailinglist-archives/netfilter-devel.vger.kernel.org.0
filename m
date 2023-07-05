Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF83748ED8
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Jul 2023 22:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjGEUXc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Jul 2023 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjGEUXa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:23:30 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3C41985;
        Wed,  5 Jul 2023 13:23:29 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qH927-0000NS-Ph; Wed, 05 Jul 2023 22:23:27 +0200
Date:   Wed, 5 Jul 2023 22:23:27 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: Re: [PATCH -stable,5.15 2/2] netfilter: nf_tables: unbind
 non-anonymous set if rule construction fails
Message-ID: <20230705202327.GH3751@breakpoint.cc>
References: <20230705141411.53123-1-pablo@netfilter.org>
 <20230705141411.53123-3-pablo@netfilter.org>
 <2023070533-swimwear-audition-49e8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023070533-swimwear-audition-49e8@gregkh>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Jul 05, 2023 at 04:14:11PM +0200, Pablo Neira Ayuso wrote:
> > [ 3e70489721b6c870252c9082c496703677240f53 ]
> > 
> > Otherwise a dangling reference to a rule object that is gone remains
> > in the set binding list.
> > 
> > Fixes: 26b5a5712eb8 ("netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain")
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> >  net/netfilter/nf_tables_api.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> But what about kernels newer than 5.15?  Surely this is also needed
> there as this only is going to first show up in 6.5-rc1, which hasn't
> been released yet.

Yes, do you need a backport? The commit cherry-picks cleanly to
6.1.y, 6.2.y and 6.3.y.
