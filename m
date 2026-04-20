Return-Path: <netfilter-devel+bounces-12087-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BYMCBt65mkHxAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12087-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 21:10:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 617FA4332CE
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 21:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5AD1301CFA4
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5713B0AD9;
	Mon, 20 Apr 2026 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="E/Y8YaMa"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12696383C82
	for <netfilter-devel@vger.kernel.org>; Mon, 20 Apr 2026 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712027; cv=none; b=gXsaeIs9bo/dUG+GcmaifvaBzJQlpOaFcZEVC8kvAlP9TVxjqY08G5ayFAE/ABtoT5fube2YshvT8+otVPztF+m9MMUhIM94vyf5Gyb8T6qtz5XhoRtQSq46trzSi63lQu2g1iXESXA+REeeTFrCnyHyk6XeSwRRCN+giAQ3FKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712027; c=relaxed/simple;
	bh=F9+dTYu+EazAQoSXhVZH7rj/z/CisEZPiNZKW0e7iG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtnOgTGT7H9fYWEqRn3caqMFJ+xw82T82PKFrjCub0yDSBdtveqJlxIjAMm20uqfJiYhx6Wz2x4qBBDY3xWrdZdGsBjBOFCehie1KUgLOd/jszOive4ndBQdJzzRDLq1xpNA67riUzZGMqTtpE0mxs0N8WJpL+AbEa93062bwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=E/Y8YaMa; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 1635460180;
	Mon, 20 Apr 2026 21:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776712024;
	bh=jmhkzg2lAwutHpq2MKp5lP2mADtXf+Px4I5BolkCzog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/Y8YaMaHLyiOHBZpbNnuyC0QVQ6zxcsgM8Bk0tDZgcwmdcZeNLUS1Ixv76Ghr5Q9
	 lvJ+5qXy9fBLpkygKZtvl+sxOmj8ZxKxvmofo73tnY27C1U4vFZNv87zzRZMQo8RH1
	 p6qi20ldbYAqxPUs4oO6YlQdTXqmSherk+MlzDZjiyRe4Hgay2kQ3kiXujVXBQnVV4
	 3BcTXCU7oYkXOWCXNvOO3Iy6CuEpKsXYtkiacf4QoQ+kDZFt/fPMC3q3C9xd4hioRi
	 hPV+FlPlj/JhlOH89loJHY8QlmUVecXRdMpzZ/FCAzpxy0Vxb8UTZxgiiRe1RySWtr
	 ROUGR9/PhMkOQ==
Date: Mon, 20 Apr 2026 21:07:01 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_compat: run checkentry() from .validate
Message-ID: <aeZ5VYC0cxxVYQ4_@chamomile>
References: <20260420174227.13087-1-pablo@netfilter.org>
 <aeZoiqyPFP0NJkz9@strlen.de>
 <aeZpj9r368paudyZ@chamomile>
 <aeZunt0QSt2EdFdF@strlen.de>
 <aeZ0_GvXUnOJPSJ3@chamomile>
 <aeZ2H8ghe3Ddcn9u@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeZ2H8ghe3Ddcn9u@strlen.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12087-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim,netfilter.org:email]
X-Rspamd-Queue-Id: 617FA4332CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 08:53:19PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Your approach duplicates .checkentry in some way, you have to make
> > sure what your .validate and .checkentry perform the same check, ie.
> > they are in sync.
> 
> Thats why I updated the affected .checkentry functions to use
> the validate functions internally -- to make sure the code is called
> even for classic iptables.
> 
> > If this needs to be generalized further, maybe checkentry() needs to
> > extended to improve integration with nftables.
> 
> I hope not.  But I don't care, if you prefer your patch then so be it.

I can toss this patch if you prefer, I will post it complete then
decide what to do.

> I just find it sad we duplicate efforts all the time.

I thought I could provide a more self-contained approach for this
nft_compat specific bug.

