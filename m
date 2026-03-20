Return-Path: <netfilter-devel+bounces-11342-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJbFBP1IvWlr8gIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11342-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 14:17:49 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB942DAD25
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 14:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 048E730B2717
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7743B9D89;
	Fri, 20 Mar 2026 13:16:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F41925BC
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012585; cv=none; b=bYQWv1xXuSqwrwQSlvpioP/WmJ4BE6y5mru62xntp9vWoI8EQyrxuB89Z7/uQonG3/WEi7D2BAi0KTrf1mBbAO/gcA3fMnYQE+lCKZBeTekQS9YwPif6RIXIz7MR7fKlwkRiy87MGFOn+X/Trl9tkwd+SHCGfGdmwAd8yo9P9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012585; c=relaxed/simple;
	bh=cKmvhWCSD5E6pn40XfZlO6aWym2bKpaQa1j+1Z37RP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ysgddb2ny4ZEhgU6pa7IZ6PZ43+OgSPOXuydvuukUmXY/cbmHzi+m0fPjBYNMDp2yKEqtYScnGuOe66jzp3tjOQ61RaGD8C0DDeTkp2JMzxyMemMGgwBpv1oXhmd1lPNS5+7pbnh0xrILiQQRKmZbpfhYeoLPgv3px8ga6/hjh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 254816080C; Fri, 20 Mar 2026 14:16:20 +0100 (CET)
Date: Fri, 20 Mar 2026 14:16:19 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 4/5] netfilter: nf_conntrack_expect: store netns and
 zone in expectation
Message-ID: <ab1Io4C98cfENWZj@strlen.de>
References: <20260320125947.305117-1-pablo@netfilter.org>
 <20260320125947.305117-5-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320125947.305117-5-pablo@netfilter.org>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11342-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.662];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,netfilter.org:email]
X-Rspamd-Queue-Id: 8FB942DAD25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> __nf_ct_expect_find() and nf_ct_expect_find_get() are called under
> rcu_read_lock() but they dereference the master conntrack via
> exp->master.
> 
> Since the expectation does not hold a reference on the master conntrack,
> this could be dying conntrack or different recycled conntrack than the
> real master due to SLAB_TYPESAFE_RCU.

Grrr, good point, I was about to say that you can safely check net
via exp->ct netns.  But yeah, object recycling is an issue.

I'll push this to nf.git:testing to let build bots have a go at
this over the weekend and will review this more closely next week.

But at first glance this series LGTM, thanks Pablo.

