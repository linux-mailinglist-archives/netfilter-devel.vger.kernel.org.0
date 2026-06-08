Return-Path: <netfilter-devel+bounces-13132-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gw8PKapEJ2qcuAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13132-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 00:39:38 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DB865B023
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 00:39:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b="e/zlx72T";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13132-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13132-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7E1B3015C92
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2026 22:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F673B388A;
	Mon,  8 Jun 2026 22:39:35 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8984B3B14DA;
	Mon,  8 Jun 2026 22:39:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958375; cv=none; b=QIRy3/P4Be06rFLDKoepsXUMas4u4LZwGJhiCrVQ+cvF89YLYSBar3xqKDID09nmjOGhACI7YjIlp+sW4qRbRFutrNVLOo63vBznRtlbBL6RDJEPyxGmMro8Y7Oj2rs03snMrn2vGHYFZW/gIcvgsSDEUw289GYZWgHP0TKh828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958375; c=relaxed/simple;
	bh=+Fi3sVsuwExNL+7pNEZPC52ELM3zS+sCwv6XvTeLfIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsIVzior6vwc68LFX9/gXBctoJCNg8BKEIbH/u5cBP9VhXcWWlQ94QAaPvxJBd2UNij6J2qA5frygiQVmD3M6YSiOBFK9Eo5AItu2sj0O95flzyaWcuhvxJz5SvTKdYBG3ob5O6oBLKB3Bwm216/7KZcM0eCYhVKNKPHOzz0604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=e/zlx72T; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 95CA66017D;
	Tue,  9 Jun 2026 00:39:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780958371;
	bh=JK1bd7LvraTNFT4vJa+JYC9LaSx8/4N0x/mO2QrqYkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/zlx72Tvq4BYNFBexcJ2DstWTQjL11q61Ft8ozJIrbs02Ws76UpVmIhArFAJcfeE
	 DJo/Iw8qqTNEqwIT5vxnC2swIncTF1foDP1T/++fQNcB5ZslYhj+Xrjqcw0udo4N/M
	 bob6cGRmjCH+zYiYUSj5JKxzSlt/gs6j4VdFOc19p1Fx7vy+AVlb+ZAjQcyLC0hRRE
	 RO5K3Te5GcP4CkDjDn0xfTk2qncmhjYtrzOxx/jUw6dkeFG+rh14qTy+O2qEQp8NOa
	 kzu8FZrgMmBws9wK0waI6S9inPv7MzrJIv39nRwm+pQd+4Hd4wx4bitXVKtchla2DM
	 hT+Xjw7KwZ3ww==
Date: Tue, 9 Jun 2026 00:39:29 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, fw@strlen.de,
	horms@kernel.org
Subject: Re: [PATCH net-next 00/15] Netfilter/IPVS updates for net-next
Message-ID: <aidEoZt4bt085hss@chamomile>
References: <20260607094954.48892-1-pablo@netfilter.org>
 <aiaubSEfDp_JQk_p@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiaubSEfDp_JQk_p@chamomile>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13132-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,netfilter.org:dkim,netfilter.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04DB865B023

Hi,

On Mon, Jun 08, 2026 at 01:58:40PM +0200, Pablo Neira Ayuso wrote:
> Hi,
> 
> I'm replying to Sashiko.dev comments here:
> 
> * [PATCH net-next 06/15] netfilter: synproxy: fix unaligned memory access in timestamp adjustment
> 
> Refers to pre-existing issue. I think this comment is not correct?

Yes, it is, inet_proto_csum_replace4() needs an even offset to the
16-bit word. Checksum will be corrupted, but at least the alignment
issue is addressed, which leaves things better than before. Maybe
it is worth to add a note to this patch.

I can post a v2 of this PR to refine the few things that make sense at
this stage.

