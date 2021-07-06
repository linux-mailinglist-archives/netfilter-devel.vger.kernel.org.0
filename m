Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1B63BDF7B
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Jul 2021 00:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhGFWtj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Jul 2021 18:49:39 -0400
Received: from mail.netfilter.org ([217.70.188.207]:52798 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFWti (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Jul 2021 18:49:38 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id A7DA96164E;
        Wed,  7 Jul 2021 00:46:47 +0200 (CEST)
Date:   Wed, 7 Jul 2021 00:46:57 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v2] src: annotation: Correctly
 identify item for which header is needed
Message-ID: <20210706224657.GA12859@salvia>
References: <YOL6jXNMeRGh+BlX@slk1.local.net>
 <20210706013656.10833-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210706013656.10833-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 06, 2021 at 11:36:56AM +1000, Duncan Roe wrote:
> Also fix header annotation to refer to nfnetlink_conntrack.h,
> not nf_conntrack_netlink.h

Please, split this in two patches. See below. Thanks.

> Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
> ---
>  examples/nf-queue.c                                | 2 +-
>  include/libnetfilter_queue/linux_nfnetlink_queue.h | 4 ++--
>  include/linux/netfilter/nfnetlink_queue.h          | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/examples/nf-queue.c b/examples/nf-queue.c
> index 3da2c24..5b86e69 100644
> --- a/examples/nf-queue.c
> +++ b/examples/nf-queue.c
> @@ -15,7 +15,7 @@
>  
>  #include <libnetfilter_queue/libnetfilter_queue.h>
>  
> -/* only for NFQA_CT, not needed otherwise: */
> +/* NFQA_CT requires CTA_* attributes defined in nfnetlink_conntrack.h */
>  #include <linux/netfilter/nfnetlink_conntrack.h>
>  
>  static struct mnl_socket *nl;

This chunk belongs to libnetfilter_queue.

> diff --git a/include/libnetfilter_queue/linux_nfnetlink_queue.h b/include/libnetfilter_queue/linux_nfnetlink_queue.h
> index 1975dfa..caa6788 100644
> --- a/include/libnetfilter_queue/linux_nfnetlink_queue.h
> +++ b/include/libnetfilter_queue/linux_nfnetlink_queue.h

This chunk below, belongs to the nf tree. You have to fix first the
kernel UAPI, then you can refresh this copy that is stored in
libnetfilter_queue.

> @@ -46,11 +46,11 @@ enum nfqnl_attr_type {
>  	NFQA_IFINDEX_PHYSOUTDEV,	/* __u32 ifindex */
>  	NFQA_HWADDR,			/* nfqnl_msg_packet_hw */
>  	NFQA_PAYLOAD,			/* opaque data payload */
> -	NFQA_CT,			/* nf_conntrack_netlink.h */
> +	NFQA_CT,			/* nfnetlink_conntrack.h */
>  	NFQA_CT_INFO,			/* enum ip_conntrack_info */
>  	NFQA_CAP_LEN,			/* __u32 length of captured packet */
>  	NFQA_SKB_INFO,			/* __u32 skb meta information */
> -	NFQA_EXP,			/* nf_conntrack_netlink.h */
> +	NFQA_EXP,			/* nfnetlink_conntrack.h */
>  	NFQA_UID,			/* __u32 sk uid */
>  	NFQA_GID,			/* __u32 sk gid */
>  	NFQA_SECCTX,			/* security context string */
> diff --git a/include/linux/netfilter/nfnetlink_queue.h b/include/linux/netfilter/nfnetlink_queue.h
> index 030672d..8e2e469 100644
> --- a/include/linux/netfilter/nfnetlink_queue.h
> +++ b/include/linux/netfilter/nfnetlink_queue.h
> @@ -42,11 +42,11 @@ enum nfqnl_attr_type {
>  	NFQA_IFINDEX_PHYSOUTDEV,	/* __u32 ifindex */
>  	NFQA_HWADDR,			/* nfqnl_msg_packet_hw */
>  	NFQA_PAYLOAD,			/* opaque data payload */
> -	NFQA_CT,			/* nf_conntrack_netlink.h */
> +	NFQA_CT,			/* nfnetlink_conntrack.h */
>  	NFQA_CT_INFO,			/* enum ip_conntrack_info */
>  	NFQA_CAP_LEN,			/* __u32 length of captured packet */
>  	NFQA_SKB_INFO,			/* __u32 skb meta information */
> -	NFQA_EXP,			/* nf_conntrack_netlink.h */
> +	NFQA_EXP,			/* nfnetlink_conntrack.h */
>  	NFQA_UID,			/* __u32 sk uid */
>  	NFQA_GID,			/* __u32 sk gid */
>  	NFQA_SECCTX,
> -- 
> 2.17.5
> 
