Return-Path: <netfilter-devel+bounces-10465-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGzpMLAGemlE1gEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10465-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 13:53:04 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA3A19D8
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 13:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8872304B5A2
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8270B2FE566;
	Wed, 28 Jan 2026 12:48:49 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E51E5B70
	for <netfilter-devel@vger.kernel.org>; Wed, 28 Jan 2026 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604529; cv=none; b=DHprH7eMjrN38aLHCT03SR50dmqQLTlq4Kgp+antUj7CyA05k0bydbQYg3d9n3oSDtyizqsyTFgXQpgXIRx+oRVmN0ZdCszeW1lzlynSAdTjZkq4HpVUijWmRdhUjAUR4RU3yCmInTnMByd4eIKsSq0JYzICqOzu/uZkRNv3Jos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604529; c=relaxed/simple;
	bh=BWBD5r5FtF9sHiHab4bJwHVtTxsfWJ6+eKafXU+7i9k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnOUcTFzwLfl/Tk9/R+OB2Zz8yGJ7SrE4E4PuH+DFY6Z3U14LSjwFoQ49BaQDaDEQ6qdUqgorEnePpMjfNHpUldkxnN1m5pse846qjjNUdHts/8Hp9uNr//qvPCML8RsdLQ3IzefOxLHhji4hi+CWBVuWqXCDhGmxBSVELlI3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 03D3160516; Wed, 28 Jan 2026 13:48:39 +0100 (CET)
Date: Wed, 28 Jan 2026 13:48:35 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jeremy Sowden <jeremy@azazel.net>, netfilter-devel@vger.kernel.org,
	Philipp Bartsch <phil@grmr.de>, Arnout Engelen <arnout@bzzt.net>
Subject: Re: [nftables PATCH] build: support SOURCE_DATE_EPOCH for
 reproducible build
Message-ID: <aXoFo8uNjMMLXvvI@strlen.de>
References: <20260123123137.2327427-1-phil@amsel.grmr.de>
 <20260123163615.GB1387959@celephais.dreamlands>
 <aXl0orzXWNXUumUB@chamomile>
 <aXoEvAQnTjh31ImG@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXoEvAQnTjh31ImG@orbyte.nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10465-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nwl.cc:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 2BEA3A19D8
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> > > Generating one time-stamp in the Makefile is a pain in backside.  I have
> > > come up with a way to do it, but it's fiddly.  Florian, Phil, would it
> > > suffice to generate the time-stamp in configure?
> 
> I deliberately chose a build timestamp, not a configure one. In most
> cases it won't matter, but since one could defeat the stamp by
> recompiling after making changes without calling configure.

I don't think thats a concern.  This is geared towards official
releases only (and catching possible issues on update path on
real deployments, not deveopment workstation).

So I vote for configure-time.

