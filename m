Return-Path: <netfilter-devel+bounces-12647-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ORdI58BC2qL/QQAu9opvQ
	(envelope-from <netfilter-devel+bounces-12647-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 14:10:07 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E288C56C4CE
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 14:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A049B314AADE
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A753FBECB;
	Mon, 18 May 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="EaV/T4oO"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B973FBB73;
	Mon, 18 May 2026 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105659; cv=none; b=Umkd8zNaCXwtaC0H5ekh7Vypfc9mFN+MjCzooE7G3UDj24STBJs8Km2X8x4uYgLm8127rkbaQKz16oVbnBPaqXHeOF6hFEFmzyBSMl8hRBO1HHf+1PgPXcCHCE33FIGv73F7iO/QhfXqr6+L6OPWL6HmDwej5ZaPXhumeMOu9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105659; c=relaxed/simple;
	bh=Dq9L8NgKLAHErwvoe6hqZn8vjQVRLs7Havu3hguUk0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXPm8ljmWluhN5fTBbL+7nPRRuFw36TjkDxwKRLiOVkhLkfwt1DEBz2yFwPEt+B2QhBU+Hhv+RY92FAiBiyeSaIWQ3Y3uxd2UFsUNb9nwxrUAmxjN4EG5SDNjf85wFm4Ie7B/3a5xFSzuLTMuvWo+TUbIuy7lXymAdI+CGIz+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=EaV/T4oO; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 6DE2F6019F;
	Mon, 18 May 2026 13:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1779105202;
	bh=x5JGP+k+YEoRidDdG4n9aMggxVuZd6ch/QnZI57RP9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaV/T4oOIcgBpxPEG2zqU/lpalYB+eYcpwz7wOZeVhUEezP9A4UAXr6gM4OwhyTRt
	 lUQiirhyxa7re5dGF0WBqcCZwjFEyU1gR4jnF0YwJFXN826Sgc7KG87rkVVPB1JHtO
	 9T+tskKu0f0tWnWF89QSBiIT5Y0MBbyegI/1vRyAPrFSs61kTn8zVjLOnC+VYIyqFA
	 JDtIv46mgUgGbkUDf7nkj5DhlLvaGC0BjiTxtTIZNj5jlU/T/kcvIJZ/TKaCAPMHbG
	 KHgMGX6n0tW8Fz8//SbeWuqLTHVjjCY3Ag4PA2kU1AQ4CpnFoemZocejLtNRNG8Ldt
	 7u5lmxz7gUsqA==
Date: Mon, 18 May 2026 13:53:19 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Qi Tang <tpluszz77@gmail.com>, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, herbert@gondor.apana.org.au,
	michael.bommarito@gmail.com, lyutoon@gmail.com
Subject: Re: [RFC] netfilter: disable payload mangling in userns
Message-ID: <agr9ry_EKdTfgoaj@chamomile>
References: <20260515100411.3141-1-fw@strlen.de>
 <20260515114848.1105927-1-tpluszz77@gmail.com>
 <agcWBZNugohelNp6@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agcWBZNugohelNp6@strlen.de>
X-Rspamd-Queue-Id: E288C56C4CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12647-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,gondor.apana.org.au];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 02:48:05PM +0200, Florian Westphal wrote:
> Qi Tang <tpluszz77@gmail.com> wrote:
> > I agree with the userns block.  I'll keep pushing the five
> > consumer-side bounds-check patches: root in init userns can
> > still install the same payload-set rule and trigger the same
> > OOB at the re-read sites, so the underlying bug fix is still
> > worth landing.
> > 
> > None of the five sites overlap with the relax wishlist (saddr/
> > daddr, transport, linklayer).  Same class showed up in an
> > earlier patch:
> >   https://lore.kernel.org/netdev/20260514035802.1540395-1-tpluszz77@gmail.com/
> > 
> > These five are unlikely to be all of them; we think the
> > consumer side warrants a broader audit.  Thoughts?
> 
> I think we have to do both.
> 
> For nft_payload/nft_exthdr:
> 1. Writes from !initial_userns are rejected (rule insert fails).
> 2. Writes for initial userns get validated at rule add time:
>   - netdev ingress is allowed to alter everything, I think
>   this is early enough to not introduce oddities that can't come
>   from wire / untrusted peer.
>  - bridge is allowed to alter everything: AFAICS there shouldn't
>  be a problem with this, same as with ingress.
>  - inet (ipv4/ip6): Check base (offset is unsigned and relative
>    to ll/network header/transport header/payload
>    - Allow modifications past transport header.
>    - Allow modifications of transport header
>    - Allow network header modifications for a subset of valid
>      offsets/lengths: saddr, daddr, checksum, tos, id, ttl / hl.
>      Reject everything else.
>    - Allow link-layer; but check at from packetpath that
>      offset + len don't write past start of the network header.
>      Else: no-op.
> 
> nfqueue is the bigger problem: userspace gives us a whole new
> packet data blob, not a delta that we should apply at offset x).
>
> I think we have to update nfqueue to do rudimentary header revalidation
> and drop the packet on failure, e.g. at least making sure tot_len is not
> past skb->len.

Agreed, nfqueue has been there for long time and such parser would
validate the packet is correct from stack POV.

But if a new function to validate that the IP header mangling is not
valid is feasible, then why not simply apply the same sanitization
from inet hooks to nft_payload/nft_exthdr?

That can be a function in net/netfilter/utils.c.

