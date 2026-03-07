Return-Path: <netfilter-devel+bounces-11017-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBGgFhRuq2ladAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11017-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 07 Mar 2026 01:15:16 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F088228F0B
	for <lists+netfilter-devel@lfdr.de>; Sat, 07 Mar 2026 01:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4186F301CC6A
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Mar 2026 00:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8523121B185;
	Sat,  7 Mar 2026 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="YrzAPgHH"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C652224AE0;
	Sat,  7 Mar 2026 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842510; cv=none; b=u1DF8b++9R/tItxWhIik6uoqCJWLgW+y58xcrSjG3w86OslsPdOXMW1PynxS4iJIJJXpLu7oWuzg/9Sa5cXDEr7H9ghgQGBA14/3+Fh63o16C0HGctSPzIFkLGO0yUBfmnlVub4VhowpVC+CszGFs2p9ApTOxxTKyJxchEYcxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842510; c=relaxed/simple;
	bh=tyt15WTiWzm1Uv5lOWMyzVaiGS0ThibnesyQLzVTAps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxdvcLCC9xYW7EE4/JTeRaAXeAP+UQWuX2oqPydob/PVBmerK4QzWL5XMYpRlSo18/jue1mqRWUxFWZdmfk2N9dEy/0S/jobRZ9jC3HPXdXV1WxAEvF4e2VIpC79mzkTozu61CjUWgyx1lFqdBY99yBghOP332brcZj2HniSSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=YrzAPgHH; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 2C9E0602D6;
	Sat,  7 Mar 2026 01:15:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1772842507;
	bh=y7jvae0QcNT4vmZ6m7HGWHRDoljbbht95hV4A1EgJQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrzAPgHH9kbo6vldrAZnlpWZGRgwQDv2mb2omyvyQIB/IC+nGYsmtQduGUS4MvED5
	 u4ss2HGfY/F8xdBPjaWYqvBbS/o9Lt+6gfw+mLIZJQyO6EEIFv5Uvp5CGDx99ALp5x
	 Am32MypFJdUWN/LzCJE5yb6RHxRHYi/CzK9FHSfHwv8o/aEwFUYOhQSxVwV5DPLDwR
	 CeN+xM2fg5F4LFL/aDtDE/uL/OEUvpKdj4y0S8pWRnhqbVjBLd9Z2E2VmHuqVj9YOM
	 iyegofiel/VG0ldMrTx9enEve0/ZTP2Iene+B2RegZOpgqe0ZFFugiVBXPg6JHJ8i+
	 bxhBXiHuNu5aw==
Date: Sat, 7 Mar 2026 01:15:04 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Chris Arges <carges@cloudflare.com>
Cc: Florian Westphal <fw@strlen.de>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lwn@lwn.net,
	jslaby@suse.cz, kernel-team@cloudflare.com,
	netfilter-devel@vger.kernel.org
Subject: Re: [REGRESSION] 6.18.14 netfilter/nftables consumes way more memory
Message-ID: <aatuCHV6qQK_lryg@chamomile>
References: <aahw_h5DdmYZeeqw@20HS2G4>
 <aaijcrM5Ke5-Zabx@chamomile>
 <aaij0XAgYRN40QdD@chamomile>
 <aamvQTTZu4-chpsS@20HS2G4>
 <aarHEfdMXDJ-Wq3V@chamomile>
 <aarHyHIQY0nS9d9K@chamomile>
 <aasa4AV5p7TFxNmj@20HS2G4>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aasa4AV5p7TFxNmj@20HS2G4>
X-Rspamd-Queue-Id: 5F088228F0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-11017-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,netfilter.org:dkim,ozlabs.org:url]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 12:20:16PM -0600, Chris Arges wrote:
> On 2026-03-06 13:25:44, Pablo Neira Ayuso wrote:
> <snip>
> > > I see what is going on, my resize logic is not correct. This is
> > > increasing the size for each new transaction, then the array is
> > > getting larger and larger on each transaction update.
> > > 
> > > Could you please give a try to this patch?
> > 
> > Scratch that.
> > 
> > Please, give a try to this patch.
> > 
> > Thanks.
> 
> Pablo,
> 
> Thanks, I'm getting this set up on a few machines. I will have:
> - 6.18.15 (original kernel version that repo'd the issue for us)
> - 6.18.15 + this patch
> - 6.18.15 + revert rbtree patchseries
> 
> I'll compare memory usage with those 3 variants and give a response.

I posted a new patch version, see:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260307001124.2897063-1-pablo@netfilter.org/

