Return-Path: <netfilter-devel+bounces-4737-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304CE9B3DBB
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Oct 2024 23:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BA7281DC9
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Oct 2024 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9AA18C02D;
	Mon, 28 Oct 2024 22:30:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBFC15B12F
	for <netfilter-devel@vger.kernel.org>; Mon, 28 Oct 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154653; cv=none; b=DaWjfQS/o7sXmwFeLLF/y70uRL84zVEODXJBLb4DFxjJhAdi+uMCUjOZQ14RjrlCjZwhhmQI4CgCTvGAyy2N2yJUgVfIyfds4kLGuYaS0YuKIDyhAWth1dFg/7D3CwgZRqXusdFd9m1p0BHFDaN9TX8ItDTIZndlPY2h0HRXy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154653; c=relaxed/simple;
	bh=mS5BrNOEFJwGPYa/yTU7ukhFZGetNJHzqBqoR7W1mzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcTR06DZBYcyCc8RiM3TpRn5qWPgtJmRqlG+k7M2ElirbyOGQPqpCcMYTi1LrTDB5Bs0saLS+xvAa593Pp7dPi9N3MkHo0XJVOMlSMsNlkKc+5t1pCq+ocdy8oW399mRtJmlIGFdkYE01hMy2+lMiCuxqBSc74CI/8SExQTg4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=46242 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1t5YG4-004lRX-FY; Mon, 28 Oct 2024 23:30:46 +0100
Date: Mon, 28 Oct 2024 23:30:43 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de, phil@nwl.cc, matttbe@kernel.org
Subject: Re: [PATCH nf,v2] netfilter: nf_tables: wait for rcu grace period on
 net_device removal
Message-ID: <ZyAQkxtWaY9PHNy5@calendula>
References: <20241028162214.177671-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028162214.177671-1-pablo@netfilter.org>
X-Spam-Score: -1.9 (-)

On Mon, Oct 28, 2024 at 05:22:14PM +0100, Pablo Neira Ayuso wrote:
> +int __nft_release_basechain(struct nft_ctx *ctx)
> +{
> +	struct nft_rule *rule;
>  
>  	if (WARN_ON(!nft_is_base_chain(ctx->chain)))
>  		return 0;
>  
> +	if (!maybe_get_net(ctx->net))
> +		return 0;

Hm, this does not work either.

If I skip releasing basechains here from event path, then it seems
netns_exit path sees a stale net_device reference which was already
removed before via _UNREGISTER event.

