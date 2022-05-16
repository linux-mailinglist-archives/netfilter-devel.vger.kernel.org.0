Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E205282EE
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 May 2022 13:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiEPLOB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 May 2022 07:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiEPLN7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 May 2022 07:13:59 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 024B030579
        for <netfilter-devel@vger.kernel.org>; Mon, 16 May 2022 04:13:58 -0700 (PDT)
Date:   Mon, 16 May 2022 13:13:55 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@chinatelecom.cn
Cc:     netfilter-devel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: [nf-next PATCH] nf_flow_table_offload: offload the PPPoE encap
 in the flowtable
Message-ID: <YoIx8zglMHjb4Gi7@salvia>
References: <1652189176-49750-1-git-send-email-wenxu@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1652189176-49750-1-git-send-email-wenxu@chinatelecom.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This is likely clashing with Felix's fixes:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20220509122616.65449-1-nbd@nbd.name/
https://patchwork.ozlabs.org/project/netfilter-devel/patch/20220509122616.65449-2-nbd@nbd.name/
https://patchwork.ozlabs.org/project/netfilter-devel/patch/20220509122616.65449-3-nbd@nbd.name/
https://patchwork.ozlabs.org/project/netfilter-devel/patch/20220509122616.65449-4-nbd@nbd.name/

On Tue, May 10, 2022 at 09:26:16AM -0400, wenxu@chinatelecom.cn wrote:
> From: wenxu <wenxu@chinatelecom.cn>
> 
> This patch put the pppoe process in the FLOW_OFFLOAD_XMIT_DIRECT
> mode. Xmit the packet with PPPoE can offload to the underlay device
> directly.
> 
> It can support all kinds of VLAN dev path:
> pppoe-->eth
> pppoe-->br0.100-->br0(vlan filter enable)-->eth
> pppoe-->eth.100-->eth
> 
> The packet xmit and recv offload to the 'eth' in both original and
> reply direction.
> 
> Signed-off-by: wenxu <wenxu@chinatelecom.cn>
> ---
> This patch based on the following one: nf_flow_table_offload: offload the vlan encap in the flowtable
> http://patchwork.ozlabs.org/project/netfilter-devel/patch/1649169515-4337-1-git-send-email-wenx05124561@163.com/
> 
>  include/net/netfilter/nf_flow_table.h | 34 ++++++++++++++++++++++++++++++++++
>  net/netfilter/nf_flow_table_ip.c      |  3 +++
>  net/netfilter/nft_flow_offload.c      | 10 +++-------
>  3 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
> index 64daafd..8be369c 100644
> --- a/include/net/netfilter/nf_flow_table.h
> +++ b/include/net/netfilter/nf_flow_table.h
> @@ -319,6 +319,40 @@ int nf_flow_rule_route_ipv6(struct net *net, const struct flow_offload *flow,
>  int nf_flow_table_offload_init(void);
>  void nf_flow_table_offload_exit(void);
>  
> +static inline int nf_flow_ppoe_push(struct sk_buff *skb, u16 id)
> +{
> +	struct ppp_hdr {
> +		struct pppoe_hdr hdr;
> +		__be16 proto;
> +	} *ph;
> +	int data_len = skb->len + 2;
> +	__be16 proto;
> +
> +	if (skb_cow_head(skb, PPPOE_SES_HLEN))
> +		return -1;
> +
> +	if (skb->protocol == htons(ETH_P_IP))
> +		proto = htons(PPP_IP);
> +	else if (skb->protocol == htons(ETH_P_IPV6))
> +		proto = htons(PPP_IPV6);
> +	else
> +		return -1;
> +
> +	__skb_push(skb, PPPOE_SES_HLEN);
> +	skb_reset_network_header(skb);
> +
> +	ph = (struct ppp_hdr *)(skb->data);
> +	ph->hdr.ver  = 1;
> +	ph->hdr.type = 1;
> +	ph->hdr.code = 0;
> +	ph->hdr.sid  = htons(id);
> +	ph->hdr.length = htons(data_len);
> +	ph->proto = proto;
> +	skb->protocol = htons(ETH_P_PPP_SES);
> +
> +	return 0;
> +}
> +
>  static inline __be16 nf_flow_pppoe_proto(const struct sk_buff *skb)
>  {
>  	__be16 proto;
> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> index 99ae2550..d1c0d95 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c
> @@ -295,6 +295,9 @@ static void nf_flow_encap_push(struct sk_buff *skb,
>  				      tuplehash->tuple.encap[i].proto,
>  				      tuplehash->tuple.encap[i].id);
>  			break;
> +		case htons(ETH_P_PPP_SES):
> +			nf_flow_ppoe_push(skb, tuplehash->tuple.encap[i].id);
> +			break;
>  		}
>  	}
>  }
> diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
> index f9837c9..eea8637 100644
> --- a/net/netfilter/nft_flow_offload.c
> +++ b/net/netfilter/nft_flow_offload.c
> @@ -122,12 +122,9 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
>  			info->encap[info->num_encaps].id = path->encap.id;
>  			info->encap[info->num_encaps].proto = path->encap.proto;
>  			info->num_encaps++;
> -			if (path->type == DEV_PATH_PPPOE) {
> -				info->outdev = path->dev;
> +			if (path->type == DEV_PATH_PPPOE)
>  				memcpy(info->h_dest, path->encap.h_dest, ETH_ALEN);
> -			}
> -			if (path->type == DEV_PATH_VLAN)
> -				info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
> +			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
>  			break;
>  		case DEV_PATH_BRIDGE:
>  			if (is_zero_ether_addr(info->h_source))
> @@ -155,8 +152,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
>  			break;
>  		}
>  	}
> -	if (!info->outdev)
> -		info->outdev = info->indev;
> +	info->outdev = info->indev;
>  
>  	info->hw_outdev = info->indev;
>  
> -- 
> 1.8.3.1
> 
