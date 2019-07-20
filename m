Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0336F093
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jul 2019 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfGTUNw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 16:13:52 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:41354 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfGTUNw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 16:13:52 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hovjq-0007eW-Jl; Sat, 20 Jul 2019 22:13:50 +0200
Date:   Sat, 20 Jul 2019 22:13:50 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 1/2] parser_bison: Get rid of (most) bison compiler
 warnings
Message-ID: <20190720201350.GF32501@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190720185226.8876-1-phil@nwl.cc>
 <20190720194322.ehyg7jlzqtugnacw@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720194322.ehyg7jlzqtugnacw@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jul 20, 2019 at 09:43:22PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Shut the complaints about POSIX incompatibility by passing -Wno-yacc to
> > bison. An alternative would be to not pass -y, but that caused seemingly
> > unsolveable problems with automake and expected file names.
> > 
> > Fix two warnings about deprecated '%pure-parser' and '%error-verbose'
> > statements by replacing them with what bison suggests.
> > 
> > A third warning sadly left in place: Replacing '%name-prefix' by what
> > is suggested leads to compilation errors.
> 
> Can you add those warnings to the changelog before pushing?

Sure!

> I don't see them, even without this patch.

I started seeing them just recently, maybe after the last bison update
(to 3.4.1).

Cheers, Phil
