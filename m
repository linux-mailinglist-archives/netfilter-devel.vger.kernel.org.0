Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E3F74B4E
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389523AbfGYKOi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 06:14:38 -0400
Received: from mail.us.es ([193.147.175.20]:46754 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389520AbfGYKOi (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:14:38 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 57A54FB44A
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jul 2019 12:14:35 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 47B1F11510A
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jul 2019 12:14:35 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3B6EA115105; Thu, 25 Jul 2019 12:14:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6053F115105;
        Thu, 25 Jul 2019 12:14:32 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 25 Jul 2019 12:14:32 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.183.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 0ADEA4265A31;
        Thu, 25 Jul 2019 12:14:31 +0200 (CEST)
Date:   Thu, 25 Jul 2019 12:14:29 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 2/7] netfilter: nf_tables_offload: add
 offload_actions callback
Message-ID: <20190725101429.mldb64bfhr67254m@salvia>
References: <1563886364-11164-1-git-send-email-wenxu@ucloud.cn>
 <1563886364-11164-3-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563886364-11164-3-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:52:39PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> There will be zero one or serval actions for some expr. such as
> payload set and immediate
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  include/net/netfilter/nf_tables.h         | 7 ++++++-
>  include/net/netfilter/nf_tables_offload.h | 2 --
>  net/netfilter/nf_tables_offload.c         | 4 ++--
>  net/netfilter/nft_immediate.c             | 2 +-
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
> index 9b62456..9285df2 100644
> --- a/include/net/netfilter/nf_tables.h
> +++ b/include/net/netfilter/nf_tables.h
> @@ -785,7 +785,7 @@ struct nft_expr_ops {
>  	int				(*offload)(struct nft_offload_ctx *ctx,
>  						   struct nft_flow_rule *flow,
>  						   const struct nft_expr *expr);
> -	u32				offload_flags;
> +	int				(*offload_actions)(const struct nft_expr *expr);

I don't understand why you need to add this? is it for payload?
