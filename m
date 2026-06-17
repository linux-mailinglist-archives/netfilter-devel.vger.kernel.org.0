Return-Path: <netfilter-devel+bounces-13308-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /YdaOizJMmr35QUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13308-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 18:19:56 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 703A369B56C
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 18:19:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=NQcHJhyj;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13308-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13308-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0351A3261905
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229E4A33F4;
	Wed, 17 Jun 2026 16:04:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BAC4A138C
	for <netfilter-devel@vger.kernel.org>; Wed, 17 Jun 2026 16:04:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712256; cv=none; b=Zd9MQyR85IBK1C/SJhrZLHLpj+RxDTWLWji7y4v4rnpqLi9bCPTzL4x+fhiHzEzaAAuNfRtV36RnobxSBQk84KV3elrq+kyFNcZliT3kUeHhH3WlVXfd1HX6JIOgbu9ztPF0ITM73YPaeusSBLKaFzna9yOviy1MuPNflioQNmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712256; c=relaxed/simple;
	bh=MFjSA0yPCcHT7tjVdjRL7Mgp9pHtw/6Wgx003V4MGQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqSbHBX2vNO1bWqgAsMGYC3IKO+josKsYeeuNGEiThCoEaZ/EYF4SZz5HMesN6bOev7bbylbIu8nX5en868FypJoqFE96F3ZXEhCSiZJICskI3HO2FYvjqKssi59GRlOugt530/StlqxZwJ8f5k53C3qtEAQjs47mLJ7Rjm3gvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=NQcHJhyj; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yWqxQAmw1t2L2FC2XKXfYxcOUPreMOsKTxTabzBJ+DA=; b=NQcHJhyjFEZlSrZ0RelSkhpPCk
	M431da0KNQ0ALWo2g0i6RqXy0GJUBK9I7nI5VZdRJHoxbQZZbc5t5r+XmX/rBk7gzdvot3uyodnwG
	yCezvlj0pAuC3XnkZ6bMQ5jgtMznn3ZeMbDQ7vc9SHJYR6rTkx+XRqju6/si0YVCZvBcapV5ifMNE
	D9vfx1i8RCPaD424/zr8QvABWPiRDY1zUwE3SQn6zfgUCToEQIv9KLJEVo3k/ki4t1qLnXuY5kmDQ
	i9RYAKfl37JWggkZGRT12M0Sa/YLd5pnTOqMMYh/Jra8vPcEdoIVw2VBbJj1yplxpg9own463og8q
	PEFXTEcA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1wZsk7-000000002nP-2AmE;
	Wed, 17 Jun 2026 18:03:55 +0200
Date: Wed, 17 Jun 2026 18:03:55 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] intervals: Fix for inconsistent union field use
Message-ID: <ajLFa6v1_aM6ItH8@orbyte.nwl.cc>
References: <20260603184715.1366533-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603184715.1366533-1-phil@nwl.cc>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[nwl.cc];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13308-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[nwl.cc:-];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,orbyte.nwl.cc:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 703A369B56C

On Wed, Jun 03, 2026 at 08:47:15PM +0200, Phil Sutter wrote:
> Reported by a static code analyzer: key->value belongs to a different
> struct in the embedded anonymous union than key->range.* which is
> accessed elsewhere in that function.
> 
> It is correct in that the function asserts key->etype to be
> EXPR_RANGE_VALUE, so key->value is not necessarily valid (it just
> happens to match key->range.low's offset.
> 
> Fixes: 91dc281a82ea6 ("src: rework singleton interval transformation to reduce memory consumption")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.

