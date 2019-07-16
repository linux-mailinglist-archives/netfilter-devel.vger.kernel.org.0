Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1966AE26
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jul 2019 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbfGPSH0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Jul 2019 14:07:26 -0400
Received: from mail.us.es ([193.147.175.20]:52148 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387949AbfGPSH0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:07:26 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 244F8C04A2
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Jul 2019 20:07:24 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 144ABFF6CC
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Jul 2019 20:07:24 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0A2D39615A; Tue, 16 Jul 2019 20:07:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1EC10A6AA;
        Tue, 16 Jul 2019 20:07:22 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 16 Jul 2019 20:07:22 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id F0CE040705C3;
        Tue, 16 Jul 2019 20:07:21 +0200 (CEST)
Date:   Tue, 16 Jul 2019 20:07:21 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 2/2 nft WIP] src: allow variables in chain priority
Message-ID: <20190716180721.kowzcch7bxm6hpk4@salvia>
References: <20190716090812.873-1-ffmancera@riseup.net>
 <20190716090812.873-3-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716090812.873-3-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:08:14AM +0200, Fernando Fernandez Mancera wrote:
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> ---
>  src/parser_bison.y | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/parser_bison.y b/src/parser_bison.y
> index c6a43cf..d55a5fc 100644
> --- a/src/parser_bison.y
> +++ b/src/parser_bison.y
> @@ -1926,7 +1926,8 @@ extended_prio_name	:	OUT
>  			|	STRING
>  			;
>  
> -prio_expr		:	extended_prio_name
> +prio_expr		:	variable_expr
> +			|	extended_prio_name

This patch is small and I think it belongs to the previous patch,
please squash it to 1/2.

Thanks Fernando.
