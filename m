Return-Path: <netfilter-devel+bounces-11123-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGmWIx5csWmGtwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11123-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 13:12:14 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B7A263770
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 13:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50CEF30098B5
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7123D3DE42D;
	Wed, 11 Mar 2026 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="CuY+cg2h"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F33DEFF3
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2026 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231130; cv=none; b=MMdrGzKedIKVd8mCaMfe4mceUMmDRALtc3wMnw+zQ+G6Way5lA3m8/lIHblLlN2TKk0OxgjEpTyg7jbIoSXR1BOAZ4tL2l0corwBQOwmySbyl0OYBVzbNPEtAqDnWavCHxrl9kk0trdESm1hybU4yY/R7Bpo/e4Y1esA6lobwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231130; c=relaxed/simple;
	bh=Cm1jSPXiGkdfuKWDftaTiXAYjhcPUOmr5zFn9p1vMaA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAiFWbiGqikZZpgTPTM3JpfFBim5uCygvEWD5I1IYqDULZGT+Z2t99r5dS26/prCdZo9VYgtpr2NX8v2Kl4xzqD2D0YvHjVpaoWox9xDUPt6WVnQQFPewjtj7f/M039XP3K3v+vHfmOIT0XbVqNTfnHoQg/TcDXFzNjtdBYEhaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=CuY+cg2h; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 50BA16026D;
	Wed, 11 Mar 2026 13:11:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1773231119;
	bh=4OhCVtgRorD3RvCv0eC1ngRB3V5wgx16RLNo3eaLeL0=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=CuY+cg2hbSl+KMwYWYDdOeKYe5N9kd5+wXLRzqZFU8Z7JZb0PLeHJS9yerDJ5K4OS
	 5ix8ympQsHG980BRpQYLQu2f1qCnZueqATfnvEjAIOS9s4E3dDCv0Wk1rkdA+pFS5d
	 u0t5VfIjgoO3m+ypb5MXCXm0ze/XsiYEfSY0/Xq5sfoH3SqCnz/DXE1lpDFJfOSrhz
	 T0Ea5q+RvLy+Q9sHfgaObuGDqkSrMOJbcO8CFUHzQQidvEZxamRhOp431Ug95naevw
	 J7LQv9sLIPhios016eKND/CsxOTy/SlXUwkZsKCOVuBvmSkdnYIHInlYoD44TBJIe4
	 dz2tbfSZHKILg==
Date: Wed, 11 Mar 2026 13:11:56 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 2/5] cache: Respect family in all list commands
Message-ID: <abFcDNwnKzer7_r7@chamomile>
References: <20260310231115.25638-1-phil@nwl.cc>
 <20260310231115.25638-3-phil@nwl.cc>
 <abE3Q6E9eZEm4-DZ@chamomile>
 <abFBziaYqOenTfVt@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abFBziaYqOenTfVt@orbyte.nwl.cc>
X-Rspamd-Queue-Id: 36B7A263770
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11123-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 11:19:58AM +0100, Phil Sutter wrote:
> On Wed, Mar 11, 2026 at 10:34:59AM +0100, Pablo Neira Ayuso wrote:
> > On Wed, Mar 11, 2026 at 12:11:12AM +0100, Phil Sutter wrote:
> > > Some list commands did not set filter->list.family even if one was given
> > > on command line, fix this.
> > > 
> > 
> > Fixes: a1a6b0a5c3c4 ("cache: finer grain cache population for list commands")
> 
> Hmm. At that point, we didn't have 'filter' parameter in
> evaluate_cache_list(). Struct nft_cache_filter was introduced later, in
> commit 3f1d3912c3a6b ("cache: filter out tables that are not
> requested").
> 
> Assuming that Fixes: tags are used for semi-automated backporting (at
> least I do ;), pointing at that commit will cause trouble.

Good point.

Helping identify backporting in a semi-automated way is good,
specially for small fixes like this.

At least for me, it helps me identify if it is an
update/enhancement/feature or fix, it is just a bit more context
information.

> Do you still think we should add that tag?

I get your point that tags need to be right if we use them.

