Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2920724B80
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 May 2019 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfEUJ2m (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 May 2019 05:28:42 -0400
Received: from mail.us.es ([193.147.175.20]:56938 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfEUJ2l (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 May 2019 05:28:41 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BCFF611EB85
        for <netfilter-devel@vger.kernel.org>; Tue, 21 May 2019 11:28:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id ABC82DA710
        for <netfilter-devel@vger.kernel.org>; Tue, 21 May 2019 11:28:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AAF28DA70F; Tue, 21 May 2019 11:28:39 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A1984DA705;
        Tue, 21 May 2019 11:28:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 21 May 2019 11:28:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (barqueta.lsi.us.es [150.214.188.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 910264265A5B;
        Tue, 21 May 2019 11:28:37 +0200 (CEST)
Date:   Tue, 21 May 2019 11:28:37 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v3 1/2] jump: Introduce chain_expr in jump and goto
 statements
Message-ID: <20190521092837.vd3egt54lvdhynqi@salvia>
References: <20190516204559.28910-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190516204559.28910-1-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 16, 2019 at 10:45:58PM +0200, Fernando Fernandez Mancera wrote:
> Now we can introduce expressions as a chain in jump and goto statements. This
> is going to be used to support variables as a chain in the following patches.

Something is wrong with json:

json.c: In function ‘verdict_expr_json’:
json.c:683:11: warning: assignment from incompatible pointer type
[-Wincompatible-pointer-types]
     chain = expr->chain;
           ^
parser_json.c: In function ‘json_parse_verdict_expr’:
parser_json.c:1086:8: warning: passing argument 3 of
‘verdict_expr_alloc’ from incompatible pointer type
[-Wincompatible-pointer-types]
        chain ? xstrdup(chain) : NULL);
        ^~~~~

Most likely --enable-json missing there.

 diff --git a/src/datatype.c b/src/datatype.c
> index ac9f2af..10f185b 100644
> --- a/src/datatype.c
> +++ b/src/datatype.c
> @@ -254,6 +254,8 @@ const struct datatype invalid_type = {
>  
>  static void verdict_type_print(const struct expr *expr, struct output_ctx *octx)
>  {
> +	char chain[NFT_CHAIN_MAXNAMELEN];
> +
>  	switch (expr->verdict) {
>  	case NFT_CONTINUE:
>  		nft_print(octx, "continue");
> @@ -262,10 +264,26 @@ static void verdict_type_print(const struct expr *expr, struct output_ctx *octx)
>  		nft_print(octx, "break");
>  		break;
>  	case NFT_JUMP:
> -		nft_print(octx, "jump %s", expr->chain);
> +		if (expr->chain->etype == EXPR_VALUE) {
> +			mpz_export_data(chain, expr->chain->value,
> +					BYTEORDER_HOST_ENDIAN,
> +					NFT_CHAIN_MAXNAMELEN);
> +			nft_print(octx, "jump %s", chain);
> +		} else {
> +			nft_print(octx, "jump ");
> +			expr_print(expr->chain, octx);
> +		}

I think this should be fine:

        case NFT_JUMP:
		nft_print(octx, "jump ");
		expr_print(expr->chain, octx);
                break;

Any reason to have the 'if (expr->chain->etype == EXPR_VALUE) {'
check?

>  		break;
>  	case NFT_GOTO:
> -		nft_print(octx, "goto %s", expr->chain);
> +		if (expr->chain->etype == EXPR_VALUE) {
> +			mpz_export_data(chain, expr->chain->value,
> +					BYTEORDER_HOST_ENDIAN,
> +					NFT_CHAIN_MAXNAMELEN);
> +			nft_print(octx, "goto %s", chain);
> +		} else {
> +			nft_print(octx, "goto ");
> +			expr_print(expr->chain, octx);

Same thing here.

Apart from those nitpicks, this looks good :)
