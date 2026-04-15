Return-Path: <netfilter-devel+bounces-11908-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FVdL4Nf32m5SAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11908-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 11:50:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C4402DF7
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 11:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC18B30B448E
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2957833B97B;
	Wed, 15 Apr 2026 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="hwekWwft"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81E33B6DB;
	Wed, 15 Apr 2026 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246258; cv=none; b=UJNMjr3xj6qTIdaNHVRcgIbaaC6LN71nYo0I2OUkRsl0cUc6xOTUIcenoWHsP8VkQRK1S+RiskIV6Z9cXdZT6tUNvovxS/pTb1NJwpe+cRADo6R8YwpixrKx1NWMLa9Bv3VwPNmoogfQ8PRiURbIDAZILEhbjlxZ/ILeNGmJIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246258; c=relaxed/simple;
	bh=rOaTC09KLz2LhzbM8oeVZ2ALb3gBx9o6prroLYDDQpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ6fcqyRm6KUuRk7vPuGnlN2r0GnoEoqjp95Imo7RNcgY+y/gGgLGYmaqryENtZAI6GVW5exh6P18de0MIFnPhsFU3mcJdY2/CvMtraNulKJBLKEdsFkmEjJvo2yNtvSIHLB0m31weFuEd37QGzc8YXevnThhFZ6Ovx/PWQX5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=hwekWwft; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 1B6B160177;
	Wed, 15 Apr 2026 11:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776246255;
	bh=rCXP0KvTyTOh92l8pVnRCgE133x+jHf1nmXM5XnPCDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwekWwftUzl6EH27hi+kJY+aPfble88N1tr4IuCf9x9PKPvL9KfoAP3gIdIkhtHeU
	 jAY1pTsU80jMUrPth75/AlGKiQG7el3kcdIP2JJAbUGPAzDoLU4c8MC2q/mWh3OD71
	 w/lPTQRauhpTwOx6Ms1ZhyZlGZAoNDznC713kT9+LfhemPxDoAra3bCzHMkiSZpuV2
	 AhhBqCqPwviukkm5RuJwAZFNJvNrYOCjSL7jVeFfn1V2jQGV/rAlTh8ZgJBJ6BgAPb
	 huZFn3sREhLG6YnH+uRzQgeGV5t+Fy3PZWlNuLE2DX/hBKkEuysr7S3vwDoVySiuuX
	 gSC2BHz3poUGQ==
Date: Wed, 15 Apr 2026 11:44:12 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: "Kito Xu (veritas501)" <hxzene@gmail.com>, phil@nwl.cc,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jengelh@medozas.de,
	kaber@trash.net, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: xt_realm: fix null-ptr-deref in realm_mt()
Message-ID: <ad9d7CqrSLYQ8gyA@chamomile>
References: <20260415034343.107920-1-hxzene@gmail.com>
 <ad9UF5Cr12YGJnbi@strlen.de>
 <ad9aDziQEBR0h3U8@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad9aDziQEBR0h3U8@chamomile>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11908-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,medozas.de,trash.net,vger.kernel.org,netfilter.org];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim]
X-Rspamd-Queue-Id: 610C4402DF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 11:27:43AM +0200, Pablo Neira Ayuso wrote:
> On Wed, Apr 15, 2026 at 11:02:15AM +0200, Florian Westphal wrote:
> > Kito Xu (veritas501) <hxzene@gmail.com> wrote:
> > > realm_mt() unconditionally dereferences skb_dst(skb) without a NULL
> > > check. The xt_realm match registers with .family = NFPROTO_UNSPEC,
> > > making it available to all netfilter protocol families. Through the
> > > nftables compat layer (nft_compat), an unprivileged user inside a
> > > user/net namespace can load this match into a bridge-family chain.
> > 
> > I do not think this bug is related to nft_compat.
> > You can also use ebtables setsockopt api to request xt_realm, no?
> > 
> > > Fixes: ab4f21e6fb1c ("netfilter: xtables: use NFPROTO_UNSPEC in more extensions")
> > 
> > Looks correct.  Alternatively we could revert the xt_realm.c change.
> > But I don't have a strong opinion here, patch looks correct.
> 
> Maybe partial revert makes sense, since in ab4f21e6fb1c:
> 
> - xt_MARK: OK
> - xt_NOTRACK: OK
> - xt_comment: OK
> - xt_mac: There is a better way to do this in bridge.
> - xt_owner, no sockets in bridge.
> - xt_physdev, which makes no sense in bridge, this is for br_netfilter
>   only.
> - xt_realm (as already mentioned).
> 
> That is, a partial revert of this patch for:
> 
> - xt_mac
> - xt_owner
> - xt_physdev
> - xt_realm

"this patch" refers to ab4f21e6fb1c 

