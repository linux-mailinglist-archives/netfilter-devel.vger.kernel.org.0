Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85D1130C97
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jan 2020 04:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgAFDkP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 Jan 2020 22:40:15 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:8976 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgAFDkP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:40:15 -0500
Received: from [192.168.188.14] (unknown [120.132.1.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 062F5417CD;
        Mon,  6 Jan 2020 11:40:07 +0800 (CST)
Subject: Re: [PATCH nf,v2] netfilter: flowtable: add nf_flowtable_time_stamp
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200105191042.147509-1-pablo@netfilter.org>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <455b8eea-59db-8f15-4c68-1dc258640cde@ucloud.cn>
Date:   Mon, 6 Jan 2020 11:40:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200105191042.147509-1-pablo@netfilter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSENNS0tLSk5NT0tJTkJZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6Txw*KzgyOD9IVkk*NTYP
        SDlPCRRVSlVKTkxDSUNJS0tDSEpCVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJS1VK
        SElVSlVJSU1ZV1kIAVlBTktKSjcG
X-HM-Tid: 0a6f78f03e242086kuqy062f5417cd
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On 1/6/2020 3:10 AM, Pablo Neira Ayuso wrote:
> This patch adds nf_flowtable_time_stamp and updates the existing code to
> use it.
>
> This patch is also implicitly fixing up hardware statistic fetching via
> nf_flow_offload_stats() where casting to u32 is missing. Use
> nf_flow_timeout_delta() to fix this.
>
> Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload support")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> v2: use nf_flow_timeout_delta()
>
>  include/net/netfilter/nf_flow_table.h | 6 ++++++
>  net/netfilter/nf_flow_table_core.c    | 7 +------
>  net/netfilter/nf_flow_table_ip.c      | 4 ++--
>  net/netfilter/nf_flow_table_offload.c | 4 ++--
>  4 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
> index f0897b3c97fb..03cc74bb2598 100644
> --- a/include/net/netfilter/nf_flow_table.h
> +++ b/include/net/netfilter/nf_flow_table.h
> @@ -106,6 +106,12 @@ struct flow_offload {
>  };
>  
>  #define NF_FLOW_TIMEOUT (30 * HZ)
> +#define nf_flowtable_time_stamp	(u32)jiffies
> +
> +static inline __s32 nf_flow_timeout_delta(unsigned int timeout)
> +{
> +	return (__s32)(timeout - (u32)jiffies);
Maybe this also can replace (u32)jiffies to nf_flowtable_time_stamp.
> +}
>  
>  struct nf_flow_route {
>  	struct {
> diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
> index 9889d52eda82..e33a73cb1f42 100644
> --- a/net/netfilter/nf_flow_table_core.c
> +++ b/net/netfilter/nf_flow_table_core.c
> @@ -134,11 +134,6 @@ static void flow_offload_fixup_tcp(struct ip_ct_tcp *tcp)
>  #define NF_FLOWTABLE_TCP_PICKUP_TIMEOUT	(120 * HZ)
>  #define NF_FLOWTABLE_UDP_PICKUP_TIMEOUT	(30 * HZ)
>  
> -static inline __s32 nf_flow_timeout_delta(unsigned int timeout)
> -{
> -	return (__s32)(timeout - (u32)jiffies);
> -}
> -
>  static void flow_offload_fixup_ct_timeout(struct nf_conn *ct)
>  {
>  	const struct nf_conntrack_l4proto *l4proto;
> @@ -232,7 +227,7 @@ int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
>  {
>  	int err;
>  
> -	flow->timeout = (u32)jiffies + NF_FLOW_TIMEOUT;
> +	flow->timeout = nf_flowtable_time_stamp + NF_FLOW_TIMEOUT;
>  
>  	err = rhashtable_insert_fast(&flow_table->rhashtable,
>  				     &flow->tuplehash[0].node,
> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> index b9e7dd6e60ce..7ea2ddc2aa93 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c
> @@ -280,7 +280,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
>  	if (nf_flow_nat_ip(flow, skb, thoff, dir) < 0)
>  		return NF_DROP;
>  
> -	flow->timeout = (u32)jiffies + NF_FLOW_TIMEOUT;
> +	flow->timeout = nf_flowtable_time_stamp + NF_FLOW_TIMEOUT;
>  	iph = ip_hdr(skb);
>  	ip_decrease_ttl(iph);
>  	skb->tstamp = 0;
> @@ -509,7 +509,7 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
>  	if (nf_flow_nat_ipv6(flow, skb, dir) < 0)
>  		return NF_DROP;
>  
> -	flow->timeout = (u32)jiffies + NF_FLOW_TIMEOUT;
> +	flow->timeout = nf_flowtable_time_stamp + NF_FLOW_TIMEOUT;
>  	ip6h = ipv6_hdr(skb);
>  	ip6h->hop_limit--;
>  	skb->tstamp = 0;
> diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
> index 6c162c954c4f..d06969af1085 100644
> --- a/net/netfilter/nf_flow_table_offload.c
> +++ b/net/netfilter/nf_flow_table_offload.c
> @@ -781,9 +781,9 @@ void nf_flow_offload_stats(struct nf_flowtable *flowtable,
>  			   struct flow_offload *flow)
>  {
>  	struct flow_offload_work *offload;
> -	s64 delta;
> +	__s32 delta;
>  
> -	delta = flow->timeout - jiffies;
> +	delta = nf_flow_timeout_delta(flow->timeout);
>  	if ((delta >= (9 * NF_FLOW_TIMEOUT) / 10) ||
>  	    flow->flags & FLOW_OFFLOAD_HW_DYING)
>  		return;
