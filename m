Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ACB554743
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Jun 2022 14:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346467AbiFVKCh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Jun 2022 06:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242513AbiFVKCQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:02:16 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 898123A73C
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jun 2022 03:02:12 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:02:08 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Radim Hrazdil <rhrazdil@redhat.com>
Subject: Re: [PATCH nf] netfilter: br_netfilter: do not skip all hooks with 0
 priority
Message-ID: <YrLooMSyU+mAecHJ@salvia>
References: <20220621162603.4094-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220621162603.4094-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 21, 2022 at 06:26:03PM +0200, Florian Westphal wrote:
> When br_netfilter module is loaded, skbs may be diverted to the
> ipv4/ipv6 hooks, just like as if we were routing.
> 
> Unfortunately, bridge filter hooks with priority 0 may be skipped
> in this case.
> 
> Example:
> 1. an nftables bridge ruleset is loaded, with a prerouting
>    hook that has priority 0.
> 2. interface is added to the bridge.
> 3. no tcp packet is ever seen by the bridge prerouting hook.
> 4. flush the ruleset
> 5. load the bridge ruleset again.
> 6. tcp packets are processed as expected.
> 
> After 1) the only registered hook is the bridge prerouting hook, but its
> not called yet because the bridge hasn't been brought up yet.
> 
> After 2), hook order is:
>    0 br_nf_pre_routing // br_netfilter internal hook
>    0 chain bridge f prerouting // nftables bridge ruleset
> 
> The packet is diverted to br_nf_pre_routing.
> If call-iptables is off, the nftables bridge ruleset is called as expected.
> 
> But if its enabled, br_nf_hook_thresh() will skip it because it assumes
> that all 0-priority hooks had been called previously in bridge context.
> 
> To avoid this, check for the br_nf_pre_routing hook itself, we need to
> resume directly after it, even if this hook has a priority of 0.
> 
> Unfortunately, this still results in different packet flow.
> With this fix, the eval order after in 3) is:
> 1. br_nf_pre_routing
> 2. ip(6)tables (if enabled)
> 3. nftables bridge
> 
> but after 5 its the much saner:
> 1. nftables bridge
> 2. br_nf_pre_routing
> 3. ip(6)tables (if enabled)
> 
> Unfortunately I don't see a solution here:
> It would be possible to move br_nf_pre_routing to a higher priority
> so that it will be called later in the pipeline, but this also impacts
> ebtables evaluation order, and would still result in this very ordering
> problem for all nftables-bridge hooks with the same priority as the
> br_nf_pre_routing one.
> 
> Searching back through the git history I don't think this has
> ever behaved in any other way, hence, no fixes-tag.

I don't see a better solution either.

Not related to this patch, more of an open question:

Why are people still using br_netfilter with nftables? Is there any
usecase that is not natively covered by nftables itself? Probably
insufficient of documentation?

br_netfilter was added because iptables provided a lot more features
than ebtables. These days this is not longer true, since they are in
feature parity.
