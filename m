Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CF629F67
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 May 2019 21:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403942AbfEXTxi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 May 2019 15:53:38 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:45079 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403797AbfEXTxi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 May 2019 15:53:38 -0400
Received: from [31.4.219.201] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <pablo@gnumonks.org>)
        id 1hUGFz-0004Hn-4M; Fri, 24 May 2019 21:53:36 +0200
Date:   Fri, 24 May 2019 21:53:34 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 3/3] src: Support intra-transaction rule references
Message-ID: <20190524195334.xgwzfzljlwt4ln74@salvia>
References: <20190522153035.19806-1-phil@nwl.cc>
 <20190522153035.19806-4-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522153035.19806-4-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 22, 2019 at 05:30:35PM +0200, Phil Sutter wrote:
> index 21d9e146e587f..9964adcf9a601 100644
> --- a/src/evaluate.c
> +++ b/src/evaluate.c
[...]
> @@ -3418,8 +3455,13 @@ static int cmd_evaluate_add(struct eval_ctx *ctx, struct cmd *cmd)
>  		handle_merge(&cmd->set->handle, &cmd->handle);
>  		return set_evaluate(ctx, cmd->set);
>  	case CMD_OBJ_RULE:
> +		/* update cache with CMD_LIST so that rules are fetched, too */
> +		ret = cache_update(ctx->nft, CMD_LIST, ctx->msgs);
> +		if (ret < 0)
> +			return ret;

This also slows down addition for the non-index case. We should allow
fetch the cache only when needed.
