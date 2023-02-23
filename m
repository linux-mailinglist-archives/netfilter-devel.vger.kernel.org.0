Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82286A1375
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Feb 2023 00:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBWXBu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Feb 2023 18:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWXBu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:01:50 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024DA37F29
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Feb 2023 15:01:48 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pVKaw-0001zR-BF; Fri, 24 Feb 2023 00:01:46 +0100
Date:   Fri, 24 Feb 2023 00:01:46 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH nf-next] netfilter: bridge: introduce broute meta
 statement
Message-ID: <20230223230146.GD26596@breakpoint.cc>
References: <20230223202246.15640-1-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223202246.15640-1-sriram.yagnaraman@est.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sriram Yagnaraman <sriram.yagnaraman@est.tech> wrote:
> +void nft_meta_bridge_set_eval(const struct nft_expr *expr,
> +			      struct nft_regs *regs,
> +			      const struct nft_pktinfo *pkt)

static?

> +{
> +		dest = eth_hdr(skb)->h_dest;
> +		if (skb->pkt_type == PACKET_HOST &&
> +		    !ether_addr_equal(skb->dev->dev_addr, dest) &&
> +		    ether_addr_equal(p->br->dev->dev_addr, dest))
> +			skb->pkt_type = PACKET_OTHERHOST;

We already support override of skb->pkt_type, I would prefer
if users to this explicitly from their ruleset if they need it.

> +	priv->key = ntohl(nla_get_be32(tb[NFTA_META_KEY]));

I think you need to check for !tb[NFTA_META_KEY] and bail out
before this line.

> +	switch (priv->key) {
> +	case NFT_META_BRI_BROUTE:
> +		len = sizeof(u8);
> +		break;

Can you bail out if this is called from something else
than PREROUTING hook?

You can look at nft_tproxy.c or similar on how to do this.
