Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935327BFFDC
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Oct 2023 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjJJO60 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Oct 2023 10:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjJJO6Z (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:58:25 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D4C6
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Oct 2023 07:58:23 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qqEBg-0004W7-NV; Tue, 10 Oct 2023 16:58:21 +0200
Date:   Tue, 10 Oct 2023 16:58:20 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] doc: remove references to timeout in reset command
Message-ID: <ZSVmjCI7mPy44lIT@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20231010142704.54741-1-pablo@netfilter.org>
 <ZSVgOhTI8mWeeNIp@orbyte.nwl.cc>
 <20231010144813.GA1407@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010144813.GA1407@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 10, 2023 at 04:48:13PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > On Tue, Oct 10, 2023 at 04:27:04PM +0200, Pablo Neira Ayuso wrote:
> > > After Linux kernel's patch ("netfilter: nf_tables: do not refresh
> > > timeout when resetting element") timers are not reset anymore, update
> > > documentation to keep this in sync.
> > 
> > How is limit statement being reset? The dump callbacks in nft_limit.c
> > ignore the 'bool reset' parameter.
> 
> Was that deliberate?  I don't see why it would be exempt?

One could reset internal tokens and last values, indeed. I don't see a
patch pending to do that, though.

BTW: nft also does not support for 'reset limit(s)'.

Cheers, Phil
