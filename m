Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5768A940
	for <lists+netfilter-devel@lfdr.de>; Sat,  4 Feb 2023 10:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjBDJlo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 4 Feb 2023 04:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjBDJln (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 4 Feb 2023 04:41:43 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCBD92E0D5
        for <netfilter-devel@vger.kernel.org>; Sat,  4 Feb 2023 01:41:42 -0800 (PST)
Date:   Sat, 4 Feb 2023 10:41:37 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH v2] netfilter: nf_tables: Introduce
 NFTA_RULE_ACTUAL_EXPR
Message-ID: <Y94oUYqArYqhkmOX@salvia>
References: <20221221142221.27211-1-phil@nwl.cc>
 <Y7/drsGvc8MkQiTY@orbyte.nwl.cc>
 <Y7/pzxvu2v4t4PgZ@salvia>
 <Y7/2843ObHqTDIFQ@orbyte.nwl.cc>
 <Y8fe9+XHbxYyD4LY@salvia>
 <Y8f4pNIcb2zH9QqZ@orbyte.nwl.cc>
 <Y9wrzkablavNnUXl@salvia>
 <Y90QrjOONoZmcCZL@orbyte.nwl.cc>
 <Y90o8eq3egHbtC3Z@salvia>
 <Y900iRzf2q8xnXyv@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y900iRzf2q8xnXyv@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 03, 2023 at 05:21:29PM +0100, Phil Sutter wrote:
[...]
> On Fri, Feb 03, 2023 at 04:32:01PM +0100, Pablo Neira Ayuso wrote:
[...]
> > I also wonder if this might cause problems with nftables and implicit
> > sets, they are bound to one single lookup expression that, when gone,
> > the set is released. Now you will have two expressions pointing to an
> > implicit set. Same thing with implicit chains. This might get tricky
> > with the transaction interface.
> 
> While indeed two lookup expressions will refer to the same anonymous
> set, only one of those expressions will ever be in use. There's no way
> the kernel would switch between rule variants (or use both at the same
> time).

OK, but control plane will reject two lookup expressions that refer to
the same anonymous set.

> > iptables is rather simple representation (no sets), but nftables is
> > more expressive.
> 
> That's not true, at least ebtables' among match is implemented using
> sets. :)

Then better have a look at this implicit set scenario I describe above
because I cannot see how this can work.
