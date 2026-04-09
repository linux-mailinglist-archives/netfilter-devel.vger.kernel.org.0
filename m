Return-Path: <netfilter-devel+bounces-11776-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ1GK1nE12mdSQgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11776-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 17:23:05 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580CE3CC927
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 17:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87DA430087DD
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Apr 2026 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1603DBD7F;
	Thu,  9 Apr 2026 15:23:03 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9C3BBA0B;
	Thu,  9 Apr 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748183; cv=none; b=kLpLsZ2nbvYrUTrVRg7sJH6O29bf6vwKqqi/v1Hs1p7w2LEGVzbIe/vqH0cTuh3Iiod1Lp45WZ5/Lyp7YZX+K3f+s54zCx6XaA2lCUx2On/0lgqRrKokCE9F3udASRdOqQeQ5Jh152qta5cXMoPoA1LFbRbRMaC1hITw+kPx82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748183; c=relaxed/simple;
	bh=8/jykii4ONZsNxIPmPDh82fKjzULUq2Qfn/VCvywlZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtbvWbiQHdAyemdU7tX1jLAxTPrzblNY7Mi4VZKKbVTqxgEGoPPAF9kGKZRc7Ubs0+yW4IrhT0fIzhGfrMqPh+axQ+QJGXjAGiEQYRsNLes6Q9lAQdY5whUTmdos74HU72+R2iRkbIV0UQCVKJJyuH57Fq8seAhzZz83GKGzydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0D77B60640; Thu, 09 Apr 2026 17:22:58 +0200 (CEST)
Date: Thu, 9 Apr 2026 17:22:58 +0200
From: Florian Westphal <fw@strlen.de>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH nf] netfilter: nf_conntrack_sip: fix OOB read in
 epaddr_len and ct_sip_parse_header_uri
Message-ID: <adfEUtiiLzjtKd8m@strlen.de>
References: <20260409095056.706441-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409095056.706441-2-bestswngs@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11776-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 580CE3CC927
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Weiming Shi <bestswngs@gmail.com> wrote:
> In epaddr_len() and ct_sip_parse_header_uri(), after sip_parse_addr()
> successfully parses an IP address, the code checks whether the next
> character is ':' to determine if a port number follows. However,
> neither function verifies that the pointer is still within bounds
> before dereferencing it.

I already queued up:
https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260313195256.2783257-1-qguanni@gmail.com/

for nf-next (I already sent the 'last' PR for 7.0).

Could you check if that resolves the problem you're reporting?

>  		p = simple_strtoul(c, (char **)&c, 10);

All of these functions require a c-string, which we usually
don't have with network packet parsing.

IOW, sip helper needs to be audited for these problems
but I don't know when I can get to it.

