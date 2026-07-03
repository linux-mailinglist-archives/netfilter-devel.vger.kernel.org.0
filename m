Return-Path: <netfilter-devel+bounces-13615-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NmnRDK6QR2oibQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13615-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 12:36:30 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A714870145C
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 12:36:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13615-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13615-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99A953016511
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jul 2026 10:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471BF3B7B96;
	Fri,  3 Jul 2026 10:29:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691C3A9D8F
	for <netfilter-devel@vger.kernel.org>; Fri,  3 Jul 2026 10:29:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074559; cv=none; b=EhN6XsgWrb6tsqSDMvCjIzBYupYGU1NkYUIQy+mgY27++gwHeM+2YNqYaBNRHpW/Bw99KWIdhG2zRCVydi+EfYl0neaowA6wbFt6Vmyx4ww7WWLSzzMb12kUCXB1QpL3J21236YkVAnxsj9lPbsR48XLUN8KgSdTuLHDFWlP4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074559; c=relaxed/simple;
	bh=4SFVnWQVJRw92MWVI6UNNBsae0bEkX1v+IVFdSaav2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBAll0ZFEtt6Hkdi/IMmbtodejE1vM+MhN/ZlFIXkLYNmdAyxBakvTgVRkhOjjxQFE2ysq+6bt+LYYyOPmSKO+B1/yZhTXi0mFmsey8uJs48nJQZ6c5d8A1OWl0vw71sdsU3vsw0pZi8gGrs+wqW/9pPBJxprR1xl2CotgBWuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C59FB602A9; Fri, 03 Jul 2026 12:29:14 +0200 (CEST)
Date: Fri, 3 Jul 2026 12:29:14 +0200
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Ren Wei <enjou1224z@gmail.com>, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, yuantan098@gmail.com,
	dstsmallbird@foxmail.com, chzhengyang2023@lzu.edu.cn
Subject: Re: [PATCH nf 1/1] netfilter: xt_time: reject pre-epoch calendar
 matching
Message-ID: <akeO-v0H9QP1psep@strlen.de>
References: <cover.1782879547.git.chzhengyang2023@lzu.edu.cn>
 <779d223ad31c493cbfc3c483293e435dca89cf90.1782879547.git.chzhengyang2023@lzu.edu.cn>
 <akd6KZo1lwQ719d0@orbyte.nwl.cc>
 <akeKGXmzONKkGqOl@strlen.de>
 <akeLxWXP7Y-5I8BQ@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akeLxWXP7Y-5I8BQ@orbyte.nwl.cc>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13615-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phil@nwl.cc,m:enjou1224z@gmail.com,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:chzhengyang2023@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,netfilter.org,davemloft.net,google.com,redhat.com,kernel.org,foxmail.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nwl.cc:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A714870145C

Phil Sutter <phil@nwl.cc> wrote:
> > This is silly.  I'm not sure this is even a bug.
> > We're in 2026 not 1970.  I really don't see why this patch is required.
> 
> I imagined a system with broken BIOS clock which boots at epoch until
> NTP has fixed it. Then stamp will be close to zero, no?

So what?  Rule won't match either way.  I wish we could get somehow
get rid of xt_time and nft_meta time matching, this was a very bad
idea from the start.

