Return-Path: <netfilter-devel+bounces-11008-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGNhFf+Oqml0TQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11008-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 06 Mar 2026 09:23:27 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C521D055
	for <lists+netfilter-devel@lfdr.de>; Fri, 06 Mar 2026 09:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78803304E0DC
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Mar 2026 08:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A603246EC;
	Fri,  6 Mar 2026 08:18:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D133120E
	for <netfilter-devel@vger.kernel.org>; Fri,  6 Mar 2026 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785092; cv=none; b=RBpkXGRN6TDTY6ZL1BUZAxAKlVPSa/cmTm3BgCbddEPkqs8paxLuNQLU5RieRblnZ1aO6qYduwMYNhYqBC+Oi46+GHcSUd8Kon0toIeNWRDp1rxuF9MrUHXv4Ca12drcRtz4Lrbtq4uWYU0Ka/WqM3UP4Qs+mqQkom9EfUYSupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785092; c=relaxed/simple;
	bh=JsHTWRN4ovn3EAiZg+g3NaunCe1djTJi+RjVYSp272Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWArOxUX+OYX+91MQdNkJvIKapsLmuWeTR15u6m+OIAsX7m85TWVhvABvN2VzoOsn5sTlgjVNLIQ4NLHCjs/esUyj4grbahD9wdQTuLU1Geaiw9zFVgXhFrJ7BotKMi1uRoNL+TFIGKK+bo20MB9zvk2SSWFyTEsQymIitEifuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B18A960516; Fri, 06 Mar 2026 09:18:08 +0100 (CET)
Date: Fri, 6 Mar 2026 09:18:03 +0100
From: Florian Westphal <fw@strlen.de>
To: Jenny Guanni Qu <qguanni@gmail.com>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, w@1wt.eu
Subject: Re: [PATCH] netfilter: nft_set_pipapo: fix stack out-of-bounds read
 in pipapo_drop()
Message-ID: <aaqNu3eCF3f5aAvT@strlen.de>
References: <20260306080854.908476-1-qguanni@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306080854.908476-1-qguanni@gmail.com>
X-Rspamd-Queue-Id: C97C521D055
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11008-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.125];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Jenny Guanni Qu <qguanni@gmail.com> wrote:
> pipapo_drop() passes rulemap[i + 1].n to pipapo_unmap() as the
> to_offset argument on every iteration, including the last one where
> i == m->field_count - 1. This reads one element past the end of the
> stack-allocated rulemap array (declared as rulemap[NFT_PIPAPO_MAX_FIELDS]
> with NFT_PIPAPO_MAX_FIELDS == 16).

Thanks, patch looks correct to me.

> diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
> index 7ef4b44471d3..9fb83fc05848 100644
> --- a/net/netfilter/nft_set_pipapo.c
> +++ b/net/netfilter/nft_set_pipapo.c
> @@ -1659,7 +1659,8 @@ static void pipapo_drop(struct nft_pipapo_match *m,
>  		}
>  
>  		pipapo_unmap(f->mt, f->rules, rulemap[i].to, rulemap[i].n,
> -			     rulemap[i + 1].n, i == m->field_count - 1);
> +			     i == m->field_count - 1 ? 0 : rulemap[i + 1].n,
> +			     i == m->field_count - 1);

Small nit, could you add

	bool last = i == m->field_count - 1;

and then use 'last ? 0 : ..., last) ?

This idiom is used elsewhere in the file as well and I think it makes
this sligthly more readable.

Thanks!

