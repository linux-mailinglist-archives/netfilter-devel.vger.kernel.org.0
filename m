Return-Path: <netfilter-devel+bounces-10482-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDueM8Yzeml+4gEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10482-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 17:05:26 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43980A50C5
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 17:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63B8230AAF32
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 15:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E89288C22;
	Wed, 28 Jan 2026 15:54:44 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFED304968;
	Wed, 28 Jan 2026 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615684; cv=none; b=h3WFLCFfIaEJ2+8OPqNCfmAOqwkXLhA+R5Pp1RZjoKn/JufK/rJvQaZs6PGnHw+RIN8ckQTH8xLCTsVYdlP5W3yeiAKSZaYqKZCTa6wn1zkBRV/slyON49YsKdK6i8k5b3w+nXxnexrmFFwilqwZn4EWXtwkgz2OnmIQp4qhVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615684; c=relaxed/simple;
	bh=qUS9d/ckayBRL8ZTvLaQC3nCL6OtpqBjZM0ezsHILbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/WaOP0i25omY7b/w5nMDsGa4krjUeCDXgIjvLk+6xlss/X8uouBFTngVYeUtj7IlC6ap+e2cOFsU2oTabAoLzZRAwAo0X36+sDLC75ev4k6p14DjlVsvh/yPCLyRhLVoxJD6OzfnoaF+Gg34n7OzOrrIUhg0pOanKpQepzGt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8D994605E7; Wed, 28 Jan 2026 16:54:40 +0100 (CET)
Date: Wed, 28 Jan 2026 16:54:41 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	bridge@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: Re: [PATCH v17 nf-next 0/4] conntrack: bridge: add double vlan,
 pppoe and pppoe-in-q
Message-ID: <aXoxQbd_7mzTSBZO@strlen.de>
References: <20251109192427.617142-1-ericwouds@gmail.com>
 <6d77bdc4-a385-43bf-a8a5-6787f99d2b7d@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d77bdc4-a385-43bf-a8a5-6787f99d2b7d@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10482-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 43980A50C5
X-Rspamd-Action: no action

Eric Woudstra <ericwouds@gmail.com> wrote:
> >  include/net/netfilter/nf_tables_ipv4.h     | 21 +++--
> >  include/net/netfilter/nf_tables_ipv6.h     | 21 +++--
> >  net/bridge/netfilter/nf_conntrack_bridge.c | 92 ++++++++++++++++++----
> >  net/netfilter/nft_chain_filter.c           | 59 ++++++++++++--
> >  net/netfilter/utils.c                      | 28 +++++--
> >  5 files changed, 176 insertions(+), 45 deletions(-)
> > 
> 
> Can I kindly ask, what is the status of this patch-set?

Rotting, sorry.

At this time most of the patchwork queue management is done
by me, there are several other patchsets also vying for attention
and syzbot just reported UaF regression in rbtree, so I will be
busy with that for a while.

I decided to defer this:
1. There were no other 'Please lets apply this' reviews so far
2. We are close to a new kernel release, hence time window
   to accept features as opposed to fixes is shrinking.
3. You patchset changes how packets get processed both by
   conntrack and nf_tables bridge family.  Yes, its done as-advertised
   but still, this has known impact.  Hence I would prefer to
   apply this early in the cycle not at the last minute.

   Futhermore its a change that, if it causes issues down the road,
   might back us into a corner where we can neither fix things in a
   backwards compatible way without breaking the new feature.

In case there is no further feedback by the time the next development
cycle starts I will apply this series as-is (or ask for a rebase
in case its no longer applicable).

I apologize for the inconvenience.

