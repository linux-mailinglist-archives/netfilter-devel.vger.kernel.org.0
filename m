Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC25D74D5FD
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Jul 2023 14:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGJMty (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Jul 2023 08:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGJMty (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:49:54 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D16A7
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jul 2023 05:49:52 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qIqKs-0004l8-FK; Mon, 10 Jul 2023 14:49:50 +0200
Date:   Mon, 10 Jul 2023 14:49:50 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Igor Raits <igor@gooddata.com>, netfilter-devel@vger.kernel.org
Subject: Re: ebtables-nft can't delete complex rules by specifying complete
 rule with kernel 6.3+
Message-ID: <20230710124950.GC12203@breakpoint.cc>
References: <CA+9S74jbOefRzu1YxUrXC7gbYY8xDKH6QNJBuAQoNnnLODxWrg@mail.gmail.com>
 <20230710112135.GA12203@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710112135.GA12203@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> Igor Raits <igor@gooddata.com> wrote:
> > Hello,
> > 
> > We started to observe the issue regarding ebtables-nft and how it
> > can't wipe rules when specifying full rule. Removing the rule by index
> > works fine, though. Also with kernel 6.1.y it works completely fine.
> > 
> > I've started with 1.8.8 provided in CentOS Stream 9, then tried the
> > latest git version and all behave exactly the same. See the behavior
> > below. As you can see, simple DROP works, but more complex one do not.
> > 
> > As bugzilla requires some special sign-up procedure, apologize for
> > reporting it directly here in the ML.
> 
> Thanks for the report, I'll look into it later today.

Its a bug in ebtables-nft, it fails to delete the rule since

938154b93be8cd611ddfd7bafc1849f3c4355201,
netfilter: nf_tables: reject unbound anonymous set before commit phase

But its possible do remove the rule via
nft delete rule .. handle $x

so the breakge is limited to ebtables-nft.
