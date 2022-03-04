Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707B34CD554
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Mar 2022 14:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiCDNmQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 4 Mar 2022 08:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiCDNmQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:42:16 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8C21B6E3C
        for <netfilter-devel@vger.kernel.org>; Fri,  4 Mar 2022 05:41:27 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1nQ8BR-0004pd-If; Fri, 04 Mar 2022 14:41:25 +0100
Date:   Fri, 4 Mar 2022 14:41:25 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] evaluate: init cmd pointer for new on-stack context
Message-ID: <YiIXBYZyMd8b5oKb@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20220304103634.13160-1-fw@strlen.de>
 <YiHv70Oqotbs5YCx@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiHv70Oqotbs5YCx@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:54:39AM +0100, Pablo Neira Ayuso wrote:
> On Fri, Mar 04, 2022 at 11:36:34AM +0100, Florian Westphal wrote:
> > else, this will segfault when trying to print the
> > "table 'x' doesn't exist" error message.
> 
> LGTM, thanks. One nitpick below:

This also fixes the segfault I was trying to avoid with my patch for
string_misspell_update(). I had definitely tried Florian's solution, but
it didn't work for me. Guess there's a bug in my test env or something.
:(

Thanks, Phil
