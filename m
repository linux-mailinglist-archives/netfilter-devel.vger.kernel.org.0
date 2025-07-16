Return-Path: <netfilter-devel+bounces-7901-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA53B07223
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Jul 2025 11:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D74189D9C5
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Jul 2025 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86712F2346;
	Wed, 16 Jul 2025 09:47:13 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95251448D5
	for <netfilter-devel@vger.kernel.org>; Wed, 16 Jul 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659233; cv=none; b=Tb/6+dRFSz2uf1yDhITSTC4X0j/YUXjAEK4+lLg3BFZ1fmF+e459YgjKrNh/2K0c0ehRneZuAue09pRAYj9SGg5CFqg6/k+Qh9dXRtYMAUcDzbXCt55OBIH6Dl4dzhDwI873Ejwe3LAxzbK1FOuBr/O5qg+s0GwrHkGMLkkjdFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659233; c=relaxed/simple;
	bh=NhGDlCzNI3dsnRn9vB+I6jZ2nRyguW8cRaLfv/JXAEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apx/7G3i7hnCB7tJUyx6l+u8KFLSo9qQThgwzKV7KyVr8XlwX5hxeFvxt7ILm98I8OA8zXgd0c6bAlxqM/dGADT1cyk2GuRak6HmibpwDTaSETlZuFUegbCQu4xKt9GZLKqKZeU2lpml5Qgjgm6xkFSSqiD1iXAkMExRvbwK/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 9EC5A604FB; Wed, 16 Jul 2025 11:47:09 +0200 (CEST)
Date: Wed, 16 Jul 2025 11:47:09 +0200
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2 1/3] mnl: Support simple wildcards in netdev hooks
Message-ID: <aHd1HbLSzO3KHI64@strlen.de>
References: <20250715151538.14882-1-phil@nwl.cc>
 <20250715151538.14882-2-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715151538.14882-2-phil@nwl.cc>

Phil Sutter <phil@nwl.cc> wrote:
> +		len = strlen(dev_array[0].ifname) + 1;
> +		if (dev_array[0].ifname[len - 2] == '*')
> +			len -= 2;

Not obvious to me, is there a guarantee that 'len' is 2?
And, what if len yields 0 here?

> +			if (dev_array[i].ifname[len - 2] == '*')
> +				len -= 2;
> +			mnl_attr_put(nlh, NFTA_DEVICE_NAME, len, dev_array[i].ifname);
>  			mnl_attr_nest_end(nlh, nest_dev);
>  		}
>  	}
> @@ -2084,14 +2090,17 @@ static void mnl_nft_ft_devs_build(struct nlmsghdr *nlh, struct cmd *cmd)
>  {
>  	const struct expr *dev_expr = cmd->flowtable->dev_expr;
>  	const struct nft_dev *dev_array;
> +	int i, len, num_devs = 0;
>  	struct nlattr *nest_dev;
> -	int i, num_devs= 0;
>  
>  	dev_array = nft_dev_array(dev_expr, &num_devs);
>  	nest_dev = mnl_attr_nest_start(nlh, NFTA_FLOWTABLE_HOOK_DEVS);
>  	for (i = 0; i < num_devs; i++) {
>  		cmd_add_loc(cmd, nlh, dev_array[i].location);
> -		mnl_attr_put_strz(nlh, NFTA_DEVICE_NAME, dev_array[i].ifname);
> +		len = strlen(dev_array[i].ifname) + 1;
> +		if (dev_array[i].ifname[len - 2] == '*')
> +			len -= 2;
> +		mnl_attr_put(nlh, NFTA_DEVICE_NAME, len, dev_array[i].ifname);

This (test, subtract, put) is a repeating pattern, perhaps this warrants a helper?

