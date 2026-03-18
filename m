Return-Path: <netfilter-devel+bounces-11276-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM6DJe7cummfcgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11276-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 18:12:14 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F32C2BFFAD
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3967D3052AFC
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7001C20CCE4;
	Wed, 18 Mar 2026 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="dvSKPjE8"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9892D6E6F
	for <netfilter-devel@vger.kernel.org>; Wed, 18 Mar 2026 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853187; cv=none; b=MDEaHsvphytsJ50fmWjpB9oSWR6jg0evmTgidk88dEeGQnHCFhW9EGu4B+BK0Rou3J5dJ5qyjTbnsKDqA4S1vIcCHR7mFFsioBKRAAwLJ3XFK/6YeVXEIehe1489Q1ubzWXDVTFakCXplcbQDXPwFdcd0ezkMBB50HvgWAwFV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853187; c=relaxed/simple;
	bh=ezNyNYk98Wy5iXo4E66EP4eHlscYUWb7QPXaR+80SsI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfIK148iRJrGxGbGB6Bei2LSng0EPrTTzqI3TAPQNvjdhQl+qfw5wgNAO2ER1mUJuo94lFeTNiFy8yoNQYdVIS3nDAlPVgPLXnaOrOPYOU69g8IcBq5gT8iPB+HI2/JnbWsEzcJvAIAjYJSYBT9mb1EsKyZabfizBRddPib9m+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=dvSKPjE8; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 11C876026F;
	Wed, 18 Mar 2026 17:59:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1773853184;
	bh=9m6HtUiZzraFsKcmQLTWMfsaqHlrcyGyCNRtS0T4WVY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=dvSKPjE8w/p+H0tc/hUw2b5Sarp0aMsjpt1GjIjr4EWcayAHlmO/PdUmivzT0Y/ip
	 A2Hd6CKkAWVBsa8GRiNu51ZpHW6xJMmrIbaRx1Y5wcxi5aW8l2h+kAmKBxUBGtJliR
	 lbsYWwTba1TuuBmcc/pAYQxLVYZ8zqhELXI6Rpe2/8s6qTYAzAtfAQxkiLWSxjEV2W
	 EIA6/Fr69ZV7Z7CszkfCFebtsx61Os/+pNoBAwBcCiAI3+DOhSiwG0JN5lidemWVMH
	 60Na4LIskuGmSiqjvEqENeIHPs3ebMytCB1PrVI7EYeCrNWnBRcAi+gz+QGfQqdRZu
	 TME7gooRrZ5CA==
Date: Wed, 18 Mar 2026 17:59:41 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
	Eric Garver <eric@garver.life>
Subject: Re: [nft PATCH 0/5] Enhance cache filter for list commands
Message-ID: <abrZ_dgaDYhh0dx6@chamomile>
References: <20260310231115.25638-1-phil@nwl.cc>
 <abrRdC2OXLyj6xnt@orbyte.nwl.cc>
 <abrZrnBsHXOwhdRS@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abrZrnBsHXOwhdRS@chamomile>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-11276-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netfilter.org:dkim]
X-Rspamd-Queue-Id: 3F32C2BFFAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 05:58:25PM +0100, Pablo Neira Ayuso wrote:
> On Wed, Mar 18, 2026 at 05:23:16PM +0100, Phil Sutter wrote:
> > On Wed, Mar 11, 2026 at 12:11:10AM +0100, Phil Sutter wrote:
> > > Reducing the amount of data fetched from kernel improves performance
> > > with large rule sets but also reduces adverse side-effects if multiple
> > > versions of nftables access the same kernel rule set. Being able to
> > > ignore parts of the rule set one is not interested in allows for (more or
> > > less) safe coexistence if each tool is operating on the data it created
> > > itself only.
> > > 
> > > This series reduces caching for list commands which specify a family
> > > and/or table. To help testing this, patch 1 extends netlink debug output
> > > to include chains, flowtables and objects so a test case may check if
> > > they are fetched or not.
> > > 
> > > The remaining patches actually increase filter use.
> > > 
> > > Phil Sutter (5):
> > >   cache: Include chains, flowtables and objects in netlink debug output
> > >   cache: Respect family in all list commands
> > >   cache: Relax chain_cache_dump filter application
> > >   cache: Filter for table when listing sets or maps
> > >   cache: Filter for table when listing flowtables
> > 
> > Series applied after inserting suggested Fixes: tags.
> 
> Uoh.
> 
> I did not even get here to review.

Oh sorry, it looks good to me.

I thought you applied the one to fix "list table ...; list table ...;".

That other series I would like to have a closer look.

