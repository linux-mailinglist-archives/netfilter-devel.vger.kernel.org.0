Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3B4AF0C5
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Feb 2022 13:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiBIMHJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Feb 2022 07:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiBIMGt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:49 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFACEC094C9D
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Feb 2022 03:06:56 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id C4034601C5;
        Wed,  9 Feb 2022 12:06:43 +0100 (CET)
Date:   Wed, 9 Feb 2022 12:06:52 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: ctnetlink: use dump structure instead
 of raw args
Message-ID: <YgOgTLD43OzJguVK@salvia>
References: <20220204121145.3471-1-fw@strlen.de>
 <YgOawS6I8ldRk72Z@salvia>
 <20220209104659.GF25000@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209104659.GF25000@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 09, 2022 at 11:46:59AM +0100, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > >  static int ctnetlink_done_list(struct netlink_callback *cb)
> > >  {
> > > -	if (cb->args[1])
> > > -		nf_ct_put((struct nf_conn *)cb->args[1]);
> > > +	struct ctnetlink_list_dump_ctx *ctx = (void *)cb->ctx;
> > 
> > Where is cb->ctx initialized?
> 
> Its zeroed in __netlink_dump_start, cb->ctx and cb->args are aliased
> via union inside netlink_callback struct.

Ah I see, it's all zero initially.

Thanks for explaining.
