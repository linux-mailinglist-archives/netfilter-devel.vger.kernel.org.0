Return-Path: <netfilter-devel+bounces-11141-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGuEO/2asmnENwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11141-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 11:52:45 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9FF270827
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 11:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 523F83019904
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328A390CB7;
	Thu, 12 Mar 2026 10:52:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5302388E74
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Mar 2026 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312751; cv=none; b=IMDRW2VJKmuTOBHUL5qCxN6dGG3yky04I5/czhiVGqT/0hYFF9MWTo+E1uW+ektKZfp0eZPkUN8I0YTNOzpgA+xFn3JxUFYDR4sdRUCTGrzjGakH6VK+DwtoUn2+5cMfybWRRlXrRiMvun3bBKkFS0CPMFKa9EgHrwGeJWb9Pko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312751; c=relaxed/simple;
	bh=X1Us7bk99aFOJ6FHYu9wpgQhj46G04WurKIWm7He0FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Op+E8LGbHrbb57EnBpYc3CqNhQCxY/ofwMLdgIXJzxpVJvKyomzmV/u7ke1yJcjayHaTAMHOE5/vaZDnYPq3hr6nNNJ0TdGaKN5qy9i2SX8Rxe4yMVGJvUziaJtQ374HRjokDr75TD4kB8i/3gwEy/qaerOB+sNfStJ9SqSQcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7C07460470; Thu, 12 Mar 2026 11:52:27 +0100 (CET)
Date: Thu, 12 Mar 2026 11:52:23 +0100
From: Florian Westphal <fw@strlen.de>
To: =?utf-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Cc: security@kernel.org, phil@nwl.cc, netfilter-devel@vger.kernel.org
Subject: Re: [SECURITY][netfilter][nf_tables] stack out-of-bounds read in
 nft_set_pipapo pipapo_drop()
Message-ID: <abKa5xR6V9D9BhjM@strlen.de>
References: <CAL_bE8LMSUQ+Ls8bP4D32kOiJH=-UqgVKgjSAk7nA0G=+XzveA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_bE8LMSUQ+Ls8bP4D32kOiJH=-UqgVKgjSAk7nA0G=+XzveA@mail.gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11141-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ozlabs.org:url,strlen.de:mid]
X-Rspamd-Queue-Id: 5C9FF270827
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

钱一铭 <yimingqian591@gmail.com> wrote:
> 2) Root cause explanation
> rulemap is a fixed-size stack array:
> union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
> When m->field_count == NFT_PIPAPO_MAX_FIELDS (16), the last iteration has i
> == 15. pipapo_drop() still evaluates:
> rulemap[i + 1].n
> which becomes rulemap[16].n, i.e. out-of-bounds read from stack.
> Important detail: although is_last == true and pipapo_unmap() immediately
> returns, the function argument rulemap[i + 1].n is already evaluated before
> the callee runs. So the OOB read is unconditional in that final iteration.
> ------------------------------
> 3) Reproducer summary
> Userspace netlink PoC sequence:
> 
>    1. NFT_MSG_NEWTABLE
>    2. NFT_MSG_NEWSET with flags NFT_SET_INTERVAL | NFT_SET_CONCAT
>    3. set key length 64
>    4. set concat descriptor with 16 fields, each field length 4
>    5. NFT_MSG_NEWSETELEM add one element
>    6. NFT_MSG_DELSETELEM delete same element
> 
> This reaches:
> nf_tables_delsetelem -> nft_setelem_remove -> nft_pipapo_remove ->
> pipapo_drop

Could you confirm this is fixed by this patch?

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260306191238.937530-1-qguanni@gmail.com/

Thanks!

