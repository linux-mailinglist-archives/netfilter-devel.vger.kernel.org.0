Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAA319E46
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Feb 2021 13:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBLMWz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 12 Feb 2021 07:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhBLMUu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:20:50 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C75C061574;
        Fri, 12 Feb 2021 04:20:08 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lAXQd-0000cy-AK; Fri, 12 Feb 2021 13:20:07 +0100
Date:   Fri, 12 Feb 2021 13:20:07 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Martin Gignac <martin.gignac@gmail.com>,
        netfilter@vger.kernel.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: Unable to create a chain called "trace"
Message-ID: <20210212122007.GE2766@breakpoint.cc>
References: <CANf9dFMJN5ZsihtygUnEWB_9T=WLbEHrZY1a5mTqLgN7J39D5w@mail.gmail.com>
 <20210208154915.GF16570@breakpoint.cc>
 <20210208164750.GM3158@orbyte.nwl.cc>
 <20210208171444.GH16570@breakpoint.cc>
 <20210209135625.GN3158@orbyte.nwl.cc>
 <20210212000507.GD2766@breakpoint.cc>
 <20210212114042.GZ3158@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212114042.GZ3158@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> I didn't find a better way to conditionally parse two following args as
> strings instead of just a single one. Basically I miss an explicit end
> condition from which to call BEGIN(0).

Yes, thats part of the problem.

> > Seems we need allow "{" for "*" and then count the {} nests so
> > we can pop off a scanner state stack once we make it back to the
> > same } level that we had at the last state switch.
> 
> What is the problem?

Detect when we need to exit the current start condition.

We may not even be able to do BEGIN(0) if we have multiple, nested
start conditionals. flex supports start condition stacks, but that
still leaves the exit/closure issue.

Example:

table chain {
 chain bla {  /* should start to recognize rules, but
		 we did not see 'rule' keyword */
	ip saddr { ... } /* can't exit rule start condition on } ... */
	ip daddr { ... }
 }  /* should disable rule keywords again */

 chain dynamic { /* so 'dynamic' is a string here ... */
 }
}

I don't see a solution, perhaps add dummy bison rule(s)
to explicitly signal closure of e.g. a rule context?
