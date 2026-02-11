Return-Path: <netfilter-devel+bounces-10732-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APIlAZ3UjGm+tgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10732-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 20:12:29 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F816127153
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 20:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2210302EE95
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 19:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584E934EF06;
	Wed, 11 Feb 2026 19:09:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44419346ADC
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Feb 2026 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836973; cv=none; b=jijydGnX/fmjtR3bDp12EWDDqW++JuA6eR75xlA/6YyqGFHka2HZVnOQ0kcP06qCtpKWFNB+eoUhqJ68Oa7KJN4LLTLJ1gdWa2t6UJL6uB2asPOFt5dxmjRA4nOqiJePfEjiihGdYkw6Pp7il/cV6nIHCphW99cQqyXLNSK+7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836973; c=relaxed/simple;
	bh=osi4F1yyV2uRCtTRKIXr2ZlidFiW5JYK1NeOes1yaNg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjvwnHAKJmZx1RNXKhqqoxjVaoyTpsFaZ1OakhnRq4ygof+RildMKsWJ/oovTr+uDkSYRFsXqgo7GQ15As08OhMW9Pup2JJqK9mLSMuLl4rDl15qkko/ZL0HEXPQkyFddGepY3tALPLbrWwtr9ZEQXwAFigI3iaPckrYkg8LZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 998E56024F; Wed, 11 Feb 2026 20:09:30 +0100 (CET)
Date: Wed, 11 Feb 2026 20:09:30 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Alyssa Ross <hi@alyssa.is>, netfilter-devel@vger.kernel.org,
	Joshua Lant <joshualant@googlemail.com>
Subject: Re: [PATCH nftables] include: fix for musl with iptables v1.8.11
Message-ID: <aYzT6kHV7ntq5kfo@strlen.de>
References: <20241219231001.1166085-2-hi@alyssa.is>
 <Z2VaEv0u3ZPcWqye@orbyte.nwl.cc>
 <v654rm6mbtymzhavlbg2fu7irth4mkz4motq7vb7rzjql5ccqa@u7xv7uvdfvsl>
 <Z2VkJrkSLRmY9lAE@orbyte.nwl.cc>
 <Z38Ladz49yJcTC8p@calendula>
 <Z38PIVmu2jAVl1k2@orbyte.nwl.cc>
 <Z38STV2bWSlz4uxo@calendula>
 <Z3-emP_FzgGAYGUJ@orbyte.nwl.cc>
 <aYyI9kN4FAgbFUA-@strlen.de>
 <aYzRlXaSetejciwU@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYzRlXaSetejciwU@orbyte.nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nwl.cc,netfilter.org,alyssa.is,vger.kernel.org,googlemail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10732-lists,netfilter-devel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nwl.cc:email,strlen.de:mid]
X-Rspamd-Queue-Id: 7F816127153
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> > Phil, would you send a formal patch to make this workaround *ONLY* in
> > netfilter_bridge.h (06e445f740c1)?
> 
> DONE.

Thanks.

> > That way the fix can be propagated to nftables.git without having to
> > adjust cached headers on every update.
> 
> I assume you prefer to keep headers untouched which are
> iptables-specific. But why not attempt to patch if_ether.h itself?

Because this is a quagmire and I prefer to only break netfiler_bridge.h
users (which should be few) rather than everyone using if_ether.h.

