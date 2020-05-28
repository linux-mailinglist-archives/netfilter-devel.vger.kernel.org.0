Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D491E689C
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2020 19:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405487AbgE1RYi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 May 2020 13:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405334AbgE1RYg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 May 2020 13:24:36 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF7C08C5C6
        for <netfilter-devel@vger.kernel.org>; Thu, 28 May 2020 10:24:36 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jeMGg-0002CN-Jw; Thu, 28 May 2020 19:24:34 +0200
Date:   Thu, 28 May 2020 19:24:34 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Laura Garcia Liebana <nevola@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        devel@zevenet.com
Subject: Re: [PATCH nf-next] netfilter: introduce support for reject at
 prerouting stage
Message-ID: <20200528172434.GL2915@breakpoint.cc>
References: <20200528171438.GA27622@nevthink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528171438.GA27622@nevthink>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Laura Garcia Liebana <nevola@gmail.com> wrote:
> +static void nf_reject_fill_skb_dst(struct sk_buff *skb_in)
> +{
> +	struct dst_entry *dst = NULL;
> +	struct flowi fl;
> +	struct flowi4 *fl4 = &fl.u.ip4;
> +
> +	memset(fl4, 0, sizeof(*fl4));
> +	fl4->daddr = ip_hdr(skb_in)->saddr;
> +	nf_route(dev_net(skb_in->dev), &dst, &fl, false, AF_INET);

Hmm, won't that need error handling for the case where we can't find
a route?
