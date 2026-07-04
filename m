Return-Path: <netfilter-devel+bounces-13641-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y/TbKuOnSGpUsQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13641-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 04 Jul 2026 08:27:47 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19778706DD3
	for <lists+netfilter-devel@lfdr.de>; Sat, 04 Jul 2026 08:27:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13641-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13641-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D3113013A89
	for <lists+netfilter-devel@lfdr.de>; Sat,  4 Jul 2026 06:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD038422F;
	Sat,  4 Jul 2026 06:27:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996EB672
	for <netfilter-devel@vger.kernel.org>; Sat,  4 Jul 2026 06:27:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783146465; cv=none; b=hKWFME6WVW24R8ed3le/DN4o9pN1f2iGiL8PeF+FUBOmdShYp2QOkpkjlZPKoUvU+AviP+Cq+iLbTTnIXZTahpy3Ur8WoBqYxnGeZ2lYZV5ms4jU9yqTJHY+lXEekC96I3IxfqSEXNS9STg243PhdlbuYUt3drYrN+RTo1USstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783146465; c=relaxed/simple;
	bh=z4rr8jPxKwPxFdmNgsQaLFvsfffM4Q4x/+oBiUBg600=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f328D0VNp7OnRvVg8FlaI/dvvTQtRkbzfjnTQia5gUpcKQgEsa3M2/cHuWzA/K4l4PmJvh7+hSEc3RvKFvya41iEb7bb7VnPabF2cSmVVeB3QTmygpkfgS+A5pzL+6HTIUm0Ukb321iTieshVFRLuancuSKraBvteLDiGVZUjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D0EEC6038C; Sat, 04 Jul 2026 08:27:34 +0200 (CEST)
Date: Sat, 4 Jul 2026 08:27:30 +0200
From: Florian Westphal <fw@strlen.de>
To: Haoze Xie <royenheart@gmail.com>
Cc: pablo@netfilter.org, phil@nwl.cc, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	netfilter-devel@vger.kernel.org, Ren Wei <n05ec@lzu.edu.cn>
Subject: Re: [PATCH nf v5 1/1] bridge: br_netfilter: pin bridge device while
 NFQUEUE holds fake dst
Message-ID: <akin0oTJJ47AL432@strlen.de>
References: <cb8bfe944f4afa8cec437fc15210a3d094612859.1780803571.git.royenheart@gmail.com>
 <53245eb5-baac-4e04-a632-1b722ea18972@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53245eb5-baac-4e04-a632-1b722ea18972@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13641-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:royenheart@gmail.com,m:pablo@netfilter.org,m:phil@nwl.cc,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:netfilter-devel@vger.kernel.org,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,nwl.cc,gmail.com,lzu.edu.cn,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,strlen.de:mid,strlen.de:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19778706DD3

Haoze Xie <royenheart@gmail.com> wrote:
> > --- a/net/netfilter/nfnetlink_queue.c
> > +++ b/net/netfilter/nfnetlink_queue.c
> > @@ -1214,6 +1214,9 @@ dev_cmp(struct nf_queue_entry *entry, unsigned long ifindex)
> >  
> >  	if (physinif == ifindex || physoutif == ifindex)
> >  		return 1;
> > +
> > +	if (entry->bridge_dev && entry->bridge_dev->ifindex == ifindex)
> > +		return 1;
> >  #endif
> >  	if (entry->skb_dev && entry->skb_dev->ifindex == ifindex)
> >  		return 1;
> 
> Hi, is there any follow up about this patch?

What do you mean, can you elaborate?

What is wrong with

c9c9b37f8c55 ("netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst")

If the patch is not sufficient, please submit a followup.

