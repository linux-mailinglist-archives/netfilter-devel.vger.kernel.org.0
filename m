Return-Path: <netfilter-devel+bounces-11216-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOeDGuy4t2mpUgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11216-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 09:01:48 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3EC295ED2
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 09:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 159133003BEF
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CC434DCEC;
	Mon, 16 Mar 2026 08:01:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B621D3E2;
	Mon, 16 Mar 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648102; cv=none; b=qS72d1m0TUaek4AUfUD5Yg8MaaAPFRL8miOr8SI0Qs6LwFDFV3Ce00ss0azLWyg81WzuZ68hJn+wHVi0n6geKo4rPZeJTwSn3wEPyIQvL1CRFI4T0Ly138hnaZ+0f16B5DJduNOSmouLMpF15i8jsUz5eqsirXxOU7j7QDoXtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648102; c=relaxed/simple;
	bh=1jhC6Mx4jIspPZxtk01ZS1ny812RNqkQAuKdCrFYDeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5Q//PXi6We1upSbE3o4ltJyJuL1fyLWyuAYsDj5XIPrSpbaPQk0XrZpCq4N6XEQMqfg++rPxoH/AMTqCfH0EahiqwlXt4fw6JXovdVZAwqoiZaww6vSJueBg0zRnAaMmMV5BXhj41tFoa1u+ZAu4fps4qTbIXBmQTB9QfESk94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id DD466605C3; Mon, 16 Mar 2026 09:01:27 +0100 (CET)
Date: Mon, 16 Mar 2026 09:01:27 +0100
From: Florian Westphal <fw@strlen.de>
To: Kit Dallege <xaum.io@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kernel@vger.kernel.org, Claude <noreply@anthropic.com>
Subject: Re: [PATCH 2/3] netfilter: add missing kernel-doc parameters for
 nf_hook()
Message-ID: <abe418p9j1ljge-4@strlen.de>
References: <20260315154619.50964-1-xaum.io@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315154619.50964-1-xaum.io@gmail.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11216-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: BF3EC295ED2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kit Dallege <xaum.io@gmail.com> wrote:
>  /**
>   *	nf_hook - call a netfilter hook
> + *	@pf:	protocol family (e.g. NFPROTO_IPV4)
> + *	@hook:	hook number (e.g. NF_INET_PRE_ROUTING)
> + *	@net:	network namespace
> + *	@sk:	socket associated with the packet, or NULL
> + *	@skb:	socket buffer holding the packet
> + *	@indev:	input network device, or NULL
> + *	@outdev: output network device, or NULL
> + *	@okfn:	function to call if the hook allows the packet to pass
>   *

I tend towards not applying this, I don't think this adds any value,
the arguments are rather obvious for anyone doing kernel networking
and its not a utility/library function either.

