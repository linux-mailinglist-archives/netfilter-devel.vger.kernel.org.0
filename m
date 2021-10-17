Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B058430966
	for <lists+netfilter-devel@lfdr.de>; Sun, 17 Oct 2021 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343749AbhJQNoC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 17 Oct 2021 09:44:02 -0400
Received: from mail.netfilter.org ([217.70.188.207]:52938 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242392AbhJQNoC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:44:02 -0400
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 52D6263EE1;
        Sun, 17 Oct 2021 15:40:11 +0200 (CEST)
Date:   Sun, 17 Oct 2021 15:41:46 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: You dropped the wrong patvh from patchwork
Message-ID: <YWwoGrraZHIaPqIx@salvia>
References: <20211016043948.2422-1-duncan_roe@optusnet.com.au>
 <YWp+/MO6jhvgUdGM@slk1.local.net>
 <YWuCt8cFd3k5YcXz@slk1.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWuCt8cFd3k5YcXz@slk1.local.net>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Oct 17, 2021 at 12:56:07PM +1100, Duncan Roe wrote:
> Hi Pablo,
> 
> On Sat, Oct 16, 2021 at 06:27:56PM +1100, Duncan Roe wrote:
> > On Sat, Oct 16, 2021 at 03:39:48PM +1100, Duncan Roe wrote:
> > > - configure --help lists non-default documentation options.
> > >   Looking around the web, this seemed to me to be what most projects do.
> > >   Listed options are --enable-html-doc & --disable-man-pages.
> > > - --with-doxygen is removed: --disable-man-pages also disables doxygen unless
> > >   --enable-html-doc is asserted.
> > > If html is requested, `make install` installs it in htmldir.
> > >
> > > Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
> > > ---
> > > v2: broken out from 0001-build-doc-Fix-man-pages.patch
> > > v3: no change (still part of a series)
> > > v4: remove --without-doxygen since -disable-man-pages does that
> > > v5: - update .gitignore for clean `git status` after in-tree build
> > >     - in configure.ac:
> > >       - ensure all variables are always set (avoid leakage from environment)
> > >       - provide helpful warning if HTML enabled but dot not found
> > [...]
> > Sorry Pablo, this is for libnetfilter_queue.
> > I don't see it in patchwork - did you get rid of it already?
> > Will re-send with correct Sj.
> >
> Sorry again for the confusion but you dropped the good libnetfilter_log patch
> that was Tested-by: Jeremy Sowden and left the bad libnetfilter_log patch that
> actually applies to libnetfilter_queue.

Are you refering to this patch?

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20211017013951.12584-1-duncan_roe@optusnet.com.au/

This is the one that Jeremy added the Tested-by: tag, correct?
