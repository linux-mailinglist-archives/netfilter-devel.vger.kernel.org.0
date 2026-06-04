Return-Path: <netfilter-devel+bounces-13043-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5K96M9UYIWqS/AAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13043-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 08:19:01 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B763D37C
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 08:19:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=MHgHUsP3;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13043-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13043-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 234DB3015AA5
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Jun 2026 06:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CCC3D1ABE;
	Thu,  4 Jun 2026 06:17:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B73B0AC3
	for <netfilter-devel@vger.kernel.org>; Thu,  4 Jun 2026 06:17:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553830; cv=none; b=hWNJhz0ZYrAAeAEmY3CtI6sCrcdiBFryDy+wphSzmF91mifbqGcoJNG946TIfceMD91amHCeygW8VQyyuIbn5xTyPORBJYulsChT1d2pZIcfpzkzLXA5Ktyk7WmIhoFddlgWMJutKSFa3uLbgAtPS2dHJeTtq1h70TOdWY7NnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553830; c=relaxed/simple;
	bh=Fuf5eKsFuESO0WuLmIz4ZCzm8zqmqzHsP2pk9D0oLmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLTIMRqbb2JaTWuqGsCJMBYLISNFYpqOxCV7uZeaGpRU9BYFsK5R3OarOLq8f0eU62IK34Myo83wqlaZJ337nxCxh0m6WIx0i1tNVXdVIozVqFtY0UeAuDqj8h1S2z5NG626Y/S5P5VEg21ctGr7ut3pWRDhxvD/39IhBSXP6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=MHgHUsP3; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id B1BF96017D;
	Thu,  4 Jun 2026 08:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780553826;
	bh=V19F5AEHUoZ04xZgzRYPLE1CqMM8VbDID9tstg2hwGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHgHUsP3AA9SX+H+TX5PwXg7kR1X+ZtP7x5drRJ4c74gGlEAyf0vwY8V2Gan/6QCi
	 P0ynOMqqKdubjP60i59KblIh+nxxUKR85KvEP7REf2KyaEn2J0fOw1IcA+dUyE/YBx
	 Bw0mktlOEG3LbpHis2aNfIWsDMOInwRvscy41lOnGdQ0xzFWHb4W5sV7nZ0+jW8aFK
	 uYd5vQAq86uBfWL80B1wA+EFTUyU7QAc010gXjP94Zma4y1VHraS3zPFESzEvKKa3o
	 lMd9MVHvr2xDGMcnpcK/q+jrCQ9O2mIVWBAwbVRQ2v3Bt40gm4UEQFzGaC2o8au/47
	 iIH1Ygxyn4HRg==
Date: Thu, 4 Jun 2026 08:17:04 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [RFC nf 0/2] netfilter: add restrictions/validations for packet
 rewrites
Message-ID: <aiEYYP0PaWOkbRgh@chamomile>
References: <20260527121147.22076-1-fw@strlen.de>
 <aiCrpdgRNCC7LkaA@chamomile>
 <aiCtz2nBZL1Q-gmL@chamomile>
 <aiC0lYKyD5UDQgLS@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiC0lYKyD5UDQgLS@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13043-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC0B763D37C

On Thu, Jun 04, 2026 at 01:11:17AM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > If anyone is breaking with ilegals field, they should come here to
> > > explain? Data plane validation might look safer ... but it will just
> > > drop packets and it will take a bit more time to the user to debug.
> > > But your approach is more conservative, it just leave the packet
> > > untouch, so it is basically ignoring the invalid mangling.
> 
> Yes, ignore resp. BREAK verdict.
> 
> > Hm. Actually, it is harder than it seems to do this from control plane
> > because dscp needs to deal with bitwise to ensure that ihl and version
> > are not modified.
> 
> Yes, there are cases like those where control plane valition is not
> possible.  I will address the AI comments and resubmit w.o. RFC tag.

It should be possible with some sort of register tracking. At ruleset
load time, the hardware offload infrastructure already do something
similar, and I added infrastructure for this for a different purpose.

But this can be done later, the datapath checks now should be fine to
start with.

