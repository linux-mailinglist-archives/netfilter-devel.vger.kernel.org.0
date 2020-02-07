Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419D3155680
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Feb 2020 12:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgBGLSP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Feb 2020 06:18:15 -0500
Received: from correo.us.es ([193.147.175.20]:54712 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGLSP (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:18:15 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C7A2C102CAF
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Feb 2020 12:18:14 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BBDC4DA714
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Feb 2020 12:18:14 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B1216DA710; Fri,  7 Feb 2020 12:18:14 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DA887DA70E;
        Fri,  7 Feb 2020 12:18:12 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 07 Feb 2020 12:18:12 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B3B1D42EF42D;
        Fri,  7 Feb 2020 12:18:12 +0100 (CET)
Date:   Fri, 7 Feb 2020 12:18:11 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Kadlecsik =?iso-8859-1?Q?J=F3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>, Phil Sutter <phil@nwl.cc>
Subject: Re: [PATCH nft v4 3/4] src: Add support for concatenated set ranges
Message-ID: <20200207111811.rybiyyacprywswig@salvia>
References: <cover.1580342294.git.sbrivio@redhat.com>
 <92d2e10dda6dbb8443383606bde835ca1e9da834.1580342294.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92d2e10dda6dbb8443383606bde835ca1e9da834.1580342294.git.sbrivio@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jan 30, 2020 at 01:16:57AM +0100, Stefano Brivio wrote:
> diff --git a/src/evaluate.c b/src/evaluate.c
> index 55591f5f3526..208250715e1f 100644
> --- a/src/evaluate.c
> +++ b/src/evaluate.c
> @@ -136,6 +136,11 @@ static int byteorder_conversion(struct eval_ctx *ctx, struct expr **expr,
>  
>  	if ((*expr)->byteorder == byteorder)
>  		return 0;
> +
> +	/* Conversion for EXPR_CONCAT is handled for single composing ranges */
> +	if ((*expr)->etype == EXPR_CONCAT)
> +		return 0;

Are you also sure this is correct?

This code was probably not exercised before with non-range
concatenations.

Thanks.

> +
>  	if (expr_basetype(*expr)->type != TYPE_INTEGER)
>  		return expr_error(ctx->msgs, *expr,
>  			 	  "Byteorder mismatch: expected %s, got %s",
