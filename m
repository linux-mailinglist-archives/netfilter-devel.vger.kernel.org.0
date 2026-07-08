Return-Path: <netfilter-devel+bounces-13751-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YInbIrpxTmqIMwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13751-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 17:50:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DAA72845E
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 17:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13751-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13751-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7EAB30E93EB
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C243DD521;
	Wed,  8 Jul 2026 15:23:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4CD3451AF;
	Wed,  8 Jul 2026 15:23:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524237; cv=none; b=YVhdwiFHcWMW6aZ5wXasd/rPG3j6buzETimV3SzjkzYfGN096rEZgZYSLn/fBNWajRRvEljWOxq/7CKWVZqQ8QgSW4yfzAlStLMN8i6/G8zP90rGPOFVLbEUHPV9gEMWdjJcOYlNEW/yrVYYjXkEZKpDBGCo4yCAZbV9Q2nwRCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524237; c=relaxed/simple;
	bh=9NlGv7j3wYR2B3bsrFkE0C5K5mAsL2M2Y8LZOX+yPfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbcqDpKAOsuxzkTBgI16AdrUqN/CWpMb4G/minfOzxuxX5DRq0AlSWJO6g93CzGriwMTnFEUyue3xRiy6lJMkDicMI7cQ3UhxKMbHQInthbucYNuzRajezgxRZyqo/qvjc5D8mzvEtkDCEVPMtE54mLxDvuM/GhRiJyOyBgGK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1884B60E29; Wed, 08 Jul 2026 17:23:53 +0200 (CEST)
Date: Wed, 8 Jul 2026 17:23:52 +0200
From: Florian Westphal <fw@strlen.de>
To: xietangxin <xietangxin@h-partners.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	gaoxingwang <gaoxingwang1@huawei.com>,
	huyizhen <huyizhen2@huawei.com>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nf_nat_masquerade: recalculate TCP TS
 offset when port is randomized
Message-ID: <ak5riPx5d3rSG6MG@strlen.de>
References: <20260629093408.3927103-1-xietangxin@h-partners.com>
 <akKN4cywAsFRdefX@strlen.de>
 <0ad60f06-387e-49bc-9e26-3dcebf182cb4@h-partners.com>
 <akUhid7_3iHovivd@strlen.de>
 <3620a5a9-9ced-4825-9bc4-6950be205749@h-partners.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3620a5a9-9ced-4825-9bc4-6950be205749@h-partners.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:xietangxin@h-partners.com,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:gaoxingwang1@huawei.com,m:huyizhen2@huawei.com,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-13751-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98DAA72845E

xietangxin <xietangxin@h-partners.com> wrote:
> Thanks for your guidance. I’ve successfully fix the helper location
> as you suggested, and it works fine for local traffic.
> 
> However, I realized that I had completely overlooked the forwarding scenario
> (where SNAT acts as a middlebox gateway, e.g. Host A -> Gateway B -> Server C).
> In this gateway scenario, when random-fully is enabled, the test results show
> a massive performance degradation: the QPS drops from ~19000 down to ~10000.

I don't think the forwarding case is fixable.

Host S could be another NAT gateway, so it could be possible that
the connections originate from different physical machines and
timestamps differ due to different clocks, not per-connection
randomisation.

> Since skb->sk is NULL on the forwarding gateway, my current approach of
> updating tp->tsoffset in struct tcp_sock cannot be applied here.

Yes. I think the tp->tsoffset recalc is fine to handle local case.

For local case we do know that we're the end host and ts recalc is fine.

> To be honest, I am currently stuck on how to handle this forwarding scenario
> within the netfilter architecture without adding redundant overhead to the fast path.
> 
> Could you please give some advice on how the community would prefer to resolve this?
> For instance, should we look into extending the Conntrack NAT extension to
> track and adjust the TCP timestamps?

If we have some guarantee that internal network isn't doing any
snat at all, then yes, one could implement some TS adjustment
scheme similar to seqadj extension we already have to deal with
tcp sequence number adjustments.

We'd have to keep state and subtract the offset to get back the
right tsecr again on reverse direction.

I'm not keen to have something like this, it would breaks PAWS
as soon as the originating host is itself a nat gateway.

Is this really a problem to begin with?

