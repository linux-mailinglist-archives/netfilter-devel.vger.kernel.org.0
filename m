Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FD231E019
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Feb 2021 21:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhBQURK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Feb 2021 15:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbhBQURA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:17:00 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0F9C061756;
        Wed, 17 Feb 2021 12:16:20 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lCTFC-0003FU-Dy; Wed, 17 Feb 2021 21:16:18 +0100
Date:   Wed, 17 Feb 2021 21:16:18 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Martin Gignac <martin.gignac@gmail.com>,
        netfilter@vger.kernel.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: Unable to create a chain called "trace"
Message-ID: <20210217201618.GI2766@breakpoint.cc>
References: <CANf9dFMJN5ZsihtygUnEWB_9T=WLbEHrZY1a5mTqLgN7J39D5w@mail.gmail.com>
 <20210208154915.GF16570@breakpoint.cc>
 <20210208164750.GM3158@orbyte.nwl.cc>
 <20210208171444.GH16570@breakpoint.cc>
 <20210209135625.GN3158@orbyte.nwl.cc>
 <20210212000507.GD2766@breakpoint.cc>
 <20210212114042.GZ3158@orbyte.nwl.cc>
 <20210212122007.GE2766@breakpoint.cc>
 <20210217195937.GA22016@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217195937.GA22016@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> > I don't see a solution, perhaps add dummy bison rule(s)
> > to explicitly signal closure of e.g. a rule context?
> 
> We can't influence start conditions from within bison (if that's what
> you had in mind).

Why not?  in scanner.l:

void scanner_pop_start_cond(void *scanner)
{
        yy_pop_state(scanner);
}

And then call it from bison as 'scanner_pop_start_cond(nft->scanner)'.

Needs %stack in scanner.l so yy_pop_state() is defined.

bison has more clue as to when a expression/rule/set block etc
has finished parsing than the scanner.

Not sure tracking { } nesting depth is enough with a pure scanner.l
approach.
