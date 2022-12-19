Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4348650955
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Dec 2022 10:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLSJci (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Dec 2022 04:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSJch (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:32:37 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C3ABC8A
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Dec 2022 01:32:36 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1p7CVd-0001hi-Lz; Mon, 19 Dec 2022 10:32:33 +0100
Date:   Mon, 19 Dec 2022 10:32:33 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nf,v1] netfilter: nf_tables: perform type checking for
 existing sets
Message-ID: <20221219093233.GA28341@breakpoint.cc>
References: <20221218214828.8749-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218214828.8749-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> If a ruleset declares a set name that matches an existing set in the
> kernel, then validate that this declaration really refers to the same
> set, otherwise bail out with EEXIST.
> 
> Currently, the kernel reports success when adding a set that already
> exists in the kernel. This usually results in EINVAL errors at a later
> stage, when the user adds elements to the set, if the set declaration
> mismatches the existing set representation in the kernel.
> 
> Add a new function to check that the set declaration really refers to
> the same existing set in the kernel.
> 
> Fixes: 96518518cc41 ("netfilter: add nftables")
> Reported-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> I plan to post a v2, there is still a number of fields that are not yet
> validated.

Thanks.  It would also be good to permit 're-add' to change
e.g. the timeout value associated with the set (if klen/dlen etc. are
equal).
