Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2D75EE84C
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Sep 2022 23:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiI1V1P (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Sep 2022 17:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiI1V1O (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:27:14 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD2696EA
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Sep 2022 14:27:13 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1odeaD-0006vs-BL; Wed, 28 Sep 2022 23:27:09 +0200
Date:   Wed, 28 Sep 2022 23:27:09 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Florian Westphal <fwestpha@redhat.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] nft: Fix meta statement parsing
Message-ID: <20220928212709.GO12777@breakpoint.cc>
References: <20220928162300.1055-1-phil@nwl.cc>
 <20220928175723.GN12777@breakpoint.cc>
 <YzSM/KSLYpHFzTIN@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzSM/KSLYpHFzTIN@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> On Wed, Sep 28, 2022 at 07:57:23PM +0200, Florian Westphal wrote:
> > Phil Sutter <phil@nwl.cc> wrote:
> > > The function nft_meta_set_to_target() would always bail since nothing
> > > sets 'sreg->meta_sreg.set' to true. This is obvious, as the immediate
> > > expression "filling" the source register does not indicate its purpose.
> > 
> > Hmm, is there a missing test case?  I did not see any failures.
> 
> extensions/libxt_TRACE.t was failing if I called iptables-test.py with
> '-n' option.

Argh, I only tested classic :-(

> > Yes; from iptables perspective a 'meta set' operation has to be mapped
> > to a target, so there is no need to store this for subsequent
> > consumption.
> 
> OK, cool. I'll push this all upstream now. :)

Thanks!
