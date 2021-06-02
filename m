Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666C53986B4
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Jun 2021 12:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFBKmh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Jun 2021 06:42:37 -0400
Received: from mail.netfilter.org ([217.70.188.207]:40940 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFBKmf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:42:35 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 235D7641D0;
        Wed,  2 Jun 2021 12:39:45 +0200 (CEST)
Date:   Wed, 2 Jun 2021 12:40:49 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH] netfilter: conntrack: remove the repeated declaration
Message-ID: <20210602104049.GA8127@salvia>
References: <1622270966-36196-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1622270966-36196-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Sat, May 29, 2021 at 02:49:26PM +0800, Shaokun Zhang wrote:
> Variable 'nf_conntrack_net_id' is declared twice, so remove the
> repeated declaration.

Thanks for your patch.

I prefer to fix this in nf-next with this patch I'm proposing:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210602103907.8082-1-pablo@netfilter.org/

> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> Cc: Florian Westphal <fw@strlen.de>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  net/netfilter/nf_conntrack_core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
> index e0befcf8113a..757520725cd4 100644
> --- a/net/netfilter/nf_conntrack_core.c
> +++ b/net/netfilter/nf_conntrack_core.c
> @@ -87,8 +87,6 @@ static __read_mostly bool nf_conntrack_locks_all;
>  
>  static struct conntrack_gc_work conntrack_gc_work;
>  
> -extern unsigned int nf_conntrack_net_id;
> -
>  void nf_conntrack_lock(spinlock_t *lock) __acquires(lock)
>  {
>  	/* 1) Acquire the lock */
> -- 
> 2.7.4
> 
