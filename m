Return-Path: <netfilter-devel+bounces-13798-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HmZtBR/XT2oppAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13798-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 19:15:11 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1945F733C46
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 19:15:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=JoqJguek;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13798-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13798-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC5B63008A71
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C339A075;
	Thu,  9 Jul 2026 17:08:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7296439E185;
	Thu,  9 Jul 2026 17:08:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616936; cv=none; b=gDcnv2LAsv781ozb0VcZSf7iIGFNTvR1yNThfT0PXHMwsw0Q4Idc5msKt058vuq/zvWWBdiluwW4ApEok8BJgTlY7ZzF1dQ+88o9TM+1T4yYK2mnSCx2pHGxk9sVoTaNFezR6LG0xB6WjDy2sC/8NnpwRWAaQHePNEP/f9XSK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616936; c=relaxed/simple;
	bh=a6cAfNnLoz+INnfNq5wkKXmUK2YYQJd6sfimX18DjLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMV/9ziUBmtLCbkKhhno5tUvCuh2sBa2A9o5kV0lpVUpGikpwT+ZtUcL8duhbKKJURtSGQbeyrcXwHH0fc2Sap46Xx3ZEebFO94ST+h3OTuBRFQx9jXyi5dI/8YCzmkXA6dd1U4SLFrD4hM7AxCVPrap2pN0nSJtT2+EAQJMDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=JoqJguek; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 1491A60579;
	Thu,  9 Jul 2026 19:08:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783616932;
	bh=A/0LHDMwrtHFuyH8bH7ZYxgtW2azlnGhsurymDeBqLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoqJguek1wENaz8q5PM9HrCtgYaUKthMaPa5CtkQZ09xXE81op0uaHVPekrGM9TRl
	 uDUVuR3z1xIPrxhtcxPikF0nP47pBjqL8jfRNjn9ILlhwBx2sk8AgcIagyCS0zXdGM
	 DY1QidhJEb0aQtH5dK+3RlDiQ1JmxbWkSRgg311/D214VlLXINYDT6vaCDY4HLAYk1
	 brkB1dfznLuZqL/PWYpJz988YIrc6ZqtngJH0K2wtDm1RSoHHBkhsx7f+zJLnWWDn3
	 gVUCejSt7lcnftTWkFvicVKbmtR6Zq8teRw5/iTx3+POTyZCcGFpuV8Gc3n0+xrjTz
	 lWmqVkkr6UETA==
Date: Thu, 9 Jul 2026 19:08:49 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ahmed Zaki <anzaki@gmail.com>
Cc: netfilter-devel@vger.kernel.org, fw@strlen.de, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: flowtable: tear down HW offloaded flows on
 FIB route changes
Message-ID: <ak_VoSJ7fozDdOzM@chamomile>
References: <20260708205404.911832-1-anzaki@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708205404.911832-1-anzaki@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anzaki@gmail.com,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13798-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netfilter.org:from_mime,netfilter.org:dkim,chamomile:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1945F733C46

On Wed, Jul 08, 2026 at 02:54:04PM -0600, Ahmed Zaki wrote:
> Hardware-offloaded flows bypass the CPU and, unlike the software
> datapath, dst_check() does not invalidate them when a route changes.
> For ephemeral flows, this is usually not a problem as the flow expire on
> its own and the driver clears the entry in the HW. However, for persistent
> flows forwarded through the device, the HW is never informed that the
> route has expired.
> 
> For tables marked with NF_FLOWTABLE_HW_OFFLOAD, listen to the per-net FIB
> notifier chain and tear down the affected flows so they are re-evaluated by
> the SW forwarding path.
> 
> A lockless list is used to reduce the work items overhead in case of a
> route change storm allowing many FIB events to be processed by one work
> item.

This walks the hashtable anyway in case of fib event, maybe simply
walk over the hashtable and call dst_check() to check if the cached
dst is still current.

> Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload support")

No, this is an enhancement, not a fix. This must be targeted to nf-next.

Thanks.

