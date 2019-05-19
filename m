Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 396AE228F3
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 May 2019 23:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfESVAl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 May 2019 17:00:41 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:53996 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfESVAl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 May 2019 17:00:41 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hSSv8-0004lS-SL; Sun, 19 May 2019 23:00:38 +0200
Date:   Sun, 19 May 2019 23:00:38 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2 3/4] netfilter: synproxy: extract SYNPROXY
 infrastructure from {ipt,ip6t}_SYNPROXY
Message-ID: <20190519210038.sgd4byoow374dd7p@breakpoint.cc>
References: <20190519205259.2821-1-ffmancera@riseup.net>
 <20190519205259.2821-4-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519205259.2821-4-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> ---
>  include/net/netfilter/nf_synproxy.h |  76 +++
>  net/ipv4/netfilter/ipt_SYNPROXY.c   | 394 +------------
>  net/ipv6/netfilter/ip6t_SYNPROXY.c  | 420 +-------------
>  net/netfilter/nf_synproxy.c         | 819 ++++++++++++++++++++++++++++
>  4 files changed, 910 insertions(+), 799 deletions(-)
>  create mode 100644 include/net/netfilter/nf_synproxy.h
>  create mode 100644 net/netfilter/nf_synproxy.c
> 
> diff --git a/include/net/netfilter/nf_synproxy.h b/include/net/netfilter/nf_synproxy.h
> new file mode 100644
> index 000000000000..97fb12ea5092
> --- /dev/null
> +++ b/include/net/netfilter/nf_synproxy.h
> +/* Hook operations used by {ip,nf}tables SYNPROXY support */
> +const struct nf_hook_ops ipv4_synproxy_ops[] = {
> +	{
> +		.hook		= ipv4_synproxy_hook,
> +		.pf		= NFPROTO_IPV4,
> +		.hooknum	= NF_INET_LOCAL_IN,
> +		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
> +	},
> +	{
> +		.hook		= ipv4_synproxy_hook,
> +		.pf		= NFPROTO_IPV4,
> +		.hooknum	= NF_INET_POST_ROUTING,
> +		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
> +	},
> +};

Can this be avoided?

This should only be placed in a single .c file, not in a header.
I also suspect this should be 'static const'.

Seems you can just move it to nf_synproxy.c, where its used.

> +static const struct nf_hook_ops ipv6_synproxy_ops[] = {

likewise.
