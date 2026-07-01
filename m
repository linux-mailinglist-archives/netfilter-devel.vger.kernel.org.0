Return-Path: <netfilter-devel+bounces-13559-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aFptMCGhRGq0yAoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13559-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 07:09:53 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252C6E9C88
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 07:09:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13559-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13559-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C3AE3014432
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jul 2026 05:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB73352012;
	Wed,  1 Jul 2026 05:09:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873628504D;
	Wed,  1 Jul 2026 05:09:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782882588; cv=none; b=GMfYXLlCwodXdpPzvjms3WRf6JuZ4L4xTjAWqCfaBzoEM65VScA/PXz3T1DJEiQbkXB49CzRUfBTAh58Rxjj/tP4AXdJOIXMk7Beh/7jU3ggAt0aGO3miVIQY7tQvo3DOMP18WLC1la36CoFWyG2+HtwTRdB0tcbangyFpnmy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782882588; c=relaxed/simple;
	bh=YSsZg+c+BnNF1ejIYyeW42itqUAnXek/1ip1UwY7Hwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkOUcuZHgg500gA1vxDrfh8DmahgsFH9i0vXsV2eLyC+72Yv3qEdac837kBPRaEu4RRM2DeesMXnvp+D3Q6qt96H+8kzr3s2BHYlerUsxZ7HLPvyP4FTcry5mGaY9Zu3nywuWu0wqN4OLwT9nwJPSL+dYEQaFE0O6bzseNjMo5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 49B456038C; Wed, 01 Jul 2026 07:09:45 +0200 (CEST)
Date: Wed, 1 Jul 2026 07:09:44 +0200
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, kadlec@netfilter.org, xmei5@asu.edu
Subject: Re: [PATCH net 3/9] netfilter: ipset: fix race between dump and
 ip_set_list resize
Message-ID: <akShGOr3YKg1bs3r@strlen.de>
References: <20260630045243.2657-1-fw@strlen.de>
 <20260630045243.2657-4-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630045243.2657-4-fw@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-13559-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:kadlec@netfilter.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid,strlen.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2252C6E9C88

Florian Westphal <fw@strlen.de> wrote:
> From: Xiang Mei <xmei5@asu.edu>

Xiang, Jozsef, could you please have a look at

https://sashiko.dev/#/patchset/20260630045243.2657-1-fw%40strlen.de

AFAICS it's correct but should be handled in a followup patch rather
than a v2.

Thanks!

