Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995D3221409
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jul 2020 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgGOSOj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Jul 2020 14:14:39 -0400
Received: from correo.us.es ([193.147.175.20]:55386 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgGOSOj (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:14:39 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 51B711F0CEE
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Jul 2020 20:14:36 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 43532DA791
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Jul 2020 20:14:36 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 384B6DA78A; Wed, 15 Jul 2020 20:14:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A5B30DA78A;
        Wed, 15 Jul 2020 20:14:33 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 15 Jul 2020 20:14:33 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 89C664265A2F;
        Wed, 15 Jul 2020 20:14:33 +0200 (CEST)
Date:   Wed, 15 Jul 2020 20:14:33 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH] netfilter: include: uapi: Use C99 flexible array
 member
Message-ID: <20200715181433.GA17636@salvia>
References: <20200713111552.25399-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713111552.25399-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

On Mon, Jul 13, 2020 at 01:15:52PM +0200, Phil Sutter wrote:
[...]
> Avoid this warning by declaring 'entries' as an ISO C99 flexible array
> member. This makes gcc aware of the intended use and enables sanity
> checking as described in:
> https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  include/uapi/linux/netfilter_ipv4/ip_tables.h  | 2 +-
>  include/uapi/linux/netfilter_ipv6/ip6_tables.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/netfilter_ipv4/ip_tables.h b/include/uapi/linux/netfilter_ipv4/ip_tables.h
> index 50c7fee625ae9..1a298cc7a29c1 100644
> --- a/include/uapi/linux/netfilter_ipv4/ip_tables.h
> +++ b/include/uapi/linux/netfilter_ipv4/ip_tables.h
> @@ -203,7 +203,7 @@ struct ipt_replace {
>  	struct xt_counters __user *counters;
>  
>  	/* The entries (hang off end: not really an array). */
> -	struct ipt_entry entries[0];
> +	struct ipt_entry entries[];

arpt_replace uses this idiom too.
