Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BD2445474
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Nov 2021 15:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhKDOGr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 4 Nov 2021 10:06:47 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:36828 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhKDOGq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:06:46 -0400
Received: from madeliefje.horms.nl (ip-80-113-23-202.ip.prioritytelecom.net [80.113.23.202])
        by kirsty.vergenet.net (Postfix) with ESMTPA id CFB4925AE8A;
        Fri,  5 Nov 2021 01:04:06 +1100 (AEDT)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
        id 3FF8327B5; Thu,  4 Nov 2021 15:04:04 +0100 (CET)
Date:   Thu, 4 Nov 2021 15:04:04 +0100
From:   Simon Horman <horms@verge.net.au>
To:     yangxingwu <xingwu.yang@gmail.com>, pablo@netfilter.org
Cc:     ja@ssi.bg, kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, Chuanqi Liu <legend050709@qq.com>
Subject: Re: [PATCH nf-next v6] netfilter: ipvs: Fix reuse connection if RS
 weight is 0
Message-ID: <20211104140401.GA16560@vergenet.net>
References: <20211104031029.157366-1-xingwu.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104031029.157366-1-xingwu.yang@gmail.com>
Organisation: Horms Solutions BV
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 04, 2021 at 11:10:29AM +0800, yangxingwu wrote:
> We are changing expire_nodest_conn to work even for reused connections when
> conn_reuse_mode=0, just as what was done with commit dc7b3eb900aa ("ipvs:
> Fix reuse connection if real server is dead").
> 
> For controlled and persistent connections, the new connection will get the
> needed real server depending on the rules in ip_vs_check_template().
> 
> Fixes: d752c3645717 ("ipvs: allow rescheduling of new connections when port reuse is detected")
> Co-developed-by: Chuanqi Liu <legend050709@qq.com>
> Signed-off-by: Chuanqi Liu <legend050709@qq.com>
> Signed-off-by: yangxingwu <xingwu.yang@gmail.com>

Acked-by: Simon Horman <horms@verge.net.au>

(v5 was acked by Julian, probably that can be propagated here)

Pablo, please consider this for nf-next at your convenience.

> ---
>  Documentation/networking/ipvs-sysctl.rst | 3 +--
>  net/netfilter/ipvs/ip_vs_core.c          | 8 ++++----
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/networking/ipvs-sysctl.rst b/Documentation/networking/ipvs-sysctl.rst
> index 2afccc63856e..1cfbf1add2fc 100644
> --- a/Documentation/networking/ipvs-sysctl.rst
> +++ b/Documentation/networking/ipvs-sysctl.rst
> @@ -37,8 +37,7 @@ conn_reuse_mode - INTEGER
>  
>  	0: disable any special handling on port reuse. The new
>  	connection will be delivered to the same real server that was
> -	servicing the previous connection. This will effectively
> -	disable expire_nodest_conn.
> +	servicing the previous connection.
>  
>  	bit 1: enable rescheduling of new connections when it is safe.
>  	That is, whenever expire_nodest_conn and for TCP sockets, when
> diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
> index 128690c512df..393058a43aa7 100644
> --- a/net/netfilter/ipvs/ip_vs_core.c
> +++ b/net/netfilter/ipvs/ip_vs_core.c
> @@ -1964,7 +1964,6 @@ ip_vs_in(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, int
>  	struct ip_vs_proto_data *pd;
>  	struct ip_vs_conn *cp;
>  	int ret, pkts;
> -	int conn_reuse_mode;
>  	struct sock *sk;
>  
>  	/* Already marked as IPVS request or reply? */
> @@ -2041,15 +2040,16 @@ ip_vs_in(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, int
>  	cp = INDIRECT_CALL_1(pp->conn_in_get, ip_vs_conn_in_get_proto,
>  			     ipvs, af, skb, &iph);
>  
> -	conn_reuse_mode = sysctl_conn_reuse_mode(ipvs);
> -	if (conn_reuse_mode && !iph.fragoffs && is_new_conn(skb, &iph) && cp) {
> +	if (!iph.fragoffs && is_new_conn(skb, &iph) && cp) {
> +		int conn_reuse_mode = sysctl_conn_reuse_mode(ipvs);
>  		bool old_ct = false, resched = false;
>  
>  		if (unlikely(sysctl_expire_nodest_conn(ipvs)) && cp->dest &&
>  		    unlikely(!atomic_read(&cp->dest->weight))) {
>  			resched = true;
>  			old_ct = ip_vs_conn_uses_old_conntrack(cp, skb);
> -		} else if (is_new_conn_expected(cp, conn_reuse_mode)) {
> +		} else if (conn_reuse_mode &&
> +			   is_new_conn_expected(cp, conn_reuse_mode)) {
>  			old_ct = ip_vs_conn_uses_old_conntrack(cp, skb);
>  			if (!atomic_read(&cp->n_control)) {
>  				resched = true;
> -- 
> 2.30.2
> 
