Return-Path: <netfilter-devel+bounces-10843-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFMZOZ+ynWndRAQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10843-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 15:15:59 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBCC188406
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D82863028E94
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770CC3A0B08;
	Tue, 24 Feb 2026 14:15:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A422652D;
	Tue, 24 Feb 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942554; cv=none; b=tGGkpqjMovHJnb4OmTCjTYwbc+3slJmckfkl9ZwriL1Q5kNg4BKTtQjubtyk+6mIyS4rxIgcTcHSVaBzoYcnaWj1V/7uqBe1lM76mqXSxZw8SAMhOFK8GAeEe5yQ/nnhPrmtije0nxjD2jwIehlWe17hxeZVE5+OCABgGWLi5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942554; c=relaxed/simple;
	bh=dnNFZinG7Mxopd2kn2Svmxzz1R3aSgDkJ0uawihEBtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcvsNYj/jX0M7+vUZEYOf+Fd3w68H2a6DdBnI3Z2UNs3+FZGRuqPrDCjEiiCU/f09SfSN/pLfiT1xEdRX16XLDsjwSRVf3qG8K0yqvqoptdTxBcwHshy/XEBHUAVZBOeD9Iib9W85gqwdGETFbDv1/TdbyXBQplVGtDk8sanmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CB90260516; Tue, 24 Feb 2026 15:15:50 +0100 (CET)
Date: Tue, 24 Feb 2026 15:15:50 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v19 nf-next 1/5] net: pppoe: avoid zero-length arrays in
 struct pppoe_hdr
Message-ID: <aZ2ylpMdcYp5C7OQ@strlen.de>
References: <20260224065307.120768-1-ericwouds@gmail.com>
 <20260224065307.120768-2-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224065307.120768-2-ericwouds@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10843-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[earthlink.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,nwl.cc,blackwall.org,nvidia.com,vger.kernel.org,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 5BBCC188406
X-Rspamd-Action: no action

Eric Woudstra <ericwouds@gmail.com> wrote:
> Jakub Kicinski suggested following patch:
> 
> W=1 C=1 GCC build gives us:
> 
> net/bridge/netfilter/nf_conntrack_bridge.c: note: in included file (through
> ../include/linux/if_pppox.h, ../include/uapi/linux/netfilter_bridge.h,
> ../include/linux/netfilter_bridge.h): include/uapi/linux/if_pppox.h:
> 153:29: warning: array of flexible structures
> 
> It doesn't like that hdr has a zero-length array which overlaps proto.
> The kernel code doesn't currently need those arrays.
> 
> PPPoE connection is functional after applying this patch.

LGTM, can you send this one directly to netdev@vger.kernel.org?

Its not netfilter related so it feels wrong to apply it, even though I
agree with it :-)

No need to resend the rest of this series.

