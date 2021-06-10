Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BB23A3268
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Jun 2021 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJRpe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Jun 2021 13:45:34 -0400
Received: from mail.netfilter.org ([217.70.188.207]:34860 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRpe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:45:34 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id DCF1E6423A;
        Thu, 10 Jun 2021 19:42:22 +0200 (CEST)
Date:   Thu, 10 Jun 2021 19:43:34 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nf-next PATCH] netfilter: nft_exthdr: Search chunks in SCTP
 packets only
Message-ID: <20210610174334.GA24536@salvia>
References: <20210610142316.24354-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210610142316.24354-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

On Thu, Jun 10, 2021 at 04:23:16PM +0200, Phil Sutter wrote:
> Since user space does not generate a payload dependency, plain sctp
> chunk matches cause searching in non-SCTP packets, too. Avoid this
> potential mis-interpretation of packet data by checking pkt->tprot.
> 
> Fixes: 133dc203d77df ("netfilter: nft_exthdr: Support SCTP chunks")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  net/netfilter/nft_exthdr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
> index 7f705b5c09de8..1093bb83f8aeb 100644
> --- a/net/netfilter/nft_exthdr.c
> +++ b/net/netfilter/nft_exthdr.c
> @@ -312,6 +312,9 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
>  	const struct sctp_chunkhdr *sch;
>  	struct sctp_chunkhdr _sch;
>  
> +	if (!pkt->tprot_set || pkt->tprot != IPPROTO_SCTP)
> +		goto err;

nft_set_pktinfo_unspec() already initializes pkt->tprot to zero.

I think it's safe to simplify this to:

	if (pkt->tprot != IPPROTO_SCTP)
