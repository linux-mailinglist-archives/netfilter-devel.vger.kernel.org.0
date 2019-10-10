Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC609D317C
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Oct 2019 21:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfJJTld (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Oct 2019 15:41:33 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:52882 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbfJJTld (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:41:33 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iIeJX-0005D7-5Z; Thu, 10 Oct 2019 21:41:31 +0200
Date:   Thu, 10 Oct 2019 21:41:31 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Edward Cree <ecree@solarflare.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: add and use nf_hook_slow_list()
Message-ID: <20191010194131.GJ25052@breakpoint.cc>
References: <20191009143046.11070-1-fw@strlen.de>
 <d4294ffa-db43-f9ad-2f7f-b33c0f241101@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4294ffa-db43-f9ad-2f7f-b33c0f241101@solarflare.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Edward Cree <ecree@solarflare.com> wrote:
> On 09/10/2019 15:30, Florian Westphal wrote:
> > At this time, NF_HOOK_LIST() macro will iterate the list and then call
> > nf_hook() for each skb.
> >
> > This makes it so the entire list is passed into the netfilter core.
> > The advantage is that we only need to fetch the rule blob once per list
> > instead of per-skb.  If no rules are present, the list operations
> > can be elided entirely.
> >
> > NF_HOOK_LIST only supports ipv4 and ipv6, but those are the only
> > callers.
> >
> > Cc: Edward Cree <ecree@solarflare.com>
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> LGTM (but see below).
> Acked-by: Edward Cree <ecree@solarflare.com>

[..]

> > +     list_for_each_entry_safe(skb, next, head, list) {
> > +             list_del(&skb->list);
> I know this was just copied from the existing code, but I've been getting
> a lot more paranoid lately about skbs escaping with non-NULL ->next
> pointers, since several bugs of that kind have turned up elsewhere.
> So should this maybe be skb_list_del_init()?

Ok, I can make that change and send a v2.
