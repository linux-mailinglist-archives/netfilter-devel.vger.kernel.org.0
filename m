Return-Path: <netfilter-devel+bounces-13532-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vlQWCEZRQ2qOWwoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13532-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 07:16:54 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A956E0737
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 07:16:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13532-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13532-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52C91300A4A0
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 05:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B32A38AC61;
	Tue, 30 Jun 2026 05:16:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB432A3D7;
	Tue, 30 Jun 2026 05:16:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796612; cv=none; b=p0sxlKXDwqkhHYlx8y0w9rDqJJ/b+X9uzKdtwpK8fPC5qLyzCrrnRVOGFQzaW6BEeCOmtfqUE+ZGq5X7OP/PI7Su6XDZ7ErQSyse1qjNop/MetO+mCHUTAZEVVqGELVVC9OdSzxBm2wd6cWFQZEXyKDnJ0DASuX//PvOsvSOjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796612; c=relaxed/simple;
	bh=wrI2NdcJ5fFbuVZ1pzUuda1VQkh21nFSHNZ8FCUTZCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyQo44iO0u73+7Tq5iP+aaWvicIyvmXRWF30KmNA2+AKZDaT1HKgPfiADHWT1ajFKABCOOoiodQW6cFiqLeOHW56W00lw/lF9CERbeeSCX9QqCWvDqgnuFcAw8uhzZYX2HjW0CkPewfBhiGsKOSNo41QSNivviJyS7w9av51MVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8D3E960D0F; Tue, 30 Jun 2026 07:16:48 +0200 (CEST)
Date: Tue, 30 Jun 2026 07:16:48 +0200
From: Florian Westphal <fw@strlen.de>
To: Zhixing Chen <running910@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: ip6t_ah: validate AH header length
Message-ID: <akNRQFx9fmi2DK0w@strlen.de>
References: <20260618125848.93550-1-running910@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618125848.93550-1-running910@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:running910@gmail.com,m:pablo@netfilter.org,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[strlen.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13532-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3A956E0737

Zhixing Chen <running910@gmail.com> wrote:
> ip6t_ah checks that the fixed AH header is present, then uses hdrlen to
> derive the advertised AH header length for matching.
> 
> Return false if the skb does not contain the advertised AH header length.
> This avoids matching AH headers whose advertised length is not present in
> the skb.
> 
> Signed-off-by: Zhixing Chen <running910@gmail.com>
> ---
> 
> I noticed ip6t_hbh and ip6t_rt already do this advertised-length check
> for their IPv6 extension headers, so this keeps ip6t_ah in line with
> those matches.

Could you make a v2 that addresses

https://sashiko.dev/#/patchset/20260618125848.93550-1-running910%40gmail.com
?

We should not return false in matches for malformed packets without
also setting ->hotdrop = true.

