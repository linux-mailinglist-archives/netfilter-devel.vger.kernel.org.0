Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2696FD707
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 May 2023 08:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbjEJGcc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 May 2023 02:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjEJGcb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 May 2023 02:32:31 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22AC84480
        for <netfilter-devel@vger.kernel.org>; Tue,  9 May 2023 23:32:28 -0700 (PDT)
Date:   Wed, 10 May 2023 08:32:22 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: always release netdev hooks
 from notifier
Message-ID: <ZFs6drN7cVJ2UQYy@calendula>
References: <20230504122021.21058-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504122021.21058-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 04, 2023 at 02:20:21PM +0200, Florian Westphal wrote:
> This reverts "netfilter: nf_tables: skip netdev events generated on netns removal".
> 
> The problem is that when a veth device is released, the veth release
> callback will also queue the peer netns device for removal.
> 
> Its possible that the peer netns is also slated for removal.  In this
> case, the device memory is already released before the pre_exit hook of
> the peer netns runs:
> 
> BUG: KASAN: slab-use-after-free in nf_hook_entry_head+0x1b8/0x1d0
> Read of size 8 at addr ffff88812c0124f0 by task kworker/u8:1/45
> Workqueue: netns cleanup_net
> Call Trace:
>  nf_hook_entry_head+0x1b8/0x1d0
>  __nf_unregister_net_hook+0x76/0x510
>  nft_netdev_unregister_hooks+0xa0/0x220
>  __nft_release_hook+0x184/0x490
>  nf_tables_pre_exit_net+0x12f/0x1b0
>  ..
> 
> Order is:
> 1. First netns is released, veth_dellink() queues peer netns device
>    for removal
> 2. peer netns is queued for removal
> 3. peer netns device is released, unreg event is triggered
> 4. unreg event is ignored because netns is going down
> 5. pre_exit hook calls nft_netdev_unregister_hooks but device memory
>    might be free'd already.

Applied to nf, thanks
