Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B901510DD
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 Feb 2020 21:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBCUSg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 Feb 2020 15:18:36 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:60622 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbgBCUSg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:18:36 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iyiAz-00078R-RN; Mon, 03 Feb 2020 21:18:33 +0100
Date:   Mon, 3 Feb 2020 21:18:33 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        syzbot <syzbot+adf6c6c2be1c3a718121@syzkaller.appspotmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: Re: [Patch nf v2 1/3] xt_hashlimit: avoid OOM for user-controlled
 vmalloc
Message-ID: <20200203201833.GA15904@breakpoint.cc>
References: <20200203043053.19192-1-xiyou.wangcong@gmail.com>
 <20200203043053.19192-2-xiyou.wangcong@gmail.com>
 <20200203121612.GR795@breakpoint.cc>
 <CAM_iQpWhQgJXumEnoKvH5VaCRTkZKmQQdKLkRsChf3+GiN47qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpWhQgJXumEnoKvH5VaCRTkZKmQQdKLkRsChf3+GiN47qQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Mon, Feb 3, 2020 at 4:16 AM Florian Westphal <fw@strlen.de> wrote:
> >
> > Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > The hashtable size could be controlled by user, so use flags
> > > GFP_USER | __GFP_NOWARN to avoid OOM warning triggered by user-space.
> > >
> > > Also add __GFP_NORETRY to avoid retrying, as this is just a
> > > best effort and the failure is already handled gracefully.
> > >
> > > Reported-and-tested-by: syzbot+adf6c6c2be1c3a718121@syzkaller.appspotmail.com
> > > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > > Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> > > Cc: Florian Westphal <fw@strlen.de>
> > > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > > ---
> > >  net/netfilter/xt_hashlimit.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
> > > index bccd47cd7190..5d9943b37c42 100644
> > > --- a/net/netfilter/xt_hashlimit.c
> > > +++ b/net/netfilter/xt_hashlimit.c
> > > @@ -293,8 +293,8 @@ static int htable_create(struct net *net, struct hashlimit_cfg3 *cfg,
> > >               if (size < 16)
> > >                       size = 16;
> > >       }
> > > -     /* FIXME: don't use vmalloc() here or anywhere else -HW */
> > > -     hinfo = vmalloc(struct_size(hinfo, hash, size));
> > > +     hinfo = __vmalloc(struct_size(hinfo, hash, size),
> > > +                       GFP_USER | __GFP_NOWARN | __GFP_NORETRY, PAGE_KERNEL);
> >
> > Sorry for not noticing this earlier: should that be GFP_KERNEL_ACCOUNT
> > instead of GFP_USER?
> 
> Why do you think it should be accounted in kmemcg?

We do that for xtables blob allocation, see xt_alloc_table_info().

> I think this one is controlled by user, so I pick GFP_USER,
> like many other cases, for example,
> proc_allowed_congestion_control().

Ok, I see, fair enough -- no objections from me.
