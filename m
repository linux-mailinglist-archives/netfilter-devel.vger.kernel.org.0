Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996F831E2E4
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Feb 2021 00:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhBQXBr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Feb 2021 18:01:47 -0500
Received: from correo.us.es ([193.147.175.20]:55050 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhBQXBp (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:01:45 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id ADC10D28CB
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Feb 2021 00:01:03 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9DD94DA722
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Feb 2021 00:01:03 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9339BDA797; Thu, 18 Feb 2021 00:01:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-105.9 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,USER_IN_WELCOMELIST,
        USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 58EFADA794;
        Thu, 18 Feb 2021 00:01:01 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 18 Feb 2021 00:01:01 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 36CBF42DC6E2;
        Thu, 18 Feb 2021 00:01:01 +0100 (CET)
Date:   Thu, 18 Feb 2021 00:01:00 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Maya Rashish <mrashish@redhat.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 2/2] Avoid out of bounds read from data
Message-ID: <20210217230100.GB32290@salvia>
References: <152a0191-c777-2b57-0775-ba94a59c74a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <152a0191-c777-2b57-0775-ba94a59c74a0@redhat.com>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 17, 2021 at 10:46:50PM +0200, Maya Rashish wrote:
> This might introduce some issues since we're now not
> filling the rest of the memory, but filling out with
> uninitialized garbage is probably as bad as leaving it
> as garbage.

What are you trying to fix?

Caller sends pass data as parameter that is smaller than
sizeof(ctr->byte)?

Thanks.

> Signed-off-by: Maya Rashish <mrashish@redhat.com>
> ---
>  include/utils.h    | 2 ++
>  src/expr/counter.c | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/utils.h b/include/utils.h
> index 8af5a8e..7413534 100644
> --- a/include/utils.h
> +++ b/include/utils.h
> @@ -67,6 +67,8 @@ void __nftnl_assert_attr_exists(uint16_t attr, uint16_t attr_max,
> 
>  #define array_size(arr)		(sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
> 
> +#define	MIN(a,b)		(a>b ? (b) : (a))
> +
>  const char *nftnl_family2str(uint32_t family);
>  int nftnl_str2family(const char *family);
> 
> diff --git a/src/expr/counter.c b/src/expr/counter.c
> index 89a602e..fb036dd 100644
> --- a/src/expr/counter.c
> +++ b/src/expr/counter.c
> @@ -35,10 +35,10 @@ nftnl_expr_counter_set(struct nftnl_expr *e, uint16_t type,
> 
>  	switch(type) {
>  	case NFTNL_EXPR_CTR_BYTES:
> -		memcpy(&ctr->bytes, data, sizeof(ctr->bytes));
> +		memcpy(&ctr->bytes, data, MIN(data_len, sizeof(ctr->bytes)));
>  		break;
>  	case NFTNL_EXPR_CTR_PACKETS:
> -		memcpy(&ctr->pkts, data, sizeof(ctr->pkts));
> +		memcpy(&ctr->pkts, data, MIN(data_len, sizeof(ctr->pkts)));
>  		break;
>  	default:
>  		return -1;
> -- 
> 2.29.2
> 
