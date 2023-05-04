Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD686F5D19
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 May 2023 19:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjECRgy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 May 2023 13:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjECRgx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 May 2023 13:36:53 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E621420B
        for <netfilter-devel@vger.kernel.org>; Wed,  3 May 2023 10:36:52 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1puGPK-0002nq-7l; Wed, 03 May 2023 19:36:50 +0200
Date:   Wed, 3 May 2023 19:36:50 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH 0/3] Extract nftnl_rule parsing code
Message-ID: <ZFKbskUv6RlJZLjj@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
References: <20230421174014.17014-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174014.17014-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Apr 21, 2023 at 07:40:11PM +0200, Phil Sutter wrote:
> nft-shared.c was already oversized, upcoming enhancement of the
> nftnl_rule parser will add to that. So prepare any further work in that
> field by creating a common 'nft-ruleparse.c' source and one for each
> family to hold all the parsing code (basically the stack below
> nft_rule_to_iptables_command_state).
> 
> Collect the existing expression parsing callbacks in a new struct
> nft_ruleparse_ops and add a pointer to it into nft_family_ops. This way
> the callbacks may be static and the nft-ruleparse-<family>.c sources
> only export their ops object.
> 
> This series does things somewhat gradually:
> 
> * First pull everything from nft-shared.c into nft-ruleparse.c (likewise
>   with header files)
> * Then perform the *_ops struct changes which should not have a
>   functional implication
> * Finally weed parsers from nft-<family>.c files into
>   nft-ruleparse-<family>.c ones.

Series applied after rebasing it onto current HEAD - the previous
arptables-related fixes caused a minor conflict.
