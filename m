Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5310E4D5
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Dec 2019 04:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfLBDRI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 1 Dec 2019 22:17:08 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:41786 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfLBDRI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 1 Dec 2019 22:17:08 -0500
Received: from [192.168.188.14] (unknown [120.132.1.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 43BF841CF1;
        Mon,  2 Dec 2019 11:16:51 +0800 (CST)
Subject: Re: [PATCH nf] netfilter: nf_tables_offload: Fix check the
 NETDEV_UNREGISTER in netdev event
From:   wenxu <wenxu@ucloud.cn>
To:     netfilter-devel@vger.kernel.org, pablo@netfilter.org
References: <1573618867-9755-1-git-send-email-wenxu@ucloud.cn>
Message-ID: <a7a98d09-f030-7fe7-b97d-23c9ee1415d5@ucloud.cn>
Date:   Mon, 2 Dec 2019 11:16:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573618867-9755-1-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSEJKS0tLSk5KTUhPSUlZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46Ijo4PzgwAwEOGhpCMTEj
        Dk8aCgJVSlVKTkxOSU5NTUpKT0hDVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJS1VK
        SElVSlVJSU1ZV1kIAVlBSUtMTjcG
X-HM-Tid: 0a6ec49c5a0c2086kuqy43bf841cf1
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi pablo,


Any comments about this patch?


BR

wenxu

On 11/13/2019 12:21 PM, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
>
> It should check the NETDEV_UNREGISTER in  nft_offload_netdev_event
>
> Fixes: 06d392cbe3db ("netfilter: nf_tables_offload: remove rules when the device unregisters")
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  net/netfilter/nf_tables_offload.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> index e25dab8..b002832 100644
> --- a/net/netfilter/nf_tables_offload.c
> +++ b/net/netfilter/nf_tables_offload.c
> @@ -446,6 +446,9 @@ static int nft_offload_netdev_event(struct notifier_block *this,
>  	struct net *net = dev_net(dev);
>  	struct nft_chain *chain;
>  
> +	if (event != NETDEV_UNREGISTER)
> +		return 0;
> +
>  	mutex_lock(&net->nft.commit_mutex);
>  	chain = __nft_offload_get_chain(dev);
>  	if (chain)
