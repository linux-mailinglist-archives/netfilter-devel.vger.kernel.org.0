Return-Path: <netfilter-devel+bounces-10969-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KRfBPU2qGm+pQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10969-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 14:43:17 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D70B12009D8
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 14:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27FA9309AA64
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4E734CFC6;
	Wed,  4 Mar 2026 13:39:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA954344DB9;
	Wed,  4 Mar 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631540; cv=none; b=f/oKL1fuNjwJyFezLZ0fTG/sJicwslyhxXPLForWaqkORRsb3JTK4aKfy779kxJzyf3OJcwMp6VBmcXpeFzmw9hwVnmysuh4NHV+/puHK4A8QIp1QeZyzMoF3KHccSF9l0kbx15i7pMyLJH2llUGuNX5FAXpBcYGjZVW/q+efvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631540; c=relaxed/simple;
	bh=u0Jee0i4XF3E6HcuNm7/a1hF5TL8QjefkDJto/zp/zw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6ELN20aaBvLq0F8jbKJS0EiKH9rk8tnq0qCcBmv9xEYhqdEQgN3huHck5dIAvQW5gIh+5EfOqknptZxiPhdsmG8KZYSeE3kG1A4wVHJVH9Ihj4D7jmiMH4eJhRfsteHG/Cb0u5AKqPZOQK7L3IysvZfSI4a72Z+u3zZ881IDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C026060D34; Wed, 04 Mar 2026 14:38:56 +0100 (CET)
Date: Wed, 4 Mar 2026 14:38:57 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>, Helen Koike <koike@igalia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH] netfilter: nf_tables: fix use-after-free on ops->dev
Message-ID: <aag18YM3g0sS7wXW@strlen.de>
References: <20260302212605.689909-1-koike@igalia.com>
 <aaYYiPTO5JYOlhhY@chamomile>
 <17499d82-ad03-44a9-ab3a-429d2ebea02f@igalia.com>
 <aafD369eE31dh1VP@strlen.de>
 <aaglAU8E48EF1m-_@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaglAU8E48EF1m-_@orbyte.nwl.cc>
X-Rspamd-Queue-Id: D70B12009D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10969-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> > And *THIS* looks buggy.
> > Shouldn't that simply be:
> > 			if (!match || ops)
> > 				continue;

FWIW I can't get the reproducer to trigger a splat with this change.
I've fed this to syzbot to double-check.

> You're right, the 'changename' check in NETDEV_REGISTER is not needed
> because even if not changing names one should skip if already
> registered. Actually, this indicates a bug unless handling
> NETDEV_CHANGENAME. Maybe add a WARN_ON_ONCE()?

Well, it does trigger, afaics.

