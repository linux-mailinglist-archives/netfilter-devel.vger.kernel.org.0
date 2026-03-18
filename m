Return-Path: <netfilter-devel+bounces-11264-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CHnLIiCumnrXQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11264-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 11:46:32 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A85492BA274
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 11:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE2EE30093A2
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747FF1D9346;
	Wed, 18 Mar 2026 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="URZwsolQ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963633067F
	for <netfilter-devel@vger.kernel.org>; Wed, 18 Mar 2026 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830785; cv=none; b=qLngSyWCC7NyEmufEwHPiZJyG01cjTLsW2PlOK1+L8MPhE0fzUg7HfOEbPuJAX475tf7JpRJ3bFeqyBh7sBKIZuF7CZAQB2O5Ufo4zH7QIAY+5lzdPMXJWWfvwKSD9eweZrA/HVcSLbOPOpVNGSlc0XlS8Io7Cmg4N5v4jouWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830785; c=relaxed/simple;
	bh=nYOuhVMgqvrFPv6ZEw6DJjiRI77Taopjxl1hK/BbePY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6MnPIYKEFG1Bn8B4vH8I0fXj8T+ic3hsQMLavZFQ2p7JKkgYKFDMNL0I66dgdyBXuMngilI50KjTAs0SnDifZjAJSZXnUKO0y1wN8zPT1Q5e0YAPGMbGPrc6fwUwSdzslIGbVrISNLGXFYe+30Je3/FXW2b/iMTvWZiKXMhEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=URZwsolQ; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=95CqMctSKPBz4KspsXYe8DLCLQCWVmJd+ei8hZApC0k=; b=URZwsolQJUFetqLm7n2kpvG/Ok
	+zh69dkFQxssN9jSHKo8J1jMi1apPL03zQ74DSmu96n9eVT6ZgbRd7GB/cabin5VRPUDvPW84HiR0
	aIEb3bZZFvJcMZnnrnE1rvMiL5xUO6dWQ98rmaUbvcRQn14o7oM6XaET20EIN0C0rSB0FmQrGPE4Z
	2/R9ZvYP54aXuK8/uxHRLIhjdb5IkXrmOHgZUtqw00oPR69UO9UzP63t11SNYVkn62D6rNSx1ojmT
	in9RclAHfWMuqaM93qSd/OejuT0RqHy+utkooUaDS4BsYNl9qW+pLoJFHBeplQw0wnSXX9B5jUrS3
	A4w47kHA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w2oPm-000000006Qp-2T0r;
	Wed, 18 Mar 2026 11:46:14 +0100
Date: Wed, 18 Mar 2026 11:46:14 +0100
From: Phil Sutter <phil@nwl.cc>
To: chlorodose <chlorodose@gmail.com>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] src: Export nftnl_set_clone symbol
Message-ID: <abqCdqPLJyKmBQc-@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	chlorodose <chlorodose@gmail.com>, netfilter-devel@vger.kernel.org
References: <20260318025651.151116-1-chlorodose@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318025651.151116-1-chlorodose@gmail.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[nwl.cc];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-11264-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: A85492BA274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi chlorodose,

On Wed, Mar 18, 2026 at 10:56:51AM +0800, chlorodose wrote:
> Seems that nftnl_set_clone is forgot to be exported, we add it back.
> 
> Signed-off-by: chlorodose <chlorodose@gmail.com>
> ---
>  src/set.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/set.c b/src/set.c
> index 54674bc..e5e51b6 100644
> --- a/src/set.c
> +++ b/src/set.c
> @@ -360,6 +360,7 @@ uint64_t nftnl_set_get_u64(const struct nftnl_set *s, uint16_t attr)
>  	return val ? *val : 0;
>  }
>  
> +EXPORT_SYMBOL(nftnl_set_clone);
>  struct nftnl_set *nftnl_set_clone(const struct nftnl_set *set)
>  {
>  	struct nftnl_set *newset;

Don't you also have to add it to src/libnftnl.map? How did you test this
patch?

Looking at the function itself, I fear the code is not correct anymore.
E.g., it does not clone expr_list or user.data. If I was to decide, I'd
rather drop it entirely instead of polishing it up. What's your
use-case?

Cheers, Phil

