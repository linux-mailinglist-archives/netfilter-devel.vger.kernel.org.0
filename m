Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A551D785DEA
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Aug 2023 18:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjHWQxb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Aug 2023 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjHWQxb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:53:31 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D2FE5C
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Aug 2023 09:53:28 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qYr6l-0006yc-2l; Wed, 23 Aug 2023 18:53:27 +0200
Date:   Wed, 23 Aug 2023 18:53:27 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nft PATCH] tests: shell: Stabilize sets/reset_command_0 test
Message-ID: <ZOY5h1wr2gue1Two@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20230823095404.10494-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823095404.10494-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:54:04AM +0200, Phil Sutter wrote:
> Timeout/expiry value testing based on seconds is way too fragile,
> especially with slow debug kernels. Rewrite the unit to test
> minute-based values. This means it is no longer feasible to wait for
> values to sufficiently change, so instead specify an 'expires' value
> when creating the ruleset and drop the 'sleep' call.
> 
> While being at it:
> 
> - Combine 'get element' and 'reset element' calls into one, assert the
>   relevant (sanitized) line appears twice in output instead of comparing
>   with 'diff'.
> - Turn comments into 'echo' calls to help debugging if the test fails.
> 
> Reported-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.
