Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E089B4407EC
	for <lists+netfilter-devel@lfdr.de>; Sat, 30 Oct 2021 09:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhJ3HsW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 30 Oct 2021 03:48:22 -0400
Received: from ink.ssi.bg ([178.16.128.7]:43737 "EHLO ink.ssi.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhJ3HsW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 30 Oct 2021 03:48:22 -0400
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 9941F3C09BA;
        Sat, 30 Oct 2021 10:45:48 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.16.1/8.16.1) with ESMTP id 19U7jhRk009603;
        Sat, 30 Oct 2021 10:45:44 +0300
Date:   Sat, 30 Oct 2021 10:45:43 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     yangxingwu <xingwu.yang@gmail.com>
cc:     Simon Horman <horms@verge.net.au>, pablo@netfilter.org,
        netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Chuanqi Liu <legend050709@qq.com>
Subject: Re: [PATCH nf-next v4] netfilter: ipvs: Fix reuse connection if RS
 weight is 0
In-Reply-To: <20211030064049.9992-1-xingwu.yang@gmail.com>
Message-ID: <e2699ba8-e733-2c71-584a-138746511f4@ssi.bg>
References: <20211030064049.9992-1-xingwu.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


	Hello,

On Sat, 30 Oct 2021, yangxingwu wrote:

> We are changing expire_nodest_conn to work even for reused connections when
> conn_reuse_mode=0 but without affecting the controlled and persistent
> connections during the graceful termination period while server is with
> weight=0.
> 
> Fixes: d752c3645717 ("ipvs: allow rescheduling of new connections when port
> reuse is detected")
> Co-developed-by: Chuanqi Liu <legend050709@qq.com>
> Signed-off-by: Chuanqi Liu <legend050709@qq.com>
> Signed-off-by: yangxingwu <xingwu.yang@gmail.com>

	Looks good to me, thanks!

Acked-by: Julian Anastasov <ja@ssi.bg>

	Simon, Pablo, may be you can change Fixes tag to be
on one line before applying.

> ---
>  Documentation/networking/ipvs-sysctl.rst |  3 +--
>  net/netfilter/ipvs/ip_vs_core.c          | 12 ++++--------
>  2 files changed, 5 insertions(+), 10 deletions(-)
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
> index 128690c512df..ce6ceb55822b 100644
> --- a/net/netfilter/ipvs/ip_vs_core.c
> +++ b/net/netfilter/ipvs/ip_vs_core.c
> @@ -1100,10 +1100,6 @@ static inline bool is_new_conn(const struct sk_buff *skb,
>  static inline bool is_new_conn_expected(const struct ip_vs_conn *cp,
>  					int conn_reuse_mode)
>  {
> -	/* Controlled (FTP DATA or persistence)? */
> -	if (cp->control)
> -		return false;
> -
>  	switch (cp->protocol) {
>  	case IPPROTO_TCP:
>  		return (cp->state == IP_VS_TCP_S_TIME_WAIT) ||
> @@ -1964,7 +1960,6 @@ ip_vs_in(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, int
>  	struct ip_vs_proto_data *pd;
>  	struct ip_vs_conn *cp;
>  	int ret, pkts;
> -	int conn_reuse_mode;
>  	struct sock *sk;
>  
>  	/* Already marked as IPVS request or reply? */
> @@ -2041,15 +2036,16 @@ ip_vs_in(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, int
>  	cp = INDIRECT_CALL_1(pp->conn_in_get, ip_vs_conn_in_get_proto,
>  			     ipvs, af, skb, &iph);
>  
> -	conn_reuse_mode = sysctl_conn_reuse_mode(ipvs);
> -	if (conn_reuse_mode && !iph.fragoffs && is_new_conn(skb, &iph) && cp) {
> +	if (!iph.fragoffs && is_new_conn(skb, &iph) && cp && !cp->control) {
>  		bool old_ct = false, resched = false;
> +		int conn_reuse_mode = sysctl_conn_reuse_mode(ipvs);
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

Regards

--
Julian Anastasov <ja@ssi.bg>
