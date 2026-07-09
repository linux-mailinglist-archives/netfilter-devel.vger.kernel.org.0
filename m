Return-Path: <netfilter-devel+bounces-13815-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UiijNY4RUGpmswIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13815-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 23:24:30 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74994735CDF
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 23:24:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13815-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13815-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8193301344E
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5563B14D0;
	Thu,  9 Jul 2026 21:24:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5761D5160;
	Thu,  9 Jul 2026 21:24:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632268; cv=none; b=qM04Vo2kwcfr70jSqC0gjrVpjC8gtSlwCfcFfzo/5i4d1AF9cAiqbIGJcp+lnK3fHV7TDaTmQQIcOo4cVWDPqVpQSHYvh/A4f1fxnnoivmTifVJt1lSB0BVpEhyYNu7SZyfmOGArDmVXqbwRPIdqhmsTJcPlqhZH1PNksUCWdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632268; c=relaxed/simple;
	bh=6lCScXnxAKdLScKBiarupLDikZ1YWD8rIA/8Qp74qlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIzjwNbhI/u6usrwjHZoGiSZfIy/KT+SR/QvYFzgz0bzgGA79qFwLuNgFy/6W+dPclO/hsVtyFhSHM3vjuuolVi9Ze46jrtQuHadpz8/A6MOhu1/586yHo4OzW1Mbq3rMY8GD00THlk6rUwHfzGaIjQoCtkhSrKIziAnclR9SuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0CB84602A9; Thu, 09 Jul 2026 23:24:24 +0200 (CEST)
Date: Thu, 9 Jul 2026 23:24:22 +0200
From: Florian Westphal <fw@strlen.de>
To: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>, lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] ipvs: fix the checksum validations
Message-ID: <alARhv8ezLbt2MBK@strlen.de>
References: <20260709202356.104307-1-ja@ssi.bg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709202356.104307-1-ja@ssi.bg>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ja@ssi.bg,m:horms@verge.net.au,m:pablo@netfilter.org,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-13815-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ssi.bg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74994735CDF

Julian Anastasov <ja@ssi.bg> wrote:
> TCP/UDP checksum validation for CHECKSUM_COMPLETE is broken
> before the git history.
> 
> Expecting skb->csum to cover data starting from the protocol
> header is wrong. As IPVS works at the IP layer, the csum for
> the IP header is not subtracted yet.
> 
> ip_vs_in_icmp_v6() is missing checksum validation for ICMPv6
> packets from clients.
> 
> Also, Sashiko points out that handle_response_icmp() being
> common for IPv4 and IPv6 is missing the pseudo-header
> calculation while validating ICMPv6 messages from real
> servers which is a problem if checksum is not validated
> by the hardware.
> 
> Fix the problems by creating ip_vs_checksum_common_check()
> helper and use it for TCP/UDP/ICMP both for IPv4 and IPv6.
> 
> Also, ip_vs_checksum_complete() can be marked static.

Just FYI, I'll ignore the sashiko comment wrt.
'hardcoded sizeof(struct ipv6hdr)' as thats resolved by your
earlier patch, so I plan to include this in tomorrows batch.

