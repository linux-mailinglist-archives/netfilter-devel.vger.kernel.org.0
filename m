Return-Path: <netfilter-devel+bounces-11921-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKCoBFWW32leWQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11921-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 15:44:53 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A5A404F69
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 15:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2AF6300D162
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 13:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F82F6577;
	Wed, 15 Apr 2026 13:44:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73733A031
	for <netfilter-devel@vger.kernel.org>; Wed, 15 Apr 2026 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260690; cv=none; b=EbC52/nzVFDOBhIrufIOuFfC58eLhYTbdv8UKZimLDKaiuGXKYsHCWp+nnlznPNiRHOrXS1z7aADBJSb+OA8xa9ChoMVEYUylgjXQ2ZeMOzYaCyJGZkKWhQ8T71eoRL8m8BMSSsEOjJ4fOFZvpYHAL38StC/irEqD2MHRu2vBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260690; c=relaxed/simple;
	bh=mbcIAsxip3Je0Mce9MUdGsnyf6RaeI4A9/9IGvcUjKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8eBViQEWIe0DZpWhioSLC6AHQTcpUyO0nTzDdM5BDKuUrLKtpDSHlNXbar7bqMuVJtZUzvdRxq97y2prj0ZRLobDigR6quiPQ+AuXt0NJV6wwQDV0/dFpN1uaCsnFo9VFJWLgUIAhTR3qr1dtJVTC6B2pCesUpphqFs3FdIWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CF1BE602AB; Wed, 15 Apr 2026 15:44:45 +0200 (CEST)
Date: Wed, 15 Apr 2026 15:44:40 +0200
From: Florian Westphal <fw@strlen.de>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org,
	coreteam@netfilter.org, phil@nwl.cc
Subject: Re: [PATCH nf-next] netfilter: nf_conncount: make number of hash
 slots configurable
Message-ID: <ad-WSA87e6Ukfi3M@strlen.de>
References: <20260413123712.42993-1-deliran@verdict.gg>
 <adz9CyDXi2wSwvjM@strlen.de>
 <DHTRLCVFNCOG.3VDTTB7NRAZFX@verdict.gg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHTRLCVFNCOG.3VDTTB7NRAZFX@verdict.gg>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11921-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verdict.gg:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 83A5A404F69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Vladimir Vdovin <deliran@verdict.gg> wrote:
> > Maybe change the code to size the array dynamically
> > based on e.g. number of online cpus?
> Hi Florian,
> 
> May be we could move it to module params?
> (not sure that this params have to depend on number of cpu)
> May be use number of cpus as default value?

I would prefer autotuning based on online cpus so this doesn't have to
be changed at all.

How many cores does your platfrom have?  The current value was set 2014.

