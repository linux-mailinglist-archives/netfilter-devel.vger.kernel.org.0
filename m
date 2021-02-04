Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0830D05D
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Feb 2021 01:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhBCAjS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Feb 2021 19:39:18 -0500
Received: from correo.us.es ([193.147.175.20]:57094 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232289AbhBCAjR (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Feb 2021 19:39:17 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0E8181C41C2
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Feb 2021 01:38:35 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 16E40DA704
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Feb 2021 01:38:35 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0C058DA730; Wed,  3 Feb 2021 01:38:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-106.1 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,URIBL_BLOCKED,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D4EC8DA704;
        Wed,  3 Feb 2021 01:38:32 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 03 Feb 2021 01:38:32 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AC6C942DF561;
        Wed,  3 Feb 2021 01:38:32 +0100 (CET)
Date:   Wed, 3 Feb 2021 01:38:32 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] erec: Sanitize erec location indesc
Message-ID: <20210203003832.GA30866@salvia>
References: <20210126175502.9171-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210126175502.9171-1-phil@nwl.cc>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

On Tue, Jan 26, 2021 at 06:55:02PM +0100, Phil Sutter wrote:
> erec_print() unconditionally dereferences erec->locations->indesc, so
> make sure it is valid when either creating an erec or adding a location.

I guess your're trigger a bug where erec is indesc is NULL, thing is
that indesc should be always set on. Is there a reproducer for this bug?

> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  src/erec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/erec.c b/src/erec.c
> index c550a596b38c8..5c3351a512464 100644
> --- a/src/erec.c
> +++ b/src/erec.c
> @@ -38,7 +38,8 @@ void erec_add_location(struct error_record *erec, const struct location *loc)
>  {
>  	assert(erec->num_locations < EREC_LOCATIONS_MAX);
>  	erec->locations[erec->num_locations] = *loc;
> -	erec->locations[erec->num_locations].indesc = loc->indesc;
> +	erec->locations[erec->num_locations].indesc = loc->indesc ?
> +						    : &internal_indesc;
>  	erec->num_locations++;
>  }
>  
> -- 
> 2.28.0
> 
