Return-Path: <netfilter-devel+bounces-250-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BBD808F98
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Dec 2023 19:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD5C1F21159
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Dec 2023 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F3F4CE14;
	Thu,  7 Dec 2023 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="onMd3X3S"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859531716;
	Thu,  7 Dec 2023 10:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tfIWnqZ3nQOuHBXi2xMiPcBXFezRuvO6di/KOho/tPw=; b=onMd3X3SuTwSLahRkZwZpue9ag
	eVHFIhln8ZggmQOkmvTNEAxCHsfAZVlYrwD+kUuMBpmOgv3NClRTzVeNPAggdKSi/OUcevMR+gwmg
	M9qY2ajG4HZPhSvVXEnMeX44wGLpyZwL7dhxk/Tbq/3Y2ouDhpbrARu9jPUAnbv8ToKz6j27kEzsY
	bruJGfTsZoUiweDpyxtzRCO6MEy9LGKQmLRWJp/u+XVPursh1UH993u0eXzKty9oRbl7HhRVSe7MB
	DmwblMNTNno9ugtOxezOFSTvTnWJqWpAYzbMC7TMaleR2P/MtnxMPlLhaX+X5l5nrGezi1K6WR581
	EMjNXDGg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
	(envelope-from <phil@nwl.cc>)
	id 1rBIoa-0008TT-RL; Thu, 07 Dec 2023 19:09:36 +0100
Date: Thu, 7 Dec 2023 19:09:36 +0100
From: Phil Sutter <phil@nwl.cc>
To: Jann Horn <jannh@google.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel <netfilter-devel@vger.kernel.org>,
	coreteam@netfilter.org, Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Network Development <netdev@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Is xt_owner's owner_mt() racy with sock_orphan()? [worse with
 new TYPESAFE_BY_RCU file lifetime?]
Message-ID: <ZXIKYGbvmO4UC+er@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Jann Horn <jannh@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel <netfilter-devel@vger.kernel.org>,
	coreteam@netfilter.org, Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Network Development <netdev@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
 <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
 <ZW+Yv6TR+EMBp03f@orbyte.nwl.cc>
 <CAG48ez2G4q-50242WRE01iaKfAhd0D+XT9Ry0uS767ceHEzHXA@mail.gmail.com>
 <ZXDctabBrEFMVxg2@orbyte.nwl.cc>
 <CAG48ez1ixOapt330sDoCfhnVhN0VmO=i9H8cSQontGkvi_NT7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1ixOapt330sDoCfhnVhN0VmO=i9H8cSQontGkvi_NT7A@mail.gmail.com>

On Wed, Dec 06, 2023 at 10:02:04PM +0100, Jann Horn wrote:
> On Wed, Dec 6, 2023 at 9:42 PM Phil Sutter <phil@nwl.cc> wrote:
> >
> > On Wed, Dec 06, 2023 at 05:28:44PM +0100, Jann Horn wrote:
> > > On Tue, Dec 5, 2023 at 10:40 PM Phil Sutter <phil@nwl.cc> wrote:
> > > > On Tue, Dec 05, 2023 at 06:08:29PM +0100, Jann Horn wrote:
> > > > > On Tue, Dec 5, 2023 at 5:40 PM Jann Horn <jannh@google.com> wrote:
> > > > > >
> > > > > > Hi!
> > > > > >
> > > > > > I think this code is racy, but testing that seems like a pain...
> > > > > >
> > > > > > owner_mt() in xt_owner runs in context of a NF_INET_LOCAL_OUT or
> > > > > > NF_INET_POST_ROUTING hook. It first checks that sk->sk_socket is
> > > > > > non-NULL, then checks that sk->sk_socket->file is non-NULL, then
> > > > > > accesses the ->f_cred of that file.
> > > > > >
> > > > > > I don't see anything that protects this against a concurrent
> > > > > > sock_orphan(), which NULLs out the sk->sk_socket pointer, if we're in
> > > > >
> > > > > Ah, and all the other users of ->sk_socket in net/netfilter/ do it
> > > > > under the sk_callback_lock... so I guess the fix would be to add the
> > > > > same in owner_mt?
> > > >
> > > > Sounds reasonable, although I wonder how likely a socket is to
> > > > orphan while netfilter is processing a packet it just sent.
> > > >
> > > > How about the attached patch? Not sure what hash to put into a Fixes:
> > > > tag given this is a day 1 bug and ipt_owner/ip6t_owner predate git.
> > >
> > > Looks mostly reasonable to me; though I guess it's a bit weird to have
> > > two separate bailout paths for checking whether sk->sk_socket is NULL,
> > > where the first check can race, and the second check uses different
> > > logic for determining the return value; I don't know whether that
> > > actually matters semantically. But I'm not sure how to make it look
> > > nicer either.
> >
> > I find the code pretty confusing since it combines three matches (socket
> > UID, socket GID and socket existence) via binary ops. The second bail
> > disregards socket existence bits, I assumed it was deliberate and thus
> > decided to leave the first part as-is.
> >
> > > I guess you could add a READ_ONCE() around the first read to signal
> > > that that's a potentially racy read, but I don't feel strongly about
> > > that.
> >
> > Is this just annotation or do you see a practical effect of using
> > READ_ONCE() there?
> 
> I mostly just meant that as an annotation. My understanding is that in
> theory, racy reads can cause the compiler to do some terrible things
> to your code (https://lore.kernel.org/all/CAG48ez2nFks+yN1Kp4TZisso+rjvv_4UW0FTo8iFUd4Qyq1qDw@mail.gmail.com/),

Thanks for the pointer, this was an educational read!

> but that's almost certainly not going to happen here.

At least it's not a switch on a value in user-controlled memory. ;)

> (Well, I guess doing a READ_ONCE() at one side without doing
> WRITE_ONCE() on the other side is also unclean...)

For the annotation aspect it won't matter. Though since it will merely
improve reliability of that check in the given corner-case which is an
unreliable situation in the first place, I'd just leave it alone and
hope for the code to be replaced by the one in nft_meta.c eventually.

Thanks, Phil

