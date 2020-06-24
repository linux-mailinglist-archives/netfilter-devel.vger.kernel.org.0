Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E25207197
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2020 12:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbgFXKzb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Jun 2020 06:55:31 -0400
Received: from correo.us.es ([193.147.175.20]:45302 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbgFXKza (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:55:30 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C15E6E8E86
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Jun 2020 12:55:29 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B2DB8DA84A
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Jun 2020 12:55:29 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B1C11DA840; Wed, 24 Jun 2020 12:55:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 736E2DA796;
        Wed, 24 Jun 2020 12:55:27 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 24 Jun 2020 12:55:27 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5790242EF42A;
        Wed, 24 Jun 2020 12:55:27 +0200 (CEST)
Date:   Wed, 24 Jun 2020 12:55:26 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Daniel =?iso-8859-1?Q?Gr=F6ber?= <dxld@darkboxed.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnf_ct resend PATCH 5/8] Add asizeof() macro
Message-ID: <20200624105526.GA20575@salvia>
References: <20200623123403.31676-1-dxld@darkboxed.org>
 <20200623123403.31676-6-dxld@darkboxed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200623123403.31676-6-dxld@darkboxed.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:34:00PM +0200, Daniel Gröber wrote:
> Signed-off-by: Daniel Gröber <dxld@darkboxed.org>
> ---
>  include/internal/internal.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/internal/internal.h b/include/internal/internal.h
> index 859724b..68c5ef0 100644
> --- a/include/internal/internal.h
> +++ b/include/internal/internal.h
> @@ -40,6 +40,8 @@
>  #define IPPROTO_DCCP 33
>  #endif
>  
> +#define asizeof(x) (sizeof(x) / sizeof(*x))

Please call this ARRAY_SIZE.

Thanks.
