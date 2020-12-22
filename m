Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583682DD309
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Dec 2020 15:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgLQOde (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Dec 2020 09:33:34 -0500
Received: from correo.us.es ([193.147.175.20]:33654 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgLQOde (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:33:34 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AF110396268
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Dec 2020 15:32:34 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9D38EDA704
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Dec 2020 15:32:34 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 92BCADA73D; Thu, 17 Dec 2020 15:32:34 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7410CDA704;
        Thu, 17 Dec 2020 15:32:32 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 17 Dec 2020 15:32:32 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5278B426CC84;
        Thu, 17 Dec 2020 15:32:32 +0100 (CET)
Date:   Thu, 17 Dec 2020 15:32:49 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] evaluate: Reject quoted strings containing only
 wildcard
Message-ID: <20201217143249.GA20353@salvia>
References: <20200924170639.15842-1-phil@nwl.cc>
 <20200928081925.GZ19674@orbyte.nwl.cc>
 <20200930102033.GA18726@salvia>
 <20201217142340.GT28824@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201217142340.GT28824@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 17, 2020 at 03:23:40PM +0100, Phil Sutter wrote:
> On Wed, Sep 30, 2020 at 12:20:33PM +0200, Pablo Neira Ayuso wrote:
> > On Mon, Sep 28, 2020 at 10:19:25AM +0200, Phil Sutter wrote:
> > > On Thu, Sep 24, 2020 at 07:06:39PM +0200, Phil Sutter wrote:
> > > > Fix for an assertion fail when trying to match against an all-wildcard
> > > > interface name:
> > > > 
> > > > | % nft add rule t c iifname '"*"'
> > > > | nft: expression.c:402: constant_expr_alloc: Assertion `(((len) + (8) - 1) / (8)) > 0' failed.
> > > > | zsh: abort      nft add rule t c iifname '"*"'
> > > > 
> > > > Fix this by detecting the string in expr_evaluate_string() and returning
> > > > an error message:
> > > > 
> > > > | % nft add rule t c iifname '"*"'
> > > > | Error: All-wildcard strings are not supported
> > > > | add rule t c iifname "*"
> > > > |                      ^^^
> > > > 
> > > 
> > > Note that all this is pretty inconsistent: The above happens only for
> > > quoted asterisks. Unquoted ones cause a different error (at least no
> > > assertion fail):
> > > 
> > > | % nft add rule t c iifname '*'
> > > | Error: datatype mismatch, expected network interface name, expression has type integer
> > > | add rule t c iifname *
> > > |              ~~~~~~~ ^
> > > 
> > > What puzzles me is that we have:
> > > 
> > > | wildcard_expr           :       ASTERISK
> > > |                         {
> > > |                                 struct expr *expr;
> > > | 
> > > |                                 expr = constant_expr_alloc(&@$, &integer_type,
> > > |                                                            BYTEORDER_HOST_ENDIAN,
> > > |                                                            0, NULL);
> > > |                                 $$ = prefix_expr_alloc(&@$, expr, 0);
> > > |                         }
> > > |                         ;
> > > 
> > > Yet when trying to use it as a prefix, it is rejected:
> > > 
> > > | % nft add rule t c ip saddr '*'
> > > | Error: datatype mismatch, expected IPv4 address, expression has type integer
> > > | add rule t c ip saddr *
> > > |              ~~~~~~~~ ^
> > > 
> > > So is this wildcard_expr simply broken or didn't I find correct way to use it
> > > yet?
> > 
> > This looks like some preliminary support for wildcard matching in set
> > elements, but my impression is that this is broken. I don't remember
> > to have seen any tests covering this.
> 
> OK. If it needs fixing, I guess that's a different issue. Are you fine
> with the "fix" for asterisk-only interface names for the time being?

I think so, yes.
