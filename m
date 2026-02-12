Return-Path: <netfilter-devel+bounces-10740-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDOmLvwZjWlbzAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10740-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 01:08:28 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E07881286F0
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 01:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA66C301BD83
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 00:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CCCA55;
	Thu, 12 Feb 2026 00:08:22 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B009748F
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Feb 2026 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854902; cv=none; b=fntC3+Mqo5TuGXm4ZI2bDN7EnZInD56Sz+BIG30UkY6BIaJdnebV4TuoJCAHCAM7RFFpT6bVN7ozZHrSGbkuy/MM/D6m4T8LVYcx2QJpKVxKScyN3MCnoN6EW61fi9tW1AnLKXVmOC6yfWPNzbfWAhxcW+4E30WpbyH9fw7J+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854902; c=relaxed/simple;
	bh=UzSxRKxJGg+E62KTWIzn3UOdIA4ktijmErjsSjjEOwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUG0MJaTngokROnqrhtydZxagEeUa4X1gFtIuOH66Aj4see/kOOQqdYg++UsC558JQyzUeXtxpHSh1nbGGRyPFR8UOocj1CdRg/KUo17hG89VJCSOOGw49doPIp6/f+XTXtfKz5VDKdc42vNvXlooJvm0rAyO0X5Rl7PJtVTsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0361D605B0; Thu, 12 Feb 2026 01:08:17 +0100 (CET)
Date: Thu, 12 Feb 2026 01:08:17 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v3] configure: Implement --enable-profiling option
Message-ID: <aY0Z63yPjQoXYp9b@strlen.de>
References: <20260211201503.27186-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211201503.27186-1-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10740-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: E07881286F0
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> This will set compiler flag --coverage so code coverage may be inspected
> using gcov.
> 
> In order to successfully profile processes which are killed or
> interrupted as well, add a signal handler for those cases which calls
> exit(). This is relevant for test cases invoking nft monitor.
>
> index 0000000000000..912ead9d7eb94
> --- /dev/null
> +++ b/src/profiling.c
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright (c) Red Hat GmbH.  Author: Phil Sutter <phil@nwl.cc>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 (or any
> + * later) as published by the Free Software Foundation.
> + */
> +
> +#include <nft.h>
> +#include <profiling.h>
> +
> +#include <signal.h>
> +#include <stdio.h>
> +
> +static void termhandler(int signo)
> +{
> +	switch (signo) {
> +	case SIGTERM:
> +		exit(143);
> +	case SIGINT:
> +		exit(130);

Unfortunately I can't find exit(3) in the list of async-signal safe
functions, so I have to assume this isn't allowed.

From a quick glance, I would suggest to either use self-pipe-trick, or,
given nft is linux specific anyway, use signalfd(2) instead of a
traditional handler; then, stuff the fd into mnl_nft_event_listener
select().

Sorry, I did not think of this earlier.  If I'm wrong and this is safe,

