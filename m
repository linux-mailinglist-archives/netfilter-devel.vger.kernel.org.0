Return-Path: <netfilter-devel+bounces-11347-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN5DJmpovWnL9gIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11347-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 16:31:54 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB312DCB26
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 16:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26882303E2C9
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 15:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DF53C942C;
	Fri, 20 Mar 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="i9+cFMQj"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBFE3C873A
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020704; cv=none; b=cXu88Ho4ZDO//NSARlPAO2GkRt9hw75k9zkSWlmqVqWdxPdl92z+H7e92jbea3Vq8byPXcqxtD8YNmeHS4R7L0F8G+pSZvxRJzzmaXxIHuXUTiKaQoCMg4wwHDN8nHfTYLoWMwKyU1Bi/LNklhYAZ8aL2wXl/IsnohkQJdXif68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020704; c=relaxed/simple;
	bh=9DQJvW5mPEp1myMusXEznI8ym+tsHjy48Sk+kj4u2yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMET28HEkdM5JxvgNquv/LjtH2RTyup8lKbHSqjowAJqN/3mS5BTRXT8uEAKb9Sek7W9hCUcKikvvXhIjSCGkHq73AlO+dfGZXxqs33r9XNy7mWHirmCLc5tGl4hgOpd2juK/SF2KbsGpdpOHr/1cEge3m1HNu1PQXai0XAHUVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=i9+cFMQj; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zgovTtorn9BaE/w6o5m0BDCgUp4Cj9L9fsbmWo6PgYI=; b=i9+cFMQjbtxk2n0CW5Wx1znaE7
	GaJvIM4esdHdiZ19QzjosQz1R1X8ik11JSdh8GThklpE2DPn1MUR0aeijwl6/8h7BnGRqfdmS0iY3
	rFmQ47FObGx/qKrvqpmuZoLwzMvmt1vlBjiC2dxC6qS3B8ezVWh/nUzF5v2GzzpaQfcVcAiD+JkdK
	oJXAqmyx2GoHiWGDPnkVR8TNrbUrFf+PlmuOW5cUb5kmhJvjWaT1AE6542G1SUsl2busNv3ENTnqi
	QwsefDoPdYlXm4w5lvob419zXqspPIV9C0NkZrCa4e4P88Q8jNa8t6UcprHFCJ/cTXyFUUYVnHIV5
	6MIpSDOg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w3bp7-000000002BN-24YM;
	Fri, 20 Mar 2026 16:31:41 +0100
Date: Fri, 20 Mar 2026 16:31:41 +0100
From: Phil Sutter <phil@nwl.cc>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] mnl: Fix ordering of hooks in 'list hooks' output
Message-ID: <ab1oXc7FPvOUWGhb@orbyte.nwl.cc>
References: <20260320151625.5318-1-phil@nwl.cc>
 <ab1mBgSjDyCs5aZC@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1mBgSjDyCs5aZC@strlen.de>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11347-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_SPAM(0.00)[0.199];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nwl.cc:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: EEB312DCB26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:21:42PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Hooks with same family, basehook and priority were inadvertently
> > inserted into the list in reverse ordering, fix that.
> 
> Right, just push this out.

Patch applied.

