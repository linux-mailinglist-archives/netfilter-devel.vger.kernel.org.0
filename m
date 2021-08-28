Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D00B3FA786
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Aug 2021 22:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhH1U2s (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 28 Aug 2021 16:28:48 -0400
Received: from mail.netfilter.org ([217.70.188.207]:54484 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhH1U2s (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 28 Aug 2021 16:28:48 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 847B26007E;
        Sat, 28 Aug 2021 22:26:59 +0200 (CEST)
Date:   Sat, 28 Aug 2021 22:27:52 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jan Engelhardt <jengelh@inai.de>,
        Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: libnetfilter_queue: automake portability warning
Message-ID: <20210828202752.GA15388@salvia>
References: <YSlUpg5zfcwNiS50@azazel.net>
 <7n261qsp-or96-6559-5orp-srp285p4p6q@vanv.qr>
 <YSqSWaXwzRhhwCk9@slk1.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSqSWaXwzRhhwCk9@slk1.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Aug 29, 2021 at 05:45:29AM +1000, Duncan Roe wrote:
> On Sat, Aug 28, 2021 at 03:39:38PM +0200, Jan Engelhardt wrote:
> >
> > On Friday 2021-08-27 23:09, Jeremy Sowden wrote:
> >
> > >Running autogen.sh gives the following output when it gets to
> > >doxygen/Makefile.am:
> > >
> > >  doxygen/Makefile.am:3: warning: shell find $(top_srcdir: non-POSIX variable name
> > >  doxygen/Makefile.am:3: (probably a GNU make extension)
> > >
> > >Automake doesn't understand the GNU make $(shell ...) [...]
> >
> > Or, third option, ditch the wildcarding and just name the sources. If going for
> > a single Makefile (ditching recursive make), that will also be beneficial for
> > parallel building, and the repo is not too large for such undertaking to be
> > infeasible.
> >
> Certainly naming the sources would work.
> 
> But, with wildcarding, Makefile.am works unmodified in other projects, such as
> libmnl. Indeed I was planning to have libmnl/autogen.sh fetch both
> doxygen/Makefile.am and doxygen/build_man.sh
> 
> If the project ends up with a single Makefile, it could `include` nearly all of
> the existing doxygen/Makefile.am, and autogen.sh could fetch that in other
> projects.

doxygen's Makefile.am is relatively small now.

autogen.sh can be used to keep build_man.sh in sync, that should be
good enough, my main concern is that addressed with shell script split
off.

So I'd suggest remove the wildcarding from Makefile.am too.
