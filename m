Return-Path: <netfilter-devel+bounces-13248-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a1asCPfYLWpnlQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-13248-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Jun 2026 00:25:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AC167FECF
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Jun 2026 00:25:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13248-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13248-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B72E7300B3F7
	for <lists+netfilter-devel@lfdr.de>; Sat, 13 Jun 2026 22:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BB236AB7C;
	Sat, 13 Jun 2026 22:25:55 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02676334C3C
	for <netfilter-devel@vger.kernel.org>; Sat, 13 Jun 2026 22:25:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389555; cv=none; b=OREBc6gaRl8w+pqmYlCyz39vj9lf/ztsNVBrnuBzL8EnKgVpojA0r7nr9HIO9knTR5QI3NqugsQ/+Xxt57aOeLn906UdGUfk/ZOEVAJhi3Fs7Ort4RYdFsKlsuB5TyGAUYy5N0bxwHAkCKzTppuCnrowAuB3jYS3HdXqbQfnC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389555; c=relaxed/simple;
	bh=pnjrow4jrFtMhlk6TR2/PbnPUXexJ2jsoP4UnrA6jLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPGqQKCzS7sqVOWPL+VfSBS4Orxri1hHeiiYNquRaMgFyrAIc2SkVvjANL8pff236SR2PyAhxxLszjmRS4ZF1SRnDUy+UJNheAbOi3bxzjgnK+QEYba9Wcc0nSDw+16qfCDx4ObL9serhSx+kuejp9fIpNxtTnZMHtjlfQNbni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 205CC605EE; Sun, 14 Jun 2026 00:25:52 +0200 (CEST)
Date: Sun, 14 Jun 2026 00:25:47 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netfilter-devel@vger.kernel.org,
	phil@nwl.cc, yuantan098@gmail.com, yifanwucs@gmail.com,
	tomapufckgml@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn,
	bronzed_45_vested@icloud.com
Subject: Re: [PATCH nf 1/1] netfilter: xt_nat: reject unsupported target
 families
Message-ID: <ai3Y68Fqd-V3cpOS@strlen.de>
References: <cover.1781144570.git.bronzed_45_vested@icloud.com>
 <5722ce33544cc22da3f811de77ab57847eb58366.1781144570.git.bronzed_45_vested@icloud.com>
 <ai3MJ2P2MnXLxcmb@strlen.de>
 <ai3TGFyMlkS1m8O3@strlen.de>
 <ai3WcsS00Rbjy61u@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai3WcsS00Rbjy61u@chamomile>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13248-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:n05ec@lzu.edu.cn,m:netfilter-devel@vger.kernel.org,m:phil@nwl.cc,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,nwl.cc,gmail.com,icloud.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6AC167FECF

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > We can only use NFPROTO_BRIDGE targets, never UNSPEC, for NF_BRIDGE
> > caller.
> 
> Maybe it is simply this patch:
> 
> commit b6fe26f86a1649f84e057f3f15605b08eda15497
> Author: Pablo Neira Ayuso <pablo@netfilter.org>
> Date:   Wed Apr 15 12:21:00 2026 +0200
>  
>     netfilter: xtables: restrict several matches to inet family
> 
> which was missing xt_nat.c?

No, ebtables targets are incompatible, they return different
values compared to ip/ip6tables.

We need a nft_target_bridge_validate (or alternative method) that
rejects all targets that are not NFPROTO_BRIDGE.

This is wnat ebtables.c already does which is why this poc would
not work for classic xtables.

That said, this patch (the xt_nat.c patch) might be a good idea
anyway, but I don't think its enough.

