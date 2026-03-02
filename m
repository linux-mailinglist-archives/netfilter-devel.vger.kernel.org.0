Return-Path: <netfilter-devel+bounces-10913-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN4VO+jLpWl3GwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10913-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 02 Mar 2026 18:42:00 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E1D1DDF8E
	for <lists+netfilter-devel@lfdr.de>; Mon, 02 Mar 2026 18:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81C02300460D
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2026 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6199B423151;
	Mon,  2 Mar 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="7ltGiybD"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC4426EBF;
	Mon,  2 Mar 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473310; cv=none; b=CL3MYcfSSMLSciJQJ0AwhNTuKXxwsQ/2KUOL7XOmudC1KiI3qIYe7LfDGruQ4alSuo9Mqc1rTspkHG4u5IoosZ6e3i3NjMCWApZR5JgG9fCT96MFASVdj0lR/yum21Z/j3gwhYXFmJAuzl74sOHdn8AOstALBcdg9I9Yl+/mExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473310; c=relaxed/simple;
	bh=4x4OAhzJKP3sJc7ALpsYHrOzDmkL/HbZ1wuO1OoMpIw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AC1grDftjXJr7vHRFrSTmENXx6ywNnYtT7nNyk8XJqcwRDdeBPxPcFThtUO6kyMHhiEFKjzEh9P6g7DK0XybL+yfxUuS35/VpyQHuWQP30uune7be72DkTePANmemqmPtnxKOUp+446CNTKaYmxGPpFPo7LUXv53En0wpdKnApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=7ltGiybD; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 6F19221D44;
	Mon, 02 Mar 2026 19:41:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=tm5CAASlYPDcu2sptEbMOYs1+WZDl2Pn80TUBqPNElE=; b=7ltGiybD6d4v
	aBZAsV2o24yC9c2v53EsIEuU9RHZJp77PElPyc+lbgOVUX/l2D+Dp0vwmQa4xg9h
	JA5EnjLXn4B4hfRe6CGD3/7YjbRB5p3mgcV2ye8acpUHx5YdVDJ4QbYAlsMLxySJ
	mVrIOcRnazK3DJqp0/AqReqWhP7OtalA9pPUz+l8lWt4U2DV9sys9WkKMP8sQ2QG
	w8nlAgSywWDp0A2FFY3wu321XJDo9RvI1w9hrlFbQ7fOlMfnTqT9OaSOZK5lewbp
	fxmaaQJcaSCmg1qWfBrQ0Fq4JJNN/5Bm68hT6NTDUgTQoUJ9AUiqlAnGQh0Yuc9d
	HO8ZUPpHmG0r0ZVSZYwqvP8W0gw1tj8cuHUTUmKuACAemHCYoV+wi+7qnQ3dwhX1
	/KBbfAUpD2nL3+XKzSwri7p1GCTUd/PixESjncIk5cmVDUxqKF8Ec5uYvOZGVevZ
	UJTOIC7KEFP6EOkT2TwR+kH6+B4DpaRF0h68gVSps6rHRQRqD3y7vDBEF/yEvqM1
	RtxVBLpKsqxnPoGBmYiNRRETGUz6gzPajFVZ/n9F+IOnJouH+B3rpm/ztxrDM/QY
	rVv1OjorcVShoS1UE2fiwZeY92EPem5l7V4k/Il5D+t0ZfB3WMAtHcbLP04HZpGu
	HvYGtMB0xBSTG+R+9jlNFgOWAX1HtpU=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Mon, 02 Mar 2026 19:41:36 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 55EF96086F;
	Mon,  2 Mar 2026 19:41:34 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.18.1) with ESMTP id 622HfLMJ073133;
	Mon, 2 Mar 2026 19:41:22 +0200
Date: Mon, 2 Mar 2026 19:41:21 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Florian Westphal <fw@strlen.de>
cc: Simon Horman <horms@verge.net.au>, Pablo Neira Ayuso <pablo@netfilter.org>,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Dust Li <dust.li@linux.alibaba.com>,
        Jiejian Wu <jiejian@linux.alibaba.com>, rcu@vger.kernel.org
Subject: Re: [PATCH nf-next 2/5] ipvs: add resizable hash tables
In-Reply-To: <aaQ955aj9ONBe695@strlen.de>
Message-ID: <8cb40028-50ed-b646-ecd7-9ab47e9ba38f@ssi.bg>
References: <20260226195021.64943-1-ja@ssi.bg> <20260226195021.64943-3-ja@ssi.bg> <aaQ955aj9ONBe695@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: F2E1D1DDF8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ssi.bg:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10913-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


	Hello,

On Sun, 1 Mar 2026, Florian Westphal wrote:

> Julian Anastasov <ja@ssi.bg> wrote:
> > +/**
> > + * ip_vs_rht_for_bucket_retry() - Retry bucket if entries are moved
> > + * @t:		current table, used as cursor, struct ip_vs_rht *var
> > + * @bucket:	index of current bucket or hash key
> > + * @sc:		temp seqcount_t *var
> > + * @retry:	temp int var
> > + */
> > +#define ip_vs_rht_for_bucket_retry(t, bucket, sc, seq, retry)		\
> 
> This triggers a small kdoc warning:
> 
> Warning: include/net/ip_vs.h:554 function parameter 'seq' not described in 'ip_vs_rht_for_bucket_retry'

	Will fix it, thanks! Just let me know if more comments
are expected before sending next version...

Regards

--
Julian Anastasov <ja@ssi.bg>


