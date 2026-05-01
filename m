Return-Path: <netfilter-devel+bounces-12368-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP5zNJt/9GmXBwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12368-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 12:25:31 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A224AB9D3
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 12:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96654300C00B
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 May 2026 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02CF386C1B;
	Fri,  1 May 2026 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="jCqzezT2"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD443859CF;
	Fri,  1 May 2026 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777631119; cv=none; b=lMZA8+51S8aOsW04o1VAZY6mJiqvEZes6RxOwOJdkXumHEIQHBjXmhvVnnKBiT9Gx69WTuMgVrUMhY980DLR5kZHQ4/LRE9fvLpnxMs21/n8SkRHvCpxQf7+aGRZSHKfGaBw/VGJKtaxnDsuKKhVLWfQxfmi8HBagEh2W6DJz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777631119; c=relaxed/simple;
	bh=fpf3RJLKQLGsAmAufvVuk9ke9/CoP9XIfxlgiYVwQ8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXII6GcS74LyYRgOIzKsRQWQILuZMBKauBOTaFqAUDrqb3Ig1xmPdjPuwdGLiXQSPU2uujDo1g8JSyGktHAw4SzA+NocY+ecI4oG21Jaw5EO43YjanuZKEz9OGFhfs5u4vcxRXcWGnPnoYzaSln4Ub4U08Wt3e2hAVtOXcnBkTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=jCqzezT2; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XHcJ5oRczR09F1mUmwDtjNTaKrqpI4nyva/XOmPfKp0=; b=jCqzezT2A0hzJGv4N14+Jv13q0
	f3TA+44q2j5ni/uEJz4BGO2xf7XLDvQqgMcyxHhc/aPlj6PP+i1ELiWL96NFBwg/3cG9DMJJ8Bj3I
	Y0NPaDFI1bnsoaFjTL03EaoAdBHaZs4LM+XJIX8vYThE8RtcAlqafF0nKanLUVN+3LTNi6LPD7EM8
	TmEve/aZZdyDhZy1qcoxrqdJuPRBaW5r3SwLkheQ/xpCF4+OCz3ZtpZfafRm/CAGt1j5xhmaDP0C2
	e5FX98dGoIgtI9ynWZkPFrCuuVV+MIRWm8PuSjdz3DHxxfCP6rLKVwYWjjA5MGJayd7+u319OVaSs
	LP5RmxtA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1wIl3N-000000003i1-07CK;
	Fri, 01 May 2026 12:25:01 +0200
Date: Fri, 1 May 2026 12:25:01 +0200
From: Phil Sutter <phil@nwl.cc>
To: HACKE-RC <rc@rexion.ai>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] netfilter: conntrack: add shared port
 parser for helpers
Message-ID: <afR_ffe8vDhjTBCf@orbyte.nwl.cc>
References: <20260501063156.2520780-1-rc@rexion.ai>
 <20260501063156.2520780-2-rc@rexion.ai>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501063156.2520780-2-rc@rexion.ai>
X-Rspamd-Queue-Id: 75A224AB9D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12368-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rexion.ai:email]

Hi,

On Fri, May 01, 2026 at 12:01:54PM +0530, HACKE-RC wrote:
> Add nf_ct_helper_parse_port() to the conntrack helper core. This
> provides a port parser that does not rely on nul-terminated strings,
> taking an explicit length parameter and validating the result fits
> in the 1-65535 range.
> 
> Modeled after the approach in 8cf6809cddcb ("netfilter:
> nf_conntrack_sip: don't use simple_strtoul") but as a shared
> function so IRC, Amanda, and other helpers can use it instead of
> open-coding simple_strtoul calls with ad-hoc range checks.
> 
> Signed-off-by: HACKE-RC <rc@rexion.ai>
> ---
>  include/net/netfilter/nf_conntrack_helper.h |  3 +++
>  net/netfilter/nf_conntrack_helper.c         | 28 +++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/include/net/netfilter/nf_conntrack_helper.h b/include/net/netfilter/nf_conntrack_helper.h
> index de2f956ab..db19fe25f 100644
> --- a/include/net/netfilter/nf_conntrack_helper.h
> +++ b/include/net/netfilter/nf_conntrack_helper.h
> @@ -160,6 +160,9 @@ nf_ct_helper_expectfn_find_by_name(const char *name);
>  struct nf_ct_helper_expectfn *
>  nf_ct_helper_expectfn_find_by_symbol(const void *symbol);
>  
> +int nf_ct_helper_parse_port(const char *cp, unsigned int len,
> +			    u16 *port, char **endp);
> +
>  extern struct hlist_head *nf_ct_helper_hash;
>  extern unsigned int nf_ct_helper_hsize;
>  
> diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
> index a715304a5..12f51670d 100644
> --- a/net/netfilter/nf_conntrack_helper.c
> +++ b/net/netfilter/nf_conntrack_helper.c
> @@ -499,6 +499,34 @@ void nf_nat_helper_unregister(struct nf_conntrack_nat_helper *nat)
>  }
>  EXPORT_SYMBOL_GPL(nf_nat_helper_unregister);
>  
> +int nf_ct_helper_parse_port(const char *cp, unsigned int len,
> +			    u16 *port, char **endp)
> +{
> +	unsigned long result = 0;
> +	const char *start = cp;
> +
> +	while (len > 0 && *cp >= '0' && *cp <= '9') {
> +		result = result * 10 + (*cp - '0');
> +		if (result > 65535)
> +			return -1;
> +		cp++;
> +		len--;
> +	}
> +
> +	if (cp == start)
> +		return -1;

This check is redundant wrt. the following one: If the loop didn't
increment 'cp', result must be zero. So you may just drop it entirely.

Cheers, Phil

> +
> +	if (result == 0)
> +		return -1;
> +
> +	*port = result;
> +	if (endp)
> +		*endp = (char *)cp;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nf_ct_helper_parse_port);
> +
>  int nf_conntrack_helper_init(void)
>  {
>  	nf_ct_helper_hsize = 1; /* gets rounded up to use one page */
> -- 
> 2.54.0
> 
> 

