Return-Path: <netfilter-devel+bounces-10575-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC7sI5Y2gWmUEwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10575-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Feb 2026 00:43:18 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1384D2B39
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Feb 2026 00:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1B8F30143D5
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Feb 2026 23:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1524638E5D8;
	Mon,  2 Feb 2026 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="WHStEgMy"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064A199252
	for <netfilter-devel@vger.kernel.org>; Mon,  2 Feb 2026 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770075794; cv=none; b=F+UGoJr69LoIRNnKhshK5nQu338sbGeM5rR+AG18juvp+w7SdyZM+hZbo19TSR2YnU4cO0SpM/Zr6R2jzBH4vzftjhlyS77b5dnUuXKIiNQVgs8DxIfbew+sKwyyEQ23acE7BY4bWFBqSdXXNz1aziGj7oZQCxPkGt1U11mqfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770075794; c=relaxed/simple;
	bh=57S3Lw46PHZh3l++mVdYBReOwd3XXIjhk+hpLenwATs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kt2kGwS1X4LmQxAa8nAJ9McWujw1ja+klQcIsWav/sM/1FvKOBR+YHXCUHW6lNokEt3yR6Piq4x0Jpv4gd719n4K4kX5/rn3e/RcUYO1TF0+1Fi3s1VRkd03JTXib0nLrb8ic5CSvJCvi3ScbRl9j1u1xCPOXmkuqszrbNCuuNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=WHStEgMy; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id BD97760179;
	Tue,  3 Feb 2026 00:43:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770075790;
	bh=tt6QWPAtMaKlbVWRddIw6CWbAz005NKzDm5RF0jWWbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHStEgMyZf99Im4aBip6YGYbHajjgfL0vNQPUj5S2ZnXvmmNvFlZHCCkY5M6J8Ygh
	 2Qo5NfSq0Df49nyICIURnSvHPtuP5oFI30oeBUpB45fEcay0MtdqlOn60n5oyGtgZJ
	 B9T9YM6LTDdJ3XnSbHbe9DeIkD1qbXOTRczQs1bRgojs4QNQSVqVZ5uUAQP7VrIuW7
	 40qAzv/NdUZsdbRl5aXsd1ezx2cVVR30oPg4tJBNbJuJMJ6Fy9c5fXALsR2TtwBGz6
	 hpbBdBUqAlVUcX45MbxUdTzMRaRcKLVjAcYefMXHiItdJv2Wfoj1tF+Weqi/t9C6Im
	 utGPASGkVXxrg==
Date: Tue, 3 Feb 2026 00:43:08 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Brian Witte <brianwitte@mailfence.com>, netfilter-devel@vger.kernel.org,
	kadlec@blackhole.kfki.hu
Subject: Re: [PATCH nf-next] netfilter: nf_tables: use dedicated mutex for
 reset operations
Message-ID: <aYE2jNhLCRanceN5@chamomile>
References: <20260127030604.39982-1-brianwitte@mailfence.com>
 <aXlTpuk0Z1CeoYwT@strlen.de>
 <aYEsrZpkqCb675vv@chamomile>
 <aYEt98DPnGV4v7IE@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYEt98DPnGV4v7IE@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-10575-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1384D2B39
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:06:43AM +0100, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > On Wed, Jan 28, 2026 at 01:09:10AM +0100, Florian Westphal wrote:
> > > Brian Witte <brianwitte@mailfence.com> wrote:
> > > Maybe its worth investigating if we should instead protect
> > > only the reset action itself, i.e. add private reset spinlocks
> > > in nft_quota_do_dump() et al?
> > 
> > Last time we discussed this:
> > 
> > - There was an attempt to make reset fully atomic (for the whole
> >   ruleset), which is not really possible because netlink dumps for a
> >   large ruleset might not fit into, not worth trying.
> > 
> > - Still, there could be two threads resetting the counters at the same
> >   time, and someone mentioned underrun is possible.
> > 
> >   Looking at last for nft_quota, it should be possible to use
> >   atomic64_xchg():
> 
> Yep, agree, some .dump callbacks can probably be reworked
> to use atomic ops for the reset case.

Only quota and counter regard the reset flag at this stage.

> > Then, for nft_counter, it is a bit more complicated, maybe a per-netns
> > spinlock for counters is sufficient, to protect this
> > nft_counter_do_dump() when the reset flag is true.
> 
> Yes, a per-netns spinlock for reset serialization inside the dumper
> callbacks is what we discussed, I think its the way to go.

OK.

