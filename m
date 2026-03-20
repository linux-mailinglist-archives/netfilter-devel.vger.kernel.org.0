Return-Path: <netfilter-devel+bounces-11310-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eofLNdmTvGlL0wIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11310-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 01:24:57 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD112D4719
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 01:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72D13064EAB
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 00:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E79B1DF258;
	Fri, 20 Mar 2026 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="p9webqaA"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A501D61B7
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773966295; cv=none; b=mjlMpxj2V+px+6GYLVJmucBEi7MpFM42xkjHZx0/qsVNT7m8KjXILHiJdZYbMnuFFpM6X3+WcXkMSD9HHnBgS/QoqpDnGbQksQYKuRhOLuduTujJICfS5LsfthMialbADK4m+X5gInBbQoGLShBReKmI8cS7vN+gS+kOvJgQ+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773966295; c=relaxed/simple;
	bh=YBTNXCWE82fh2pIILXnj6SWDDBegP7WB4SVPe3FGEIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWoe0IVZs551zHlJ7f0CSXoabZi3hyHCU6RWIbtfbsZSJLVd7D0VF6rxiTwpWhFGO4L6l1g1by1Tzs0byylsI/9D4bdF/+DnEYXZbLdweoJOhHdS5LMse3uwK6qsaIPOlwrxutpfsDFd7bstK+x8e8vE2GD3v13PxeCYVrnUDbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=p9webqaA; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 7FD1F600B5;
	Fri, 20 Mar 2026 01:24:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1773966283;
	bh=CVLnqBE3sQRpp04+pzP0AQwqWUXv0YxSYk0D0BcQYxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9webqaAEXOEs6zmTK0jO39e0TI4Yy1CZCKVI52wSRnKDJ+zuojH6qZoR4UZdH7c7
	 dTDWifnBsmccJWkUgizdeDiEnbWIKNwZcf8cvRY2KP8uv0cnEp0q3Hyh9uYSfLC5oP
	 uduM4XmJhml6BXYdbxYLyfGjhFzp3+oW4vDkwrVU9kHJU2HocvCm5UBnbAm/oeeA7m
	 ahibJADVmQ6YzKQZ6/co/MhjNqSFEivrtJm+Iamdv3ZAS47r2hkvLJULlRYFa89Ytm
	 7g9+Y+DUmyozHjpmLqVRsh85KH4xoxGzXJELbr/z0qlw9cawlFpcp0N5fW2HgnvTwE
	 imFNi7j9vs0Rg==
Date: Fri, 20 Mar 2026 01:24:40 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH] netfilter: nfnetlink_hook: Dump nat type chains
Message-ID: <abyTyJBv47f3v9gd@chamomile>
References: <20260313153220.19662-1-phil@nwl.cc>
 <abwegj2TijkaQVLz@strlen.de>
 <abwraHUuxizN4krg@orbyte.nwl.cc>
 <abwtAkSF8-SmH684@strlen.de>
 <abxlzn7lymOxWUFa@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abxlzn7lymOxWUFa@orbyte.nwl.cc>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-11310-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AD112D4719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:08:30PM +0100, Phil Sutter wrote:
> On Thu, Mar 19, 2026 at 06:06:10PM +0100, Florian Westphal wrote:
> > Phil Sutter <phil@nwl.cc> wrote:
> > > Ah, so the nat-type chain's priority value orders it inside the
> > > dispatcher's list.
> > 
> > Yes.
> > 
> > > Maybe I should print them below the dispatcher hook with extra
> > > indentation? Maybe extra braces could further clarify, e.g.:
> > > 
> > > | hook postrouting {
> > > |         +0000000100 nf_nat_ipv6_out [nf_nat] {
> > > |                 +0000200000 chain inet nat postrouting [nft_chain_nat]
> > > |         }
> > > |         +2147483647 nf_confirm [nf_conntrack]
> > > | }
> > 
> > Actually  one could override the hook value with the one of the
> > nat base hook.  The ordering inside the dispatcher is whats important,
> > the exact numerical value isn't important.
> 
> Hmm. I like how one can use 'list hooks' output to find a good spot for
> a new base chain. The real nat chain priority value is needed for that,
> but no point in considering made up use-cases. Seeing the chains
> attached to a given nat dispatcher is already a step forward, and having
> their ordering is probably well enough.

I guess the goal is to expose iptables and nftables in place?

Is it really needed to expose this internal +0000200000?

Maybe simply report instead?

         +0000000100 nf_nat_ipv6_out [nf_nat]: chain ip nat POSTROUTING [iptable_nat]
         +0000000100 nf_nat_ipv6_out [nf_nat]: chain inet nat postrouting [nft_chain_nat]

Yes, it looks like a duplicate, but it is sort of how it works now, no
need to expose dispatcher details.

