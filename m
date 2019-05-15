Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3E1F43A
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 May 2019 14:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEOMVT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 May 2019 08:21:19 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:50516 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfEOK6v (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 May 2019 06:58:51 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hQrcY-0002KL-33; Wed, 15 May 2019 12:58:50 +0200
Date:   Wed, 15 May 2019 12:58:50 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 2/2 nft] jump: Allow goto and jump to a variable using
 nft input files
Message-ID: <20190515105850.GA4851@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        netfilter-devel@vger.kernel.org
References: <20190514211340.913-1-ffmancera@riseup.net>
 <20190514211340.913-2-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514211340.913-2-ffmancera@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hey,

On Tue, May 14, 2019 at 11:13:40PM +0200, Fernando Fernandez Mancera wrote:
[...]
> diff --git a/src/datatype.c b/src/datatype.c
> index 6aaf9ea..7e9ec5e 100644
> --- a/src/datatype.c
> +++ b/src/datatype.c
> @@ -297,11 +297,22 @@ static void verdict_type_print(const struct expr *expr, struct output_ctx *octx)
>  	}
>  }
>  
> +static struct error_record *verdict_type_parse(const struct expr *sym,
> +					       struct expr **res)
> +{
> +	*res = constant_expr_alloc(&sym->location, &string_type,
> +				   BYTEORDER_HOST_ENDIAN,
> +				   (strlen(sym->identifier) + 1) * BITS_PER_BYTE,
> +				   sym->identifier);
> +	return NULL;
> +}

One more thing: The above lacks error checking of any kind. I *think*
this is the place where one should make sure the symbol expression is
actually a string (but I'm not quite sure how you do that).

In any case, please try to exploit that variable support in the testcase
(or maybe a separate one), just to make sure we don't allow weird
things.

Thanks, Phil
