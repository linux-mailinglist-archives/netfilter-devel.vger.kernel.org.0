Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DE42B3490
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Nov 2020 12:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgKOLQ7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 15 Nov 2020 06:16:59 -0500
Received: from correo.us.es ([193.147.175.20]:45028 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgKOLQ6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 15 Nov 2020 06:16:58 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5381AD1621
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Nov 2020 12:16:57 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 43F0BDA72F
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Nov 2020 12:16:57 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 39A73DA722; Sun, 15 Nov 2020 12:16:57 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 334FEDA704;
        Sun, 15 Nov 2020 12:16:55 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 15 Nov 2020 12:16:55 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 176584265A5A;
        Sun, 15 Nov 2020 12:16:55 +0100 (CET)
Date:   Sun, 15 Nov 2020 12:16:54 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnftnl 1/1] bitwise: improve formatting of registers in
 bitwise dumps.
Message-ID: <20201115111654.GA24499@salvia>
References: <20201114173605.244338-1-jeremy@azazel.net>
 <20201114173605.244338-2-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201114173605.244338-2-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Nov 14, 2020 at 05:36:05PM +0000, Jeremy Sowden wrote:
> Registers are formatted as 'reg %u' everywhere apart from in bitwise
> expressions where they are formatted as 'reg=%u'.  Change bitwise to
> match.

LGTM.

But this also needs an update for the nftables tests too, right?

Thanks.

> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
> ---
>  src/expr/bitwise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/expr/bitwise.c b/src/expr/bitwise.c
> index 9ea2f662b3e6..ba379a84485e 100644
> --- a/src/expr/bitwise.c
> +++ b/src/expr/bitwise.c
> @@ -215,7 +215,7 @@ nftnl_expr_bitwise_snprintf_bool(char *buf, size_t size,
>  {
>  	int remain = size, offset = 0, ret;
>  
> -	ret = snprintf(buf, remain, "reg %u = (reg=%u & ",
> +	ret = snprintf(buf, remain, "reg %u = ( reg %u & ",
>  		       bitwise->dreg, bitwise->sreg);
>  	SNPRINTF_BUFFER_SIZE(ret, remain, offset);
>  
> -- 
> 2.29.2
> 
