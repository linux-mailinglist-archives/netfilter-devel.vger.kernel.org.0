Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23855EE3D8
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Sep 2022 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiI1SF5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Sep 2022 14:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiI1SFy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:05:54 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CE9101961
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Sep 2022 11:05:51 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1odbRM-0002gP-95; Wed, 28 Sep 2022 20:05:48 +0200
Date:   Wed, 28 Sep 2022 20:05:48 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Florian Westphal <fwestpha@redhat.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] nft: Fix meta statement parsing
Message-ID: <YzSM/KSLYpHFzTIN@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Florian Westphal <fwestpha@redhat.com>,
        netfilter-devel@vger.kernel.org
References: <20220928162300.1055-1-phil@nwl.cc>
 <20220928175723.GN12777@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928175723.GN12777@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 28, 2022 at 07:57:23PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > The function nft_meta_set_to_target() would always bail since nothing
> > sets 'sreg->meta_sreg.set' to true. This is obvious, as the immediate
> > expression "filling" the source register does not indicate its purpose.
> 
> Hmm, is there a missing test case?  I did not see any failures.

extensions/libxt_TRACE.t was failing if I called iptables-test.py with
'-n' option.

> > The whole source register purpose storing in meta_sreg seems to be
> > pointless, so drop it altogether.
> 
> Yes; from iptables perspective a 'meta set' operation has to be mapped
> to a target, so there is no need to store this for subsequent
> consumption.

OK, cool. I'll push this all upstream now. :)

Thanks, Phil
