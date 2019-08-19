Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122FB92133
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Aug 2019 12:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfHSKV2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Aug 2019 06:21:28 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:55674 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbfHSKV2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:21:28 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1hzemx-0003no-TG; Mon, 19 Aug 2019 12:21:23 +0200
Date:   Mon, 19 Aug 2019 12:21:23 +0200
From:   Florian Westphal <fw@strlen.de>
To:     wenxu@ucloud.cn
Cc:     pablo@netfilter.org, fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_table_offload: Fix the incorrect
 rcu usage in nft_indr_block_get_and_ing_cmd
Message-ID: <20190819102123.GA2588@breakpoint.cc>
References: <1566208007-22513-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566208007-22513-1-git-send-email-wenxu@ucloud.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

wenxu@ucloud.cn <wenxu@ucloud.cn> wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> The nft_indr_block_get_and_ing_cmd is called in netdevice notify
> It is the incorrect rcu case, To fix it just traverse the list under
> the commit mutex.

What is an 'incorrect rcu case'?

Please clarify, e.g. by including rcu warning/splat backtrace here.

> +	struct nft_ctx ctx = {
> +		.net	= dev_net(dev),
> +	};

Why is this ctx needed?

> +	mutex_lock(&ctx.net->nft.commit_mutex);

net->nft.commit_mutex?

> -		list_for_each_entry_rcu(chain, &table->chains, list) {
> +		list_for_each_entry_safe(chain, nr, &table->chains, list) {

Why is _safe needed rather than list_for_each_entry()?
