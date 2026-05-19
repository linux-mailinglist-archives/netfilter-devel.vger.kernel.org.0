Return-Path: <netfilter-devel+bounces-12704-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EL1I7jBDGqJlgUAu9opvQ
	(envelope-from <netfilter-devel+bounces-12704-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 22:02:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8365846CB
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 22:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CBDE308B3CA
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E393B775A;
	Tue, 19 May 2026 20:01:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2FA3B7777
	for <netfilter-devel@vger.kernel.org>; Tue, 19 May 2026 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220861; cv=none; b=SSkX1gTTLnevG9coQ4tBYVad2gRZaOovxt6Sm9TvWBix7KPxKo/YlVSlflF2myvQEu1VlVCPQYkq+P/asoMwbzQsMHtfYg/MHVZkOXGtWvU3QLEpTVwfYfAUqW7iskcPYK3dyMa/VLvZd0zhqDNjjUE2ihYXYzwe/kgTktqhJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220861; c=relaxed/simple;
	bh=YRzpkJK2vF5bdAnERuvJ1FcmRBx48zxt4jXB+yd6jrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwvsjFKLrmlzvyzOSs8H0TtZXDD6wrce61W8Cv1nUY51TK56CWu1cL7MEvIKyH8+6MQ/NRcv4a1eKoemXW2gQaneyg2il3hG+kt1sFF7X0TScXO9uC7dj1WfISheXPg5gkU+sw+HirSFhs238cxfl18JD/DMl6Jdt45DVSlo8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id DF4FB607BD; Tue, 19 May 2026 22:00:57 +0200 (CEST)
Date: Tue, 19 May 2026 22:00:57 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: =?iso-8859-1?Q?=C0lex_Fern=E1ndez?= <tomaquet18@protonmail.com>,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v4] netfilter: conntrack: fix integer overflow in
 expectation timeout
Message-ID: <agzBef_OUFnMo8Pv@strlen.de>
References: <20260504112300.715192-1-tomaquet18@protonmail.com>
 <agy8JBZYvx54GYfL@strlen.de>
 <agzAFhNpiYNcBeZ5@chamomile>
 <agzAlQb36seb2Rhr@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agzAlQb36seb2Rhr@chamomile>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[protonmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12704-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:email]
X-Rspamd-Queue-Id: 2A8365846CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > I think this is just a cleanup / nf-next material?
> 
> But this can also go through nf.git for correctness, we can just
> describe in the PR the effect of this bug.

Yes, its low risk change to clamp this, it can go via nf too.

