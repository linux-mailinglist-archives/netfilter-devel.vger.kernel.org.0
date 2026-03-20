Return-Path: <netfilter-devel+bounces-11343-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFNVJRFOvWlr8gIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11343-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 14:39:29 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 875152DB18B
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2375300C6F6
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AE32857FA;
	Fri, 20 Mar 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="JbJky/uh"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EFC284B3B
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013964; cv=none; b=NDzGR0XAR+cxhPzdGozaA2tgym5ndBfSofzbeA2G69x0eLQwZBnfNQJnhOanPxuDbhKzqPp62GD93511g1XRMYW8CpzJCCIa0Cg4jZM8evnjkcPR7ibnLhyCQJTB1RLbAMrWaMyKEldrCg/gAvNqPNG05n6il6qQjtUSqq94NZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013964; c=relaxed/simple;
	bh=axu1EzvSPfcxCusL6O9E2dEwTXMrnYqN2KQGnWv7+K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRCeANOvTS3NCpL2JP4AK/3eoKehsxn9LjQ7gTZ1QCMu8R/EsUt3ygyHbbOTmeu3H2FqvC40Xj6S3cctjGC2rZY7ApcORYDPo/xIm4jGj3vgJlTN8sndUqJF2uDxUOXyp+xafElGNGSPSL1NySTM+qdtrDL3RXYoucbnR2g38Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=JbJky/uh; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZZN6ZTLR+J+fmWXXEmC5jc8UcQz2GEXEOBvK+ZECKfU=; b=JbJky/uhVBCxa2tdNchtfXk0Gn
	+F2psx6ZqvhHWVH0DkepCQTi/w/IGgKnV09UqcisysM5VVDQWy4ClIFdrjH8bfzbHBV9hRt8GU3/x
	L97oOMcdX2zoMGVV2KPUApFnIQx1Myd/xJYu04Utcuwu10LG0IQ0LymyTfBGvkmBVNXTaNl2hoZjP
	uageavouodQng7ZegtxhSC37RzJWLukDaBYxbq5ZjTBeSaIAnEcV6St3BfiyD03jtXxEtm2o1N0sQ
	DXPR3rMJ5EqO1NV1HtYH0nBENeErFW/iPbVYU87KypjF+iDr0LQiwwSzv9aJNJSs2aYePhTEcH2SV
	0BzbCGtg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w3a4I-000000000VZ-1T2O;
	Fri, 20 Mar 2026 14:39:14 +0100
Date: Fri, 20 Mar 2026 14:39:14 +0100
From: Phil Sutter <phil@nwl.cc>
To: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [ipset PATCH] tests: Fix for standalone calls to
 setlist_resize.sh
Message-ID: <ab1OAvr0r7eQbTsn@orbyte.nwl.cc>
References: <20250722153205.4626-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722153205.4626-1-phil@nwl.cc>
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11343-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.130];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: 875152DB18B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jul 22, 2025 at 05:32:05PM +0200, Phil Sutter wrote:
> If called without ip_set.ko loaded, the unconditional 'rmmod ip_set' at
> startup will fail and the previous 'set -e' makes that fatal.
> 
> Fixes: ed47b815a0d2c ("tests: add namespace test and take into account delayed set removal at module remove")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.

