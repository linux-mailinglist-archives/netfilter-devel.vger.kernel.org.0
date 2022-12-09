Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551466486B8
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Dec 2022 17:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLIQqI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 9 Dec 2022 11:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLIQpx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:45:53 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3912E6A1
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Dec 2022 08:45:50 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1p3gVQ-0004jx-Mm; Fri, 09 Dec 2022 17:45:48 +0100
Date:   Fri, 9 Dec 2022 17:45:48 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nft PATCH 3/4] xt: Rewrite unsupported compat expression dumping
Message-ID: <Y5NmPEyyWFMe6q8P@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20221124165641.26921-1-phil@nwl.cc>
 <20221124165641.26921-4-phil@nwl.cc>
 <Y5NdNmKQrlRAKRfm@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5NdNmKQrlRAKRfm@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Dec 09, 2022 at 05:07:18PM +0100, Pablo Neira Ayuso wrote:
> On Thu, Nov 24, 2022 at 05:56:40PM +0100, Phil Sutter wrote:
> > Choose a format which provides more information and is easily parseable.
> > Then teach parsers about it and make it explicitly reject the ruleset
> > giving a meaningful explanation. Also update the man pages with some
> > more details.
> 
> There is a bugzilla ticket related to xt and json support, you can
> probably add a Closes: tag link.

This should be nfbz#1621, but it's about translating xt to native in
JSON format. All my patch does is extend the xt JSON format a bit. AIUI,
we would have to extend libxtables to provide translations into JSON.

So even with perfect two-ways translation available, JSON interface is
unusable if iptables-nft is in use.

Cheers, Phil
