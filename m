Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5ABA4F18
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Sep 2019 08:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfIBGM3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Sep 2019 02:12:29 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:48349 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBGM2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Sep 2019 02:12:28 -0400
Received: from [192.168.188.14] (unknown [120.132.1.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id B764A419F9;
        Mon,  2 Sep 2019 14:12:16 +0800 (CST)
Subject: Re: [PATCH nf-next v5 1/2] netfilter: nf_flow_offload: add net in
 offload_ctx
From:   wenxu <wenxu@ucloud.cn>
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
References: <1566363399-30976-1-git-send-email-wenxu@ucloud.cn>
 <1566363399-30976-2-git-send-email-wenxu@ucloud.cn>
Message-ID: <947c63d8-29c1-b611-bc2a-a4bf2d2cb1cb@ucloud.cn>
Date:   Mon, 2 Sep 2019 14:12:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566363399-30976-2-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSUhIS0tLSk5CSU1ITUpZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MEk6DDo4Ijg2MTEWCAweURJC
        CRcaCxpVSlVKTk1MT0tPTEhNQ0JMVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJS1VK
        SElVSlVJSU1ZV1kIAVlBSENPTDcG
X-HM-Tid: 0a6cf09a41452086kuqyb764a419f9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi  pablo,

How about this series?

BR

wenxu

On 8/21/2019 12:56 PM, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
>
> In the offload_ctx, the net can be used for other actions
> such as fwd netdev
>
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
> v5: no change
>
>  include/net/netfilter/nf_tables_offload.h | 3 ++-
>  net/netfilter/nf_tables_api.c             | 2 +-
>  net/netfilter/nf_tables_offload.c         | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/netfilter/nf_tables_offload.h b/include/net/netfilter/nf_tables_offload.h
> index 8a5969d9..71453fd 100644
> --- a/include/net/netfilter/nf_tables_offload.h
> +++ b/include/net/netfilter/nf_tables_offload.h
> @@ -25,6 +25,7 @@ struct nft_offload_ctx {
>  		__be16				l3num;
>  		u8				protonum;
>  	} dep;
> +	struct net *net;
>  	unsigned int				num_actions;
>  	struct nft_offload_reg			regs[NFT_REG32_15 + 1];
>  };
> @@ -61,7 +62,7 @@ struct nft_flow_rule {
>  #define NFT_OFFLOAD_F_ACTION	(1 << 0)
>  
>  struct nft_rule;
> -struct nft_flow_rule *nft_flow_rule_create(const struct nft_rule *rule);
> +struct nft_flow_rule *nft_flow_rule_create(struct net *net, const struct nft_rule *rule);
>  void nft_flow_rule_destroy(struct nft_flow_rule *flow);
>  int nft_flow_rule_offload_commit(struct net *net);
>  void nft_indr_block_get_and_ing_cmd(struct net_device *dev,
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index fe3b7b0..d4f611a 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -2844,7 +2844,7 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
>  		return nft_table_validate(net, table);
>  
>  	if (chain->flags & NFT_CHAIN_HW_OFFLOAD) {
> -		flow = nft_flow_rule_create(rule);
> +		flow = nft_flow_rule_create(net, rule);
>  		if (IS_ERR(flow))
>  			return PTR_ERR(flow);
>  
> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> index d3c4c9c..9d9a864 100644
> --- a/net/netfilter/nf_tables_offload.c
> +++ b/net/netfilter/nf_tables_offload.c
> @@ -28,12 +28,13 @@ static struct nft_flow_rule *nft_flow_rule_alloc(int num_actions)
>  	return flow;
>  }
>  
> -struct nft_flow_rule *nft_flow_rule_create(const struct nft_rule *rule)
> +struct nft_flow_rule *nft_flow_rule_create(struct net *net, const struct nft_rule *rule)
>  {
>  	struct nft_offload_ctx ctx = {
>  		.dep	= {
>  			.type	= NFT_OFFLOAD_DEP_UNSPEC,
>  		},
> +		.net = net,
>  	};
>  	struct nft_flow_rule *flow;
>  	int num_actions = 0, err;
