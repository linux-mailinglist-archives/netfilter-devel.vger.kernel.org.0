Return-Path: <netfilter-devel+bounces-10394-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHLcBJwcc2mwsAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10394-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jan 2026 08:00:44 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521A71528
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jan 2026 08:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CFD9300A8CA
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jan 2026 06:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DBF33B6D5;
	Fri, 23 Jan 2026 06:55:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918F6337BBF
	for <netfilter-devel@vger.kernel.org>; Fri, 23 Jan 2026 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151305; cv=none; b=kFuxx+uqAFSfZeOgsw4/TliL6gkCXXdhAaU7168YnYhaxnuAU8wv31/He6JISUc66gNWNk5aN6QoULpWFPM16s8d+EX/pNyDF3XICaDZDC+/GabJYVVWDvilDpqig8kFPyuUghob6Ahg3Q3LUfN2XPRhf+QiHtDKDFpoTdcPR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151305; c=relaxed/simple;
	bh=4/v0zAqLasZ0NR5qCih/0qgMvuTRYVGg8/WEqxiYO2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bV2KWytt0WSCqw/UtF9R65CYP6feBA3wna12eHfZRcn/tndyxoXETSDztnzEU9PjxACITZTcqLWxfHiEQDygkkbsNasRS/FQQ8WYwCZvsrP1JDhWNXKHK41KQBmk3iz7+3QVOPYmiXCaz4Y5IokBEawGTP5C8LqKwKItzbK7CEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id DA8B960284; Fri, 23 Jan 2026 07:54:59 +0100 (CET)
Date: Fri, 23 Jan 2026 07:54:51 +0100
From: Florian Westphal <fw@strlen.de>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [PATCH v6 2/2] netfilter: nfnetlink_queue: optimize verdict
 lookup with hash table
Message-ID: <aXMbOwOw0yVpIWZl@strlen.de>
References: <20260117173231.88610-1-scott.k.mitch1@gmail.com>
 <20260117173231.88610-3-scott.k.mitch1@gmail.com>
 <aWwUd1Z8xz5Kk30j@strlen.de>
 <CAFn2buDVyipnvn8iW1dsPN827D1BBrZ9xLjcuJHC7W00xjioSg@mail.gmail.com>
 <aXD1ior73lU4LYwm@strlen.de>
 <CAFn2buAFkjBHZL2LRGkfaAXGd9ut+uta1MaxaHuM+=MJdGf_zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFn2buAFkjBHZL2LRGkfaAXGd9ut+uta1MaxaHuM+=MJdGf_zQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10394-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8521A71528
X-Rspamd-Action: no action

Scott Mitchell <scott.k.mitch1@gmail.com> wrote:
> > > > +#define NFQNL_HASH_MAX_SIZE        131072
> > >
> > > Is there a use case for such a large table?
> >
> > Order of magnitude goal is to gracefully handle 64k verdicts in a
> > queue (w/ out of order verdicting).
> > Ouch.  I fear this will need way more work, we will have to implement
> > some form of memory accounting for the queued skbs, e.g. by tracking
> > queued bytes instead of queue length.
> >
> > nfqueue comes from a time when GSO did not exist, now even a single
> > skb can easily have 2mb worth of data.
> 
> I agree byte-based memory accounting would be valuable for preventing
> memory exhaustion with large queues (especially with GSO). However, I
> believe this is orthogonal to the hash verdict lookup optimization
> (hash table itself has bounded memory overhead, skb memory pressure
> exists today with the linear list). Does that align with your
> thinking?

Yes, this is an existing bug.

> For my use case, packet sizes are bounded and NFQA_CFG_QUEUE_MAXLEN
> provides sufficient protection.

Its sufficient for cooperative use cases only, we have to get
rid of NFQA_CFG_QUEUE_MAXLEN (resp. translate it to a byte
approximation) soon.

If you have time it would be good if you could followup.
If not, I can see if I can make cycles available to do this.

Unfotunately its not that simple due to 64k queues, so the
accouting will have to be pernet and not per queue.

