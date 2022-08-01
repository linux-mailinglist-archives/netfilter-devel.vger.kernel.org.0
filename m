Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F1D58674D
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Aug 2022 12:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiHAKVV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Aug 2022 06:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiHAKVV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:21:21 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 404AD2FA
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Aug 2022 03:21:20 -0700 (PDT)
Date:   Mon, 1 Aug 2022 12:21:16 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@chinatelecom.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_flow_table: delay teardown the
 offload flow until fin packet recv from both direction
Message-ID: <YuepHPfKs6UtI3TF@salvia>
References: <1658810716-106274-1-git-send-email-wenxu@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1658810716-106274-1-git-send-email-wenxu@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Tue, Jul 26, 2022 at 12:45:16AM -0400, wenxu@chinatelecom.cn wrote:
> From: wenxu <wenxu@chinatelecom.cn>
> 
> A fin packet receive not always means the tcp connection teardown.
> For tcp half close case, only the client shutdown the connection
> and the server still can sendmsg to the client. The connection
> can still be offloaded until the server shutdown the connection.
> 
> Signed-off-by: wenxu <wenxu@chinatelecom.cn>
> ---
>  include/net/netfilter/nf_flow_table.h |  3 ++-
>  net/netfilter/nf_flow_table_ip.c      | 14 ++++++++++----
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
> index d5326c4..0c4864d 100644
> --- a/include/net/netfilter/nf_flow_table.h
> +++ b/include/net/netfilter/nf_flow_table.h
> @@ -129,7 +129,8 @@ struct flow_offload_tuple {
>  	/* All members above are keys for lookups, see flow_offload_hash(). */
>  	struct { }			__hash;
>  
> -	u8				dir:2,
> +	u8				dir:1,
> +					fin:1,
>  					xmit_type:3,
>  					encap_num:2,
>  					in_vlan_ingress:2;
> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> index b350fe9..c191861 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c
> @@ -19,7 +19,8 @@
>  #include <linux/udp.h>
>  
>  static int nf_flow_state_check(struct flow_offload *flow, int proto,
> -			       struct sk_buff *skb, unsigned int thoff)
> +			       struct sk_buff *skb, unsigned int thoff,
> +			       enum flow_offload_tuple_dir dir)
>  {
>  	struct tcphdr *tcph;
>  
> @@ -27,9 +28,14 @@ static int nf_flow_state_check(struct flow_offload *flow, int proto,
>  		return 0;
>  
>  	tcph = (void *)(skb_network_header(skb) + thoff);
> -	if (unlikely(tcph->fin || tcph->rst)) {
> +	if (unlikely(tcph->rst)) {
>  		flow_offload_teardown(flow);
>  		return -1;
> +	} else if (unlikely(tcph->fin)) {
> +		flow->tuplehash[dir].tuple.fin = 1;
> +		if (flow->tuplehash[!dir].tuple.fin == 1)
> +			flow_offload_teardown(flow);

Maybe add a new flag to enum nf_flow_flags instead?
