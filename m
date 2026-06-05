Return-Path: <netfilter-devel+bounces-13074-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m1oqGTbhImr3egEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13074-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 16:46:14 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1A9648F61
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 16:46:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13074-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13074-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A8D23086146
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jun 2026 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91913BB101;
	Fri,  5 Jun 2026 14:40:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EFE3BB685
	for <netfilter-devel@vger.kernel.org>; Fri,  5 Jun 2026 14:40:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670450; cv=none; b=e65t4/6AbosxdQU/yjxMK9t+j+bnb94e923yjaSixji/Zg87z0SWgnpF4+qJ7c5OgUR1KQGhKm1TDaFvtL6hYeT6CGTE30LbbZyq0Yru7d7uediSUdXxgdl6ywO6NzDd7huKelWyHNoXXg5nJUHwmuQS0Ape3ba3bqPzAWdgS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670450; c=relaxed/simple;
	bh=jgSqkBg44ONBcw0ms+VJvUkkgo7BVULZPod8TvbshtM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdlkItWOfA92k4io/L03waB/AbUHYsBGqFmpaqIPHF7dTKs8wP32Uh1oI2kKBzFEWn3sBdkR/7hRaXxHhQPEzP+rZV24norNwZeWTtgCgVFUh8M/We1k+YEVWYOejkZn6ZH1FV8z3bn3NahdIC0KMJLDSUXlqsSmLr+AcBsILrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 33AA160425; Fri, 05 Jun 2026 16:40:46 +0200 (CEST)
Date: Fri, 5 Jun 2026 16:40:43 +0200
From: Florian Westphal <fw@strlen.de>
To: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v4 2/5] netfilter: nf_conncount: use per
 nf_conncount_data spinlocks
Message-ID: <aiLf6wZh7GXBt0cd@strlen.de>
References: <20260605131123.19435-1-fw@strlen.de>
 <20260605131123.19435-3-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605131123.19435-3-fw@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13074-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid,strlen.de:from_mime,strlen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA1A9648F61

Florian Westphal <fw@strlen.de> wrote:
> -	data = kmalloc_obj(*data);
> +	data = kvzalloc_obj(*data);

AI suggest to add GFP_KERNEL_ACCOUNT here, but I don't plan to send
a new version just for this (it would likely only trigger more
goal-post-change comments).

The other comment in patch 5 is largely academic and not really
and issue.

