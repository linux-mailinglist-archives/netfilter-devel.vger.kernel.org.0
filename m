Return-Path: <netfilter-devel+bounces-11822-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI4mGMc82mlCzQgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11822-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Apr 2026 14:21:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9853DFDB0
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Apr 2026 14:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D7453059FD6
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Apr 2026 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E6A33F5A6;
	Sat, 11 Apr 2026 12:14:49 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631C231C9F
	for <netfilter-devel@vger.kernel.org>; Sat, 11 Apr 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775909689; cv=none; b=deKZ9SfWBO4kXvz5URqz8mQN5By4EdemIXvrS9LJDaDtJ+8vHflSRCqJOLjIQ1MEW3Ha9xXOm2vxSFAsuC9kptXv9fMpeoURFJU1WYjLSVQqv1CKqQkrx5eKYyYbDpS0Dfpa7Zzadt+lGa4xbpFaZVl6OhWY6zC/hdANlH9Yri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775909689; c=relaxed/simple;
	bh=VxA1SEJo/Rwb1hbW8w2OllWKpnNYNr6y5mJHEhv3dsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL4YvzDa4JEvZD/AAVQFrt3gkHrMJ/ESPcfGTxa1/p3gxUjldhOC8gSgVl5EaiYIL7FdtZiRNBXpAwMfReQHW8u8Az42mn8A9uOg2HeAX4vyCX8dAc54fkJoxK86FLIbg7XRvhaMOCSNMa8qGC3AiXB8tlu9rrhWXX8F9X8hSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8EFB060491; Sat, 11 Apr 2026 14:14:45 +0200 (CEST)
Date: Sat, 11 Apr 2026 14:14:45 +0200
From: Florian Westphal <fw@strlen.de>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nft_set_pipapo_avx2: restore
 performance optimization
Message-ID: <ado7NVm_yFVwASx-@strlen.de>
References: <20260401110230.19226-1-fw@strlen.de>
 <20260411123015.4a78f491@elisabeth>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411123015.4a78f491@elisabeth>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11822-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: DE9853DFDB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Stefano Brivio <sbrivio@redhat.com> wrote:
> ...right, I'm not exactly proud of it, but if we don't hide that stuff
> the amount of visual noise explodes. I couldn't think of any better
> solution.

It's fine as-is, I just missed that "ret" thing in the first place.

> I really couldn't understand how turning those into "else if" would have
> anything to do with the scope "ret"... until I realised and actually
> read your reference. Oops.

I've sent a v2 that moves the LLM report ahead.
I hope its a bit better this way.  Actual patch is not changed so I
copied your RvB tag.

> intermediate matching bitmap (between fields) with a lot of leading
> zeroes.

Right.  Thanks for reviewing!

