Return-Path: <netfilter-devel+bounces-11142-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LrKN1WdsmndOAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11142-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 12:02:45 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 549E72708E9
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 12:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BED630205CD
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 11:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F04631197B;
	Thu, 12 Mar 2026 11:02:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C74342146
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Mar 2026 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313359; cv=none; b=d5J2eaJFtUoPB06QbmRBgqsj5CalJphjUvKeVWmYcr1te7vbDVhgLgezy+B5Wsioh6VHAGJ2cxX3I27PJsEqW4W36oaVixZ2SpoX+dm7XenKKLYLEgL8edMArIwz0DZZ2taOjMaSQcVmbVqEAV2mqnmKDoEQsq9xIqBbxzW4yys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313359; c=relaxed/simple;
	bh=Q94EJPlwqChzFQrvuxEOZJlLLNxfZw1EKXRxV1dnr1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHfklYF8JygP9pY0Fbz9USaA9q6eRb+K404KYYQuTRLeGSK0+P6Iyd0eIlTErRbsy4mxAIoVZVozip4lWVDpDOlv3nXKJkOIluvhecU58CfZKLRTn97ZTKHwSf2nhbvKilva5yqpgKPyl2Tf//MqWIiSNWSBIjWj5NQkPx9YqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D524060470; Thu, 12 Mar 2026 12:02:35 +0100 (CET)
Date: Thu, 12 Mar 2026 12:02:37 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] nf_tables: nft_dynset: fix possible stateful
 expression memleak in error path
Message-ID: <abKdTesNowf_-h3F@strlen.de>
References: <20260312101120.3512073-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312101120.3512073-1-pablo@netfilter.org>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11142-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid,netfilter.org:email]
X-Rspamd-Queue-Id: 549E72708E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> If cloning the second stateful expression in the element via GFP_ATOMIC
> fails, then the first stateful expression remains in place without being
> released.
> 
>    unreferenced object (percpu) 0x607b97e9cab8 (size 16):
>      comm "softirq", pid 0, jiffies 4294931867
>      hex dump (first 16 bytes on cpu 3):
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      backtrace (crc 0):
>        pcpu_alloc_noprof+0x453/0xd80
>        nft_counter_clone+0x9c/0x190 [nf_tables]
>        nft_expr_clone+0x8f/0x1b0 [nf_tables]
>        nft_dynset_new+0x2cb/0x5f0 [nf_tables]
>        nft_rhash_update+0x236/0x11c0 [nf_tables]
>        nft_dynset_eval+0x11f/0x670 [nf_tables]
>        nft_do_chain+0x253/0x1700 [nf_tables]
>        nft_do_chain_ipv4+0x18d/0x270 [nf_tables]
>        nf_hook_slow+0xaa/0x1e0
>        ip_local_deliver+0x209/0x330
> 
> Pass NULL to nft_set_elem_expr_destroy() given stateful expressions do
> not require context at this stage.

static void nft_connlimit_do_destroy(const struct nft_ctx *ctx,
                                     struct nft_connlimit *priv)
{
        nf_ct_netns_put(ctx->net, ctx->family);
        nf_conncount_cache_free(priv->list);
        kfree(priv->list);
}

I think minimal fake context could work though, the clone wasn't
exposed to other cpus yet.

Other than this patch looks correct to me.

