Return-Path: <netfilter-devel+bounces-11075-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAQCGyMhsGmCgAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11075-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 14:48:19 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D10DF250D01
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 14:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8259B314343B
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D63DCD9E;
	Tue, 10 Mar 2026 12:39:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062193D1709;
	Tue, 10 Mar 2026 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146345; cv=none; b=fJrYknRkk72BSH0uKjKcPvkKaQ4CO6QjlLPv78TZjfs29Mb5cgLwp7GHuEIa7PqY7LAg/jDYwSuxCI158tO/l7I9L8/W9tbnPXrEEjnB+n3oMQZP9Ey6tqW1dxNWaW9AZDI4JBEzVshTnQF/MRa+Ru5S7VRwu0pPNOoCnH4qHTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146345; c=relaxed/simple;
	bh=49jaIySXqudH/XzbRYsMiOat/c3nwKoEY5Xxxum3XdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAHe+nBVJtdY544p1BXrTE9kW5cK10JRK+WicIO40sQV716MuBXg33y3HRnWwDyh+QIhKteRktOO6MTDjo2pfZeJowu25DtpyNne7QHs2k9qU04nHEx/7/Qg+YPfDwfZ2THBJajgFdIJMbyf4vh9+tcfDqEaMw9afU8Yrm1XD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0DAA56052A; Tue, 10 Mar 2026 13:39:02 +0100 (CET)
Date: Tue, 10 Mar 2026 13:39:02 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>, netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Phil Sutter <phil@nwl.cc>,
	Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v19 nf-next 5/5] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
Message-ID: <abAQ5i9SulUkHkcy@strlen.de>
References: <20260224065307.120768-1-ericwouds@gmail.com>
 <20260224065307.120768-6-ericwouds@gmail.com>
 <76b3546a-37c5-4dab-9074-4df0cbe48524@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b3546a-37c5-4dab-9074-4df0cbe48524@gmail.com>
X-Rspamd-Queue-Id: D10DF250D01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11075-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,redhat.com,kernel.org,vger.kernel.org,blackwall.org,google.com,nvidia.com,lists.linux.dev,davemloft.net,nwl.cc,earthlink.net,lunn.ch];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.945];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Action: no action

Eric Woudstra <ericwouds@gmail.com> wrote:
> Just in case, I'm sending a kind and small reminder, before it is too
> late in the cycle.

I dropped this due to questions/feedback:
https://lore.kernel.org/netfilter-devel/20260225015256.967692-1-kuba@kernel.org/
https://lore.kernel.org/netfilter-devel/20260225015235.967500-1-kuba@kernel.org/

(You can ignore the bit wrt. 'net: pppoe: avoid zero-length arrays in
 struct pppoe_hdr', I am aware you sent a patch to net, so that part is
 covered).

