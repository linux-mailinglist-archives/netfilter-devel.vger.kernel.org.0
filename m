Return-Path: <netfilter-devel+bounces-13179-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 95eXOuCbKGoOGwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13179-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 01:04:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E969664B11
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 01:04:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lXuNbtxE;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13179-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13179-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83027306EF37
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 23:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A43B27EE;
	Tue,  9 Jun 2026 23:03:09 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4336539EF30;
	Tue,  9 Jun 2026 23:03:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046189; cv=none; b=Cj2qREAlFnJ4rl0qCGLcoAnyPkKwbO2MLVyIjfq7KEL6CD+XoILQ3rxaZUYRQL+tA+9jVjFyPralKmom0eI4j4Tlt7IjZjrVvEBcNTPxo2Ca7yHQazK+B/DWRKlwsh/O+SOw09dLSLl8HpIVVMXFNHzYUhrT4ece0qXvdFuJTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046189; c=relaxed/simple;
	bh=S0FwGmOfWBF0ZuzvBV2cmCs6f1kahPE2hTDM8i1M9w4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NB6pY/fSuZKJqqge6dno+pxR9GXic9k/X9RMNIitKgiFkL/qyCRU26dHqDXhkbu16dIon/MTCNKQ41yAFQxFCIK56zhsd+LIRSJOUV5ha14IpMKeiqC4q8geRyUcprHTswubUDLd5rvaO5AFsMraHyqXAb+IIf91bLOXJmZgt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXuNbtxE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58AE1F00893;
	Tue,  9 Jun 2026 23:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781046187;
	bh=3/W3fHN//C2H+FsUJvZKtOCL62SWLw8hoJcSToyb1jA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lXuNbtxE0EnawPRESQVgXRpJ+Yb0mNXuoeLDOCvz+XOzej0igTIP33uh5+ai3f36P
	 t6xYhWVWjR49I9OKYuBtZUvchF32nZn8LaBmjFvHuCBWnVbPOo2dqP4+jvoCR1/8yI
	 LbfaYWQ0+wgGlyrrqmpR+HYRzKHnD2MTbNUSd+RLxhZrOjI+3Q8ptuxVf/NXPDyBpA
	 WRXDLheHVy5htKXqcTFhoNvhB94swJUVpIwI7e/ssY9n/Os2qGuufo23AItsAYiNVR
	 D3/2iAGyZsiUZmBOGZks7YGHFCnq4mxChfUjLFwvg++oXwk3zShRft/og7ietUhAhD
	 SdOCDjtjhH5Zg==
Date: Tue, 9 Jun 2026 16:03:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dummy: add phony ndo_setup_tc stub
Message-ID: <20260609160306.79be97b5@kernel.org>
In-Reply-To: <aiiaGPj0XQ0mx-cp@chamomile>
References: <20260609142813.9197-1-fw@strlen.de>
	<aiiaGPj0XQ0mx-cp@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13179-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E969664B11

On Wed, 10 Jun 2026 00:56:24 +0200 Pablo Neira Ayuso wrote:
> On Tue, Jun 09, 2026 at 04:28:09PM +0200, Florian Westphal wrote:
> > diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> > index 9101b1703b52..26e7ed5a8575 100644
> > --- a/net/netfilter/nf_tables_offload.c
> > +++ b/net/netfilter/nf_tables_offload.c
> > @@ -234,6 +234,9 @@ bool nft_chain_offload_support(const struct nft_base_chain *basechain)
> >  				return false;
> >  
> >  			dev = ops->dev;
> > +			if (dev_net(dev)->user_ns != &init_user_ns)
> > +				return false;  
> 
> I have no idea how hardware offload can be used away from init_net_ns
> (not even init_user_ns). For most drivers, this exposes the same
> hardware offload capabilities for all netns, so they can interfer
> each?
> 
> @Jakub: Did you mention any driver that already support netns?
> Otherwise, maybe it is worth to restrict driver which do not explicit
> opt-in to netns support?

IDK if any SW driver can do it, I guess that's the risk here.

For HW drivers it doesn't matter which netns they are in, offload
should just work. But of course malicious users can't conjure up HW
devices, admin has to explicitly move the device into a netns.
Which is an explicit "permission grant".

The offload itself should be inherently netns aware since it should 
not cross netns boundaries?

