Return-Path: <netfilter-devel+bounces-10722-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPHANF9/jGl9pwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10722-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 14:08:47 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4FC124A72
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 14:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15F04301327B
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 13:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12FB30E0F2;
	Wed, 11 Feb 2026 13:08:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35E251791
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Feb 2026 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815325; cv=none; b=bLCF2h6HZzLZEPSrKWvlwSkyCFqT7fXuBGzsanL35U73TGuQ9MJpXrwrQOkqJSGNIrtUzYVkwvw7LUGtHvy5XA/JkbsenImFXRDwMAZs2Z+U0w4TxtxufnuPRxhr4ab+18vpZp8Y3W2W+2K0lbRcq5H7/ONlT4mnDHbiHLeuR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815325; c=relaxed/simple;
	bh=OdNxs3qOiY3ItzBXB/7vUbUthUU5QbuoKXHuaPHefxw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRk6rhksC7utcDA6Iv/pEU/jM+jmPhxS5UORnrlsU21bNB74dl0J9tU1ST6O7gnQYdPzFzPyihKVL2hScRJxBHkDtLw9GO2Gmz4wFEaWu/1Fpscpuy4u3YMG07xCSKnJ3Sj5eBdlKHleHcAHn5Fdbbpeh5Abz2xB8ONYLVbImFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 79050605E7; Wed, 11 Feb 2026 14:08:42 +0100 (CET)
Date: Wed, 11 Feb 2026 14:08:42 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>, Ilia Kashintsev <ilia.kashintsev@gmail.com>,
	netfilter-devel@vger.kernel.org
Subject: Re: Global buffer overflow in parse_ip6_mask()
Message-ID: <aYx_Wupq7R-2ndbc@strlen.de>
References: <CAF6ebR70NXKv54uEE=kGC2O9tg5K+LoB5gZCm7tKJJaJRGLZcg@mail.gmail.com>
 <aUQTNcIKD-7YzYQQ@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUQTNcIKD-7YzYQQ@orbyte.nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[nwl.cc,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10722-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D4FC124A72
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> The reason why the second memset() call may mis-behave is the broken
> div-round-up in there: It does (bits / 8) + 1 when it should do
> (bits + 7) / 8 instead. Fixed that, only the p[bits / 8] field access
> needs to remain conditional:
> 
> @@ -364,8 +364,9 @@ static struct in6_addr *parse_ip6_mask(char *mask)
>         if (bits != 0) {
>                 char *p = (char *)&maskaddr;
>                 memset(p, 0xff, bits / 8);
> -               memset(p + (bits / 8) + 1, 0, (128 - bits) / 8);
> -               p[bits / 8] = 0xff << (8 - (bits & 7));
> +               memset(p + (bits + 7) / 8, 0, (128 - bits) / 8);
> +               if (bits & 7)
> +                       p[bits / 8] = 0xff << (8 - (bits & 7));
>                 return &maskaddr;
>         }

Phil, would you mind formally submitting this as fix?

