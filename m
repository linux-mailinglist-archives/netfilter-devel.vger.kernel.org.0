Return-Path: <netfilter-devel+bounces-3354-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1B79571C2
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Aug 2024 19:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75FFB279E3
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Aug 2024 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C884F5FB;
	Mon, 19 Aug 2024 17:02:18 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F9F9DA;
	Mon, 19 Aug 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086938; cv=none; b=PQOcZLcESqH65OS+kvGw42mzryuyKfBqe18IlMzkYo40YCPbiWc+6CX0RxobawlBTSN6J1Q/3bbJVYL8AVLmpvrj42FP/BhpBGqch8Dvb03xt/g/I0wb1nmNVlydrO1ATT+8/ozVQQuOn1vjl+NwIvX/5Mfkgh2bZDDWTl7Nc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086938; c=relaxed/simple;
	bh=0/yX71sibvy6y6xr5ja3FRC+MNBNWio0ehxkcewZnHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN2Brqf5llgDKMkApzxk4CXtHJVqZ+7JL/33YcDipTBBwOoEvGUzurDYXLU9Y4R1t1u6S4U0joCQdUMXH9xkmXXAz7YbpFZgfZ98MlC2Yq0VZqOHlC/PdhaHi4V17/t0MUEJegfJnlliw6J8NiyJFeOB/4jJt8uZWmqzmPBE74Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=49820 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sg5li-005buT-7V; Mon, 19 Aug 2024 19:02:12 +0200
Date: Mon, 19 Aug 2024 19:02:09 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: kadlec@netfilter.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] netfilter: remove unnecessary assignment in
 translate_table
Message-ID: <ZsN6kQLn9fqMpNCm@calendula>
References: <20240701115302.7246-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701115302.7246-1-liujing@cmss.chinamobile.com>
X-Spam-Score: -1.9 (-)

On Mon, Jul 01, 2024 at 07:53:02PM +0800, Liu Jing wrote:
> in translate_table, the initialized value of 'ret' is unused,
> because it will be assigned in the rear. thus remove it.
> 
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
>  net/ipv4/netfilter/ip_tables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
> index fe89a056eb06..c9b34d7d7558 100644
> --- a/net/ipv4/netfilter/ip_tables.c
> +++ b/net/ipv4/netfilter/ip_tables.c
> @@ -664,7 +664,7 @@ translate_table(struct net *net, struct xt_table_info *newinfo, void *entry0,
>  	struct ipt_entry *iter;
>  	unsigned int *offsets;
>  	unsigned int i;
> -	int ret = 0;
> +	int ret;

ip6_tables is a copy&paste from ip_tables, so it is arp_tables.

I think all of them have the same unnecessary initialization.

Would you still post v2?

