Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C6B7AA7F
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jul 2019 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfG3OD4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Jul 2019 10:03:56 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:38090 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728913AbfG3OD4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:03:56 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hsSjK-0006H1-Ia; Tue, 30 Jul 2019 16:03:54 +0200
Date:   Tue, 30 Jul 2019 16:03:54 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2 0/2] parser_bison: Get rid of (most) bison
 compiler warnings
Message-ID: <20190730140354.GO14469@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190723132313.13238-1-phil@nwl.cc>
 <20190730124106.5edmsjwzzgknpnjs@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730124106.5edmsjwzzgknpnjs@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Tue, Jul 30, 2019 at 02:41:06PM +0200, Pablo Neira Ayuso wrote:
> On Tue, Jul 23, 2019 at 03:23:11PM +0200, Phil Sutter wrote:
> > Eliminate as many bison warnings emitted since bison-3.3 as possible.
> > Sadly getting bison, flex and automake right is full of pitfalls so on
> > one hand this series does not fix for deprecated %name-prefix statement
> > and on the other passes -Wno-yacc to bison to not complain about POSIX
> > incompatibilities although automake causes to run bison in POSIX compat
> > mode in the first place. Fixing either of those turned out to be
> > non-trivial.
> 
> Indeed, lots of warnings and things to be updated.
> 
> Do you think it's worth fixing those in the midterm?
> 
> We can just place these two small ones in the tree, I'm just concerned
> about tech debt in the midterm, these deprecated stuff might just go
> away.

We should avoid calling bison with -y since the parser simply isn't
POSIX yacc compatible. I found a trick somewhere in WWW to do that (one
has to substitute AC_PROG_YACC) but lost the reference again. But after
doing so, there was a problem with file names I failed to resolve.
Hence why I resorted to just passing -Wno-yacc.

Cheers, Phil
