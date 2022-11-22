Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF0E634318
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Nov 2022 18:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiKVR5K (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Nov 2022 12:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiKVR4u (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:56:50 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DFB686B2
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Nov 2022 09:55:51 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1oxXUr-0007ib-Fj; Tue, 22 Nov 2022 18:55:49 +0100
Date:   Tue, 22 Nov 2022 18:55:49 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables-nft RFC 1/5] nft-shared: dump errors on stdout to
 garble output
Message-ID: <Y30NJTaQx8Wn7RLE@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20221121111932.18222-1-fw@strlen.de>
 <20221121111932.18222-2-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121111932.18222-2-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:19:28PM +0100, Florian Westphal wrote:
> Intentionally garble iptables-nft output if we cannot dissect
> an expression that we've just encountered, rather than dump an
> error message on stderr.
> 
> The idea here is that
> iptables-save | iptables-restore
> 
> will fail, rather than restore an incomplete ruleset.

What I don't like about this is that users won't notice the problem
until they try to restore the ruleset. For us it is clearly beneficial
to see where things break, but I doubt regular users care and we should
just tell them to stop mixing iptables and nft calls.

Can we maybe add "--force" to iptables-nft-save to make it print as much
as possible despite the table being considered incompatible? Not sure
how ugly this is to implement, though.

We still exit(0) in case parsing fails, BTW. Guess this is the most
important thing to fix despite all the above.

Thanks, Phil
