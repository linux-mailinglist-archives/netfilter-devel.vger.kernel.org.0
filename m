Return-Path: <netfilter-devel+bounces-11941-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DvXAkn632ntbAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11941-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 22:51:21 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC76407B91
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 22:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CEF33009023
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2F7387569;
	Wed, 15 Apr 2026 20:51:17 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A063845D9
	for <netfilter-devel@vger.kernel.org>; Wed, 15 Apr 2026 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286277; cv=none; b=FBwpV9i7ODuY1Ke/hFAzrVAW054uxsU0OY4utnOb5QcifofcKZszaLGDEpopTAQSP3T8PGkEJp8/kx/pkgqPWzDhpg1sey1wZUVoXDht76BvVfEPMlSRPhgaK6IJYCDbvlvnoqZi8Vwk8hm3xoQ2zGiz2nP0D1ikYxZPu2Irwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286277; c=relaxed/simple;
	bh=nCBRKkWY2Jey9UVNjPsk+K/+jJvjpOpjd21vzCxWwrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W331p+TUDzXLxed108oZcxTQvQeoO1QQLwmo3NQUwOUko+79FwJhME/u07c7W3300WhsgrxSi1tzLuaRFjZIxJd1Ry6MimFuwKd4UamM1jxh1O9QmywTPPR/UIrCFx8E85ehPhtoFMEkOecqHclzxKEfp0ZJ+KFsJ9KGbtPDj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 252A660490; Wed, 15 Apr 2026 22:51:09 +0200 (CEST)
Date: Wed, 15 Apr 2026 22:51:09 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf,v2 3/3] netfilter: nf_tables: add hook transactions
 for device deletions
Message-ID: <ad_6PaOwZJRHWgTd@strlen.de>
References: <20260415171038.41442-1-pablo@netfilter.org>
 <20260415171038.41442-2-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415171038.41442-2-pablo@netfilter.org>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11941-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 6EC76407B91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Restore the flag that indicates that the hook is going away, ie.
> NFT_HOOK_REMOVE, but add a new transaction object to track deletion
> of hooks without altering the basechain/flowtable hook_list during
> the preparation phase.
> 
> The existing approach that moves the hook from the basechain/flowtable
> hook_list to transaction hook_list breaks netlink dump path readers
> of this RCU-protected list.
> 
> It should be possible use an array for nft_trans_hook to store the
> deleted hooks to compact the representation but I am not expecting
> many hook object, specially now that wildcard support for devices
> is in place.
> 
> Note that the nft_trans_chain_hooks() list contains a list of struct
> nft_trans_hook objects for DELCHAIN and DELFLOWTABLE commands, while
> this list stores struct nft_hook objects for NEWCHAIN and NEWFLOWTABLE.
> Note that new commands can be updated to use nft_trans_hook for
> consistency.
> 
> Fixes: 7d937b107108 ("netfilter: nf_tables: support for deleting devices in an existing netdev chain")
> Fixes: b6d9014a3335 ("netfilter: nf_tables: delete flowtable hooks via transaction list")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> v2: no changes.
> 
>  include/net/netfilter/nf_tables.h |  13 ++++
>  net/netfilter/nf_tables_api.c     | 124 ++++++++++++++++++++++++++----
>  2 files changed, 120 insertions(+), 17 deletions(-)
> 
> diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
> index ec8a8ec9c0aa..3ec41574af77 100644
> --- a/include/net/netfilter/nf_tables.h
> +++ b/include/net/netfilter/nf_tables.h
> @@ -1216,12 +1216,15 @@ struct nft_stats {
>  	struct u64_stats_sync	syncp;
>  };
>  
> +#define NFT_HOOK_REMOVE	(1 << 0)
> +
>  struct nft_hook {
>  	struct list_head	list;
>  	struct list_head	ops_list;
>  	struct rcu_head		rcu;
>  	char			ifname[IFNAMSIZ];
>  	u8			ifnamelen;
> +	u8			flags;
>  };
>  
>  struct nf_hook_ops *nft_hook_find_ops(const struct nft_hook *hook,
> @@ -1676,6 +1679,16 @@ struct nft_trans {
>  	u8				put_net:1;
>  };
>  
> +/**
> + * struct nft_trans_hook - nf_tables hook update in transaction
> + * @list: used internally
> + * @hook: struct nft_hook with the device hook
> + */
> +struct nft_trans_hook {
> +	struct list_head		list;
> +	struct nft_hook			*hook;
> +};

Do I get this correctly?

nft_trans_container_flowtable(trans)->hook_list
and
nft_trans_container_chain(trans)->hook_list

Either hold 'struct nft_hook' objects or nft_trans_hook objects?
Former when adding, latter when removing from existing base hook?

> +		trans_hook = kmalloc(sizeof(*trans_hook), GFP_KERNEL);

Note that 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
transformed such allocation requests to use "kmalloc_obj(*trans_hook, GFP_KERNEL);"
instead.

