Return-Path: <netfilter-devel+bounces-11288-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIqLHJ+/u2n1ngIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11288-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 10:19:27 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF0D2C880D
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 10:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4922C301078D
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E213B6BF7;
	Thu, 19 Mar 2026 09:18:17 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02D37F018
	for <netfilter-devel@vger.kernel.org>; Thu, 19 Mar 2026 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911897; cv=none; b=FojH4tM2xSJ/5SLYQmVzFV6VfzRW+lLeHSzug9G0fAuN9EPAiLS6fO3uqmYhzWDIVS0KaeHglPFBn/ap5qb8R/90Xu+RwTPyRb9otE2128hFdlIpfeyYlPiANl9BU8OlNWax/cJgCemtT8ZJBcE6aono0g5JfKVzeji3lxUX0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911897; c=relaxed/simple;
	bh=Fg01wNRidLBXFO5MHQpk/6hleWtvyVLx0LRbg6syNcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edz7UFK/GPO5mk8RUXcvc3T1tjDtp5xXV8wzS1dC9UzqaPCYzV96WigMvoYb3qi6HiHtL5cr04r8TAVPh6CW3rJDuSZtGkCorC/tQ8750tU3okvTbPE2lnw27sNL+igmbxGPPpKljaTlElZl0nB+Mu60lX4tqq9HOyHO0La7KRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 32ABD606E1; Thu, 19 Mar 2026 10:18:11 +0100 (CET)
Date: Thu, 19 Mar 2026 10:18:11 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Chloro Dose <chlorodose@gmail.com>
Subject: Re: [libnftnl PATCH] set{,_elem}: Drop nftnl_set{,_elem}_clone()
Message-ID: <abu_U5twbHFFv-FT@strlen.de>
References: <20260319090613.13874-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319090613.13874-1-phil@nwl.cc>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[netfilter.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-11288-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.555];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nwl.cc:email]
X-Rspamd-Queue-Id: DFF0D2C880D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Phil Sutter <phil@nwl.cc> wrote:
> These functions were never exported and are not used internally anymore.
> Maybe due to that, they became incorrect (e.g., they ignore expr_list)
> so drop them altogether.

Acked-by: Florian Westphal <fw@strlen.de>

