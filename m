Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503897E071F
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Nov 2023 17:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbjKCQ7o (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Nov 2023 12:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbjKCQ7n (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:59:43 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889C6125
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 09:59:41 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qyxWF-0006ze-Pa; Fri, 03 Nov 2023 17:59:39 +0100
Date:   Fri, 3 Nov 2023 17:59:39 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Thomas Haller <thaller@redhat.com>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v3 2/2] json: drop warning on stderr for missing
 json() hook in stmt_print_json()
Message-ID: <20231103165939.GG8035@breakpoint.cc>
References: <20231103162937.3352069-1-thaller@redhat.com>
 <20231103162937.3352069-3-thaller@redhat.com>
 <ZUUkA43oAM7XO7LU@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUUkA43oAM7XO7LU@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Fri, Nov 03, 2023 at 05:25:14PM +0100, Thomas Haller wrote:
> > diff --git a/src/statement.c b/src/statement.c
> > index f5176e6d87f9..d52b01b9099a 100644
> > --- a/src/statement.c
> > +++ b/src/statement.c
> > @@ -141,6 +141,7 @@ static const struct stmt_ops chain_stmt_ops = {
> >  	.type		= STMT_CHAIN,
> >  	.name		= "chain",
> >  	.print		= chain_stmt_print,
> > +	.json		= NULL, /* BUG: must be implemented! */
> 
> This is a bit starting the house from the roof.
> 
> Better fix this first, so this ugly patch does not need to be applied.

Agreed, I would keep the fprintf and all the fallback print code.
We can remove this AFTER expternal means (unit test f.e.) ensure all the
stmt/expr_ops have the needed callbacks.
