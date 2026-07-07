Return-Path: <netfilter-devel+bounces-13692-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BKPsEg8OTWo5uQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13692-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 16:32:47 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEEC71CA8C
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 16:32:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b="Y7VY/bnp";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13692-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13692-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 215F33101984
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Jul 2026 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779F44229AE;
	Tue,  7 Jul 2026 14:16:09 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CE42314A
	for <netfilter-devel@vger.kernel.org>; Tue,  7 Jul 2026 14:16:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433769; cv=none; b=Pwd3huNPQU80cqG8Rw8IPQigAQsIfeGpnE7Z4cbZXaysO2bj0lVXd4HI2fF6c5dWghENbtJYay8VZC+ZlQr6YWzCWXtvxCaHglMHbR946yZk5X9LiqpYCXhV4s1Zc4yM8mqaYbx4KD5kF5T88RSOp987S4XTmaTTGD48qyP0Dm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433769; c=relaxed/simple;
	bh=HMvXTewk34QsdjmyjVlR3zGuOZkgzgyjyoUxXYtKLgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlZVKd7/6XQexU5nq/B5CqforNs1szZ1GGF2T7hurKLRZaAnACuvMM8L8x3bjyl54SpfCfsmHgxXXRfwIjHzHKfDebMSE0jsMv9WpDC/SsODk9BeJ4xmWql/BwboVQU3F4bJ/RahGjbb4iMM0hg/54lVumWVf1NQkRK4JskkC84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Y7VY/bnp; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 9CACD60577;
	Tue,  7 Jul 2026 16:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783433764;
	bh=Oys78aXhyImAMTFuC/BnSM5ZKfmKeImYGz6ni3EF0V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7VY/bnpuQEERlFbmPaA/yC2VKyQ6KH31n1hDtJozh+CSZajeciK7JxnJ04Fkmy1r
	 2vRRB5i9R8keDMoa9p/mzBPodWuFbCJYNXi5IA619CbyIHnJwGLiwY1TRV3IXdlwYF
	 OpQ2h1mK450KnlwlhJJ/yShjL1wcxVMWM/HPXuZpGDya8eL5cJY4uGRA3YSBrbQzDY
	 r5Y5DzXNWe35uIFknV3dzI2Y4hWzVCMTKJyJWyDt5Q7qtft0O+87yibK/cWp250sil
	 9TNI7mJSVMciMpJYoy7ZGpjwzqUchcpexuWRkbTqEhMBS0fLpJ96qC8jsRLQoDP10v
	 mtdsO/K0BmKow==
Date: Tue, 7 Jul 2026 16:16:01 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 2/2] tests: shell: expand get command test with open
 intervals
Message-ID: <ak0KITUOuYAXYm5v@chamomile>
References: <20260702123634.349861-1-pablo@netfilter.org>
 <20260702123634.349861-2-pablo@netfilter.org>
 <akz-fH24aKQbjaHm@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akz-fH24aKQbjaHm@orbyte.nwl.cc>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13692-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netfilter.org:from_mime,netfilter.org:url,netfilter.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABEEC71CA8C

Hi Phil,

On Tue, Jul 07, 2026 at 03:26:20PM +0200, Phil Sutter wrote:
> Hi Pablo,
> On Thu, Jul 02, 2026 at 02:36:34PM +0200, Pablo Neira Ayuso wrote:
> > Extend the existing test to cover get commands with open internals.
> 
> This test fails on a Big Endian testing machine running Fedora Rawhide
> running 7.2.0-0.rc2.21.fc45. Does this perhaps test a recent kernel fix
> or something?

Does this kernel contain this kernel fix?

https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git/commit/?id=d63611cbe8af99dd61b118ee6e5b5e3e518250b2

as well as this userspace fix:

https://git.netfilter.org/nftables/commit/?id=4eafc1a2a9ef5a827b1b4e58cb3b2832d2eb1650

> Here's the test output for reference:
> 
> | W: [FAILED]     1/1 testcases/sets/0034get_element_0
> | Command: testcases/sets/0034get_element_0 
> | Error: Could not process rule: No such file or directory
> | get element ip t s { 11 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^
> | Error: Could not process rule: No such file or directory
> | get element ip t s { 15-18 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | Error: Could not process rule: Too many open files
> | get element ip t s { 60000-65534 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | ERROR: asked for '60000-65534' in set s, expecting '60000-65535' but got
> | ''
> | Error: Could not process rule: Too many open files
> | get element ip t s { 60001-65534 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | ERROR: asked for '60001-65534' in set s, expecting '60000-65535' but got
> | ''
> | Error: Could not process rule: Too many open files
> | get element ip t s { 22-24, 60000-65534 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | ERROR: asked for '22-24, 60000-65534' in set s, expecting '20-30,
> | 60000-65535' but got ''
> | Error: Could not process rule: Too many open files
> | get element ip t s { 22-24, 60001-65534 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | ERROR: asked for '22-24, 60001-65534' in set s, expecting '20-30,
> | 60000-65535' but got ''
> | Error: Could not process rule: Too many open files
> | get element ip t s { 60001-65534, 10 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | ERROR: asked for '60001-65534, 10' in set s, expecting '60000-65535, 10'
> | but got ''
> | Error: Could not process rule: No such file or directory
> | get element ip t s { 10-40 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | Error: Could not process rule: No such file or directory
> | get element ip t s { 10-20 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | Error: Could not process rule: No such file or directory
> | get element ip t s { 10-25 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | Error: Could not process rule: No such file or directory
> | get element ip t s { 25-55 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | Error: Could not process rule: No such file or directory
> | get element ip t ips { 10.0.0.2 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | Error: Could not process rule: No such file or directory
> | get element ip t cs { 10.0.0.1 . 23 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> | Error: Could not process rule: No such file or directory
> | get element ip t cs { 10.0.0.2 . 22 }
> | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Cheers, Phil

