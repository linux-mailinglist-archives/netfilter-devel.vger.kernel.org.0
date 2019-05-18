Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75599224CF
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 May 2019 22:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfERUUe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 May 2019 16:20:34 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:52534 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727620AbfERUUe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 May 2019 16:20:34 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hS5om-0000N1-C7; Sat, 18 May 2019 22:20:32 +0200
Date:   Sat, 18 May 2019 22:20:32 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 4/5 nf-next] netfilter: synproxy: extract IPv6 SYNPROXY
 infrastructure from ip6t_SYNPROXY
Message-ID: <20190518202032.2bjv4e547kli56c6@breakpoint.cc>
References: <20190518182151.1231-1-ffmancera@riseup.net>
 <20190518182151.1231-5-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518182151.1231-5-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:

Hi Fernando

> +void
> +synproxy_send_client_synack_ipv6(struct net *net,
> +				 const struct sk_buff *skb,
> +				 const struct tcphdr *th,
> +				 const struct synproxy_options *opts)

[..]

> +	nth->seq	= htonl(__cookie_v6_init_sequence(iph, th, &mss));

It seems that __cookie_v6_init_sequence() is the only dependency of
this module on ipv6.

If we would make it accessible via nf_ipv6_ops struct, then the
dependency goes away and we could place ipv4 and ipv6 parts in a
single module.

Just saying, it would avoid adding extra modules.
We could then have

nf_synproxy.ko  # shared code
nft_synproxy.ko # nftables frontend
xt_SYNPROXY.ko	# ip(6)tables frontends
