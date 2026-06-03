Return-Path: <netfilter-devel+bounces-13041-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GfsmAHu7IGoR7QAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13041-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 01:40:43 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB6963BE30
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 01:40:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13041-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13041-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 224B33040C3D
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jun 2026 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A674657CF;
	Wed,  3 Jun 2026 23:40:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48E4028F1
	for <netfilter-devel@vger.kernel.org>; Wed,  3 Jun 2026 23:40:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530040; cv=none; b=htSQ7EhMTKgFeN7ZgboGV5fSL2rQbU7gtUQH+os1ru8MF5T0M3XjT9hpTlT7ZjNpo0sHiNOSk7Er8KHCQ7E937JNQm8rOipH9aLENYw7L9M9ZQHVguL4CGmOEYzoTrolYRIH+5LZIxkkL6RUF9S3MuLnA1RkVTPOn+zdHVtBbZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530040; c=relaxed/simple;
	bh=4eBleRyW+hhyZxxeRba9/TKg/4oYMDO4S6Ebe3GJyck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFvwysZM1348w3wFKIJgDZIas5z7pzIe/PupyCPz4Wr+MXMeN1iV2d+DGoaMi2oyIMulBAXq4UW772oBVZrRKH5A4r1FybkljCWav5F+T4rPkYZ2PJwLCUHHh75l3zbzcpCbx8aW7TaxdGLEBZW48eLPJ8Ud3Zf10fQ3Dj6KU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 591336078A; Thu, 04 Jun 2026 01:40:37 +0200 (CEST)
Date: Thu, 4 Jun 2026 01:40:36 +0200
From: Florian Westphal <fw@strlen.de>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
	pablo@netfilter.org, phil@nwl.cc, razor@blackwall.org,
	idosch@nvidia.com, stephen@networkplumber.org,
	sw@simonwunderlich.de, davem@davemloft.net, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	royenheart@gmail.com
Subject: Re: [PATCH nf v2 1/1] bridge: br_netfilter: move fake rtable off
 struct net_bridge
Message-ID: <aiC7dFYZpiEHZeyG@strlen.de>
References: <831936f111e6e1f435f4f6247d07fe6a6624d271.1779680014.git.royenheart@gmail.com>
 <ahagS3rGl2sG0OVS@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahagS3rGl2sG0OVS@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netfilter-devel@vger.kernel.org,m:bridge@lists.linux.dev,m:pablo@netfilter.org,m:phil@nwl.cc,m:razor@blackwall.org,m:idosch@nvidia.com,m:stephen@networkplumber.org,m:sw@simonwunderlich.de,m:davem@davemloft.net,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:royenheart@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-13041-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,netfilter.org,nwl.cc,blackwall.org,nvidia.com,networkplumber.org,simonwunderlich.de,davemloft.net,gmail.com,lzu.edu.cn];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,strlen.de:mid,strlen.de:from_mime,strlen.de:email,lzu.edu.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FB6963BE30

Florian Westphal <fw@strlen.de> wrote:
> Ren Wei <n05ec@lzu.edu.cn> wrote:
> > Use rt_dst_alloc() so the fake dst reuses the core IPv4 rtable
> > lifecycle, and release the bridge device reference during teardown via
> > dst_dev_put() before dropping the bridge-owned dst reference.
> 
> I think AI review is mostly correct:
> https://sashiko.dev/#/patchset/831936f111e6e1f435f4f6247d07fe6a6624d271.1779680014.git.royenheart%40gmail.com
> 
> - no need for constant refcount bump
> - I don't think the ipv4 specific functions can be used safely here.

Are you going to send a new version or should this be treated as
a bug report?

Thanks.

