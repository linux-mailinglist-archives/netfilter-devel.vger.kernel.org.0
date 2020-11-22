Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F414F2BC8C6
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Nov 2020 20:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgKVTfn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 22 Nov 2020 14:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgKVTfn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 22 Nov 2020 14:35:43 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1465AC0613CF
        for <netfilter-devel@vger.kernel.org>; Sun, 22 Nov 2020 11:35:43 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kgv97-0002n1-Tj; Sun, 22 Nov 2020 20:35:37 +0100
Date:   Sun, 22 Nov 2020 20:35:37 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Cc:     will@kernel.org, pablo@netfilter.org, stranche@codeaurora.org,
        netfilter-devel@vger.kernel.org, tglx@linutronix.de, fw@strlen.de,
        peterz@infradead.org
Subject: Re: [PATCH nf] netfilter: x_tables: Switch synchronization to RCU
Message-ID: <20201122193537.GV15137@breakpoint.cc>
References: <1606072636-23555-1-git-send-email-subashab@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606072636-23555-1-git-send-email-subashab@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org> wrote:
> diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
> index af22dbe..416a617 100644
> --- a/net/netfilter/x_tables.c
> +++ b/net/netfilter/x_tables.c
> @@ -1349,6 +1349,14 @@ struct xt_counters *xt_counters_alloc(unsigned int counters)
>  }
>  EXPORT_SYMBOL(xt_counters_alloc);
[..]

>  	/* Do the substitution. */
> -	local_bh_disable();
> -	private = table->private;
> +	private = xt_table_get_private_protected(table);
>  
>  	/* Check inside lock: is the old number correct? */
>  	if (num_counters != private->number) {

There is a local_bh_enable() here that needs removal.

Did you test it with PROVE_LOCKING enabled?

The placement/use of rcu_dereference and the _protected version
looks correct, I would not expect splats.
