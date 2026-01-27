Return-Path: <netfilter-devel+bounces-10450-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAYhCLNMeWmzwQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10450-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 00:39:31 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA819B720
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 00:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92EB6300950E
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 23:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7842D879F;
	Tue, 27 Jan 2026 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="KEJnd5y/"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B520C023
	for <netfilter-devel@vger.kernel.org>; Tue, 27 Jan 2026 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557167; cv=none; b=Vrgwsr37b1fBNIfQ33SovWwhMneXrbYI8dj7FvAqFmFxqJWfbpVD1PKQ2iVMGIfhg0eG3Bq//gjwWGplrXRJ4gII2prFGzo4xmb5lr/EB5BMsydL3Cgm5AD7Y+x6EQM4L1kxTgsPipaL/3dczU+aBGsmo7uA7l6SDNuYnJY2J4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557167; c=relaxed/simple;
	bh=9Ruu38L3WWAFI1lF2LLip92/Ni2LvBI1K8c7BIOsMdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TW6pcLAU9Hp1AJ/mYfIoMMSBUFQpQHPtTG7NzrVXnOnPdPp06gATHh74GKtvnXPnjUoYK373fLdzYRxYIP2ruM0Tji1FdkrCiHMGTOlgypoMVaOt/N1BvcCJIkUcfH9U/aCqXC0iD9eNc+wnaUMJSS7CNyXYz9fk+NJSQz2FJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=KEJnd5y/; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 5DE1060254;
	Wed, 28 Jan 2026 00:39:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1769557163;
	bh=0dMbuM3C7NKtoNfVtityKIzeEpjhi+l+HawKx36x8E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEJnd5y/Q0qlqiwPd889UtnpRvt+8/0EzBqQvqPbkg/7GJWYZQ4IqreJK9DxSwWt3
	 6FZYrmcrei+qn+KkOxJE6ru3tykIjkUBsbykeu8A6DwU/ThfnR3MBVdTaAc451rj3d
	 RcVKODB3DoXAg94AW3NE2UWVKPTuhTKDeVjK/TucieLbhvsQzjah1rFV/R8Wqd/kZr
	 EX6c8Vl++C4OkyuAV4tyGFPOu+yhcdOQmROU/u7RaYCehpuh8y0MbjPeeL5MZEsjkn
	 id7dzdcdOghWrMC3EoArlCXrM1CSNXjuMTWDblQUuL8zMwUmVPY4FuRa0H/Ghg5ray
	 5fJTN+heWYJuw==
Date: Wed, 28 Jan 2026 00:39:20 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 9/9] udata: Store u32 udata values in Big Endian
Message-ID: <aXlMqOfp2klbz_bH@chamomile>
References: <20251023160547.10928-1-phil@nwl.cc>
 <20251023160547.10928-10-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023160547.10928-10-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10450-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nwl.cc:email,netfilter.org:dkim]
X-Rspamd-Queue-Id: 6BA819B720
X-Rspamd-Action: no action

On Thu, Oct 23, 2025 at 06:05:47PM +0200, Phil Sutter wrote:
> Avoid deviation of this data in between different byte orders. Assume
> that direct callers of nftnl_udata_put() know what they do.

How does this work after an update?

Load ruleset with nft version previous to this, then upgrade, then
list ruleset with new nft version.

> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  src/udata.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/udata.c b/src/udata.c
> index a1956571ef5fd..8cf4e7ca61e2f 100644
> --- a/src/udata.c
> +++ b/src/udata.c
> @@ -8,6 +8,7 @@
>  #include <udata.h>
>  #include <utils.h>
>  
> +#include <arpa/inet.h>
>  #include <stdlib.h>
>  #include <stdint.h>
>  #include <string.h>
> @@ -100,7 +101,9 @@ EXPORT_SYMBOL(nftnl_udata_put_u32);
>  bool nftnl_udata_put_u32(struct nftnl_udata_buf *buf, uint8_t type,
>  			 uint32_t data)
>  {
> -	return nftnl_udata_put(buf, type, sizeof(data), &data);
> +	uint32_t data_be = htonl(data);
> +
> +	return nftnl_udata_put(buf, type, sizeof(data_be), &data_be);
>  }
>  
>  EXPORT_SYMBOL(nftnl_udata_type);
> @@ -128,7 +131,7 @@ uint32_t nftnl_udata_get_u32(const struct nftnl_udata *attr)
>  
>  	memcpy(&data, attr->value, sizeof(data));
>  
> -	return data;
> +	return ntohl(data);
>  }
>  
>  EXPORT_SYMBOL(nftnl_udata_next);
> -- 
> 2.51.0
> 

