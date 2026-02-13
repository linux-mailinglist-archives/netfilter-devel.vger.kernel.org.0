Return-Path: <netfilter-devel+bounces-10763-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJGwOsQhj2mvJgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10763-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Feb 2026 14:06:12 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3010A136341
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Feb 2026 14:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F673032066
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Feb 2026 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7174B35C1A1;
	Fri, 13 Feb 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="dZ9ITkkP"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F173033DF
	for <netfilter-devel@vger.kernel.org>; Fri, 13 Feb 2026 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770987969; cv=none; b=lRR60euRD21IQqxq/fjFCyzeRT1UbAWkVT/RdloPWhXZGvMszXggj4KiGSDW/8SUigiidU/wW6HoTrhoHUMBB5c+WQZay0PWRzogLf+TKe4d1+9RU319x1IYjXTJzKBgSrvyZeOYmILV8eSO8qawQFayKxl/muy7XhwCZms7hXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770987969; c=relaxed/simple;
	bh=8vjUX+oOBnnr0Xpx+NlKII+Ux/7gHSZyfIiLAsdCkdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjVg9pdIZNJTWyZePqxZ1CcFZbubekrDuZyZPGmdf0+S+AyK+lIZ4tiYZGb5ljX4a22am/wnVMSeql8j8htUKOv4TQEgohztzGhT51PKpGLfeYjZ78+1Qp+wybxy7ZVsO5UISLfbPK8WdPR83tpp5LGVO4wVNUneEv7RGSr4eM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=dZ9ITkkP; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NVbeGgZMqV681NG/VkgXrKIZsyDPV4M0HvFVCJ6itrE=; b=dZ9ITkkPOWDW/kNePcfJeMKjWu
	V3b81In4i1DYwI54t6QbqYQEQY710/rmu78iYmFgvqLBBYdKusCgTcrr/MqvIKiwvNDkWk8YkK4I2
	kRX931UNBRoPwChFIqFX29eHJ4NIDM+uRRvSJfse1I2J44l2rQS2djTELpHGn76bWYcX9X8mKEbJH
	9rPfDP7EUErIkv/9KVSFZI/VJwXG8d1J36w/RFHiRY5YzCN3SegHrAGrjzYQGq0O9CcwPUJVZyCQL
	J5U82bUoBOpayySENMdwuTUxIgawua9SYLRLczRM0xt3JjEMZpaI7PZOTN4S5dz97c/0rmzoDTyof
	Vn39SjYA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vqss0-000000007C4-1jAF;
	Fri, 13 Feb 2026 14:06:04 +0100
Date: Fri, 13 Feb 2026 14:06:04 +0100
From: Phil Sutter <phil@nwl.cc>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH] iptables: fix null dereference parsing bitwise operations
Message-ID: <aY8hvMbo6JVX5hto@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
References: <20260202101408.745532-1-one-d-wide@protonmail.com>
 <aYz2eUev4mUdN7uX@orbyte.nwl.cc>
 <wsfxGCi6FNb3Qj2_tw3b9WZS2spw8DyUe34OgpSzj8UQg7tNdw0RReS7iwQBnoVIHfZOIFoCUFf6mVAVOAGCSabgUgWBa9yABVwyAzNI_lc=@protonmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wsfxGCi6FNb3Qj2_tw3b9WZS2spw8DyUe34OgpSzj8UQg7tNdw0RReS7iwQBnoVIHfZOIFoCUFf6mVAVOAGCSabgUgWBa9yABVwyAzNI_lc=@protonmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[nwl.cc];
	FREEMAIL_TO(0.00)[protonmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10763-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: 3010A136341
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 07:34:29PM +0000, Remy D. Farley wrote:
> On Wednesday, February 11th, 2026 at 21:37, Phil Sutter <phil@nwl.cc> wrote:
> 
> > On Mon, Feb 02, 2026 at 10:14:52AM +0000, Remy D. Farley wrote:
> > > diff --git a/iptables/nft-ruleparse.c b/iptables/nft-ruleparse.c
> > > index cdf1af4f..1a9084e3 100644
> > > --- a/iptables/nft-ruleparse.c
> > > +++ b/iptables/nft-ruleparse.c
> > > @@ -232,6 +232,11 @@ static void nft_parse_bitwise(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
> > >  	const void *data;
> > >  	uint32_t len;
> > >
> > > +	if (nftnl_expr_get_u32(e, NFTNL_EXPR_BITWISE_OP) != 0 /* empty or MASK_XOR */) {
> > > +		ctx->errmsg = "unsupported bitwise operation";
> > > +		return;
> > > +	}
> > > +
> > 
> > This is redundant wrt. the stricter compatibility check below, right? Or
> > did you find a call to nft_rule_to_iptables_command_state() which is not
> > guarded by nft_is_table_compatible()?
> 
> 
> Yeah, I wasn't sure that was the case. I'll remove this check.
> 
> 
> > Anyway, I would add two checks to that function like so:
> > 
> > | if (!data) {
> > | 	ctx->errmsg = "missing bitwise xor attribute";
> > | 	return;
> > | }
> > 
> > (And the same for bitwise mask.) It will sanitize the function's code
> > irrespective of expression content, readers won't have to be aware of
> > (and rely upon) bitwise expression semantics with NFTNL_EXPR_BITWISE_OP
> > attribute value being zero.
> > 
> > >  	if (!sreg)
> > >  		return;
> > >
> > > diff --git a/iptables/nft.c b/iptables/nft.c
> > > index 85080a6d..661fac29 100644
> > > --- a/iptables/nft.c
> > > +++ b/iptables/nft.c
> > > @@ -4029,7 +4029,6 @@ static const char *supported_exprs[] = {
> > >  	"payload",
> > >  	"meta",
> > >  	"cmp",
> > > -	"bitwise",
> > >  	"counter",
> > >  	"immediate",
> > >  	"lookup",
> > > @@ -4056,6 +4055,10 @@ static int nft_is_expr_compatible(struct nftnl_expr *expr, void *data)
> > >  	    nftnl_expr_is_set(expr, NFTNL_EXPR_LOG_GROUP))
> > >  		return 0;
> > >
> > > +	if (!strcmp(name, "bitwise") &&
> > > +	    nftnl_expr_get_u32(expr, NFTNL_EXPR_BITWISE_OP) == 0 /* empty or MASK_XOR */)
> > 
> > '== NFT_BITWISE_MASK_XOR' and drop the comment.
> 
> 
> It took me a while to realize iptables/linux headers are quite outdated,
> so NFT_BITWISE_MASK_XOR is still called NFT_BITWISE_BOOL in there.

Ah, sorry about that. I merely looked at current kernel headers to check
if that magic zero could be replaced by something more descriptive.

Cheers, Phil

