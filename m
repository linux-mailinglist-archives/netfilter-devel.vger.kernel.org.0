Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66A440AC5E
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Sep 2021 13:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhINL0g (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Sep 2021 07:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbhINL0f (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:26:35 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A66C061574
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Sep 2021 04:25:18 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1mQ6Yu-0000WY-2P; Tue, 14 Sep 2021 13:25:16 +0200
Date:   Tue, 14 Sep 2021 13:25:16 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <snemec@redhat.com>
Cc:     netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH iptables] iptables-test.py: print with color escapes only
 when stdout isatty
Message-ID: <20210914112516.GA26723@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <snemec@redhat.com>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
References: <20210902113307.2368834-1-snemec@redhat.com>
 <20210903125250.GK7616@orbyte.nwl.cc>
 <20210903164441+0200.281220-snemec@redhat.com>
 <20210903153420.GM7616@orbyte.nwl.cc>
 <20210906110438+0200.839986-snemec@redhat.com>
 <20210913150533.GA22465@orbyte.nwl.cc>
 <20210914110342+0200.713702-snemec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210914110342+0200.713702-snemec@redhat.com>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hey,

On Tue, Sep 14, 2021 at 11:03:42AM +0200, Štěpán Němec wrote:
> On Mon, 13 Sep 2021 17:05:33 +0200
> Phil Sutter wrote:
> 
> > Applied, thanks!
> 
> Thank you.
> 
> I see that you've pushed your series including the change to print error
> messages to stdout [1] in the meantime.
> 
> I don't have a strong opinion on whether output of a script whose
> (only?) purpose is to print diagnostic messages should go to stdout or
> stderr, but I do think that having the "ERROR"s go to stderr and "OK"s
> go to stdout is more confusing than useful: was that really intentional?
> 
> As a side effect of that change, my patch will act funny depending on
> which output stream is being redirected, too.

Argh, you're right and I missed that.


Printing errors to stderr is useful to compare failing tests against an
expected set of failures - it is simply a task of comparing output on
stderr with a recorded one.

To not overcomplicate things, maybe the easiest fix would be to print
colors only if both stdout and stderr are a tty. What do you think?

Cheers, Phil
