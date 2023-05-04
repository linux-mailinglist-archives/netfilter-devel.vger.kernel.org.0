Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0082C6F04A8
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Apr 2023 13:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbjD0LCC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Apr 2023 07:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243304AbjD0LCB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:02:01 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 078854C09
        for <netfilter-devel@vger.kernel.org>; Thu, 27 Apr 2023 04:01:59 -0700 (PDT)
Date:   Thu, 27 Apr 2023 13:01:55 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH v2] netfilter: nf_tables: Introduce
 NFTA_RULE_ACTUAL_EXPR
Message-ID: <ZEpWIxsipUoH489w@calendula>
References: <Y94oUYqArYqhkmOX@salvia>
 <Y97HaXaEtIlFUQSJ@orbyte.nwl.cc>
 <Y+DN2miPlSlBAIaj@salvia>
 <Y+IrUPyJi/GE6Cbk@salvia>
 <Y+Iudd7MODhgjrgz@orbyte.nwl.cc>
 <Y+4LoOjaT1RU6I1r@orbyte.nwl.cc>
 <Y+4Tmv3H24XTiEhK@salvia>
 <Y+4cBvcq7tH2Iw2t@orbyte.nwl.cc>
 <ZEmCdMVboNu6dKiL@calendula>
 <ZEpVGpY3QzUwAMia@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZEpVGpY3QzUwAMia@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 27, 2023 at 12:57:30PM +0200, Phil Sutter wrote:
> Hi Pablo,
> 
> On Wed, Apr 26, 2023 at 09:58:44PM +0200, Pablo Neira Ayuso wrote:
> [...]
> > My proposal:
> 
> Thanks for returning to this. Your approach requires to define a minimum
> version from which on forward-compat is guaranteed. I was trying to
> avoid this requirement though so things would work for "unknown user
> space".

You also require a kernel that supports your approach.

> Currently, the only offending extension is ebt_among since it doesn't
> exist (and never did) in non-native form. If I implement among extension
> parsing (even in non-functional form), my original approach would work.
> This also means having a minimum version for full compat, but it affects
> ebtables (actually, use of ebt_among) only.

Yes, but this is fully user data, kernel really does not need to do
anything with this alternative representation, which is what I do not
like from you proposal.

I really think userdata is the place to deal with this.
