Return-Path: <netfilter-devel+bounces-12924-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MSHAfwXGGqKdAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-12924-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 12:25:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0E5F08C6
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 12:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA73330193B0
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B93ADB9A;
	Thu, 28 May 2026 10:24:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F6305678
	for <netfilter-devel@vger.kernel.org>; Thu, 28 May 2026 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963859; cv=none; b=umApHmjHGQlxuFM33q3LHAfLlYrWypngo+M0WSqVW2V4+jPLwuN/+2aJA2vClrdLt/OgYm4SHWIrrjjpMFwjO11uN3iT98JQTmwwz3MyRjNpBjeUl7IkBQMVYEX30DQKZl+Cril20sM/ZpWzuzmkdrvDClLao7GWrEr2gB/uuB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963859; c=relaxed/simple;
	bh=JUUXOKEnluzNPdrNs3GfHsu4VoW1A7teToJukAHh1P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxtFPxVN1b451NhSg+HfuSeVbvDcwY1hqEVVPKjTe3hoxTvcdim9jyorDFj+iODwPWutzgZ2JKHcd97Mz1LGhxargxnR4gmfR3JMpiIDttI3w9MiKO0WgXlb6/KdtU1iGvuzPuSHLOe7QxtsupyPF/ViGJjHSft0RlWCOx/RhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CB4B760551; Thu, 28 May 2026 12:24:14 +0200 (CEST)
Date: Thu, 28 May 2026 12:24:14 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_ct: fix OOB in NFT_CT_SRC/DST eval
Message-ID: <ahgXzrLZx8J5NbVx@strlen.de>
References: <20260528042620.263828-1-jiayuan.chen@linux.dev>
 <ahfQGCNs8hl6FlHL@strlen.de>
 <ahfV6K6KrG0akLUZ@strlen.de>
 <88abc4d7-8316-4c9e-aca0-351fe0ecb2b0@linux.dev>
 <ahfqfM6xQKZr_xbA@strlen.de>
 <58fc5150-76e7-46e5-a72f-41133c408109@linux.dev>
 <ahf2XAmRnsjK0krp@strlen.de>
 <c1383a3a-6c76-411a-8ae3-1dfe90052fb7@linux.dev>
 <ahgLdDKloq01r7lK@strlen.de>
 <ahgS9K_8Q9AHhQ0K@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahgS9K_8Q9AHhQ0K@chamomile>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-12924-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:email,linux.dev:email]
X-Rspamd-Queue-Id: A6A0E5F08C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Thu, May 28, 2026 at 11:31:32AM +0200, Florian Westphal wrote:
> > Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> >  type filter hook output priority -300; policy accept;
> >  ct zone set 1
> >  ct original saddr 0.0.0.0 counter accept
> > }
> > 
> > Then: ping -c 1 127.0.0.1
> > 
> > should the rule match the template or not?
> 
> I don't think so, no matching on the template conntrack.

Great, I will make a test case for nftables.
Jiayuan, would you send a v2  that fixes the OOB+register leak
and restricts template matching?

Thanks!

