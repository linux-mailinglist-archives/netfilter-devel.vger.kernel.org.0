Return-Path: <netfilter-devel+bounces-11020-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAepAtYirGnulgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11020-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 07 Mar 2026 14:06:30 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BB122BD34
	for <lists+netfilter-devel@lfdr.de>; Sat, 07 Mar 2026 14:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65BAE301C5B5
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Mar 2026 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BEF39E6D1;
	Sat,  7 Mar 2026 13:06:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034A39E16A
	for <netfilter-devel@vger.kernel.org>; Sat,  7 Mar 2026 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772888787; cv=none; b=FCWsnYF5xoUKwDzVnmk6kFFZuDRrcTnjwqMDGyaMMHZIk3rXmd89CXoUVPdNTe94GbztA6wGWl+RLAqU4SkfPatpKYgiIWxhu4+Kcgvs1gSnf1qzOJz2guzU39Iyvd+5U5aEZYze1HwUd/bCG+FGVypkZwkTGnq9sRj2mqXuBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772888787; c=relaxed/simple;
	bh=74LBSmSfxwe36Fugw3zWrJ8SzGieG9C3xCU5xZslyuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3qCC9Nf2UPcEY5XbIFvZKCFxCal+A91JQeEQzlVxfDS33UJcMzio5mgRJgM7olf4c6fsyU+msCiIUXB/MIzxgQUajXBoLnVBtfmnTUYvX47zd1ks5biG7YeJy9DuhWhYC+MQr4iDHoDbjl9aX9A0/rm/2XmyG/FyiGDdeXtbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 9850B6077F; Sat, 07 Mar 2026 14:06:23 +0100 (CET)
Date: Sat, 7 Mar 2026 14:06:23 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, carges@cloudflare.com
Subject: Re: [PATCH nf,v2] netfilter: nft_set_rbtree: allocate same array
 size on updates
Message-ID: <aawiz8SnS4HwV97z@strlen.de>
References: <20260307001124.2897063-1-pablo@netfilter.org>
 <aavqwA_H032EaiRg@strlen.de>
 <aawhRH5SLVzNTots@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aawhRH5SLVzNTots@chamomile>
X-Rspamd-Queue-Id: 83BB122BD34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11020-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.084];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> There is also set->ndeact that provides a hint on deactivated
> elements.

Oh, right, I fogot about that.

So we even have an estimate of how many elements will disappear.
> 
> So yes, there are smarter things that can be done here, but as for
> this patch, my initial approach in this fix series was intentionally
> simple.

Sure, its better to use a simple patch for nf, rest can be expiremented
with in nf-next, I did not want to hold up this patch and I intend to
pick it up for nf.

