Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA6943D169
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Oct 2021 21:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhJ0TK0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Oct 2021 15:10:26 -0400
Received: from mail.netfilter.org ([217.70.188.207]:48982 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhJ0TKZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:10:25 -0400
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 382F263F21;
        Wed, 27 Oct 2021 21:06:10 +0200 (CEST)
Date:   Wed, 27 Oct 2021 21:07:54 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <snemec@redhat.com>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 1/3] tests: shell: README: copy edit
Message-ID: <YXmjii3KR7nyrK8u@salvia>
References: <20211020124512.490288-1-snemec@redhat.com>
 <20211020150402.GJ1668@orbyte.nwl.cc>
 <20211021103025+0200.945334-snemec@redhat.com>
 <20211021102644.GM1668@orbyte.nwl.cc>
 <20211021130323+0200.342006-snemec@redhat.com>
 <YXkWeFPM3ixQ2cTb@salvia>
 <20211027115112+0200.686229-snemec@redhat.com>
 <YXkmZaJit3R8XpzL@salvia>
 <20211027130438+0200.462117-snemec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211027130438+0200.462117-snemec@redhat.com>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 27, 2021 at 01:04:38PM +0200, Štěpán Němec wrote:
> On Wed, 27 Oct 2021 12:13:57 +0200
> Pablo Neira Ayuso wrote:
> 
> > On Wed, Oct 27, 2021 at 11:51:12AM +0200, Štěpán Němec wrote:
> >> > * patch 2/3, what is the intention there? a path to the nft executable
> >> >   is most generic way to refer how you use $NFT, right?
> >> 
> >> No, not since 7c8a44b25c22. I've always thought that 'Fixes:' is mostly
> >> or at least also meant for humans, i.e., that the person reading the
> >> commit message and wanting to better understand the change would look at
> >> the referenced commit, but if that is a wrong assumption to make, I
> >> propose to add the following description:
> >
> >>   Since commit 7c8a44b25c22, $NFT can contain an arbitrary command, e.g.
> >>   'valgrind nft'.
> >
> > OK, but why the reader need to know about former behaviour? The git
> > repository already provides the historical information if this is of
> > his interest. To me, the README file should contain the most up to
> > date information that is relevant to run the test infrastructure.
> 
> I agree, and that's what the patch does: 'a path to the nft executable'
> is the former behaviour, arbitrary command is the most up to date
> information. (The "Since..." text above is my proposal for the commit
> description, not for the README file.)

OK, this slightly more verbose description in the paragraph above LGTM.

[...]
> >> > Regarding reference to 4d26b6dd3c4c, not sure it is worth to add this
> >> > to the README file. The test infrastructure is only used for internal
> >> > development use, this is included in tarballs but distributors do not
> >> > package this.
> >> 
> >> IMO this argument should speak _for_ including the commit reference
> >> rather than omitting it, as the developer is more likely to be
> >> interested in the commit than the consumer.
> >>
> >> I thought about making the wording simply describe the current state
> >> without any historical explanations, but saying "Test files are
> >> executable files matching the pattern <<name_N>>, where N doesn't mean
> >> anything." seemed weird.
> >
> > For historical explanations, you can dig into git.
> 
> Would the following README text work for you?
> 
>   Test files are executable files matching the pattern <<name_N>>,
>   where N has no meaning. All tests should return 0 on success.
> 
>   Since they are located with `find', test files can be put in any
>   subdirectory.

LGTM.

> Maybe saying "where N should be 0 in all new tests" would be less
> strange?

This is also OK, we can probably remove the trailing 0 at some point
given it has no meaning anymore.

> I think both are significantly less helpful than my original version,
> but at least they aren't wrong like the current text.

Makes sense.

> Proposed commit description, based on your comments:
> 
>   Since commit 4d26b6dd3c4c, test file name suffix no longer reflects
>   expected exit code in all cases.
> 
>   Move the sentence "Since they are located with `find', test files can
>   be put in any subdirectory." to a separate paragraph.

LGTM.

Thanks.
