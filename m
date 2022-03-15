Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD94DA49C
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Mar 2022 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343952AbiCOVbZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Mar 2022 17:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiCOVbY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:31:24 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 980155BD3D
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Mar 2022 14:30:09 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 25E5762FFF;
        Tue, 15 Mar 2022 22:27:48 +0100 (CET)
Date:   Tue, 15 Mar 2022 22:30:06 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [RFC] conntrack event framework speedup
Message-ID: <YjEFXmDfNN6k63+H@salvia>
References: <20220315120538.GB16569@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315120538.GB16569@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:05:38PM +0100, Florian Westphal wrote:
> Hello,
> 
> Due to net.netfilter.nf_conntrack_events=1 we eat some uncessesary
> overhead:
> 
> 1. allocation of new conntrack entries needs to alloc ct->ext
> 2. inverse for deletion/free.
> 3. Because the ctnetlink module is typically active, each packet will
>    end up calling __nf_conntrack_eventmask_report via nf_confirm() and
>    then in ctnetlink only to find that we have no listeners
>    (and we can't call nfnetlink_has_listeners() from conntrack because
>     that would yield a dependency of conntrack to nfnetlink).
> 
> I would propose to add minimal conntrack specific code
> to nfnetlink, namely, to add bind()(/unbind() calls that inc/dec a
> counter for each ctnetlink event listener/socket.
> If counter becomes nonzero, flip a bit in struct net.
> 
> This would allow us to do the following:
> 
> add new net.netfilter.nf_conntrack_events default mode: 2, autodetect.

Probably the sysctl entry does not make any sense anymore if you can
autodetect when there is a listener?

> in nfnetlink bind, inc pernet counter when event group is bound.
> in nfnetlink unbind, dec pernet counter when event group is unbound.

So you keep one counter per netlink group in netns area?

> in init_conntrack() allocate the event cache extension only if
>  a) nf_conntrack_events == 1, or
>  b) nf_conntrack_events == 2 and pernet counter is nonzero.
> 
> Extend nf_confirm() to check of the pernet counter before
> call to __nf_conntrack_eventmask_report().
> 
> If nobody spots a problem with this idea I'd start to work on
> a prototype.

There is also setsockopt() to subscribe to netlink groups, you might
need to extend netlink_kernel_cfg to deal with this case too?
