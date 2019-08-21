Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF21198626
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 23:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfHUVAc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 17:00:32 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43072 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728971AbfHUVAc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:00:32 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i0XiY-000714-8g; Wed, 21 Aug 2019 23:00:30 +0200
Date:   Wed, 21 Aug 2019 23:00:30 +0200
From:   Florian Westphal <fw@strlen.de>
To:     michael-dev <michael-dev@fami-braun.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: nftables matching gratuitous arp
Message-ID: <20190821210030.GC20113@breakpoint.cc>
References: <c81c933d181adbfdad94057569501d35@fami-braun.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81c933d181adbfdad94057569501d35@fami-braun.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

michael-dev <michael-dev@fami-braun.de> wrote:
> I'm trying to match gratuitous arp with nftables. I've tried
> > nft add rule bridge filter somechain arp saddr ip == arp daddr ip
> 
> but nft (some commits before 0.9.2) says:
> > Error: syntax error, unexpected daddr, expecting end of file or newline
> > or semicolon
> > add rule bridge filter FORWARD arp saddr ip == arp daddr ip
>                                                    ^^^^^
> Looking at the description of the netlink protocol, it looks like two loads
> and a cmp of both registers would do it.

Yes, but cmp doesn't support this, see nft_cmp_eval() in
net/netfilter/nft_cmp.c .

The compare occurs between a register and a immediate value.

Having cmp (and also binops) involving a second sreg would be
good to have.
