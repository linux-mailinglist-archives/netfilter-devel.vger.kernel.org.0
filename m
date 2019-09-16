Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C91B35F8
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Sep 2019 09:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfIPHxD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Sep 2019 03:53:03 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:60916 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbfIPHxD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:53:03 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i9loe-0007om-R3; Mon, 16 Sep 2019 09:52:56 +0200
Date:   Mon, 16 Sep 2019 09:52:56 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH] nftables: don't crash in 'list ruleset' if policy is not
 set
Message-ID: <20190916075256.GL10656@breakpoint.cc>
References: <20190916073320.2799091-1-slyfox@gentoo.org>
 <801524a6-86ce-620b-f06e-9792a37786cb@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801524a6-86ce-620b-f06e-9792a37786cb@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> Hi Sergei,
> 
> On 9/16/19 9:33 AM, Sergei Trofimovich wrote:
> > Minimal reproducer:
> > 
> > ```
> >   $ cat nft.ruleset
> >     # filters
> >     table inet filter {
> >         chain prerouting {
> >             type filter hook prerouting priority -50
> >         }
> >     }
> > 
> >     # dump new state
> >     list ruleset
> > 
> >   $ nft -c -f ./nft.ruleset
> >     table inet filter {
> >     chain prerouting {
> >     Segmentation fault (core dumped)
> > ```
> > 
> > The crash happens in `chain_print_declaration()`:
> > 
> > ```
> >     if (chain->flags & CHAIN_F_BASECHAIN) {
> >         mpz_export_data(&policy, chain->policy->value,
> >                         BYTEORDER_HOST_ENDIAN, sizeof(int));
> > ```
> > 
> > Here `chain->policy` is `NULL` (as textual rule does not mention it).
> > 
> > The change is not to print the policy if it's not set
> > (similar to `chain_evaluate()` handling).
> 
> Thanks for fixing that. Sorry I missed that we could have a base chain
> without policy.
> 
> Acked-by: Fernando Fernandez Mancera <ffmancera@riseup.net>

Applied, thanks.
