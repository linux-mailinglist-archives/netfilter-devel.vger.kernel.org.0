Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84466F049B
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Apr 2023 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbjD0K5h (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Apr 2023 06:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbjD0K5g (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:57:36 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5359C4698
        for <netfilter-devel@vger.kernel.org>; Thu, 27 Apr 2023 03:57:32 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1przJa-0003ZK-BL; Thu, 27 Apr 2023 12:57:30 +0200
Date:   Thu, 27 Apr 2023 12:57:30 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH v2] netfilter: nf_tables: Introduce
 NFTA_RULE_ACTUAL_EXPR
Message-ID: <ZEpVGpY3QzUwAMia@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <Y900iRzf2q8xnXyv@orbyte.nwl.cc>
 <Y94oUYqArYqhkmOX@salvia>
 <Y97HaXaEtIlFUQSJ@orbyte.nwl.cc>
 <Y+DN2miPlSlBAIaj@salvia>
 <Y+IrUPyJi/GE6Cbk@salvia>
 <Y+Iudd7MODhgjrgz@orbyte.nwl.cc>
 <Y+4LoOjaT1RU6I1r@orbyte.nwl.cc>
 <Y+4Tmv3H24XTiEhK@salvia>
 <Y+4cBvcq7tH2Iw2t@orbyte.nwl.cc>
 <ZEmCdMVboNu6dKiL@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEmCdMVboNu6dKiL@calendula>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Wed, Apr 26, 2023 at 09:58:44PM +0200, Pablo Neira Ayuso wrote:
[...]
> My proposal:

Thanks for returning to this. Your approach requires to define a minimum
version from which on forward-compat is guaranteed. I was trying to
avoid this requirement though so things would work for "unknown user
space".

Currently, the only offending extension is ebt_among since it doesn't
exist (and never did) in non-native form. If I implement among extension
parsing (even in non-functional form), my original approach would work.
This also means having a minimum version for full compat, but it affects
ebtables (actually, use of ebt_among) only.

Cheers, Phil
