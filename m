Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67CC4C618E
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Feb 2022 04:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiB1DLS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 27 Feb 2022 22:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiB1DLS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:11:18 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376F43EBAD
        for <netfilter-devel@vger.kernel.org>; Sun, 27 Feb 2022 19:10:40 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nOWQo-0007Ta-Bx; Mon, 28 Feb 2022 04:10:38 +0100
Date:   Mon, 28 Feb 2022 04:10:38 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@redhat.com>
Subject: Re: [PATCH v2 nf] netfilter: nf_queue: don't assume sk is full socket
Message-ID: <20220228031038.GB26547@breakpoint.cc>
References: <20220225130241.14357-1-fw@strlen.de>
 <8cd10394-ae9c-a727-2b33-dd89516ac5b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd10394-ae9c-a727-2b33-dd89516ac5b9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > +		nf_queue_sock_put(state->sk);
> >   #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
> >   	dev_put(entry->physin);
> 
> 
> OK but it looks like there might be an orthogonal bug.
> 
> The sock_hold() side seems suspect, because there is no guarantee
> 
> that sk_refcnt is not already 0.

Ugh.  Looks like we also need skb_sk_is_prefetched() check and then
take care of skb->sk too if its not owned by skb destructor.

> Not sure how netfilter would react with stats->sk set to NULL ?

Its passed as arg to dst_output() later so I think its fine.
