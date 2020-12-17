Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA712DD2FA
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Dec 2020 15:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgLQOYX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Dec 2020 09:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgLQOYX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:24:23 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09DDC061794
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Dec 2020 06:23:42 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kpuBw-00039X-2d; Thu, 17 Dec 2020 15:23:40 +0100
Date:   Thu, 17 Dec 2020 15:23:40 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] evaluate: Reject quoted strings containing only
 wildcard
Message-ID: <20201217142340.GT28824@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200924170639.15842-1-phil@nwl.cc>
 <20200928081925.GZ19674@orbyte.nwl.cc>
 <20200930102033.GA18726@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930102033.GA18726@salvia>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 30, 2020 at 12:20:33PM +0200, Pablo Neira Ayuso wrote:
> On Mon, Sep 28, 2020 at 10:19:25AM +0200, Phil Sutter wrote:
> > On Thu, Sep 24, 2020 at 07:06:39PM +0200, Phil Sutter wrote:
> > > Fix for an assertion fail when trying to match against an all-wildcard
> > > interface name:
> > > 
> > > | % nft add rule t c iifname '"*"'
> > > | nft: expression.c:402: constant_expr_alloc: Assertion `(((len) + (8) - 1) / (8)) > 0' failed.
> > > | zsh: abort      nft add rule t c iifname '"*"'
> > > 
> > > Fix this by detecting the string in expr_evaluate_string() and returning
> > > an error message:
> > > 
> > > | % nft add rule t c iifname '"*"'
> > > | Error: All-wildcard strings are not supported
> > > | add rule t c iifname "*"
> > > |                      ^^^
> > > 
> > 
> > Note that all this is pretty inconsistent: The above happens only for
> > quoted asterisks. Unquoted ones cause a different error (at least no
> > assertion fail):
> > 
> > | % nft add rule t c iifname '*'
> > | Error: datatype mismatch, expected network interface name, expression has type integer
> > | add rule t c iifname *
> > |              ~~~~~~~ ^
> > 
> > What puzzles me is that we have:
> > 
> > | wildcard_expr           :       ASTERISK
> > |                         {
> > |                                 struct expr *expr;
> > | 
> > |                                 expr = constant_expr_alloc(&@$, &integer_type,
> > |                                                            BYTEORDER_HOST_ENDIAN,
> > |                                                            0, NULL);
> > |                                 $$ = prefix_expr_alloc(&@$, expr, 0);
> > |                         }
> > |                         ;
> > 
> > Yet when trying to use it as a prefix, it is rejected:
> > 
> > | % nft add rule t c ip saddr '*'
> > | Error: datatype mismatch, expected IPv4 address, expression has type integer
> > | add rule t c ip saddr *
> > |              ~~~~~~~~ ^
> > 
> > So is this wildcard_expr simply broken or didn't I find correct way to use it
> > yet?
> 
> This looks like some preliminary support for wildcard matching in set
> elements, but my impression is that this is broken. I don't remember
> to have seen any tests covering this.

OK. If it needs fixing, I guess that's a different issue. Are you fine
with the "fix" for asterisk-only interface names for the time being?

Thanks, Phil
