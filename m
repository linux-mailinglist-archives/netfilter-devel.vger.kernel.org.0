Return-Path: <netfilter-devel+bounces-11321-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHltJyAxvWmI7QIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11321-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:36:00 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A65F2D9AD9
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59B5530911E6
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9539438A72C;
	Fri, 20 Mar 2026 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="LgFtUJs9"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E153A758A
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006327; cv=none; b=A/adi6+TJU47wQa4Sfk8eN7aPFdifBMnU2y00I53TOhWx77lkmMkhviQTkpulJRQNys+q6jRMvPfxAltRstXlv5ysWLeFlb2hNYFqNa9GIlcLhfeTPzfPmwDZScp0HoZo2fCoHlqlnbcWjXDADa3kz+0t0WjZDfflJylJYlBex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006327; c=relaxed/simple;
	bh=g5MG+PQkXNFON71VGH27JrUuBXliZLMnjqXRiGnTPgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFeNTEtxDS6+ZPozEEflTW+tnQ0L0uDHCny68UPkHeqdEljwDqmJ2h7vw7MOSTO3yRO32QvC9eAXzI9M1Hn19pY5kSvhe5MyPHA6C/va2LdEyjdIsVbFaoZN11EhNb6XOeXcC3lSIfIxEXbkmgpceXlvCgqbAlyHRZPeLMX+fF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=LgFtUJs9; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+gipUmcqHyefpKDXlyJweQhlbuaXl3xMNl4t1k98d2s=; b=LgFtUJs90k/Y3JiLqUOyi4bX7V
	VVk7gtvFUcd+0oLmti+5Lh8DrORXZepjGHF2dveJ19QUuzTdR9Do52geiAp3hGif9avNAEFJnisxj
	hGlhPeDyQL7+tNQBXqSadBWh76VVrSJ9In/3caI1TZZHUqB5yNYlT2TyBjiM5zbwYum8OnhqrVot0
	MjK+hUylxEKXNUlim+Az4STaD1NJe9vgTHDiJhm+oLQ0u8FQPZZWkCh0R3qtLrwJoewAAvPuXlDxL
	a/GmXAvMYVzSS+qdtJgWI4qSOCUbjf1bV0Z1zpabWTmbhi3Y7E3DZhep98N+p4S7CD5R/UJls3xJA
	iAPbgnGw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w3Y5E-0000000074w-1xAi;
	Fri, 20 Mar 2026 12:32:04 +0100
Date: Fri, 20 Mar 2026 12:32:04 +0100
From: Phil Sutter <phil@nwl.cc>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Daniel Winship <danw@redhat.com>
Subject: Re: [nft PATCH] segtree: Fix for variable-sized object may not be
 initialized
Message-ID: <ab0wNFdmoeeaV9Rs@orbyte.nwl.cc>
References: <20260319133208.19823-1-phil@nwl.cc>
 <ab0sc0AmGcDZjnHh@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0sc0AmGcDZjnHh@strlen.de>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11321-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	DKIM_TRACE(0.00)[nwl.cc:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.083];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1A65F2D9AD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:16:17PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Seen with gcc-11.5.0 on an aarch64 machine, build failed. Looking at the
> > code, r1len (or r1->len, actually) really seems variable. So use
> > memset() and fix build for that older compiler version at least.
> 
> Thanks for fixing this.
> 
> Acked-by: Florian Westphal <fw@strlen.de>

Patch applied, thanks for your review!

