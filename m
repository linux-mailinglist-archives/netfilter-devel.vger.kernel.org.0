Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A210F1564
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Nov 2019 12:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfKFLra (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Nov 2019 06:47:30 -0500
Received: from correo.us.es ([193.147.175.20]:37566 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfKFLr3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:47:29 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 66DC6BAE80
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Nov 2019 12:47:25 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 584C0D1929
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Nov 2019 12:47:25 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4D8F6D1DBB; Wed,  6 Nov 2019 12:47:25 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2BC0480132;
        Wed,  6 Nov 2019 12:47:23 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 06 Nov 2019 12:47:23 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 05CBC4251480;
        Wed,  6 Nov 2019 12:47:22 +0100 (CET)
Date:   Wed, 6 Nov 2019 12:47:24 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] doc: Drop incorrect requirement for nft configs
Message-ID: <20191106114724.mscqhcyttwm7ydos@salvia>
References: <20191105131439.31826-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105131439.31826-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 05, 2019 at 02:14:39PM +0100, Phil Sutter wrote:
> The shebang is not needed in files to be used with --file parameter.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Right, this is actually handled as a comment right now, not as an
indication of what binary the user would like to use.

It should be possible to implement the shebang for nft if you think
this is useful.

Thanks.

> ---
>  doc/nft.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/doc/nft.txt b/doc/nft.txt
> index ed2157638032a..c53327e25833d 100644
> --- a/doc/nft.txt
> +++ b/doc/nft.txt
> @@ -85,8 +85,7 @@ For a full summary of options, run *nft --help*.
>  
>  *-f*::
>  *--file 'filename'*::
> -	Read input from 'filename'. If 'filename' is -, read from stdin. +
> -	nft scripts must start *#!/usr/sbin/nft -f*
> +	Read input from 'filename'. If 'filename' is -, read from stdin.
>  
>  *-i*::
>  *--interactive*::
> -- 
> 2.23.0
> 
