Return-Path: <netfilter-devel+bounces-11211-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ix2HN05ftmnWAwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11211-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Mar 2026 08:27:10 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F77290290
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Mar 2026 08:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDA71300442F
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Mar 2026 07:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8997D1ACEDE;
	Sun, 15 Mar 2026 07:27:04 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD1778C9C
	for <netfilter-devel@vger.kernel.org>; Sun, 15 Mar 2026 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773559624; cv=none; b=Nw4Gj/mnvDa1cBhkKI/9RLNI6TC7ZH0i/7DCjQWghErkojO9fVd+hryuHzkPktU78ZACusibLENj4ZAYmsKzPgTfORIInIQpkhsQxgEa2IbEjy+yoqi/Oalxq7jsCgd/Ggo4s3rtUh6L0pS187KVGtm63mMMsZWZbJGyA/9Ea1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773559624; c=relaxed/simple;
	bh=9UoUYeCa7EyN1Gw2XyYclPrYJZsdHIByOuWlu3zeyXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju4m8jfRU999bL+qiTDj5TWSjbbUK7pLI+L8VMHofWia6+9HayjLlEbkd3FWQgTczf31hzqMJF2DnAYNVWf7krys9rAWE92kw5Vz84ozjMI9yWovP7LAo6vAPRaybXaDnZy6QVB35W/SQs0TRBWDq72qFGQMb8a84shQ92I7I/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 50BEB6080C; Sun, 15 Mar 2026 08:26:54 +0100 (CET)
Date: Sun, 15 Mar 2026 08:26:53 +0100
From: Florian Westphal <fw@strlen.de>
To: Guanni Qu <qguanni@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@netfilter.org,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nf_nat_sip: validate exp->dir in
 nf_nat_sip_expected()
Message-ID: <abZfPZvV1lpmLW89@strlen.de>
References: <20260313201346.562476-1-qguanni@gmail.com>
 <abSelah2hPOUbEng@strlen.de>
 <abVLg641YYZ6TlvM@chamomile>
 <CAFzOa17xzzjC6U7rC647kA-mT9FTMvX+V1Tc7isxeaP4+P5oww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFzOa17xzzjC6U7rC647kA-mT9FTMvX+V1Tc7isxeaP4+P5oww@mail.gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11211-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31F77290290
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guanni Qu <qguanni@gmail.com> wrote:
> Hi Florian, Pablo,
> 
> You're right, the root cause is the missing ctnetlink validation
> that Florian's patch fixes. I hit this crash while testing SIP NAT
> with crafted expectations via ctnetlink, which is how exp->dir
> ended up out of range.

Thanks for confirming, I'll drop it from pachwork.

