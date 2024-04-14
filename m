Return-Path: <netfilter-devel+bounces-1742-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261308A18D8
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Apr 2024 17:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8299B2B676
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Apr 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E513ADC;
	Thu, 11 Apr 2024 15:30:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6941754B;
	Thu, 11 Apr 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849412; cv=none; b=kKnT4oh0Z6+Kb8vtZItwFnmVPTr83lOJtSpr5Fpwp7ayAFOe8/Yo4XQaq3C+CZdJ6x5wxzxfJG6ezSIqTTuUJCfilPETk5pR8zO5Ktx/1Cif9ceb3GWbNftkRbIBWlcpOZC9oGfz3BbjUNqAruyF/HjHx2gz6t1yAsyJHV1oEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849412; c=relaxed/simple;
	bh=JKNbGormCwQYI0rSuwJRb8OZ+BVOoZDZLn5KrMa84vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9w4XvgTomSaRc1XrnxSQaxUTpBMk43bE/NhcHgE45K2Ku0dhy0kiA+lFSnKoKEzTWJf3siCpPrNA5Vc1lQd8ywKPRfdVL0vmmbx5PIURgnQUUS9vnaAvy9uL9nzN0sXKYlBr1jOQw01CbLOUY5fjkAgbf8gPihqz6nUwdv9prA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Thu, 11 Apr 2024 17:30:04 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
	fw@strlen.de
Subject: Re: [PATCH net 0/7] Netfilter fixes for net
Message-ID: <ZhgB_HtISg0TML01@calendula>
References: <20240411112900.129414-1-pablo@netfilter.org>
 <07f609433f7248412abb184d826976a766cea2e8.camel@redhat.com>
 <ZhfMi7hL3TW0qmj7@calendula>
 <828d9e79d2203cb8325f632bbcebd22e45f987c2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <828d9e79d2203cb8325f632bbcebd22e45f987c2.camel@redhat.com>

On Thu, Apr 11, 2024 at 01:58:37PM +0200, Paolo Abeni wrote:
> On Thu, 2024-04-11 at 13:42 +0200, Pablo Neira Ayuso wrote:
> > On Thu, Apr 11, 2024 at 01:39:30PM +0200, Paolo Abeni wrote:
> > > On Thu, 2024-04-11 at 13:28 +0200, Pablo Neira Ayuso wrote:
> > > > Hi,
> > > > 
> > > > The following patchset contains Netfilter fixes for net:
> > > > 
> > > > Patches #1 and #2 add missing rcu read side lock when iterating over
> > > > expression and object type list which could race with module removal.
> > > > 
> > > > Patch #3 prevents promisc packet from visiting the bridge/input hook
> > > > 	 to amend a recent fix to address conntrack confirmation race
> > > > 	 in br_netfilter and nf_conntrack_bridge.
> > > > 
> > > > Patch #4 adds and uses iterate decorator type to fetch the current
> > > > 	 pipapo set backend datastructure view when netlink dumps the
> > > > 	 set elements.
> > > > 
> > > > Patch #5 fixes removal of duplicate elements in the pipapo set backend.
> > > > 
> > > > Patch #6 flowtable validates pppoe header before accessing it.
> > > > 
> > > > Patch #7 fixes flowtable datapath for pppoe packets, otherwise lookup
> > > >          fails and pppoe packets follow classic path.
> > > > 
> > > > Please, pull these changes from:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-24-04-11
> > > > 
> > > > Thanks.
> > > > 
> > > > ----------------------------------------------------------------
> > > > 
> > > > The following changes since commit 19fa4f2a85d777a8052e869c1b892a2f7556569d:
> > > > 
> > > >   r8169: fix LED-related deadlock on module removal (2024-04-10 10:44:29 +0100)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-24-04-11
> > > > 
> > > > for you to fetch changes up to 6db5dc7b351b9569940cd1cf445e237c42cd6d27:
> > > > 
> > > >   netfilter: flowtable: incorrect pppoe tuple (2024-04-11 12:14:10 +0200)
> > > > 
> > > > ----------------------------------------------------------------
> > > > netfilter pull request 24-04-11
> > > > 
> > > > ----------------------------------------------------------------
> > > > Florian Westphal (1):
> > > >       netfilter: nft_set_pipapo: do not free live element
> > > > 
> > > > Pablo Neira Ayuso (4):
> > > >       netfilter: br_netfilter: skip conntrack input hook for promisc packets
> > > >       netfilter: nft_set_pipapo: walk over current view on netlink dump
> > > >       netfilter: flowtable: validate pppoe header
> > > >       netfilter: flowtable: incorrect pppoe tuple
> > > > 
> > > > Ziyang Xuan (2):
> > > >       netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()
> > > >       netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()
> > > > 
> > > >  include/net/netfilter/nf_flow_table.h      | 12 +++++++++++-
> > > >  include/net/netfilter/nf_tables.h          | 14 ++++++++++++++
> > > >  net/bridge/br_input.c                      | 15 +++++++++++----
> > > >  net/bridge/br_netfilter_hooks.c            |  6 ++++++
> > > >  net/bridge/br_private.h                    |  1 +
> > > >  net/bridge/netfilter/nf_conntrack_bridge.c | 14 ++++++++++----
> > > >  net/netfilter/nf_flow_table_inet.c         |  3 ++-
> > > >  net/netfilter/nf_flow_table_ip.c           | 10 ++++++----
> > > >  net/netfilter/nf_tables_api.c              | 22 ++++++++++++++++++----
> > > >  net/netfilter/nft_set_pipapo.c             | 19 ++++++++++++-------
> > > >  10 files changed, 91 insertions(+), 25 deletions(-)
> > > 
> > > Whoops, I'm finishing testing right now todays PR, I hope it's not a
> > > big issue if this lands later?
> > 
> > Apologies, I am working at full steam here, I could not deliver any sooner.
> 
> I'm sorry, I was likely unclear, the above was just a question (not a
> complain): do you have strong preference for these fixes to land into
> today's PR? (the answer is unclear to me)

No problem Paolo, I can miss this flight, it is OK.

