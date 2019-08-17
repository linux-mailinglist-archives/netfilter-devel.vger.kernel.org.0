Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2212D912D8
	for <lists+netfilter-devel@lfdr.de>; Sat, 17 Aug 2019 22:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfHQUz4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 17 Aug 2019 16:55:56 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50080 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbfHQUzz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 17 Aug 2019 16:55:55 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hz5ju-0001pT-9T; Sat, 17 Aug 2019 22:55:54 +0200
Date:   Sat, 17 Aug 2019 22:55:54 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables 0/8] add typeof keyword
Message-ID: <20190817205554.iq7rfmvwzcugfmzc@breakpoint.cc>
References: <20190816144241.11469-1-fw@strlen.de>
 <20190817102351.x2s2vj5hgvsi5vak@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817102351.x2s2vj5hgvsi5vak@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> I know I sent a RFC using typeof(), I wonder if you could just use the
> selector instead, it's a bit of a lot of type typeof() . typeof()
> probably.
> 
> So this is left as this:
> 
>         type osf name
> 
> in concatenations, like this:
> 
>         nft add set ip filter allowed "{ type ip daddr . tcp dport; }"
> 
> Probably I would ask my sysadmin friends what they think.

Yes, please do, it would be good to get a non-developer perspective.

I'm very used to things like sizeof(), so typeof() felt natural to me.

Might be very un-intuitive for non-developers though, so it would be
good to get outside perspective.

Thanks!
