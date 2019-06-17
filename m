Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73A548863
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 18:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFQQLF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 12:11:05 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:33438 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfFQQLF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:11:05 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hcuDo-0001qc-L3; Mon, 17 Jun 2019 18:11:04 +0200
Date:   Mon, 17 Jun 2019 18:11:04 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nft 3/5] src: add cache level flags
Message-ID: <20190617161104.GT31548@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, fw@strlen.de
References: <20190617122518.10486-1-pablo@netfilter.org>
 <20190617122518.10486-3-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617122518.10486-3-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Mon, Jun 17, 2019 at 02:25:16PM +0200, Pablo Neira Ayuso wrote:
[...]
> -int cache_evaluate(struct nft_ctx *nft, struct list_head *cmds)
> +unsigned int cache_evaluate(struct nft_ctx *nft, struct list_head *cmds)
>  {
> -	unsigned int echo_completeness = CMD_INVALID;
> -	unsigned int completeness = CMD_INVALID;
> +	unsigned int flags = NFT_CACHE_EMPTY;
>  	struct cmd *cmd;
>  
>  	list_for_each_entry(cmd, cmds, list) {
>  		switch (cmd->op) {
>  		case CMD_ADD:
>  		case CMD_INSERT:
> -		case CMD_REPLACE:
> -			if (nft_output_echo(&nft->output))
> -				echo_completeness = cmd->op;
> -
> +			flags |= NFT_CACHE_TABLE |
> +				 NFT_CACHE_CHAIN |
> +				 NFT_CACHE_SET |
> +				 NFT_CACHE_FLOWTABLE |
> +				 NFT_CACHE_OBJECT;

This means we start fetching the cache for simple 'add rule' commands
again, right?

This should be the reason why that test case started failing for you.

> +
> +			if (nft_output_echo(&nft->output)) {
> +				flags |= NFT_CACHE_SETELEM |
> +					 NFT_CACHE_RULE;
> +				break;
> +			}
>  			/* Fall through */
>  		case CMD_CREATE:
> -			completeness = evaluate_cache_add(cmd);
> +			flags = evaluate_cache_add(cmd, flags);
> +			break;
> +		case CMD_REPLACE:
> +			flags |= NFT_CACHE_FULL;
>  			break;
>  		case CMD_DELETE:
> -			completeness = evaluate_cache_del(cmd);
> +			flags |= NFT_CACHE_TABLE |
> +				 NFT_CACHE_CHAIN |
> +				 NFT_CACHE_SET |
> +				 NFT_CACHE_FLOWTABLE |
> +				 NFT_CACHE_OBJECT;

Same here, I guess: Single 'delete rule' command causes fetching of
above ruleset items (unless I miss something).

Cheers, Phil
