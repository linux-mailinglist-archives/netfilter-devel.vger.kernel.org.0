Return-Path: <netfilter-devel+bounces-11731-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBAWOBNE1mk0DAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11731-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 14:03:31 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E6F3BBB08
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Apr 2026 14:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAE3330041C6
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Apr 2026 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF7638B153;
	Wed,  8 Apr 2026 12:03:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F13B3C12
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Apr 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649808; cv=none; b=YV7PgvmnPoHjDv2s7NcxGz2lFJxESdC+rZubyNYsvOqbSnhsQAnPNa5FGLTMeZdj96OtIVURtULg9GN+dCBq25Q4Kx40clERI0DM0KeHt9z1pHX0Sw7YIhvtHcPGF78bKthfgqeUYbMSfK3Kfm3tc0qyXD9F8CogcAgYnS8Igwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649808; c=relaxed/simple;
	bh=7MBcAQywZ3WuOvRoUdZduVx/NOQ7b3i9A9gVJPziq2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgStBefOb7YcSlofNz+UylQICXfJoi42WrP1l1lek3e+ylPyRnU5CKDS+yyQVk0LoIFQEKH+pTWDCWxlQCcxddUXF6/nXJW5MHrLyNhS3wUgj032aQc/5npGbLxpiSnt14zwXb4eTjJd0m9ftnOxMtg+PWSi59mcSqUNzoIgCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 65B6360560; Wed, 08 Apr 2026 14:03:24 +0200 (CEST)
Date: Wed, 8 Apr 2026 14:03:24 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, phil@nwl.cc
Subject: Re: [PATCH nft 1/5] libnftables: report EPERM to non-root users with
 -f/--filename
Message-ID: <adZEAkrcCcXEau_1@strlen.de>
References: <20260408115922.48676-1-pablo@netfilter.org>
 <20260408115922.48676-2-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408115922.48676-2-pablo@netfilter.org>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-11731-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.953];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,netfilter.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81E6F3BBB08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Similar to 3cfb9e4b3e40 ("src: report EPERM for non-root users").
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  src/libnftables.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/src/libnftables.c b/src/libnftables.c
> index 66b03a1170bb..e3218da9f48f 100644
> --- a/src/libnftables.c
> +++ b/src/libnftables.c
> @@ -767,8 +767,13 @@ static int __nft_run_cmd_from_filename(struct nft_ctx *nft, const char *filename
>  		nft_optimize(nft, &cmds);
>  
>  	rc = nft_evaluate(nft, &msgs, &cmds);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		if (errno == EPERM) {
> +			fprintf(stderr, "%s (you must be root)\n",
> +				strerror(errno));
> +		}
>  		goto err;
> +	}

Hmm, should the library leave stderr alone?

