Return-Path: <netfilter-devel+bounces-13687-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5s9IGwPaTGqiqwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13687-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 12:50:43 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BC971AA09
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 12:50:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=lWRncKkA;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13687-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13687-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3283430AF7B1
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Jul 2026 10:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D753E5A32;
	Tue,  7 Jul 2026 10:46:58 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091853C13F5
	for <netfilter-devel@vger.kernel.org>; Tue,  7 Jul 2026 10:46:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421217; cv=none; b=LcMFwHLKC3sJq/qR2qEkq7Qdd4Y46qHR+854oNnGoLVKNYRKLFHkEMO1WdAPneH5+Vw54dQaQG2zE37sMTZUbcSrxDis15xsfoX2DIokH0/4ry8jwKLb5XZ3yG72R+tWAhDRA0OmfH6gEn0Itk9l+JGrF39opmIND4tyz9jrJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421217; c=relaxed/simple;
	bh=aJ3/zI/Ipe0tDI7hs5GjITZYuJblgVMtVaQl6YroG5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4hRqXzJ/gDfsECuiPfEAJeq0FB5PXd6H7b2gLWFPdcZIKh7Nx4eWedVvfYnKs6mmHrBkwJdC40nZSW4x3m8TugWmEzYDrozk1f0Zwj1fr4EBCEW9Q9w9TTH/97HlDcOulmPMdqhzonInbB0gYirQSo9Txc+O+eweKYZSqeyA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=lWRncKkA; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 214BE60578;
	Tue,  7 Jul 2026 12:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783421205;
	bh=BlkcZ+Tgvd52QZqm9e0nRwyOR0Hs96z9PEAFP302U6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWRncKkA/BdtaCIEBwyGufqn2TdZUuWyNKwUm4k5mxSRrH1bDnwmgIDcWnchVdfMY
	 QU+reBhV2+F1TyyvdN3227Q29cnIMrhz1hyeY5At9r1+JmUHZzdrCh2o48LhX8dJnS
	 tzLdTamsUTgekPZn9nLbBK3tjecI+EoEwQPaDBC+REyI6tPV53tbYhKbmzc/KnV6Ma
	 5Qk7byW0vOFjAx6m1UnevB87vrlP9vC/jxTAomdCLdtv8O96mUJmq9RXKaHDMlbq6y
	 43ok+QJ8stLPEJFto2M5l0eaDf+B69uySFOI09z0xkUkhghYf5n6er3diyrIMo9ox8
	 tJSnvw+O1kNyQ==
Date: Tue, 7 Jul 2026 12:46:42 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, lorenzo@kernel.org,
	chzhengyang2023@lzu.edu.cn
Subject: Re: [PATCH nf,v2 2/3] netfilter: flowtable: IPIP tunnel hardware
 offload is not yet support
Message-ID: <akzZEhCyHWq95gGB@chamomile>
References: <20260630094056.97038-1-pablo@netfilter.org>
 <20260630094056.97038-2-pablo@netfilter.org>
 <akzVhnsxasPRga8H@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akzVhnsxasPRga8H@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,m:lorenzo@kernel.org,m:chzhengyang2023@lzu.edu.cn,s:lists@lfdr.de];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13687-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netfilter.org:from_mime,netfilter.org:email,netfilter.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1BC971AA09

On Tue, Jul 07, 2026 at 12:31:34PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > No driver supports for IPIP tunnels yet, give up early on setting up the
> > hardware offload for this scenario.
> 
> This series triggers many drive-by findings.
> 
> No big deal, should be addressed later.
> 
> > +	__set_bit(NF_FLOW_HW, &flow->flags);
> 
> Would you mind if I mangle this to use set_bit() ?

Go ahead.

> Its a low-hanging fruit, the other findings need
> more attention.

Yes.

> Otherwise I can also apply this as-is, its an improvement
> in either case.

I will follow with other comments, they are pointing to relevant
issues.

