Return-Path: <netfilter-devel+bounces-11122-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEkBGjZHsWlCtAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11122-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 11:43:02 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B26242626DC
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 11:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C84AC3467FCA
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BF23C944E;
	Wed, 11 Mar 2026 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="g846SjWp"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4F3CAE85
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2026 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224402; cv=none; b=jQdZ+IvMjrtm4tvHO7BFbxf6zBq7xOwPc6qYgIPdszBPIpT398RNJCznelGiGz7Om+lJEgk2G94F3jcyn2tbh5nl/55u9djTrBTIG1NATErbZA5N8jWCYdUPJfSGucT7jMvq+3QZQ7yQCbLdGsGDHXnAAbnODmv5wM3rtC7b61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224402; c=relaxed/simple;
	bh=QsvE5Iajauwhq6cZgVR0InoctpmoiDK8eJ6KLZMOF3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmYBP/UDNtf97fw05uNOoi2pEm1xm37H+xmtlgnM0MHbXPZjQjCcw2H73IGWKBfKXrjnpuM36iSlQUaFlZBoGHQ6mtK5otQ6RXxanBX4u51DLYhTTgafQAbVUjOw4d9n81ws38Ox5gcKkgGJlaxC/vyVmXWcRI2e72vbTnOkyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=g846SjWp; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=K8yrCHIBgB6Kz+i7Ec5e2IyUs98e7MCRPuAr+AWVY+8=; b=g846SjWpA7Favcfm4n66rE2LAe
	5lrD4KBBYHH4RSNY7GWflRlk5n8S+AWUQXtI3ict4ZpaliT5lFurq3gzWinnFW/+thQO21imqgo9K
	reIrXcuqHVr3bozT7UxxHxNrtqU3/F96naVZZ9ZGopf7WuOCQOIuxYuCW3uaiCqVOo+WWS+ozYqWG
	D86P+U5D9Bfx36ZkrrzS1ztxPtn+6E35O6Poyz3JUIe+zxEGUpSgZ0A6gM3oEM5SbUx7O1PwSsDVQ
	3kx2vWyInKmjAc73ppJkzvqrZsDA0c3T3lhxdlCrKqpdv+dKR9SbMHmfvOnqLfU2+YPAxt4s3QWtd
	+V5Ktb4Q==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w0GfW-000000006Vi-2HBe;
	Wed, 11 Mar 2026 11:19:58 +0100
Date: Wed, 11 Mar 2026 11:19:58 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 2/5] cache: Respect family in all list commands
Message-ID: <abFBziaYqOenTfVt@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
References: <20260310231115.25638-1-phil@nwl.cc>
 <20260310231115.25638-3-phil@nwl.cc>
 <abE3Q6E9eZEm4-DZ@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abE3Q6E9eZEm4-DZ@chamomile>
X-Rspamd-Queue-Id: B26242626DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11122-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nwl.cc:email,netfilter.org:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 10:34:59AM +0100, Pablo Neira Ayuso wrote:
> On Wed, Mar 11, 2026 at 12:11:12AM +0100, Phil Sutter wrote:
> > Some list commands did not set filter->list.family even if one was given
> > on command line, fix this.
> > 
> 
> Fixes: a1a6b0a5c3c4 ("cache: finer grain cache population for list commands")

Hmm. At that point, we didn't have 'filter' parameter in
evaluate_cache_list(). Struct nft_cache_filter was introduced later, in
commit 3f1d3912c3a6b ("cache: filter out tables that are not
requested").

Assuming that Fixes: tags are used for semi-automated backporting (at
least I do ;), pointing at that commit will cause trouble.

Do you still think we should add that tag?

> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> 
> Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks for reviewing!

