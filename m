Return-Path: <netfilter-devel+bounces-13226-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bAbhBylBK2rV5AMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13226-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2026 01:13:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D14BA675C8C
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2026 01:13:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13226-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13226-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4334B32AFA79
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 23:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB8C3C8C69;
	Thu, 11 Jun 2026 23:12:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9937F74C;
	Thu, 11 Jun 2026 23:12:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219565; cv=none; b=oDSXUxhJYeiKxWxJ7/WsxtR0kM/M4+bndzZ5LmlTrWcsCckpOTaXw77qk+9U5qJ3wp0s47dscPmH5N1rCY+U3UGPCueVZ5dWnFUTVr8aeWDrAG8LVw8Fh2lx5xNM0S6Ur6tVclAKT3UCsFZ+YAPS6W+dKPUrc2vq40G0coJlnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219565; c=relaxed/simple;
	bh=KLe3hk5VUfU8noaxNmRkNEhMu7EBz0zeqqyDmsnIcAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQzBF21EbrYRTvh9d/GBdQ2eCcne1GElycsJoF8DGNyLRBUAqYzieSaWo2QEQSCdXnBwdkriyAYhPXX+LLreV/uRT8hAPKDOWPWmme0+dGNpow8xyjA12nfDKu+KlMRUkPFp4kxS3mIy9qgmZ2uAgRjurbA6NAVAAroahE++JjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 58793602B9; Fri, 12 Jun 2026 01:12:35 +0200 (CEST)
Date: Fri, 12 Jun 2026 01:12:33 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] netdevsim: tc: allow to test nf_tables
 offload control plane code
Message-ID: <aitA4f_9YaQV-I_l@strlen.de>
References: <20260610175906.1767-1-fw@strlen.de>
 <20260610175906.1767-2-fw@strlen.de>
 <20260611133910.2887266f@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611133910.2887266f@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13226-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D14BA675C8C

Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 10 Jun 2026 19:58:43 +0200 Florian Westphal wrote:
> > @@ -73,7 +86,10 @@ nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
> >  						  &nsim_block_cb_list,
> >  						  nsim_setup_tc_block_cb,
> >  						  ns, ns, true);
> > +	case TC_SETUP_FT:
> > +		return 0;
> >  	default:
> >  		return -EOPNOTSUPP;
> >  	}
> >  }
> > +ALLOW_ERROR_INJECTION(nsim_setup_tc, ERRNO);
> 
> As you probably seen other netdevsim offloads use explicit debugfs 
> files to "fail operation X". Slightly easier to deal with, and
> netdevsim is a test harness anyway. But entirely up to you.

I'd rather not reimplement the '30% failure rate' and the 'make-it-fail'
logic (allows to have restrict the error injection to selected
processed), so I would prefer to give fuzzers more rope.

I'll fix up the sashiko hints in v2.

