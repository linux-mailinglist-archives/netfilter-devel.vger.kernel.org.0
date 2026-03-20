Return-Path: <netfilter-devel+bounces-11326-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC3IBdMzvWmI7QIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11326-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:47:31 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A064F2D9CAA
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A98E23009B07
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CC83469E6;
	Fri, 20 Mar 2026 11:47:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4881A6800
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007247; cv=none; b=E8yTkeOP5D5BDbeabxAe0Az6psJvv8wRf8B5iXNe4b86IFpRlXWsXJOux+TqjA6qrX7TnBZJohoVpkrtlWdGNZHow0iSsEbzmgLRSnBOm93gf7m8ckRFbB/QdDZs+HxJLWYXQKXtxNp+DkOA5c0yehHvk3DIwJolbClaXI2y1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007247; c=relaxed/simple;
	bh=S9zoxZm219qSC+Ioy70FND7phXJtbI115058U3z+dNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgZzCTzsB4gSjgiWtaVJ+TF3QUCkRZVOxbyb72S6sckkod/zf81xCJuaz5rndEBBNZXqt5KEYguxeX0AGOZQf3Wn8ad94FeOz0lkXfFIiyU1eP46XMrckuori7X15QJm5Q8l1q1V0AT5hWlhSZaolBPXvn/ftODzqv67Onc56FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3C70A6080C; Fri, 20 Mar 2026 12:47:24 +0100 (CET)
Date: Fri, 20 Mar 2026 12:47:23 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH] netfilter: nfnetlink_hook: Dump nat type chains
Message-ID: <ab0zy4fOLraYqVPJ@strlen.de>
References: <abwegj2TijkaQVLz@strlen.de>
 <abwraHUuxizN4krg@orbyte.nwl.cc>
 <abwtAkSF8-SmH684@strlen.de>
 <abxlzn7lymOxWUFa@orbyte.nwl.cc>
 <abyTyJBv47f3v9gd@chamomile>
 <ab0enMtOAFiG0mSN@orbyte.nwl.cc>
 <ab0rbTfE7LWIk7f-@orbyte.nwl.cc>
 <ab0tB2o90FukwQxU@strlen.de>
 <ab0u4JS4Z7THrP6B@orbyte.nwl.cc>
 <ab0xNu8tKdWigNQ1@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0xNu8tKdWigNQ1@orbyte.nwl.cc>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.554];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-11326-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: A064F2D9CAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Phil Sutter <phil@nwl.cc> wrote:
> > Sure, but <=nftables-1.1.6 will still get it wrong. Can we tolerate
> > that?
> 
> The kernel could dump them in reverse. :D

WTF, no no no.

The kernel is fine, this is a userspace bug.

It wasn't noticed because typical configurations don't add same-prio
hooks.

Userspace MUST dump in the order received so the dumped list reflects
the actual execution order.

