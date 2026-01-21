Return-Path: <netfilter-devel+bounces-10367-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNJzLAULcWmPcQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10367-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 18:21:09 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 371835A73A
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 18:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CEDF7E3D4D
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176BD449ECF;
	Wed, 21 Jan 2026 16:04:18 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7E3ECBC4
	for <netfilter-devel@vger.kernel.org>; Wed, 21 Jan 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011458; cv=none; b=iBw6t5mUOkgb0vMamJPuq4ThD6T5kJDWez1m3kMsJaxicWc2cimQZ4qgjEF+1OtMzQXWV/RyEaD6RIVzj1Ry+jD5EZz+XUfjuicA+mSO8LDGRCO/rlpl+GHZIq6Upmyh2yjKyYG3hpHnme+FhAMDXxNvbq++I8GDdPBPgIXf9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011458; c=relaxed/simple;
	bh=00nnYyjbbcH7nqzimPnexzOUXPjQhm3Vr6q9pxjER2Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPzoZDk5xLKWmfWLz2jg4CNBr18W4AR5lHbOrVgG/W4hu2r4vvJF/1/SfdhOsVJ5DvzdYqg2q0DQ3JF7RcpYQUIIcgTdM4/jbcIShcJgMNDEIJZ0l1ex3s4xN9VHuiZko8xvxvoRkWkfL2P1n2DZPtMxcU3SqkxjAykR6uLxnYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6A488604E3; Wed, 21 Jan 2026 17:04:13 +0100 (CET)
Date: Wed, 21 Jan 2026 17:04:13 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] monitor: fix memleak in setelem cb
Message-ID: <aXD4_Ye_KaOJgywb@strlen.de>
References: <20260121133917.11734-1-fw@strlen.de>
 <aXD4dVwPHZHGhhrh@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXD4dVwPHZHGhhrh@orbyte.nwl.cc>
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10367-lists,netfilter-devel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 371835A73A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Phil Sutter <phil@nwl.cc> wrote:
> On Wed, Jan 21, 2026 at 02:39:08PM +0100, Florian Westphal wrote:
> > since 4521732ebbf3 ("monitor: missing cache and set handle initialization")
> > these fields are initied via handle_merge(), so don't clear them in
> > the json output case.  Fixes:
> > 
> > ==31877==ERROR: LeakSanitizer: detected memory leaks
> > Direct leak of 16 byte(s) in 2 object(s) allocated from:
> >  #0 0x7f0cb9f29d4b in strdup asan/asan_interceptors.cpp:593
> >  #1 0x7f0cb9b584fd in xstrdup src/utils.c:80
> >  #2 0x7f0cb9b355b3 in handle_merge src/rule.c:127
> >  #3 0x7f0cb9ae12b8 in netlink_events_setelem_cb src/monitor.c:457
> > 
> > Seen when running tests/monitor with asan enabled.
> > 
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> Looks like a fix of commit 4521732ebbf34 ("monitor: missing cache and
> set handle initialization")?

Yes

