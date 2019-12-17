Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39948122ADE
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Dec 2019 13:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfLQMEr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Dec 2019 07:04:47 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:60700 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfLQMEr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:04:47 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1ihBan-0001US-KF; Tue, 17 Dec 2019 13:04:45 +0100
Date:   Tue, 17 Dec 2019 13:04:45 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nft,RFC] main: remove need to escape quotes
Message-ID: <20191217120445.GA8553@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, fw@strlen.de
References: <20191216214157.551511-1-pablo@netfilter.org>
 <20191217004257.GI14465@orbyte.nwl.cc>
 <20191217103509.nj4wsu7y2wyjpdyp@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217103509.nj4wsu7y2wyjpdyp@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Tue, Dec 17, 2019 at 11:42:51AM +0100, Pablo Neira Ayuso wrote:
> On Tue, Dec 17, 2019 at 01:42:57AM +0100, Phil Sutter wrote:
> > Hi Pablo,
> > 
> > On Mon, Dec 16, 2019 at 10:41:57PM +0100, Pablo Neira Ayuso wrote:
> > > If argv[i] contains spaces, then restore the quotes on this string.
> > > 
> > > There is one exception though: in case that argc == 2, then assume the
> > > whole input is coming as a quoted string, eg. nft "add rule x ...;add ..."
> > > 
> > > This patch is adjusting a one test that uses quotes to skip escaping one
> > > semicolon from bash. Two more tests do not need them.
> > 
> > I appreciate your efforts at making my BUGS note obsolete. :)
> > In this case though, I wonder if this really fixes something:
> 
> nft add rule x y log prefix "test: "
> 
> instead of
> 
> nft add rule x y log prefix \"test: \"
> 
> > I use quotes in only two cases:
> > 
> > A) When forced by the parser, e.g. with interface names.
> 
> Interface names have no spaces, so this patch fixes nothing there indeed.

Ah, sorry - I mixed that up. There are spots though where quotes are
mandatory, namely in include statement and for ct helper types. The
latter is relevant on cmdline and quotes not being restored there is at
least inconsistent.

Also, we had a longer discussion at NFWS about enforcing quotes for
strings on input (or at least quoting them all on output) to fix for
cases where a recognized keyword was chosen for a name by accident.

> > B) To escape the curly braces (and any semi-colons inside) in chain or
> >    set definitions.
> > 
> > Unless I miss something, case (A) will still need escaped quotes since
> > interface names usually don't contain whitespace. In case (B), your
> > patch would typically bite me as I merely quote the braces, like so:
> > 
> > | # nft add chain inet t c '{ type filter hook input priority filter; policy drop; }'
> 
> You do this trick not to escape three times, ie.
> 
> | #nft add chain inet t c \{ type filter hook input priority filter; policy drop\; \}
> 
> Your trick works fine right now because the argv list is not honored
> by the main function, your quotes to avoid escaping the values will
> result in:
> 
> argv[0] = nft
> argv[1] = add
> argv[2] = chain
> argv[3] = inet
> argv[4] = t
> argv[5] = c
> argv[6] = { type filter hook input priority filter; policy drop; }
> 
> This is not a problem because main translates this into a plain buffer
> to feed the bison parser for the command line mode.
> 
> With my patch, this will still work:
> 
> | # nft 'add chain inet t c { type filter hook input priority filter; policy drop; }'
> 
> So you can still use quotes to avoid escaping, but quotes are
> restricted to the whole command OR to use them to really quote a
> string.
> 
> So I'm debating if it's worth providing a simple and consistent model
> we can document on how to use quotes in nft from the command line, in
> this patch:
> 
> 1) You can quote the whole command to avoid escape characters that
>    have special semantics in your shell, eg. { and ; in zsh. Or ; in bash.
> 
> 2) You do not need to escape quotes anymore as in the example above
>    for log prefix.
> 
> Otherwise, we are allowing for quotes basically anywhere.
> 
> If in the future, we decide to stop using bison for whatever reason
> and we rely on argc and argv, this might make things harder for a new
> parser. Not telling I have an incentive to replace the parser right
> now though.
> 
> > Of course that's a matter of muscle memory, but IIUC, your fix won't
> > work if one wants to pass flags in addition to a quoted command. Or does
> > getopt mangle argc?
> 
> argc is left untouch, it would need to pass it as a pointer to
> getopt_long() to update it. Not related, but getopt mangles argv,
> because it reorders options, it is placing them right before the
> non-options, so optind points to the beginning of what main passes to
> the bison parser. Well actually mangling will not happen anymore if
> the patch to enforce options before command is applied (looks like
> feedback on the mailing list points to that direction).

So this means that neither:

| # nft -a 'add rule t c accept'

nor:

| # nft '-a add rule t c accept'

will work, right?

> Probably not worth the effort and we should start promoting people to
> use the interactive interface for `nft -i'. If autocompletion is
> supported there, then there would be a real incentive for users to
> pick `nft -i'.

ACK.

Cheers, Phil
