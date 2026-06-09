Return-Path: <netfilter-devel+bounces-13163-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mgNGLI91KGoZFAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13163-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 22:20:31 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 307BA664103
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 22:20:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13163-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13163-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A756B3049FF3
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 20:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966B344DAE;
	Tue,  9 Jun 2026 20:18:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94B3101B6
	for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2026 20:18:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036336; cv=none; b=gwVyEBhz8MJUwv+ANgARZNXHGMGaThSpcYjnMnpu9xmnoArADlMtADb+WXgtOv9F7rz56RpT330Xx1QReKJk8Lo3FrBphyIuOxH3g7bB1NAjdLWt/qp1XsQ1Ji9IgF0NFjTfrgSEg7o3JpHnOE/JunGMjQ/55l8k5Ac+4G3Qg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036336; c=relaxed/simple;
	bh=5nLg38TKicTWKWzLXWRD9Wq6oAYrNczBg1efgcBxhZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha+EIO0kIClrGOkLOK4AoHngDGdbEcc+2rw4sZQJ3fppyhusPj8fAZ9P/u5vAEdgY4+K1bG06OFMkNbGOooPr5KmTgm0j3eOmR5maRAKxSSeZmbq0BYl0NTvkgYjco8uzMJ9E6bUVN0Wx/XBnfs/vMQsY9asroBJsDmRuumkIgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CFF5360C94; Tue, 09 Jun 2026 22:18:52 +0200 (CEST)
Date: Tue, 9 Jun 2026 22:18:46 +0200
From: Florian Westphal <fw@strlen.de>
To: Davide Ornaghi <d.ornaghi97@gmail.com>
Cc: netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>, coreteam@netfilter.org
Subject: Re: [PATCH 1/2] netfilter: nft_fib: fix stale stack leak via the
 OIFNAME register
Message-ID: <aih1JpA0iAD84GNb@strlen.de>
References: <20260609163215.1102215-1-d.ornaghi97@gmail.com>
 <20260609163215.1102215-2-d.ornaghi97@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609163215.1102215-2-d.ornaghi97@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:d.ornaghi97@gmail.com,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:coreteam@netfilter.org,m:dornaghi97@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13163-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 307BA664103

Davide Ornaghi <d.ornaghi97@gmail.com> wrote:
> diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
> index 327a5f3365..6df811b8d5 100644
> --- a/net/netfilter/nft_fib.c
> +++ b/net/netfilter/nft_fib.c
> @@ -107,6 +107,9 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
>  		return -EINVAL;
>  	}
>  
> +	if (priv->flags & NFTA_FIB_F_PRESENT)
> +		len = sizeof(u8);
> +

Would you mind sending a v2 that also rejects NFTA_FIB_F_PRESENT for all
cases except NFT_FIB_RESULT_OIF ?

Its not strictly required but its better to be explicit, I think.

Rest looks good.

