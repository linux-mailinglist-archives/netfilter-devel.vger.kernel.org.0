Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BC5DC2B6
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 12:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfJRKYF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Oct 2019 06:24:05 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:34254 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727791AbfJRKYF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:24:05 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iLPQQ-0002ZF-6W; Fri, 18 Oct 2019 12:24:02 +0200
Date:   Fri, 18 Oct 2019 12:24:02 +0200
From:   Florian Westphal <fw@strlen.de>
To:     wenxu@ucloud.cn
Cc:     pablo@netfilter.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_tables: add vlan support
Message-ID: <20191018102402.GY25052@breakpoint.cc>
References: <1571392968-1263-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571392968-1263-1-git-send-email-wenxu@ucloud.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

wenxu@ucloud.cn <wenxu@ucloud.cn> wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> This patch implements the vlan expr type that can be used to
> configure vlan tci and vlan proto

Looks like a very small module with no external dependencies,
I think you could make this a nft-builtin feature and just add
nft_vlan.o to 'nf_tables-objs' in net/netfilter/Makefile, similar to
nft_rt.

What do you think?

If you plan to extend this in the future then I'm fine with keeping it
as a module.

> +static int nft_vlan_set_init(const struct nft_ctx *ctx,
> +			     const struct nft_expr *expr,
> +			     const struct nlattr * const tb[])
> +{
> +	struct nft_vlan *priv = nft_expr_priv(expr);
> +	int err;

I think you need to add

	if (!tb[NFTA_VLAN_ACTION] ||
	    !tb[NFTA_VLAN_SREG] ||
	    !tb[NFTA_VLAN_SREG2])
		return -EINVAL;

Other than that this looks good to me.
