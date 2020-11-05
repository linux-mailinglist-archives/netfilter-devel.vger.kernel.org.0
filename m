Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE472A8276
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Nov 2020 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgKEPpL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Nov 2020 10:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbgKEPpK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:45:10 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC38DC0613CF
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Nov 2020 07:45:10 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kahRl-0006l6-GZ; Thu, 05 Nov 2020 16:45:09 +0100
Date:   Thu, 5 Nov 2020 16:45:09 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 1/7] parser: merge sack-perm/sack-permitted and
 maxseg/mss
Message-ID: <20201105154509.GA25824@breakpoint.cc>
References: <20201105141144.31430-1-fw@strlen.de>
 <20201105141144.31430-2-fw@strlen.de>
 <20201105152256.GA3399@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105152256.GA3399@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> > -			|	MAXSEG		{ $$ = TCPOPTHDR_MAXSEG; }
> > +			|	MSS  	  	{ $$ = TCPOPTHDR_MAXSEG; }
> > +			|	SACK_PERM	{ $$ = TCPOPTHDR_SACK_PERMITTED; }
> >  			|	WINDOW		{ $$ = TCPOPTHDR_WINDOW; }
> > -			|	SACK_PERMITTED	{ $$ = TCPOPTHDR_SACK_PERMITTED; }
> > +			|	WSCALE		{ $$ = TCPOPTHDR_WINDOW; }
> 
> Did you mean to add this here?

Right, this could be a distinct change.

ATM there is
... synproxy ... wscale
and
... tcp option window ...

Like the sack-perm vs. sack-permitted mess it probably
makes sense to get rid of one of those tokens so both work
interchangeably, i.e.

tcp option wscale
and
tcp option window
are the same.

I will remove this chunk before pushing it out.
