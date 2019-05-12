Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B81ADCA
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 May 2019 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfELSb5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 12 May 2019 14:31:57 -0400
Received: from mail.us.es ([193.147.175.20]:44302 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfELSb4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 12 May 2019 14:31:56 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A0F291A0988
        for <netfilter-devel@vger.kernel.org>; Sun, 12 May 2019 20:31:54 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8EB35DA701
        for <netfilter-devel@vger.kernel.org>; Sun, 12 May 2019 20:31:54 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 12B25DA713; Sun, 12 May 2019 20:31:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1960ADA708;
        Sun, 12 May 2019 20:31:33 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 12 May 2019 20:31:33 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id EAC8B4265A5B;
        Sun, 12 May 2019 20:31:32 +0200 (CEST)
Date:   Sun, 12 May 2019 20:31:32 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft WIP] jump: Allow jump to a variable when using nft
 input files
Message-ID: <20190512183132.nk2zjjlat46gu3s7@salvia>
References: <20190509113358.856-1-ffmancera@riseup.net>
 <20190509145701.bwg5wrkv47eahhlp@salvia>
 <23cad3e6-a0d2-d19d-03df-0aab6258417f@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23cad3e6-a0d2-d19d-03df-0aab6258417f@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, May 12, 2019 at 08:16:19PM +0200, Fernando Fernandez Mancera wrote:
> diff --git a/src/parser_bison.y b/src/parser_bison.y
> index 9aea652..5f61b14 100644
> --- a/src/parser_bison.y
> +++ b/src/parser_bison.y
[...]
> @@ -3841,6 +3841,14 @@ verdict_expr		:	ACCEPT
>  			}
>  			;
> 
> +chain_expr		:	identifier
> +			{
> +				$$ = constant_expr_alloc(&@$, &string_type,
> +							 BYTEORDER_HOST_ENDIAN,
> +							 sizeof($1) * BITS_PER_BYTE, &$1);

I think you should use NFT_NAME_MAXLEN instead of sizeof($1) here.

> +			}
> +			;
> +
>  meta_expr		:	META	meta_key
>  			{
>  				$$ = meta_expr_alloc(&@$, $2);
> -- 
> 2.20.1
