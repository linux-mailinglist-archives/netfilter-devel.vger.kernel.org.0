Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625CA1F95AD
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2020 13:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgFOLyb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Jun 2020 07:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgFOLya (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:54:30 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CB0C061A0E
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Jun 2020 04:54:30 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jknh2-000677-KT; Mon, 15 Jun 2020 13:54:24 +0200
Date:   Mon, 15 Jun 2020 13:54:24 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Laura =?utf-8?Q?Garc=C3=ADa_Li=C3=A9bana?= <nevola@gmail.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: shell: Drop redefinition of DIFF variable
Message-ID: <20200615115424.GJ23632@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Stefano Brivio <sbrivio@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Laura =?utf-8?Q?Garc=C3=ADa_Li=C3=A9bana?= <nevola@gmail.com>,
        netfilter-devel@vger.kernel.org
References: <bdced35aa00b7933e8b67a52b37754d0b6f86f59.1592170402.git.sbrivio@redhat.com>
 <20200615090044.GH23632@orbyte.nwl.cc>
 <20200615121811.08c347e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615121811.08c347e2@redhat.com>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Stefano,

On Mon, Jun 15, 2020 at 12:18:11PM +0200, Stefano Brivio wrote:
> On Mon, 15 Jun 2020 11:00:44 +0200
> Phil Sutter <phil@nwl.cc> wrote:
> 
> > Hi Stefano,
> > 
> > On Sun, Jun 14, 2020 at 11:41:49PM +0200, Stefano Brivio wrote:
> > > Commit 7d93e2c2fbc7 ("tests: shell: autogenerate dump verification")
> > > introduced the definition of DIFF at the top of run-tests.sh, to make
> > > it visually part of the configuration section. Commit 68310ba0f9c2
> > > ("tests: shell: Search diff tool once and for all") override this
> > > definition.
> > > 
> > > Drop the unexpected redefinition of DIFF.  
> > 
> > I would fix it the other way round, dropping the first definition.
> 
> Then it's not visibly configurable anymore. It was in 2018, so it
> looks like a regression to me.

Hmm? Commit 68310ba0f9c2 is from January this year?!

> > It's likely a missing bit from commit 68310ba0f9c20, the second
> > definition is in line with FIND and MODPROBE definitions immediately
> > preceding it.
> 
> I see a few issues with those blocks:
> 
> - that should be a single function called (once or multiple times) for
>   nft, find, modprobe, diff, anything else we'll need in the future.
>   It would avoid any oversight of this kind and keep the script
>   cleaner. For example, what makes sort(1) special here?

It is simply grown and therefore a bit inconsistent.

> - quotes are applied inconsistently. If you expect multiple words from
>   which(1), then variables should also be quoted when used, otherwise
>   the check might go through, and we fail later

There are needless quotes around $(...) but within single brackets we
need them if we expect empty or multi-word strings. Typical output would
be 'diff not found' and using '[ ! -x "$DIFF" ]' we check if which
returned diff's path or said error message. We don't expect diff's path
to contain spaces, hence no quoting afterwards.

Cheers, Phil
