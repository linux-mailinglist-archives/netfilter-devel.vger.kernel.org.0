Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363611EC58
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 May 2019 12:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfEOKt3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 May 2019 06:49:29 -0400
Received: from mx1.riseup.net ([198.252.153.129]:57240 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfEOKt3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 May 2019 06:49:29 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id A058D1A01F3;
        Wed, 15 May 2019 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1557917368; bh=vbFGIutch89qKJX+I44gIGNMjghzwfncVkmeRMWj1uE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=WCIoiDfQJGd3eaDuctKWpG2LbB07SW+jFu2kenHUzlruB7mUjSpd77tSesdmxg/dv
         nTQESrNE97a6ZUnKorrWV1T+ksNY4INePrv3w0zQ73SCARM1Dmr2rZ7JO6RUTtYSk9
         dB4YEDlKr2GhElJXweCxZLsEZfyztOCqCbz7ePpQ=
X-Riseup-User-ID: A0A4E19A0B9FAF2A4501E139DBA143ABCD3315100245F9C7CC1BC195FC7D02CF
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 8C2CA120553;
        Wed, 15 May 2019 03:49:27 -0700 (PDT)
Subject: Re: [PATCH 2/2 nft] jump: Allow goto and jump to a variable using nft
 input files
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
References: <20190514211340.913-1-ffmancera@riseup.net>
 <20190514211340.913-2-ffmancera@riseup.net>
 <20190515104652.GZ4851@orbyte.nwl.cc>
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
Openpgp: preference=signencrypt
Message-ID: <2956adee-9781-90b8-a668-12800e425e5e@riseup.net>
Date:   Wed, 15 May 2019 12:49:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190515104652.GZ4851@orbyte.nwl.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On 5/15/19 12:46 PM, Phil Sutter wrote:
> Hi,
> 
> On Tue, May 14, 2019 at 11:13:40PM +0200, Fernando Fernandez Mancera wrote:
>> This patch introduces the use of nft input files variables in 'jump' and 'goto'
>> statements, e.g.
>>
>> define dest = ber
>>
>> add table ip foo
>> add chain ip foo bar {type filter hook input priority 0;}
>> add chain ip foo ber
>> add rule ip foo ber counter
>> add rule ip foo bar jump $dest
>>
>> table ip foo {
>> 	chain bar {
>> 		type filter hook input priority filter; policy accept;
>> 		jump ber
>> 	}
>>
>> 	chain ber {
>> 		counter packets 71 bytes 6664
>> 	}
>> }
>>
>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
>> ---
>>  src/datatype.c     | 11 +++++++++++
>>  src/parser_bison.y |  6 +++++-
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/datatype.c b/src/datatype.c
>> index 6aaf9ea..7e9ec5e 100644
>> --- a/src/datatype.c
>> +++ b/src/datatype.c
>> @@ -297,11 +297,22 @@ static void verdict_type_print(const struct expr *expr, struct output_ctx *octx)
>>  	}
>>  }
>>  
>> +static struct error_record *verdict_type_parse(const struct expr *sym,
>> +					       struct expr **res)
>> +{
>> +	*res = constant_expr_alloc(&sym->location, &string_type,
>> +				   BYTEORDER_HOST_ENDIAN,
>> +				   (strlen(sym->identifier) + 1) * BITS_PER_BYTE,
>> +				   sym->identifier);
>> +	return NULL;
>> +}
>> +
>>  const struct datatype verdict_type = {
>>  	.type		= TYPE_VERDICT,
>>  	.name		= "verdict",
>>  	.desc		= "netfilter verdict",
>>  	.print		= verdict_type_print,
>> +	.parse		= verdict_type_parse,
>>  };
>>  
>>  static const struct symbol_table nfproto_tbl = {
>> diff --git a/src/parser_bison.y b/src/parser_bison.y
>> index 69b5773..a955cb5 100644
>> --- a/src/parser_bison.y
>> +++ b/src/parser_bison.y
>> @@ -3841,7 +3841,11 @@ verdict_expr		:	ACCEPT
>>  			}
>>  			;
>>  
>> -chain_expr		:	identifier
>> +chain_expr		:	variable_expr
>> +			{
>> +				$$ = $1;
>> +			}
> 
> Are you sure this is needed? The provided code should be what bison does
> by default if no body was given.
> 

Yes, you are right! Thanks to point that. I am going to remove it in the
next patch series.

> Cheers, Phil
> 

