Return-Path: <netfilter-devel+bounces-11165-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LFsI8Y6s2ntSwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11165-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 23:14:30 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2579627AE19
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 23:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23E1F304AA27
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 22:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F6A3FBED5;
	Thu, 12 Mar 2026 22:14:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2F3FD140
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Mar 2026 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773353666; cv=none; b=JsI5tJtUgiXq0cGGyLruP/UkUf5eAtjCyoigvXLrp5ROJ7iq/JXelP5fKEm4OhhwBjjSOI63z6wbtqC/t9FgKgijhgfzYFgLpO7jFdHBRVYpRtXanOG++tuyZEwbDzZavUbbN/9XFTSkepvdTQlGv1T4c6qX+KZDqacRLF9FGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773353666; c=relaxed/simple;
	bh=Oi9aKfBiBGMQ9e3JwobNd1BKrBGzXdUqm1kfNo9sDFM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN+gndPxXJQK8PiXnkedcBEl14iSAjGOT8YKtvJGqOQxu5h8TtKCJo4MpDkQZAdcj6iJQ4Pg2mp7nI0oTjMpCIFDjOwTRdCsvD1QVAETDNQuoIbfk3o1llcr3WrpYTTkR+373eFGKaCuTB9bJaqL6+bTjk0VvcpGNUPM1a6E+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A195760345; Thu, 12 Mar 2026 23:14:18 +0100 (CET)
Date: Thu, 12 Mar 2026 23:14:20 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>, Jeremy Sowden <jeremy@azazel.net>,
	Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft] tests: py: use `os.unshare` Python function
Message-ID: <abM6vF13kX78q2Rh@strlen.de>
References: <20260305175358.806280-1-jeremy@azazel.net>
 <aasRsr93TOUuH_Xb@orbyte.nwl.cc>
 <20260306183553.GA5468@celephais.dreamlands>
 <abCki9aBa8wVBvQi@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abCki9aBa8wVBvQi@orbyte.nwl.cc>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-11165-lists,netfilter-devel=lfdr.de];
	TO_DN_ALL(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid,nwl.cc:email]
X-Rspamd-Queue-Id: 2579627AE19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Phil Sutter <phil@nwl.cc> wrote:
> > which suggests it's time-zone related.  Didn't see anything about that
> > in the doc's.  Will take a closer look.  Apologies.
> 
> Yes, it's odd. Neither unshare module nor 'unshare -n' behave like this,
> even though os.unshare is described as doing the same as unshare command
> does. It also doesn't mangle os.environ['TZ'] value, no idea why it
> messes with this.

Is there anyone working on a fix?

This breaks my CI pipeline (i.e. I disabled meta.t tests).

