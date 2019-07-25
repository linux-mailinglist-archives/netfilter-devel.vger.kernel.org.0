Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BC074A4B
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 11:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfGYJsd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 05:48:33 -0400
Received: from mail.us.es ([193.147.175.20]:35160 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfGYJsd (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:48:33 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2A0FEFB362
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jul 2019 11:48:31 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 19A5811510D
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jul 2019 11:48:31 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0F3BE11510A; Thu, 25 Jul 2019 11:48:31 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0F20D115104;
        Thu, 25 Jul 2019 11:48:29 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 25 Jul 2019 11:48:26 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.183.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A7BC34265A2F;
        Thu, 25 Jul 2019 11:48:28 +0200 (CEST)
Date:   Thu, 25 Jul 2019 11:48:26 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 3/7] netfilter: nft_table_offload: Add rtnl for
 chain and rule operations
Message-ID: <20190725094826.kv7cvjsiykuwr6em@salvia>
References: <1563886364-11164-1-git-send-email-wenxu@ucloud.cn>
 <1563886364-11164-4-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563886364-11164-4-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:52:40PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> The nft_setup_cb_call and ndo_setup_tc callback should be under rtnl lock
> 
> or it will report:
> kernel: RTNL: assertion failed at
> drivers/net/ethernet/mellanox/mlx5/core/en_rep.c (635)
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  net/netfilter/nf_tables_offload.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> index 33543f5..3e1a1a8 100644
> --- a/net/netfilter/nf_tables_offload.c
> +++ b/net/netfilter/nf_tables_offload.c
> @@ -115,14 +115,18 @@ static int nft_setup_cb_call(struct nft_base_chain *basechain,
>  			     enum tc_setup_type type, void *type_data)
>  {
>  	struct flow_block_cb *block_cb;
> -	int err;
> +	int err = 0;
>  
> +	rtnl_lock();

Please, have a look at 90d2723c6d4cb2ace50fc3b932a2bcc77710450b and
review if this assumption is correct. Probably nfnl_lock() is missing
from __nft_release_basechain().

I'd like to avoid grabbing the rtnl_lock().
