Return-Path: <netfilter-devel+bounces-13787-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fmHyL4mHT2p+iwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13787-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 13:35:37 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B482D7306A9
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 13:35:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=an5bK1Sc;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13787-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13787-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3010430564F5
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39BB411675;
	Thu,  9 Jul 2026 11:28:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2597409631
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Jul 2026 11:28:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596522; cv=none; b=MxrGx39F488MQBS5yRISOjmwfsGNnx+JHwIJFKNnsNrc54VscHS0dfSbdY2x8BaF+AZtJiKZGqssNVC02vkU0Z3ADPenwVtQR0UD/xYTdyQ0ikAXrg+PCI8a/qQMqLt/UXnXBnWMriA4yrk0tFMrRL4h+mPZOX311DVpHgR+jgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596522; c=relaxed/simple;
	bh=F6oemxPG6PEgQ9iR5P7rfWM6JzOC6u1d9X4bfcMeUoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmwxBxphTKe81H0XxTcO9uT4sqdoaCI9KkTYXy+JSM3G3BQUzeigmM454b80yOvm+IxhEnm7JlXLlaXRrJQxQreQgD9sWp2Uc17bpgGrM7lhVFJLeqBZLz+/fDeHA7HxpmTYr0SVHW1pbYxVk0MXZBJHq6auPT21u1A4p5fUpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=an5bK1Sc; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9gJmsq+V4DMPgCeNWDopDjW8sG7rW+mhAOc+hVHrkI4=; b=an5bK1ScSO0C5ZOxJafP/5PmU4
	xq+8jn2v09v3QxFX6eQYZ+4zD3vntpDzrQdZwst8moSevBLbYXmm77+xz6Ax3lS9UTZDug9srAjV1
	WOruMw2oklgzYaaitvKVpskco3oQuM0dHg0zSY4561Km7s9eJtWP4D3qefB1dR1eu/rb88StQSW7y
	n/1ojIXO7jyIgOdNEoWuIXKDVBRNMO/e3jgeFAbTG2hPUrB9EETVI4Eg55Kq5y/W9fW0d3lOVvAxR
	joz66IOzC0xFph+Fi7i1zKXiQcO9SEEvioWYocd4ErTMb72U7ky0fCsS0NRZhQcofudRKLX3LvF2q
	lG9q+VMw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1whmvn-000000004yf-0Tvi;
	Thu, 09 Jul 2026 13:28:39 +0200
Date: Thu, 9 Jul 2026 13:28:39 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH 4/4] netfilter: nfnetlink_hook: Fix for
 concurrent NAT hooks dump and change
Message-ID: <ak-F5wxDnAQ8qfYU@orbyte.nwl.cc>
References: <20260708161940.1477671-1-phil@nwl.cc>
 <20260708161940.1477671-5-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708161940.1477671-5-phil@nwl.cc>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	TAGGED_FROM(0.00)[bounces-13787-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[orbyte.nwl.cc:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nwl.cc:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B482D7306A9

On Wed, Jul 08, 2026 at 06:19:40PM +0200, Phil Sutter wrote:
[...]
> diff --git a/net/netfilter/nfnetlink_hook.c b/net/netfilter/nfnetlink_hook.c
> index 0657fbb3e605..e01e59eddd64 100644
> --- a/net/netfilter/nfnetlink_hook.c
> +++ b/net/netfilter/nfnetlink_hook.c
[...]
> @@ -361,8 +371,10 @@ static int nfnl_hook_dump_nat(struct sk_buff *nlskb,
>  			break;
>  	}
>  
> -	if (!err)
> +	if (!err) {
> +		ctx->natv = 0

There's a typo here (missing semi-colon), kindly spotted by kernel test
robot. I'll send a v2 once it has cooled down a bit.

Sorry, Phil

