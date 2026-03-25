Return-Path: <netfilter-devel+bounces-11414-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FnIDdQcxGnlwQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-11414-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 18:35:16 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAB8329EA4
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 18:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7331300252A
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28575405ACB;
	Wed, 25 Mar 2026 17:29:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318C4014A8;
	Wed, 25 Mar 2026 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459767; cv=none; b=a59+D7Oouks0oYgZgXj7tpFUE1nOapQ5Q6x56pFdVl8QCZxEZGnq27ReHv4Cksli9C6u1VObKF2cYv8RW20KSyDsEZ3WrBghUqrPexUwsCdv15e0uVhFhfa14fbmU2UpyE5EpQA8nXojLzFULYWc6fSEqC4z9ujtO6E76wzaEPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459767; c=relaxed/simple;
	bh=97rYFqJNRPWwAQmAUMBPRGRwoJMnJ7FsODxE0p7iAX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxyJ5Szq5vU/FusiI4+W4lbGzZhWVnhU9mKdN/wiz5Isx1CNgovAK7Q9c3uNJqOGpEKUcTb1MzOPYKIkLPPChyahn0fakXvwR1oWhmx5lHSdZ/69WDiF+adQe3JMCnDze84pa80Nonch86KlbOzvqAF7D7jjNzIT7yljYgqrZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D3F39608BD; Wed, 25 Mar 2026 18:29:23 +0100 (CET)
Date: Wed, 25 Mar 2026 18:28:58 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net 10/14] netfilter: ctnetlink: ensure safe access to
 master conntrack
Message-ID: <acQbWvJUK20gbTWg@strlen.de>
References: <20260325131108.23045-1-fw@strlen.de>
 <20260325131108.23045-11-fw@strlen.de>
 <acQa30IdYh3PeLAh@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acQa30IdYh3PeLAh@chamomile>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11414-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FAB8329EA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Sorry for this late followup incremental fix.

I'm tired.

> diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
> index 509d3eb6f56a..cf39662c4b97 100644
> --- a/net/netfilter/nf_conntrack_expect.c
> +++ b/net/netfilter/nf_conntrack_expect.c
> @@ -325,7 +325,9 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
>  		       u_int8_t proto, const __be16 *src, const __be16 *dst)
>  {
>  	struct net *net = read_pnet(&exp->master->ct_net);
> -
> +	struct nf_conntrack_helper *helper;
> +	struct nf_conn *ct = exp->master;
> +	struct nf_conn_help *help;
>  	int len;
>  
>  	if (family == AF_INET)
> @@ -336,7 +338,14 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
>  	exp->flags = 0;
>  	exp->class = class;
>  	exp->expectfn = NULL;
> -	rcu_assign_pointer(exp->helper, nfct_help(exp->master)->helper);
> +	help = nfct_help(ct);

Do we have a reference here? Is that safe?

I'm not looking forward to a new PR.

