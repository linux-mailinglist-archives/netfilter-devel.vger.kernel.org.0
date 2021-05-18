Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93D3882E6
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 May 2021 00:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352821AbhERW5l (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 May 2021 18:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhERW5l (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 May 2021 18:57:41 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21D4C061573
        for <netfilter-devel@vger.kernel.org>; Tue, 18 May 2021 15:56:22 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lj8dQ-0002b4-0A; Wed, 19 May 2021 00:56:20 +0200
Date:   Wed, 19 May 2021 00:56:19 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, dvyukov@google.com, fw@strlen.de
Subject: Re: [PATCH nf] netfilter: nftables: accept all dummy chain when
 table is dormant
Message-ID: <20210518225619.GA8317@breakpoint.cc>
References: <20210518224730.317215-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518224730.317215-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> The dormant flag need to be updated from the preparation phase,
> otherwise, two consecutive requests to dorm a table in the same batch
> might try to remove the same hooks twice, resulting in the following
> warning:
> 
>  hook not found, pf 3 num 0
>  WARNING: CPU: 0 PID: 334 at net/netfilter/core.c:480 __nf_unregister_net_hook+0x1eb/0x610 net/netfilter/core.c:480
>  Modules linked in:
>  CPU: 0 PID: 334 Comm: kworker/u4:5 Not tainted 5.12.0-syzkaller #0
>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>  Workqueue: netns cleanup_net
>  RIP: 0010:__nf_unregister_net_hook+0x1eb/0x610 net/netfilter/core.c:480

Would it be possible to reject such a batch instead of having to add
rely on dummy hooking instead?

I don't think we should try to be clever with nonsensical yes-no-yes-yes-no
type commits.
