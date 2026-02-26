Return-Path: <netfilter-devel+bounces-10878-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEYqBwkPoGnbfQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10878-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 10:14:49 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 970C71A3376
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 10:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97AE33087E15
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 09:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32EC396D3D;
	Thu, 26 Feb 2026 09:10:51 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F7392C42;
	Thu, 26 Feb 2026 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097051; cv=none; b=siQpHy6Iijd1vCyqH2uwnQsxNZwtNrBdnGOsryzrpzceXnSy4ZZOmieShLr54+emwxaRmDLxqmT86LES69jmfYjBqxwd4chfGfFQQrYBV9IT57tHbTUHcI35Tx+tCs8cnOgyf0IQ4nWnYb1Q0tSHY07YvTiT4OwqT0PAMH2gBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097051; c=relaxed/simple;
	bh=Fh+b1V9rhAgnVw3VtKVw8I5n9lH9h8HQoZhXzFdWI6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeV9dMWY2DQBqnpXh6GHSZaDrQqyHvIdFOP4PS7ZJ+y+vZVZNrSre4L5VU8FOsr5i4/m9T5hC99++w5DMB9j5UiqP4hYkxjHrBecuRTXlIhj+iNmAY+oKj/XZeVaGNPx+aSwmg/eHdfL4YbhwXZKM4Y5MPPTF5JwC9KOyWzqr1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 08EFC60516; Thu, 26 Feb 2026 10:10:48 +0100 (CET)
Date: Thu, 26 Feb 2026 10:10:47 +0100
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org
Subject: Re: [PATCH net 1/2] netfilter: nf_conntrack_h323: fix OOB read in
 decode_choice()
Message-ID: <aaAOFygrzyyp2a_z@strlen.de>
References: <20260225130619.1248-1-fw@strlen.de>
 <20260225130619.1248-2-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225130619.1248-2-fw@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10878-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,redrays.io:email,strlen.de:mid,strlen.de:email]
X-Rspamd-Queue-Id: 970C71A3376
X-Rspamd-Action: no action

Florian Westphal <fw@strlen.de> wrote:
> From: Vahagn Vardanian <vahagn@redrays.io>
> 
> In decode_choice(), the boundary check before get_len() uses the
> variable `len`, which is still 0 from its initialization at the top of
> the function:
> 

@net maintainers: would you mind applying this patch directly?

I don't know when Pablo can re-spin his fix, and I don't want
to hold up the H323 patch.

It seems silly to send a v2 MR with only one change.

Thanks!

