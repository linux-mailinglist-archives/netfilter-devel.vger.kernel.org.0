Return-Path: <netfilter-devel+bounces-1454-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB7088165F
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 18:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A18EB237CE
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 17:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8C66A02E;
	Wed, 20 Mar 2024 17:19:07 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E469DEA
	for <netfilter-devel@vger.kernel.org>; Wed, 20 Mar 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955147; cv=none; b=TqRetqYgrTOCfW/YCi3YA89MZz5SMFqO4Oj92h1rfBvuoOWWt8+r+Rft+Aazvk6+Fpdeq8CH5vNJyMssnbUavtp6xzUDj/UuWxjHDjFJrZmkqfAottrwL6kMbSl8lI2NfNmte5tpx0EkhhiAFQNxoXFYpCn5i2gGFgg708BM1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955147; c=relaxed/simple;
	bh=RbvrcRYsIv5l2Ic6DoT2ltRyrjbYfWX4xS53oMeq1l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnQ8oimtnvWcTgc2cZzWN2rZ8cRZfACe3gk+G8OsK81XxclfjK8pDEV1LrQVVJhDVfmfSUtYCRn2lcSrFxsUcr67IQB1sVRzqpXRfQuBFk+cY43HexqZv4y1+c0nv1CabFNNr5p+WOeJDO59yVujpncduQbFllxG3SuJfUZKzmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Wed, 20 Mar 2024 18:19:01 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Quan Tian <tianquan23@gmail.com>
Cc: netfilter-devel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de
Subject: Re: [PATCH nf] netfilter: nf_tables: do not reject dormant flag
 update for table with owner
Message-ID: <ZfsahX3i-F9ZnLre@calendula>
References: <20240315170124.1584-1-tianquan23@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315170124.1584-1-tianquan23@gmail.com>

On Sat, Mar 16, 2024 at 01:01:24AM +0800, Quan Tian wrote:
> If a table was owned by a process, its dormant flag couldn't be updated
> because the code required the table to be an orphan.
> 
> $ nft -i
> nft> add table ip test { flags owner ; }
> nft> list table ip test
> table ip test { # progname nft
> 	flags owner
> }
> nft> add table ip test { flags owner ; flags dormant ; }
> Error: Could not process rule: Operation not supported
> add table ip test { flags owner ; flags dormant ; }
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Patch LGTM, thanks

> Fixes: 31bf508be656 ("netfilter: nf_tables: Implement table adoption support")
> Signed-off-by: Quan Tian <tianquan23@gmail.com>
> ---
>  net/netfilter/nf_tables_api.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index e93f905e60b6..f06b09b32d80 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -1219,7 +1219,8 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
>  	if ((nft_table_has_owner(ctx->table) &&
>  	     !(flags & NFT_TABLE_F_OWNER)) ||
>  	    (flags & NFT_TABLE_F_OWNER &&
> -	     !nft_table_is_orphan(ctx->table)))
> +	     !(nft_table_has_owner(ctx->table) ||
> +	       nft_table_is_orphan(ctx->table))))
>  		return -EOPNOTSUPP;
>
>  	if ((flags ^ ctx->table->flags) & NFT_TABLE_F_PERSIST)

