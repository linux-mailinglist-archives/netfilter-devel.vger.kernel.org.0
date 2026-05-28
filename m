Return-Path: <netfilter-devel+bounces-12918-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP/TB/DyF2q5WAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-12918-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 09:46:56 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0C25EDE62
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 09:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BB5230336D8
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 07:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF993451AB;
	Thu, 28 May 2026 07:46:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880E31195C
	for <netfilter-devel@vger.kernel.org>; Thu, 28 May 2026 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954413; cv=none; b=gLBzd8E+HlelJuGSdRdU9tWCz5pKriv0EjCGQhEmXtXuq1be2P+0sFzXtcGmp6P4WDeFVgtMcphN2GhZZMXL4oLHgYYKZcA5Cc2dr7qsbdA3UE283K4V+kuAZvir63hgcUQ1DAs+mNWYYo5pWQBJC1pVNMOBY/aBiS7BcCbAiB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954413; c=relaxed/simple;
	bh=kqd0XNH3/BUvHkv0YeyaJRpUAmjkcpR6sTZpn10OkdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dkd9P4Nnb/UyqLsNFmo69OITVo+3x8ggeMoaqcQ0fMLFhv9KADCs4lSe7S5m1vjf1jgo2C+7K6LBnfEM1mZ0U1Nio5yph/hGjcCMA1f173UNkLygoXiN+GBVD/b6Lcxrb/uWbPZ4n7x/fCeo5CPeuJ92bjbpEX1X14LXcgat9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A5659604A0; Thu, 28 May 2026 09:46:50 +0200 (CEST)
Date: Thu, 28 May 2026 09:46:50 +0200
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2] scanner: Accept all statements' first words in
 all scopes
Message-ID: <ahfy6vvK8dhvBig-@strlen.de>
References: <20260508111538.3783172-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508111538.3783172-1-phil@nwl.cc>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-12918-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,strlen.de:mid,strlen.de:email,nwl.cc:email]
X-Rspamd-Queue-Id: AF0C25EDE62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Phil Sutter <phil@nwl.cc> wrote:
> To fix for token lookahead with exclusive start conditions, we must
> accept all keywords which may immediately follow the exclusive scope in
> that scope as well. This affects basically the first word of every
> statement which may follow a limit statement.
> 
> Add a test case to make sure things stay that way. A few quirks exist
> though:
> - xt statement would need special testing since having it in a rule is
>   supposed to fail the command
> - The parser formally accepts nonsensical things like strings, numbers
>   and variable references on LHS, but these seem to be needed for the
>   data part in map elements only
> 
> Suggested-by: Florian Westphal <fw@strlen.de>
> Fixes: 9d105581b5f1b ("scanner: Introduce SCANSTATE_RATE")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Is there anything missing here or were you waiting for a formal ack?

Acked-by: Florian Westphal <fw@strlen.de>

