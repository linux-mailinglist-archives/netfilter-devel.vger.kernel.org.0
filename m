Return-Path: <netfilter-devel+bounces-11117-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNAFIFo7sWkLswIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11117-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 10:52:26 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 531E1261507
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 10:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E8F930D0439
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2752D0610;
	Wed, 11 Mar 2026 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="OF2qH+og"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620028980F
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2026 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221928; cv=none; b=FOF8QPzW5tLqa1AnFwlpyYZjO2JgDlqKQ/S4WgjZtPFM5nQ4p+lM7a4HM1+fEWPtGzWoIWvCv2dMxKtuBYZABBcyKWCBCknLyQkokE/AS8BPjPx02ND6N28/+xlKrz3CA/jUeazLi0uitCeE6R4Mvyky4pSOsYDPPErQqYXPA9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221928; c=relaxed/simple;
	bh=8M4BJpaphTCW0L70AWE06tZUOWYafxDskdIIlXr0UMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpvvOV4DrYMa6hf1DkKEE1ILQoEljCbcyJy/L84JlzADT6OlrhmZ5IKT6AkAtRFVNcczN00V9kHbpgF7meaQI9laTQPC+SNSekxldXuTWWkL4MCii4ncnWA5/gI2o70zGYuHMQ6uulF6pH5un2YQWBXKEbm7v4DWw9G8LDdg598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=OF2qH+og; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 594CE602B4;
	Wed, 11 Mar 2026 10:38:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1773221925;
	bh=+0mGr2DHrueRMJ6WgXfPnjD2RUzyWMMC89pMe3yx5wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OF2qH+ogOQs1Jl+M9XQPsokcvdxHoYglUunlFH475QOIdeP67HbWUlvWmz8jL0xec
	 CwdOFmEcazEkG3Cgi0OVQp0x4tas91+jP6n9sSaZxHcqNRFxe+YHRM8mCldbvdBXZs
	 em1f0PRqrVWLmmoCO/AHxX4G0+wZ1C4fsUP3Xww7kDURXJ7QRWnEjlZ05vJcZY7AMQ
	 da4mqHB4rrL5gpyObzWfPxjHo4j/9Zk3RPRmDMUXtabMjRYWwo5m1uV+n9U/5vd5zc
	 rKQoPV7pJ/5etClkvny8s368sJLzThPQAbSJL4YMpDI+CKZGeAqef+NErDa4lidzcy
	 mEpKfWB1jkyBA==
Date: Wed, 11 Mar 2026 10:38:42 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 3/5] cache: Relax chain_cache_dump filter application
Message-ID: <abE4Ik-Qorwr471H@chamomile>
References: <20260310231115.25638-1-phil@nwl.cc>
 <20260310231115.25638-4-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310231115.25638-4-phil@nwl.cc>
X-Rspamd-Queue-Id: 531E1261507
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
	TAGGED_FROM(0.00)[bounces-11117-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nwl.cc:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 12:11:13AM +0100, Phil Sutter wrote:
> While populating chain cache, a filter was only effective if it limited
> fetching to both a table and a chain. Make it apply to 'list chains'
> command as well which at most specifies a family and table.
> 
> Since the code is OK with filter->list fields being NULL, merely check
> for filter to be non-NULL (which is the case if nft_cache_update() is
> called by nft_cmd_enoent_chain()).

Fixes: 17297d1acbbf ("cache: Filter chain list on kernel side")

> Signed-off-by: Phil Sutter <phil@nwl.cc>

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

