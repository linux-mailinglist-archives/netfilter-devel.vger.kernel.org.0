Return-Path: <netfilter-devel+bounces-12316-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJTMDOjx8mnNvwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12316-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 08:08:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B6D49DDA8
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 08:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07306300A622
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 06:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6543090D9;
	Thu, 30 Apr 2026 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="mPRU9Kxb"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BE369224
	for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2026 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529317; cv=none; b=rdd8BNVDODF1q9PuryghsG+HjdnV4OVCe9O1ZjvxDTFuCgzJwdLT98XzWREZ7bId9hHb9fhQusEXZggYhgNleZ/NTvwhEt9kOWrkSMHPOnJ8pc57ngqbyzsrqCQrokTnFCj40t0zRobYxEH3O0FJCWZe8XAy7nbsKvKjWUuGFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529317; c=relaxed/simple;
	bh=3zNvl5poJA0veQ4lq7L/SXTn0Wpb9Y0E0UPdqUhWJWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2nW7oe8ezwri+3KvwaUn7fVsU3R/EqEsWJRElbbYr8nlV6KH+rQ6IK+Lf+lrSqCKhLF0VIjxPTtoEFMV95eLubCzmciD4AEk8S1D/ihWnQRgn7rq6SV58D84GJW2Lbd4iLWGTUcrmGNdrpl8Gw5CKGNkQlKF3S6VmmPdAWPFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=mPRU9Kxb; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 0EF3B6017E;
	Thu, 30 Apr 2026 08:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777529314;
	bh=lGW/lvk+nbjVGw40EEdEFJnuoB4gZcuSEqOa6A4IwUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPRU9KxbTd7+CAhG24o6kOf37jDb5QHYzBQgEi5Y89TBdy3W5H7douqkX4mo39byY
	 iq9U4XdFXycWyN7oLa5Z+DtW8Q6O5ILkDj8nTO4UurcE8nWw6dACD0sBy4YDceJCLc
	 i7TtuJKODAA2pbm4ugTX16jW7y479o0LnGzzLBmYnFJNBzAB7oq1oEFa9hVGMa7PDl
	 riNbvoQI/3HNlUGGcnVHdZqrfwHcobAwH7UxQwsB3szNq+TxIWjEQRWxFAjV1ePLEy
	 o3en624OAstVESEo4XzYt6jTHFp21Rpq15pZoAGCG9Pfaznz4aOPKn4rd4l/cwOWao
	 yVJYANA7cJCAQ==
Date: Thu, 30 Apr 2026 08:08:31 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, phil@nwl.cc,
	fw@strlen.de
Subject: Re: [PATCH 3/3 nf v5] netfilter: xtables: fix L4 header parsing for
 non-first fragments
Message-ID: <afLx347nrAJLqsyf@chamomile>
References: <20260428102548.6750-1-fmancera@suse.de>
 <20260428102548.6750-3-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428102548.6750-3-fmancera@suse.de>
X-Rspamd-Queue-Id: B6B6D49DDA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12316-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim]

Hi Fernando,

On Tue, Apr 28, 2026 at 12:25:48PM +0200, Fernando Fernandez Mancera wrote:
> Multiple targets and matches relies on L4 header to operate. For
> fragmented packets, every fragment carries the transport protocol
> identifier, but only the first fragment contains the L4 header.
> 
> As the 'raw' table can be configured to run at priority -450 (before
> defragmentation at -400), the target/match can be reached before
> reassembly. In this case, non-first fragments have their payload
> incorrectly parsed as a TCP/UDP header. This would be of course a
> misconfiguration scenario. In most of the cases this just lead to a
> unreliable behavior for fragmented traffic.
> 
> Add a fragment check to ensure target/match only evaluates unfragmented
> packets or the first fragment in the stream.

One more little issue here: There seems to be an issue in
xt_hashlimit, hashlimit_init_dst() drops packets via hotdrop if it
returns -1.

