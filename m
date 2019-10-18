Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B592DC7AE
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfJROsJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Oct 2019 10:48:09 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:44236 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbfJROsI (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:48:08 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iLTXy-0005gq-4c; Fri, 18 Oct 2019 16:48:06 +0200
Date:   Fri, 18 Oct 2019 16:48:06 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] xtables-restore: Fix --table parameter check
Message-ID: <20191018144806.GG26123@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190920154920.7927-1-phil@nwl.cc>
 <20191018140508.GB25052@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018140508.GB25052@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Florian,

On Fri, Oct 18, 2019 at 04:05:08PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Xtables-restore tries to reject rule commands in input which contain a
> > --table parameter (since it is adding this itself based on the previous
> > table line). Sadly getopt_long's flexibility makes it hard to get this
> > check right: Since the last fix, comments starting with a dash and
> > containing a 't' character somewhere later were rejected. Simple
> > example:
> > 
> > | *filter
> > | -A FORWARD -m comment --comment "- allow this one" -j ACCEPT
> > | COMMIT
> > 
> > To hopefully sort this once and for all, introduce is_table_param()
> > which should cover all possible variants of legal and illegal
> > parameters. Also add a test to make sure it does what it is supposed to.
> 
> Thanks for adding a test for this.
> How did you generate it?  The added code is pure voodoo magic to me,
> so I wonder if we can just remove the 'test for -t in iptables-restore
> files' code.

Sorry, I didn't mean to create such unreadable code. I guess after
managing to wrap my head around to understand the old code, the new one
seemed much more clear to me. ;)

The problem with dropping that check is the potential mess we get when
users add '-t' parameter to rules in dumps. While *tables-restore adds
'-t' option for the current table itself, arg parsing in at least
do_commandeb and do_commandx accepts multiple '-t' options (so the last
one wins).

Assuming that this checking for '-t' presence is a mess and we should
get rid of it, I can imagine two alternatives:

1) Disallow multiple '-t' options. A nice and easy solution, but not
   backwards compatible.
2) Make *tables-restore add the '-t' option last. This is a bit of a
   hack and will cause unexpected behaviour for users trying to add '-t'
   option in dumps.

What do you think? Or should I respin after adding a bunch of comments
to is_table_param() to make it more clear?

Thanks, Phil
