Return-Path: <netfilter-devel+bounces-13614-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1qajBmuMR2rJawAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13614-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 12:18:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAE87011B7
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 12:18:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=K7Fideac;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13614-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13614-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E87023003632
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jul 2026 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670563385A7;
	Fri,  3 Jul 2026 10:15:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E43B47CB
	for <netfilter-devel@vger.kernel.org>; Fri,  3 Jul 2026 10:15:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073742; cv=none; b=RRL8+3wp5JljBmf2Sl2Kjr4YMgNkjoTqObeuyF5L82M7CLaLMLYDOZNqemgVPTMdo+pwJpBO4c5MfPyQbGgOE+58Q4uANR11wA+qPJz/yl2O9mOgIDh57W2jdBO0vOAi2UMVLJxPHXmTSr2+4DO88ENcDrJ7TZcNEICMTAG+NnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073742; c=relaxed/simple;
	bh=9+SRdspSG1I37QsNXYe+OM6C1ZfgNqFAZlpoTWNULJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxDxMMWRIgL8NnV+NKjSd/mB2Vr9c2khx6D0qZQ45hhDBU7wI/x6aXK4ACzaRLcLSZJGtg8eLBBYQnSrLqh30bNcZvwN4+xG4IjbNWCuCOm6vlf64og4PhPKfqb4e4Ef8SCvZYEEwi35ZtCZTa67EKDhHQZ2KgS/gybJSSO23hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=K7Fideac; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hQacM1nPgZpU4KZ+z6y5YU5u+9jEZdzkLuM3TOSOCpA=; b=K7FideacYvABojOX0+2Y6vPAe5
	7rPWhnRRSKkWaAM431jzBvBIeaUvqJEmAV0Y5NPII4QHZIIAni3vHp2qymdHwpO9YSOrUsxZi92pO
	B5D92N7FOoXoGy0MfjO68MpWyIVUHaV2FiLwH86q3oxJ4fjbBexW6KWf1fFgO/sOTIXqDIMr0QUFs
	21CIlLPd+YzU1uZZn9vpPEmHvbC/TtE7L3xA+zI74MUlwaQ6EqCW2PKu0rcxy9TLe7IrajOoI7xCp
	hQT6pFAH4I6332i1YFSAKoXenb0ABoy62Ovo1SRO/gr6BvSrQ85bsPv6KU9ryfYa5vBxGKN0dlut0
	fK91whMQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1wfavl-000000006sn-2gvP;
	Fri, 03 Jul 2026 12:15:33 +0200
Date: Fri, 3 Jul 2026 12:15:33 +0200
From: Phil Sutter <phil@nwl.cc>
To: Florian Westphal <fw@strlen.de>
Cc: Ren Wei <enjou1224z@gmail.com>, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, yuantan098@gmail.com,
	dstsmallbird@foxmail.com, chzhengyang2023@lzu.edu.cn
Subject: Re: [PATCH nf 1/1] netfilter: xt_time: reject pre-epoch calendar
 matching
Message-ID: <akeLxWXP7Y-5I8BQ@orbyte.nwl.cc>
References: <cover.1782879547.git.chzhengyang2023@lzu.edu.cn>
 <779d223ad31c493cbfc3c483293e435dca89cf90.1782879547.git.chzhengyang2023@lzu.edu.cn>
 <akd6KZo1lwQ719d0@orbyte.nwl.cc>
 <akeKGXmzONKkGqOl@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akeKGXmzONKkGqOl@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13614-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[nwl.cc];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:enjou1224z@gmail.com,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:chzhengyang2023@lzu.edu.cn,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,netfilter.org,davemloft.net,google.com,redhat.com,kernel.org,foxmail.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lzu.edu.cn:email,orbyte.nwl.cc:mid,nwl.cc:from_mime,nwl.cc:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AAE87011B7

On Fri, Jul 03, 2026 at 12:08:25PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > On Fri, Jul 03, 2026 at 03:32:43PM +0800, Ren Wei wrote:
> > > From: Zhengyang Chen <chzhengyang2023@lzu.edu.cn>
> > > 
> > > When XT_TIME_CONTIGUOUS handles a cross-day daytime range, packets in
> > > the post-midnight part of the range are matched against the previous
> > > calendar day by subtracting SECONDS_PER_DAY from stamp.
> 
> This is silly.  I'm not sure this is even a bug.
> We're in 2026 not 1970.  I really don't see why this patch is required.

I imagined a system with broken BIOS clock which boots at epoch until
NTP has fixed it. Then stamp will be close to zero, no?

Cheers, Phil

