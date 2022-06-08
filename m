Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED75B542DFB
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jun 2022 12:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiFHKhq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 8 Jun 2022 06:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiFHKhb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:37:31 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41F0C22BAD0
        for <netfilter-devel@vger.kernel.org>; Wed,  8 Jun 2022 03:33:47 -0700 (PDT)
Date:   Wed, 8 Jun 2022 12:33:43 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: use get_random_u32 instead of prandom
Message-ID: <YqB7B2/b0mqqYVlO@salvia>
References: <20220518181531.92593-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220518181531.92593-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 18, 2022 at 08:15:31PM +0200, Florian Westphal wrote:
> bh might occur while updating per-cpu rnd_state from user context,
> ie. local_out path.
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: nginx/2725
> caller is nft_ng_random_eval+0x24/0x54 [nft_numgen]
> Call Trace:
>  check_preemption_disabled+0xde/0xe0
>  nft_ng_random_eval+0x24/0x54 [nft_numgen]
> 
> Use the random driver instead, this also avoids need for local prandom
> state.
> 
> Based on earlier patch from Pablo Neira.

Applied to nf.git, thanks.

For the record, I have also added to the commit description:

    Moreover, prandom now uses the random driver since d4150779e60f
    ("random32: use real rng for non-deterministic randomness").
