Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C384BC8C6
	for <lists+netfilter-devel@lfdr.de>; Sat, 19 Feb 2022 15:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiBSODQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 19 Feb 2022 09:03:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiBSODP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:03:15 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FE75AEF5
        for <netfilter-devel@vger.kernel.org>; Sat, 19 Feb 2022 06:02:56 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1nLQK6-0002z7-7Y; Sat, 19 Feb 2022 15:02:54 +0100
Date:   Sat, 19 Feb 2022 15:02:54 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH] netfilter: conntrack: Relax helper
 auto-assignment warning for nftables
Message-ID: <YhD4jmfJE1MSdnzg@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20220219132024.29328-1-phil@nwl.cc>
 <20220219132547.GA27537@breakpoint.cc>
 <YhDxiXjhNrPLW9Oc@orbyte.nwl.cc>
 <20220219134159.GB27537@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219134159.GB27537@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Feb 19, 2022 at 02:41:59PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > I tried, but nf_ct_pernet() is not usable from module context, or
> > actually symbol nf_conntrack_net_id. So I had to introduce a routine to
> > set the value. On the other hand I didn't like the fact that it would
> > permanently disable the warning even after 'nft flush ruleset'
> > (nit-picking).
> > I can recover that approach and send a v2 if you think (re-)using refcnt
> > is a bad idea here.
> 
> I think its a good idea to add a helper function disable the warning.
> 
> We can also call it from xt_CT.c.

OK, I'll prepare a v2. Thanks!
