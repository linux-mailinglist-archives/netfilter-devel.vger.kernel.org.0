Return-Path: <netfilter-devel+bounces-13408-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GwdXDG9WOmq/6QcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13408-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 11:48:31 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8690E6B5ECC
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 11:48:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=alrXHWFV;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13408-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13408-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C1CE301588B
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0315364028;
	Tue, 23 Jun 2026 09:48:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A613F30C359
	for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2026 09:48:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208108; cv=none; b=CMfRrLjXDNHy/9hEDsLFVUQoE1gjfyy9SNhVIxcTi1jR2ntEw2xEArp8Il8YXmvWwMwvBPwEJp+R9xEg6PiFooJ5FWD9JF7MmLaa0CTvlJ2qsiSn0auo51HhTpINfDjpmobpAdutYfWl4Ae5RsKR9DEx19m7U8gGRm2NrxFrtQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208108; c=relaxed/simple;
	bh=qhK9z6zKO/RpsbbHtKP9kBwMgR1RXLoNV7pYx38/C4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/2OMSIweNryNr+IsbEMzjwRgNsg+QCah0xvpI3+9xK97ccELXsqDzraHCFMvPlKZXapr1MC/2U8qMUpnPhgyopGUkAWJVu4mWEn4rwSysj/gyOqQZTiXqhmMgH2wz7WLK7NFXxHdkHzpPo7HBqfesmJq2KpEwOwdrP0iXx3LfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=alrXHWFV; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 836EF60193;
	Tue, 23 Jun 2026 11:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782208098;
	bh=pCu1qmnqeaW4lIOT8FVYAKa/gUkBOOHtFXMRdijVI1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alrXHWFVpv3v0Jd/DgQ7NmAdlg4Y2Qui0LHGXiiysO1IX45ES1vpxh9npSNrCtd1h
	 2htZTVijuUVTWpbpeC/hmStvxXFFhWBwzwFHm4OgWt2H1HNWUorzTYYGwv6vcKUgNp
	 Vw93eV6iJce9AA0/NFn4Em1beR0KbeDyRj57qCBx+f36aDvnQyRjFIXx6VrUWq61XN
	 mdI/8+L28U15aO6o45HZ/CwLDMcWLtG3Vl0a7JEJ0Z51sEkfYjn6XHkVcaMIa+zPJO
	 siRPK18FLnt/DrLcDA78GwWV9hEjjqsS1LgvzfjKYBHhm3/zd6L7f2lwI82/+7zeaP
	 Vng6zsboxaAvw==
Date: Tue, 23 Jun 2026 11:48:16 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] libmnl: add MNL_TYPE_UARR for devlink u64 array
 attributes
Message-ID: <ajpWYAQ1Od2ilpAk@chamomile>
References: <20260623043755.2435685-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623043755.2435685-1-rkannoth@marvell.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13408-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email,chamomile:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8690E6B5ECC

On Tue, Jun 23, 2026 at 10:07:55AM +0530, Ratheesh Kannoth wrote:
> Add MNL_TYPE_UARR (129) to enum mnl_attr_data_type to match
> DEVLINK_VAR_ATTR_TYPE_U64_ARRAY in the kernel. That type represents
> devlink param values encoded as a nested list of u64 attributes in
> DEVLINK_ATTR_PARAM_VALUE_DATA, allowing drivers and userspace to
> exchange variable-length u64/u32 arrays (e.g. multi-value devlink params).
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  include/libmnl/libmnl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/libmnl/libmnl.h b/include/libmnl/libmnl.h
> index 0331da7..078d517 100644
> --- a/include/libmnl/libmnl.h
> +++ b/include/libmnl/libmnl.h
> @@ -133,6 +133,7 @@ enum mnl_attr_data_type {
>  	MNL_TYPE_NESTED_COMPAT,
>  	MNL_TYPE_NUL_STRING,
>  	MNL_TYPE_BINARY,
> +	MNL_TYPE_UARR = 129,

Why 129?

>  	MNL_TYPE_MAX,
>  };
>  
> -- 
> 2.43.0
> 
> 

