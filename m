Return-Path: <netfilter-devel+bounces-234-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671608075B9
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 17:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9894E1C20F2E
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563CB495F1;
	Wed,  6 Dec 2023 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxXEzb3u"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3165248CCE;
	Wed,  6 Dec 2023 16:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF0DC433C8;
	Wed,  6 Dec 2023 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701881397;
	bh=rMAoUjOmr5QtbI6rn6eo4WOMrnTR1D6zBGzrt2Afy9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxXEzb3uTcRmZMsipF5O+JnEPiOGWtYp0M/22/GFpAre2r31rmbRgosxfeQy7MBQX
	 kq8PRy7iC0/1XmiUQDXu771Y4nV++RTEguPHotHNSz/zO8Sxmi8ZRt0oc0eGgydDKU
	 6z4+YiNKQsrUHsKsGlGi5GrM0njU/F+OjNTDACkIJ4+7s+F+IMG1KvaQFi9ZSbRohG
	 x/2v6f1Eypy+DwRBuqEQt18Z4FTSuZe4spozrr8nFoBOw+otVxNv0UhACO7mKs7tOe
	 wyI2+KtO36rz1L/KZv6o1fr6TvEOCuHeLv9/jd26pDrwgG1ZDVWRLVRQGYE0pOaUnp
	 vr1RQcbqs13XQ==
Date: Wed, 6 Dec 2023 17:49:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel <netfilter-devel@vger.kernel.org>,
	coreteam@netfilter.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Network Development <netdev@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Is xt_owner's owner_mt() racy with sock_orphan()? [worse with
 new TYPESAFE_BY_RCU file lifetime?]
Message-ID: <20231206-fixpunkt-annehmbar-d191785a09a3@brauner>
References: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
 <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
 <ZW+Yv6TR+EMBp03f@orbyte.nwl.cc>
 <CAG48ez2G4q-50242WRE01iaKfAhd0D+XT9Ry0uS767ceHEzHXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2G4q-50242WRE01iaKfAhd0D+XT9Ry0uS767ceHEzHXA@mail.gmail.com>

On Wed, Dec 06, 2023 at 05:28:44PM +0100, Jann Horn wrote:
> On Tue, Dec 5, 2023 at 10:40 PM Phil Sutter <phil@nwl.cc> wrote:
> > On Tue, Dec 05, 2023 at 06:08:29PM +0100, Jann Horn wrote:
> > > On Tue, Dec 5, 2023 at 5:40 PM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > Hi!
> > > >
> > > > I think this code is racy, but testing that seems like a pain...
> > > >
> > > > owner_mt() in xt_owner runs in context of a NF_INET_LOCAL_OUT or
> > > > NF_INET_POST_ROUTING hook. It first checks that sk->sk_socket is
> > > > non-NULL, then checks that sk->sk_socket->file is non-NULL, then
> > > > accesses the ->f_cred of that file.
> > > >
> > > > I don't see anything that protects this against a concurrent
> > > > sock_orphan(), which NULLs out the sk->sk_socket pointer, if we're in
> > >
> > > Ah, and all the other users of ->sk_socket in net/netfilter/ do it
> > > under the sk_callback_lock... so I guess the fix would be to add the
> > > same in owner_mt?
> >
> > Sounds reasonable, although I wonder how likely a socket is to
> > orphan while netfilter is processing a packet it just sent.
> >
> > How about the attached patch? Not sure what hash to put into a Fixes:
> > tag given this is a day 1 bug and ipt_owner/ip6t_owner predate git.
> 
> Looks mostly reasonable to me; though I guess it's a bit weird to have
> two separate bailout paths for checking whether sk->sk_socket is NULL,
> where the first check can race, and the second check uses different
> logic for determining the return value; I don't know whether that
> actually matters semantically. But I'm not sure how to make it look
> nicer either.
> I guess you could add a READ_ONCE() around the first read to signal
> that that's a potentially racy read, but I don't feel strongly about
> that.

It should be possible to split it into two static inlin helpers:

owner_mt_fast()
owner_mt_slow()

And then abstract the lockless and locked fetches into the two helpers.

