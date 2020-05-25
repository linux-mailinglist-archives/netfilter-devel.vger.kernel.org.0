Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201F01E0E10
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2020 14:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390371AbgEYMD4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 May 2020 08:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390306AbgEYMD4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 May 2020 08:03:56 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC2C061A0E
        for <netfilter-devel@vger.kernel.org>; Mon, 25 May 2020 05:03:56 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jdBpi-0004yE-IM; Mon, 25 May 2020 14:03:54 +0200
Date:   Mon, 25 May 2020 14:03:54 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, jacobraz@chromium.org,
        fw@strlen.de, mkubecek@suse.cz
Subject: Re: [PATCH nf,v2 1/2] netfilter: conntrack: make conntrack userspace
 helpers work again
Message-ID: <20200525120354.GD2915@breakpoint.cc>
References: <20200525114715.2301-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525114715.2301-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Florian Westphal says:
> 
> "Problem is that after the helper hook was merged back into the confirm
> one, the queueing itself occurs from the confirm hook, i.e. we queue
> from the last netfilter callback in the hook-list.
> 
> Therefore, on return, the packet bypasses the confirm action and the
> connection is never committed to the main conntrack table.
> 
> Therefore, on return, the packet bypasses the confirm action and the
> connection is never committed to the main conntrack table.
> 
> To fix this there are several ways:
> 1. revert the 'Fixes' commit and have a extra helper hook again.
>    Works, but has the drawback of adding another indirect call for
>    everyone.
> 
> 2. Special case this: split the hooks only when userspace helper
>    gets added, so queueing occurs at a lower priority again,
>    and normal nqueue reinject would eventually call the last hook.
> 
> 3. Extend the existing nf_queue ct update hook to allow a forced
>    confirmation (plus run the seqadj code).
> 
> This goes for 3)."
> 
> Fixes: 827318feb69cb ("netfilter: conntrack: remove helper hook again")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> v2: call __nf_conntrack_update() before ct helper confirmation.

Reviewed-by: Florian Westphal <fw@strlen.de>
