Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9FEDD8CF
	for <lists+netfilter-devel@lfdr.de>; Sat, 19 Oct 2019 15:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfJSNee (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 19 Oct 2019 09:34:34 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:39690 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbfJSNed (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 19 Oct 2019 09:34:33 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iLosJ-0001rx-3D; Sat, 19 Oct 2019 15:34:31 +0200
Date:   Sat, 19 Oct 2019 15:34:31 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] xtables-restore: Fix --table parameter check
Message-ID: <20191019133431.GD25052@breakpoint.cc>
References: <20190920154920.7927-1-phil@nwl.cc>
 <20191018140508.GB25052@breakpoint.cc>
 <20191018144806.GG26123@orbyte.nwl.cc>
 <20191018205808.GC25052@breakpoint.cc>
 <20191019101526.GI26123@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019101526.GI26123@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> I don't quite like this check, hence I don't overly cling to it. As you
> see, checking for presence of an option in getopt() format is not easy
> and we do that for every option of every rule in a dump. Maybe we should
> really just append the explicit table param and accept that user's table
> option is not rejected but simply ignored.

I'd propose that you just push this patch out, with a few addiotnal
comments.

E.g. test script could have

# First a few inputs that should not be mistaken
# for a "-t" option:
OKLINES=
...
# Variants of -t, --table, etc. including
# multiple, concatenated short options.
NONOLINES...

For the actual code I will leave it up to you, perhaps
just include examples, e.g.

/* must catch inputs like --tab=mangle, too */
if (index(s, '=')), ..

...

As for the last part, maybe either convert it to
a loop instead of goto, or at least return right away
in match case, i.e.

switch (*s) {
case 't': return true;
case ' ': return false; /* end of options */
case '\0': return false; /* no 't' found */
