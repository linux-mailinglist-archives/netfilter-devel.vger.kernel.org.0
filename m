Return-Path: <netfilter-devel+bounces-13693-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GzNsC9MYTWozvAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13693-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 17:18:43 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F1A71D2D4
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 17:18:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=jlOHxXCx;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13693-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13693-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94FAA3028033
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Jul 2026 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF0D31077A;
	Tue,  7 Jul 2026 14:49:59 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7322F12CDBE
	for <netfilter-devel@vger.kernel.org>; Tue,  7 Jul 2026 14:49:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435799; cv=none; b=o1pX+Z9JLzFwVGey7s4ueyE9EwhRz8OhsBHaYv15/uoaKClvyqHxhZ7/a99V6fQaXVXQPkDeF+674IM3FkUQ5FTVc16QAL/+M0i87GZKpjTPUbRi5WWtmbaUlEzrBQetM7jsCgmHLqLu9NdwvayvWtmStqUToD0mkrnHKOPJ6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435799; c=relaxed/simple;
	bh=MH3XDG3yMn509sxtRVGzWhUohZUIqI66PGbH6qvu6nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcEAHgUlZznIqY+u/AwZdCmyCDZEbTSWQkgRSzl8wcPie8v4/gxtDZXRJRH3o3z174qq4+TgRQAAL4YSEyfiRnFS8shKGieyR+7UllE8BU2M3JBK5twmooKV79S7h1k7Dl62Gbo1PiXX8zg/EnzC0FutSivNwiK6Hf6b9pY48oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=jlOHxXCx; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=V8RONei49XuW+pG3nPA3nEQSp6UOlpl341CHGBHq87o=; b=jlOHxXCx8AZ0vbZ+8BOkBujfYx
	CSXEFE7ObyYXLilbHpf/e2ek5gXmhp76vKehSyDxRbJw52JmRQ9wRHGhSotz1YTzFhkJtS/NBVkJL
	8R2xUbv/GeQorPcvBAC725axKhXWUzmqGq+8MoVvZcYlcUBJ4gh/uWHwchF4acWqrFVtNxTaVQ257
	a8s99tZOpEkx2wau33spTHUgvjmo13SmxEQRVMEdIGcCb+45VmzP4ZGw2ebZHdDaK0TIzogrNjMbQ
	iqYPDP0gWx/3iykvadx33k39jKqXIkLC45RHQUV6sQF878hXW6XmC48rPZa+C34dyY0aF+2bDHxCe
	5BjqLGqA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1wh77T-00000000488-2C0I;
	Tue, 07 Jul 2026 16:49:55 +0200
Date: Tue, 7 Jul 2026 16:49:55 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 2/2] tests: shell: expand get command test with open
 intervals
Message-ID: <ak0SE7hrYpUdxjVK@orbyte.nwl.cc>
References: <20260702123634.349861-1-pablo@netfilter.org>
 <20260702123634.349861-2-pablo@netfilter.org>
 <akz-fH24aKQbjaHm@orbyte.nwl.cc>
 <ak0KITUOuYAXYm5v@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak0KITUOuYAXYm5v@chamomile>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[nwl.cc];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13693-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64F1A71D2D4

On Tue, Jul 07, 2026 at 04:16:01PM +0200, Pablo Neira Ayuso wrote:
> Hi Phil,
> 
> On Tue, Jul 07, 2026 at 03:26:20PM +0200, Phil Sutter wrote:
> > Hi Pablo,
> > On Thu, Jul 02, 2026 at 02:36:34PM +0200, Pablo Neira Ayuso wrote:
> > > Extend the existing test to cover get commands with open internals.
> > 
> > This test fails on a Big Endian testing machine running Fedora Rawhide
> > running 7.2.0-0.rc2.21.fc45. Does this perhaps test a recent kernel fix
> > or something?
> 
> Does this kernel contain this kernel fix?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git/commit/?id=d63611cbe8af99dd61b118ee6e5b5e3e518250b2

Ah, thanks for the pointer. Rawhide kernels are "best effort" by early
rebase vs. excessive backporting, so a fix in nf.git must be rather
critical to hit it before linus.git.

> as well as this userspace fix:
> 
> https://git.netfilter.org/nftables/commit/?id=4eafc1a2a9ef5a827b1b4e58cb3b2832d2eb1650

Yes, this is present. To give you a bit of context: I have a script
which builds current upstream HEAD of iptables, nftables and
dependencies on a fresh Rawhide for running the test suites. I reserve a
RH-internal Big Endian machine (s390x VM) for it. The goal is to detect
Big Endian breakers early.

Thanks for clarifying!

Cheers, Phil

