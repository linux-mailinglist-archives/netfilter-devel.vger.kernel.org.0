Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CABD4C6C64
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Feb 2022 13:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbiB1M0Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Feb 2022 07:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiB1MZo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:25:44 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB2975634
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Feb 2022 04:24:36 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nOf4n-0001Xr-VC; Mon, 28 Feb 2022 13:24:30 +0100
Date:   Mon, 28 Feb 2022 13:24:29 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Linux MM <linux-mm@kvack.org>, kernel@openvz.org,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: Re: [PATCH RFC] memcg: Enable accounting for nft objects
Message-ID: <20220228122429.GC26547@breakpoint.cc>
References: <81d734aa-7a0f-81b4-34fb-516b17673eac@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <81d734aa-7a0f-81b4-34fb-516b17673eac@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Vasily Averin <vvs@virtuozzo.com> wrote:
> nftables replaces iptables but still lacks memcg accounting.
> 
> This patch account most part of nft-related allocation and should protect host from nft misuse
> inside memcg-limited container.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  net/netfilter/core.c          |  2 +-
>  net/netfilter/nf_tables_api.c | 51 +++++++++++++++++++----------------
>  2 files changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/net/netfilter/core.c b/net/netfilter/core.c
> index 354cb472f386..6a2b57774999 100644
> --- a/net/netfilter/core.c
> +++ b/net/netfilter/core.c
> @@ -58,7 +58,7 @@ static struct nf_hook_entries *allocate_hook_entries_size(u16 num)
>  	if (num == 0)
>  		return NULL;
> -	e = kvzalloc(alloc, GFP_KERNEL);
> +	e = kvzalloc(alloc, GFP_KERNEL_ACCOUNT);

makes sense to me.

> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index 5fa16990da95..5e1987ec9715 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -149,7 +149,7 @@ static struct nft_trans *nft_trans_alloc_gfp(const struct nft_ctx *ctx,
>  {
>  	struct nft_trans *trans;
> -	trans = kzalloc(sizeof(struct nft_trans) + size, gfp);
> +	trans = kzalloc(sizeof(struct nft_trans) + size, gfp | __GFP_ACCOUNT);

trans_alloc is temporary in nature, they are always free'd by the
time syscall returns (else, bug).

> @@ -1084,6 +1084,7 @@ static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
>  	struct nft_table *table;
>  	struct nft_ctx ctx;
>  	u32 flags = 0;
> +	gfp_t gfp = GFP_KERNEL_ACCOUNT;
>  	int err;
>  	lockdep_assert_held(&nft_net->commit_mutex);
> @@ -1113,16 +1114,16 @@ static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
>  	}
>  	err = -ENOMEM;
> -	table = kzalloc(sizeof(*table), GFP_KERNEL);
> +	table = kzalloc(sizeof(*table), gfp);

Why gfp temporary variable?  Readability? The subsititution looks correct.

Rest looks good, you might need to update nft_limit_init() and a few
other stateful expressions that alloc internal data too.
