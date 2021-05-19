Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D37388A2B
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 May 2021 11:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbhESJIm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 May 2021 05:08:42 -0400
Received: from mail.netfilter.org ([217.70.188.207]:45012 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbhESJIm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 May 2021 05:08:42 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 4E04C64177;
        Wed, 19 May 2021 11:06:27 +0200 (CEST)
Date:   Wed, 19 May 2021 11:07:19 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, dvyukov@google.com
Subject: Re: [PATCH nf] netfilter: nftables: accept all dummy chain when
 table is dormant
Message-ID: <20210519090719.GA30969@salvia>
References: <20210518224730.317215-1-pablo@netfilter.org>
 <20210518225619.GA8317@breakpoint.cc>
 <20210518231824.GA27217@salvia>
 <20210519083028.GB8317@breakpoint.cc>
 <20210519090150.GA30723@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210519090150.GA30723@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 19, 2021 at 11:01:50AM +0200, Pablo Neira Ayuso wrote:
> On Wed, May 19, 2021 at 10:30:28AM +0200, Florian Westphal wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > On Wed, May 19, 2021 at 12:56:19AM +0200, Florian Westphal wrote:
> > > > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > > > The dormant flag need to be updated from the preparation phase,
> > > > > otherwise, two consecutive requests to dorm a table in the same batch
> > > > > might try to remove the same hooks twice, resulting in the following
> > > > > warning:
> > > > > 
> > > > >  hook not found, pf 3 num 0
> > > > >  WARNING: CPU: 0 PID: 334 at net/netfilter/core.c:480 __nf_unregister_net_hook+0x1eb/0x610 net/netfilter/core.c:480
> > > > >  Modules linked in:
> > > > >  CPU: 0 PID: 334 Comm: kworker/u4:5 Not tainted 5.12.0-syzkaller #0
> > > > >  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > >  Workqueue: netns cleanup_net
> > > > >  RIP: 0010:__nf_unregister_net_hook+0x1eb/0x610 net/netfilter/core.c:480
> > > > 
> > > > Would it be possible to reject such a batch instead of having to add
> > > > rely on dummy hooking instead?
> > > 
> > > That's a simple way to fix it, yes, ie. hit EBUSY.
> > > 
> > > > I don't think we should try to be clever with nonsensical yes-no-yes-yes-no
> > > > type commits.
> > > 
> > > Note that no such EBUSY limitation exists so far in the transaction
> > > semantics that I know [*]. We already discussed that robots might do
> > > non-sensical stuff when creating a batches, and reporting EBUSY for
> > > this add-del-add case might just break them.
> > 
> > I don't think this breaks existing users, noone except syzbot
> > reported such WARN splat so far.
> > 
> > > This also removes the conditional hook registration, so hooks are
> > > registered once at chain creation. This simplifies interaction with
> > > the netfilter core at the cost of adding complexity to
> > > nf_tables_commit_chain_prepare() path.
> > 
> > It also adds side effect (hook registration) during preparation phase.
> 
> Chain hook registration always happened from preparation phase before
> this patch.
> 
> > I think its similar to
> > 
> > add table foo
> > delete table foo
> > delete table foo
> > 
> > ... and that gives -ENOENT.
> 
> This is the preparation phase that is rejecting it with -ENOENT.
> 
> The sequence that this patch handles is similar to:
> 
> add table foo
> delete table foo
> add table foo
> 
> which does _not_ hit EBUSY.
> 
> The existing transaction semantics handles similar sequences for the
> existing objects.
> 
> This patch ensures that:
> 
> add table x
> add chain x y { type filter hook input priority 0; }
> add table x { flags dormant; }
> add table x { ; }
> 
> in a batch file works fine.

Actually, the sequence this handle is:

add table x
add chain x y { type filter hook input priority 0; }
add table x { flags dormant; }
add table x { ; }
add table x { flags dormant; }

which is similar to:

add table x
delete table x
add table x

> A robot could generate such sequence above.
