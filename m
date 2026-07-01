Return-Path: <netfilter-devel+bounces-13577-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b+KlBzJrRWqK/goAu9opvQ
	(envelope-from <netfilter-devel+bounces-13577-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 21:32:02 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D406F0DE5
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 21:32:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13577-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13577-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B543B30156C5
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jul 2026 19:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6822392C29;
	Wed,  1 Jul 2026 19:31:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F7224AF2;
	Wed,  1 Jul 2026 19:31:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934314; cv=none; b=d2yfVGLekPq7kmrBJz5hs4RnCwTSUuBu7wDbxz16AjPx7waorZwKchqgozoht1TMkYQE6Wk32pQkaEJYeRpLL4/QaUS/mPL3iKZGbQpwiaSCzmaVAkG6ZADqJnLyDtJ//PsknM9dYfpTGzCagNwe+38fpucN4wd41rGBARI3s8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934314; c=relaxed/simple;
	bh=mLzcRSnztu80B3fI2V8y3dsoxit704VRlvjta6+On38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIiaGtgH21D9+rMlObLAX90F6V3CYoyCEvkHA4CZaG7Ahvqi6mznRL0nntjsqkwj9IzLFwEdWykDl7G3TLs3Jx7BmzNKi6WzkMj0p7i7DQuwD4wBiS4jBdJaPqT+UyaszSHD64ONtpTb4K6OO7imtoOzbm3pm2ZVl/E7RNVEm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1EB2060543; Wed, 01 Jul 2026 21:31:45 +0200 (CEST)
Date: Wed, 1 Jul 2026 21:31:39 +0200
From: Florian Westphal <fw@strlen.de>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_set_rbtree: reject interval-end get
 for open intervals
Message-ID: <akVrG9sRqSDPbkXb@strlen.de>
References: <20260630155507.92815-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630155507.92815-1-mlbnkm1@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mlbnkm1@gmail.com,m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[strlen.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13577-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82D406F0DE5

Melbin K Mathew <mlbnkm1@gmail.com> wrote:
> nft_rbtree_get() uses the interval endpoint selected by
> nft_array_get_cmp(). For NFT_SET_ELEM_INTERVAL_END requests, the function
> uses interval->to to recover struct nft_rbtree_elem.
> 
> Open-ended intervals can have a NULL end endpoint. In that case,
> nft_array_get_cmp() treats the missing endpoint as b = -1, which can
> still match an interval-end query. Avoid deriving an element pointer
> from a NULL endpoint and report the element as not found instead.
> 
> Return -ENOENT for interval-end requests against open-ended intervals.
> 
> Fixes: 2aa34191f06f ("netfilter: nft_set_rbtree: use binary search array in get command")
> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
> ---
> Notes:
>   A reduced userspace model confirms the comparator returns match for a
>   NULL-ended interval when NFT_SET_ELEM_INTERVAL_END is set, and that
>   container_of(NULL, ext) produces a garbage pointer (UBSAN fires).
> 
>   I have not reproduced an end-to-end crash through normal nft CLI usage.
>   An instrumented WARN in this branch did not fire during interval-set
>   tests with nft add/get/list. The patch is a defensive fix for the NULL
>   endpoint case.
> 
>   Tested on 7.2-rc1 with KASAN and UBSAN enabled. Function tracing
>   confirms nft_rbtree_get() is reached via nft get element. The added
>   guard returns -ENOENT for a NULL interval endpoint in the instrumented
>   test case.
> ---
>  net/netfilter/nft_set_rbtree.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
> index 018bbb6df4..024a2cd3a6 100644
> --- a/net/netfilter/nft_set_rbtree.c
> +++ b/net/netfilter/nft_set_rbtree.c
> @@ -184,10 +184,13 @@ nft_rbtree_get(const struct net *net, const struct nft_set *set,
>  	if (!interval || nft_set_elem_expired(interval->from))
>  		return ERR_PTR(-ENOENT);
>  
> -	if (flags & NFT_SET_ELEM_INTERVAL_END)
> +	if (flags & NFT_SET_ELEM_INTERVAL_END) {
> +		if (!interval->to)
> +			return ERR_PTR(-ENOENT);
>  		rbe = container_of(interval->to, struct nft_rbtree_elem, ext);
> -	else
> +	} else {
>  		rbe = container_of(interval->from, struct nft_rbtree_elem, ext);
> +	}

Hmm, I don't think the query should have returned a match in the first
place, i.e. we should have left via (!interval || ... condition.

Pablo, could you please have a look?

I suspect we want something like this:

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -150,10 +150,12 @@ static int nft_array_get_cmp(const void *pkey, const void *entry)
 		b = memcmp(ctx->key, nft_set_ext_key(interval->to), ctx->klen);
 
 	if (a >= 0) {
-		if (ctx->flags & NFT_SET_ELEM_INTERVAL_END && b <= 0)
-			return 0;
-		else if (b < 0)
+		if (ctx->flags & NFT_SET_ELEM_INTERVAL_END && b <= 0) {
+			if (interval->to)
+				return 0;
+		} else if (b < 0) {
 			return 0;
+		}
 	}
 
 	if (a < 0)

When userspace asks for end interval, but we have an open interval,
then cmp callback shouldn't indicate a match.

