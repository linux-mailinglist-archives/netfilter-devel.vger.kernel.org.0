Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3562229DA
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Jul 2020 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgGPR1J (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Jul 2020 13:27:09 -0400
Received: from ja.ssi.bg ([178.16.129.10]:57964 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbgGPR1I (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:27:08 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id 06GHQrsa007472;
        Thu, 16 Jul 2020 20:26:55 +0300
Date:   Thu, 16 Jul 2020 20:26:53 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Andrew Sy Kim <kim.andrewsy@gmail.com>
cc:     Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next] ipvs: ensure RCU read unlock when connection
 flushing and ipvs is disabled
In-Reply-To: <20200716170314.9617-1-kim.andrewsy@gmail.com>
Message-ID: <alpine.LFD.2.23.451.2007162025220.5182@ja.home.ssi.bg>
References: <20200716170314.9617-1-kim.andrewsy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


	Hello,

On Thu, 16 Jul 2020, Andrew Sy Kim wrote:

> When ipvs is disabled in ip_vs_expire_nodest_conn_flush,
> we should break instead of return so that rcu_read_unlock()
> is run.
> 
> Signed-off-by: Andrew Sy Kim <kim.andrewsy@gmail.com>

Acked-by: Julian Anastasov <ja@ssi.bg>

> ---
>  net/netfilter/ipvs/ip_vs_conn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
> index a5e9b2d55e57..a90b8eac16ac 100644
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@ -1422,7 +1422,7 @@ void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs)
>  
>  		/* netns clean up started, abort delayed work */
>  		if (!ipvs->enable)
> -			return;
> +			break;
>  	}
>  	rcu_read_unlock();
>  }
> -- 
> 2.20.1

Regards

--
Julian Anastasov <ja@ssi.bg>
