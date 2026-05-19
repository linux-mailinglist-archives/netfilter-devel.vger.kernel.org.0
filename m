Return-Path: <netfilter-devel+bounces-12696-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMAYGyitDGqGkwUAu9opvQ
	(envelope-from <netfilter-devel+bounces-12696-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 20:34:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CFC583BED
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 20:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E49AF30028F8
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4902328243;
	Tue, 19 May 2026 18:34:11 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21C7314D15
	for <netfilter-devel@vger.kernel.org>; Tue, 19 May 2026 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215651; cv=none; b=WNHcgDghpx3h/IDbXq/0BGbV7T9avIz77KPFg8T//ekc2Cdvs1XVbJrv9Cv3TPlPWk3dWDM4zDkHNaBA+Dbcp65DtXtNihgOrKDr4tAWSLlcVa0RXE+L5UzSgL7HplBKksO7mR+ACOO02eehgog2e5abS7f/KUYQ4rtrTyh2NBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215651; c=relaxed/simple;
	bh=dpm07bYiTuvHb7l46ac8PMeAUEq9RzYMiEPmRwGwVuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3enyV5X3RiAnwKO4ql+g8F8IfuNU1lvkWzerFLyUNliv+jZeSkcVnVuiEZXnRsVZKNr3V3XJtd4MukzwLccB5kJIafJkrpzBqhrXVcgjUnPGf4vBGG3QBGa6ZZrhtkyMjaiRDmLl6NZAOz024asPUy1NY18R/iyDmbA0RjwjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C60EC607BD; Tue, 19 May 2026 20:34:01 +0200 (CEST)
Date: Tue, 19 May 2026 20:34:01 +0200
From: Florian Westphal <fw@strlen.de>
To: Igor Garofano <igorgarofano@gmail.com>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org
Subject: Re: [SECURITY] nft_byteorder: incorrect u32* stride in 64-bit
 byteorder eval leading to firewall bypass
Message-ID: <agytGR61BMXsNSYq@strlen.de>
References: <CAOOOOYyfpwO7inyq2wXtpT0kY0s19-n4OZf2MCR62WRi7vzMMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOOOOYyfpwO7inyq2wXtpT0kY0s19-n4OZf2MCR62WRi7vzMMg@mail.gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-12696-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Queue-Id: B3CFC583BED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Igor Garofano <igorgarofano@gmail.com> wrote:

[ removed security@korg from CC ]

> A logic error in nft_byteorder_eval() causes incorrect byteorder conversion
> for 64-bit (size=8) operations in nftables. The source register is indexed
> using a u32* pointer (4-byte stride) while nft_reg_load64() reads 8 bytes,
> causing overlapping reads for any priv->len > 8. The result is that bytes
> are swapped from the wrong positions, leading to incorrect packet matching
> decisions.

Multi-stride is never used by nftables.  This feature is unused and will
be removed:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260512133617.8191-1-fw@strlen.de/

