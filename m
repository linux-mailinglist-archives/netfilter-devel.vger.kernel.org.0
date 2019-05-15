Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC5D1EDB5
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 May 2019 13:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfEOLMi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 May 2019 07:12:38 -0400
Received: from mail.us.es ([193.147.175.20]:53132 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbfEOLMh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 May 2019 07:12:37 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E41D21D94A5
        for <netfilter-devel@vger.kernel.org>; Wed, 15 May 2019 13:12:34 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D4786DA711
        for <netfilter-devel@vger.kernel.org>; Wed, 15 May 2019 13:12:34 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D36FCDA70B; Wed, 15 May 2019 13:12:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D3D40DA703;
        Wed, 15 May 2019 13:12:32 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 15 May 2019 13:12:32 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AE9804066764;
        Wed, 15 May 2019 13:12:32 +0200 (CEST)
Date:   Wed, 15 May 2019 13:12:32 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 2/2 nft] jump: Allow goto and jump to a variable using
 nft input files
Message-ID: <20190515111232.lu3ifr72mlhfriqc@salvia>
References: <20190514211340.913-1-ffmancera@riseup.net>
 <20190514211340.913-2-ffmancera@riseup.net>
 <20190515105850.GA4851@orbyte.nwl.cc>
 <347917dc-086b-998c-dd2f-b5e4a87b38b1@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347917dc-086b-998c-dd2f-b5e4a87b38b1@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 15, 2019 at 01:02:05PM +0200, Fernando Fernandez Mancera wrote:
> 
> 
> On 5/15/19 12:58 PM, Phil Sutter wrote:
> > Hey,
> > 
> > On Tue, May 14, 2019 at 11:13:40PM +0200, Fernando Fernandez Mancera wrote:
> > [...]
> >> diff --git a/src/datatype.c b/src/datatype.c
> >> index 6aaf9ea..7e9ec5e 100644
> >> --- a/src/datatype.c
> >> +++ b/src/datatype.c
> >> @@ -297,11 +297,22 @@ static void verdict_type_print(const struct expr *expr, struct output_ctx *octx)
> >>  	}
> >>  }
> >>  
> >> +static struct error_record *verdict_type_parse(const struct expr *sym,
> >> +					       struct expr **res)
> >> +{
> >> +	*res = constant_expr_alloc(&sym->location, &string_type,
> >> +				   BYTEORDER_HOST_ENDIAN,
> >> +				   (strlen(sym->identifier) + 1) * BITS_PER_BYTE,
> >> +				   sym->identifier);
> >> +	return NULL;
> >> +}
> > 
> > One more thing: The above lacks error checking of any kind. I *think*
> > this is the place where one should make sure the symbol expression is
> > actually a string (but I'm not quite sure how you do that).
> > 
> > In any case, please try to exploit that variable support in the testcase
> > (or maybe a separate one), just to make sure we don't allow weird
> > things.
> > 
> 
> I think I can get the symbol type and check if it is a string. I will
> check this on the testcase as you said. Thanks!

There's not much we can do in this case I think, have a look at
string_type_parse().
