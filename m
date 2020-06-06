Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59BD1F05EA
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Jun 2020 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgFFJ1L (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Jun 2020 05:27:11 -0400
Received: from correo.us.es ([193.147.175.20]:38820 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFFJ1K (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Jun 2020 05:27:10 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 35047EF746
        for <netfilter-devel@vger.kernel.org>; Sat,  6 Jun 2020 11:27:08 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 265AFDA78B
        for <netfilter-devel@vger.kernel.org>; Sat,  6 Jun 2020 11:27:08 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1BFCADA73F; Sat,  6 Jun 2020 11:27:08 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 72B2ADA73F;
        Sat,  6 Jun 2020 11:27:05 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 06 Jun 2020 11:27:05 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 56F0841E4800;
        Sat,  6 Jun 2020 11:27:05 +0200 (CEST)
Date:   Sat, 6 Jun 2020 11:27:05 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue 1/1] build: dist: Add fixmanpages.sh
 to distribution tree
Message-ID: <20200606092705.GA18613@salvia>
References: <20200606052510.27423-1-duncan_roe@optusnet.com.au>
 <20200606052510.27423-2-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200606052510.27423-2-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jun 06, 2020 at 03:25:10PM +1000, Duncan Roe wrote:
> Tested by running Slackware package builder on libnetfilter_queue-1.0.4.tar.bz2
> created by 'make dist' after applying the patch. Works now, failed before.
> 
> Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
> ---
>  Makefile.am | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile.am b/Makefile.am
> index a5b347b..796f0d0 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -10,3 +10,4 @@ pkgconfigdir = $(libdir)/pkgconfig
>  pkgconfig_DATA = libnetfilter_queue.pc
>  
>  EXTRA_DIST += Make_global.am
> +EXTRA_DIST += fixmanpages.sh

Please, move this script to the 'doxygen' folder.

Thanks.
