Return-Path: <netfilter-devel+bounces-11279-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIJ8CuL0ummVdQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11279-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 19:54:26 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A81242C1A7A
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 19:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 345BD30131E4
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 18:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3E30E858;
	Wed, 18 Mar 2026 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="Y4ZHCSIK"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD921771B
	for <netfilter-devel@vger.kernel.org>; Wed, 18 Mar 2026 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859779; cv=none; b=OsDD49zKv+12JUd7E0vSS1JgFFfn3dsioQuAds+FwJUA8Pc6gFwXJ2ems0yzHJ+azTMqpMaMA1yVbKQJUqG6Salfao6hzo0MmWPxJoCfw0VfExR5v/ZtMTYmRuXNsPXOqlxbLo+1X0jF6+ZM0Infb5lR38A/r4CYzpi4YPF3Yyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859779; c=relaxed/simple;
	bh=1BVuQcWFnGU8Jm/IGWdCV1cebeaZ28LawZBb57745dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN39m0UWHvDBOVbMCtwEjwqFnSpGonSNqppY4sA4Z4qD1dIuERkXuhEt/h7NTkua+Pbvuu0XreYsuS/D53zzKV1AiuPWkVPX60CCUX/f9j0xXd8oXwES4SOUsgfoQHOIfzB3Ycvy73Z4GCV6CXAdJrOc5GFU0XEhJo4+snOil78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=Y4ZHCSIK; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3ykfMi7GP7KGNx2PO7WGrOTQV3P3Y941j2eictItDMw=; b=Y4ZHCSIKItCxpxr8wnWDfTc7CO
	pHQwMLoNM7YJIliR2tWdM37ivsRYOlgSlT0GiaHYgIAdfqzMsXLrxcK3FtYVmVdo/AX871PqJSfeS
	EG457xElRkR7Fd4fawnAv1hx6FCnDSdgHHP5Qq1/0PtdiqIok+iNsf6TEhjXxbbsAp9pI2h3eFsyE
	8ekQnYgZZt3UfGMVa/ezISWcSXZj5fJW19fhFwih5ULJYIKtD7iwjF8T6prHwGhdWF272fm+3eWmk
	5ranuEJPW2eF1tvizRhASA8M5r3ZSPXRq+MqYAIVHAuxQdIWJzb+POfgYsAkgRDjKAeAl0quviCaj
	cgqkG3Cw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w2vxX-000000005PS-0i0Q;
	Wed, 18 Mar 2026 19:49:35 +0100
Date: Wed, 18 Mar 2026 19:49:35 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, Eric Garver <eric@garver.life>
Subject: Re: [nft PATCH 0/5] Enhance cache filter for list commands
Message-ID: <abrzv2oUPZ1OU6Aq@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Eric Garver <eric@garver.life>
References: <20260310231115.25638-1-phil@nwl.cc>
 <abrRdC2OXLyj6xnt@orbyte.nwl.cc>
 <abrZrnBsHXOwhdRS@chamomile>
 <abrZ_dgaDYhh0dx6@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abrZ_dgaDYhh0dx6@chamomile>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11279-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_SPAM(0.00)[0.192];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A81242C1A7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 05:59:41PM +0100, Pablo Neira Ayuso wrote:
> On Wed, Mar 18, 2026 at 05:58:25PM +0100, Pablo Neira Ayuso wrote:
> > On Wed, Mar 18, 2026 at 05:23:16PM +0100, Phil Sutter wrote:
> > > On Wed, Mar 11, 2026 at 12:11:10AM +0100, Phil Sutter wrote:
> > > > Reducing the amount of data fetched from kernel improves performance
> > > > with large rule sets but also reduces adverse side-effects if multiple
> > > > versions of nftables access the same kernel rule set. Being able to
> > > > ignore parts of the rule set one is not interested in allows for (more or
> > > > less) safe coexistence if each tool is operating on the data it created
> > > > itself only.
> > > > 
> > > > This series reduces caching for list commands which specify a family
> > > > and/or table. To help testing this, patch 1 extends netlink debug output
> > > > to include chains, flowtables and objects so a test case may check if
> > > > they are fetched or not.
> > > > 
> > > > The remaining patches actually increase filter use.
> > > > 
> > > > Phil Sutter (5):
> > > >   cache: Include chains, flowtables and objects in netlink debug output
> > > >   cache: Respect family in all list commands
> > > >   cache: Relax chain_cache_dump filter application
> > > >   cache: Filter for table when listing sets or maps
> > > >   cache: Filter for table when listing flowtables
> > > 
> > > Series applied after inserting suggested Fixes: tags.
> > 
> > Uoh.
> > 
> > I did not even get here to review.
> 
> Oh sorry, it looks good to me.

Yes, you gave your Reviewed-by: for all but the first patch! O:-)

> I thought you applied the one to fix "list table ...; list table ...;".
> 
> That other series I would like to have a closer look.

Yes, I also appreciate some review of that one. Also I wanted to try
implementing cache update per command, if only to see how troublesome
that will be.

Thanks, Phil

