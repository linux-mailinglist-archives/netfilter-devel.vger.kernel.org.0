Return-Path: <netfilter-devel+bounces-12086-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOotMiV25mlBwwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12086-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 20:53:25 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 773054331A6
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 20:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3996300B9E1
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13273B19A2;
	Mon, 20 Apr 2026 18:53:23 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E23A5E81
	for <netfilter-devel@vger.kernel.org>; Mon, 20 Apr 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711203; cv=none; b=g+H/ta7Hj4taugzeKB1OGCaX5akojoCi7+8b5PqiyGl24oCnszY2hjtSafx3ogrULH1wfVpX3NAIC1JZumzWNI0CvyL2vuXANh0E5//ic7dJuuPhOgxip5eVOqYO4UfmS5kvPtwT+gMGsuf6zmyIF4XYtYfcFVVUvkXjzLeYXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711203; c=relaxed/simple;
	bh=ZxLVVjNsnzSh6sdHnDEYU/AfC0EVdm5zrYlgO/bD0/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqFNdbAz8VScx5N9xyo/0chesm6cTB8IPGm7EfHIdhDUOA4HY6Sdq5LpiNfmGt1MrAAbcgynUjIHBR0ZomoFxj1NK3zuaMXA812ubWuGjmxx26GmDNqe+1nmZ1cxNz/vfzcUqkz3ecOUBFMHQDc8OJ58MIALCqZN2PVgQQS9q04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 872B760490; Mon, 20 Apr 2026 20:53:20 +0200 (CEST)
Date: Mon, 20 Apr 2026 20:53:19 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_compat: run checkentry() from .validate
Message-ID: <aeZ2H8ghe3Ddcn9u@strlen.de>
References: <20260420174227.13087-1-pablo@netfilter.org>
 <aeZoiqyPFP0NJkz9@strlen.de>
 <aeZpj9r368paudyZ@chamomile>
 <aeZunt0QSt2EdFdF@strlen.de>
 <aeZ0_GvXUnOJPSJ3@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeZ0_GvXUnOJPSJ3@chamomile>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12086-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:mid,netfilter.org:email]
X-Rspamd-Queue-Id: 773054331A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Your approach duplicates .checkentry in some way, you have to make
> sure what your .validate and .checkentry perform the same check, ie.
> they are in sync.

Thats why I updated the affected .checkentry functions to use
the validate functions internally -- to make sure the code is called
even for classic iptables.

> If this needs to be generalized further, maybe checkentry() needs to
> extended to improve integration with nftables.

I hope not.  But I don't care, if you prefer your patch then so be it.

I just find it sad we duplicate efforts all the time.

