Return-Path: <netfilter-devel+bounces-12849-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDcuD6WrFWrgXgcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12849-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 16:18:13 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88D5D7501
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 16:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BF69301D59A
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9F3D47C5;
	Tue, 26 May 2026 14:17:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5D3B9935
	for <netfilter-devel@vger.kernel.org>; Tue, 26 May 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805047; cv=none; b=Rxyd2ni7mDC5m9stwH8WNM3FZ6KQRjAUuI4mZmuz3eQAVCyZz//Gq89mcuUkekJMckZD5GuN43+UcUSexI8pXqBSmGsMzzPbf3m0sE2sYtwPqSYe/4fM67oobkunZBQHgQHX7iiQls6RG1TJ4p38Bfsdm8kH9ogisJyu5EPZcrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805047; c=relaxed/simple;
	bh=Hw89zjHXYuJPAqNu81TWdZdhri6+cGoXia7E9mltXLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fzv/xXUeSQhJJuNDXy4ZnSu+7JhM1YIDlo81KCxvIFV7WdqHhcONlFaUQpBuZtRQS2/MTTVKrGPDQiw/Kgi2rDOQkSrzNhJ3uSvQXhKjDpPNogwwNiCHEw4oxV3N0/NKZ1lr2csyd+bBKtEqBv1xuNrYp+Feg9y1CYg9Sx5OUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id AC36660551; Tue, 26 May 2026 16:17:22 +0200 (CEST)
Date: Tue, 26 May 2026 16:17:17 +0200
From: Florian Westphal <fw@strlen.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_fib_ipv6: bail out of sibling walk if
 rt got unlinked
Message-ID: <ahWrbTAdNIjo02D-@strlen.de>
References: <20260526020227.4857-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526020227.4857-1-jiayuan.chen@linux.dev>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12849-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CF88D5D7501
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> This was reported by Sashiko [1].
> 
> The RCU walk over rt->fib6_siblings can spin forever if rt is unlinked
> mid-iteration: rt->fib6_siblings.next still points into the old ring,
> so the loop never meets &rt->fib6_siblings as its terminator.
> 
> fib6_purge_rt() always does WRITE_ONCE(rt->fib6_nsiblings, 0) before
> list_del_rcu(), so readers can use rt->fib6_nsiblings == 0 as the
> detach signal. The same pattern is used in fib6_info_uses_dev() and
> rt6_nlmsg_size().
> 
> [1]: https://sashiko.dev/#/patchset/20260520023411.391233-1-jiayuan.chen%40linux.dev
> Suggested-by: Florian Westphal <fw@strlen.de>
> Fixes: 1c32b24c234b ("netfilter: nft_fib_ipv6: switch to fib6_lookup")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/ipv6/netfilter/nft_fib_ipv6.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
> index c0a0075e2590..2dbe44715df3 100644
> --- a/net/ipv6/netfilter/nft_fib_ipv6.c
> +++ b/net/ipv6/netfilter/nft_fib_ipv6.c
> @@ -191,6 +191,9 @@ static bool nft_fib6_info_nh_uses_dev(struct fib6_info *rt,
>  
>  		if (nft_fib6_info_nh_dev_match(nh_dev, dev))
>  			return true;
> +
> +		if (!READ_ONCE(rt->fib6_nsiblings))
> +			return false;
>  	}

This time sashiko points to same bug pattern in rt6_fill_node:

This is a pre-existing issue, but does rt6_fill_node() also need this
detach check to prevent the same infinite loop?

https://sashiko.dev/#/patchset/20260526020227.4857-1-jiayuan.chen%40linux.dev

(No need to resend this patch, but maybe you have cycles to fix the
 other spot too)

