Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026BE3597CF
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Apr 2021 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhDII1h (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 9 Apr 2021 04:27:37 -0400
Received: from mail.netfilter.org ([217.70.188.207]:42032 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhDII1f (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:27:35 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id BD88D63E3D;
        Fri,  9 Apr 2021 10:26:58 +0200 (CEST)
Date:   Fri, 9 Apr 2021 10:27:17 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf v2] netfilter: nft_payload: fix the
 h_vlan_encapsulated_proto flow_dissector vlaue
Message-ID: <20210409082717.GA9793@salvia>
References: <1617944629-10338-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1617944629-10338-1-git-send-email-wenxu@ucloud.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Apr 09, 2021 at 01:03:49PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> For the vlan packet the h_vlan_encapsulated_proto should be set
> on the flow_dissector_key_basic->n_porto flow_dissector.
> 
> Fixes: a82055af5959 ("netfilter: nft_payload: add VLAN offload support")
> Fixes: 89d8fd44abfb ("netfilter: nft_payload: add C-VLAN offload support")
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  net/netfilter/nft_payload.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
> index cb1c8c2..84c5ecc 100644
> --- a/net/netfilter/nft_payload.c
> +++ b/net/netfilter/nft_payload.c
> @@ -233,8 +233,8 @@ static int nft_payload_offload_ll(struct nft_offload_ctx *ctx,
>  		if (!nft_payload_offload_mask(reg, priv->len, sizeof(__be16)))
>  			return -EOPNOTSUPP;
>  
> -		NFT_OFFLOAD_MATCH(FLOW_DISSECTOR_KEY_VLAN, vlan,
> -				  vlan_tpid, sizeof(__be16), reg);
> +		NFT_OFFLOAD_MATCH(FLOW_DISSECTOR_KEY_BASIC, basic,
> +				  n_proto, sizeof(__be16), reg);

nftables already sets KEY_BASIC accordingly to 0x8100.

# nft --debug=netlink add rule netdev x y vlan id 100
netdev
  [ meta load iiftype => reg 1 ]
  [ cmp eq reg 1 0x00000001 ]
  [ payload load 2b @ link header + 12 => reg 1 ]
  [ cmp eq reg 1 0x00000081 ] <----------------------------- HERE
  [ payload load 2b @ link header + 14 => reg 1 ]
  [ bitwise reg 1 = ( reg 1 & 0x0000ff0f ) ^ 0x00000000 ]
  [ cmp eq reg 1 0x00006400 ]

What are you trying to fix?
