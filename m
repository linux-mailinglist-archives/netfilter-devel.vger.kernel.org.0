Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 992B11F0A7
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 May 2019 13:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbfEOLqV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 May 2019 07:46:21 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:50608 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfEOLqV (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 May 2019 07:46:21 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hQsMT-0002tC-Rd; Wed, 15 May 2019 13:46:17 +0200
Date:   Wed, 15 May 2019 13:46:17 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 2/2 nft] jump: Allow goto and jump to a variable using
 nft input files
Message-ID: <20190515114617.GB4851@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        netfilter-devel@vger.kernel.org
References: <20190514211340.913-1-ffmancera@riseup.net>
 <20190514211340.913-2-ffmancera@riseup.net>
 <20190515105850.GA4851@orbyte.nwl.cc>
 <347917dc-086b-998c-dd2f-b5e4a87b38b1@riseup.net>
 <20190515111232.lu3ifr72mlhfriqc@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515111232.lu3ifr72mlhfriqc@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 15, 2019 at 01:12:32PM +0200, Pablo Neira Ayuso wrote:
> On Wed, May 15, 2019 at 01:02:05PM +0200, Fernando Fernandez Mancera wrote:
> > 
> > 
> > On 5/15/19 12:58 PM, Phil Sutter wrote:
> > > Hey,
> > > 
> > > On Tue, May 14, 2019 at 11:13:40PM +0200, Fernando Fernandez Mancera wrote:
> > > [...]
> > >> diff --git a/src/datatype.c b/src/datatype.c
> > >> index 6aaf9ea..7e9ec5e 100644
> > >> --- a/src/datatype.c
> > >> +++ b/src/datatype.c
> > >> @@ -297,11 +297,22 @@ static void verdict_type_print(const struct expr *expr, struct output_ctx *octx)
> > >>  	}
> > >>  }
> > >>  
> > >> +static struct error_record *verdict_type_parse(const struct expr *sym,
> > >> +					       struct expr **res)
> > >> +{
> > >> +	*res = constant_expr_alloc(&sym->location, &string_type,
> > >> +				   BYTEORDER_HOST_ENDIAN,
> > >> +				   (strlen(sym->identifier) + 1) * BITS_PER_BYTE,
> > >> +				   sym->identifier);
> > >> +	return NULL;
> > >> +}
> > > 
> > > One more thing: The above lacks error checking of any kind. I *think*
> > > this is the place where one should make sure the symbol expression is
> > > actually a string (but I'm not quite sure how you do that).
> > > 
> > > In any case, please try to exploit that variable support in the testcase
> > > (or maybe a separate one), just to make sure we don't allow weird
> > > things.
> > > 
> > 
> > I think I can get the symbol type and check if it is a string. I will
> > check this on the testcase as you said. Thanks!
> 
> There's not much we can do in this case I think, have a look at
> string_type_parse().

OK, maybe it's not as bad as I feared, symbol_parse() is called only if
we do have a symbol expr. Still I guess we should make sure nft
complains if the variable points to any other primary_expr or a set
reference ('@<something>').

Cheers, Phil
