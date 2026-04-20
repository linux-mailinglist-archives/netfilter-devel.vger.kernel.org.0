Return-Path: <netfilter-devel+bounces-12065-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICOSFrhU5mkDuwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12065-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 18:30:48 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 509B842F904
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 18:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 943313154689
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AE635FF5B;
	Mon, 20 Apr 2026 14:03:38 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751C35B64B
	for <netfilter-devel@vger.kernel.org>; Mon, 20 Apr 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693817; cv=none; b=m7i7uQneOdUqfyr/1BislmydEM7f1865jr68apxoeRsyNj5FP1SPlhbWCybvGecKWdvnFnnZFlrzQTvgO1HLqgTkXIpdoccab4FsalIciGU3M85xP0iLGd1NOCzKW0gpFbSBBXD3VbjF03LbYv5vEAF/gRsJukr2/QWo3TKg0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693817; c=relaxed/simple;
	bh=hMzUSV3qYUm7kcpMbXCteh3du5pUrpurDeRDnvmQd6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7qZmO0HcOWXswxTnsY2OU4TiBx2IPQKIHzpdZ+aqjiibIZbkkv3JMY7M6CDL1jn3uRtyVNhCYjQJ9Fkt4uBn/OfBviotsL5OOcasrv40induTcOGdNHUxO/QMqv0I2MaEq7VlMTxq9ZYW+JlZC73rWGKkdlBx9N3ak3RYAuuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5D55460490; Mon, 20 Apr 2026 16:03:27 +0200 (CEST)
Date: Mon, 20 Apr 2026 16:03:26 +0200
From: Florian Westphal <fw@strlen.de>
To: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH 2/2] netfilter: ipset: Fix data race between add and dump
 in all hash types
Message-ID: <aeYyIjzGGupy99Fv@strlen.de>
References: <20260415082039.4133308-1-kadlec@netfilter.org>
 <20260415082039.4133308-3-kadlec@netfilter.org>
 <ad9mzYNk5JpDfklg@strlen.de>
 <4e01c555-2f4c-81b7-e6c4-d1f7b3e2e99f@blackhole.kfki.hu>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e01c555-2f4c-81b7-e6c4-d1f7b3e2e99f@blackhole.kfki.hu>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12065-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:mid,kfki.hu:email]
X-Rspamd-Queue-Id: 509B842F904
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu> wrote:
> limit the searching range for existing elements (which might be timed out 
> as well). So until the "size" is unchanged (no growing/shrinking), the 
> worst things which can happen if it's not "correct":
> 
> - new element added but dump/test don't "find" it
> - element deleted but dump/test find it
> 
> The critical part is when "size" changes. But "size" never updated 
> directly: a completely new bucket is created when growing/shrinking and 
> the new bucket is assigned via RCU mechanism.
> 
> So why do you thing the helpers are required to read/update the "pos" 
> element of the hash bucket? I might not see the wood for the trees.

As-is it is confusing. Pos is updated concurrently to dumpers
with no ordering and no annotations (READ_ONCE, WRITE_ONCE).

Maybe they are not required, but then there should be WRITE_ONCE()
and READ_ONCE and a comment explaining that this is deliberately racy.

Basically what you wrote above.  It would help to understand what
guarantees there are and that this is good enough.

As-is KCSAN will surely splat without data race annotations.

