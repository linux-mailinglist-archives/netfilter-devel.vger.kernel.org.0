Return-Path: <netfilter-devel+bounces-6731-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A81A7DAD2
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Apr 2025 12:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5791891378
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Apr 2025 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39B422FF2E;
	Mon,  7 Apr 2025 10:14:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C8822A4D6;
	Mon,  7 Apr 2025 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744020861; cv=none; b=rAbq9iJ0uOamURp6z34IeUJVYM08tnY0mZe1somKO95wgRSIgtD3ZyW9AgeMSWyHc6xpap9WVADVXopWE8TgJI5Oq3dwmoDwJKWykagYDQblb7Uxy/VgNBt4lcxYmsYEEPBVl6wmCZLlO7RBjI9eQxfhFeXkc7zMtd6ZlXlCY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744020861; c=relaxed/simple;
	bh=nux7wkliuOCQzBPV7ozaY6XFbNNo0B17CDiMSqLgA+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3sEaFpaAAQbTThw+yTpOGwujKdeHunlVwkSNLwVlVuAu8naN64B8PGgtCZNpxLOj5YPlnCG3MFTzKn6DorwB0i79o/E2alJkLWPqnNqEanEu9dad5pq8FLsckT96meI+lTa0rL6tcxHbKKwAC+5zvh9gCEodzbo5QkFjAELaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1u1jUG-0003Sy-Dd; Mon, 07 Apr 2025 12:13:52 +0200
Date: Mon, 7 Apr 2025 12:13:52 +0200
From: Florian Westphal <fw@strlen.de>
To: lvxiafei <xiafei_xupt@163.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	lvxiafei <lvxiafei@sensetime.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH] netfilter: netns nf_conntrack: per-netns
 net.netfilter.nf_conntrack_max sysctl
Message-ID: <20250407101352.GA10818@breakpoint.cc>
References: <20250407095052.49526-1-xiafei_xupt@163.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407095052.49526-1-xiafei_xupt@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

lvxiafei <xiafei_xupt@163.com> wrote:
> The modification of nf_conntrack_max in one netns
> should not affect the value in another one.

nf_conntrack_max can only be changed in init_net.

Given the check isn't removed:
   /* Don't allow non-init_net ns to alter global sysctls */
   if (!net_eq(&init_net, net)) {
       table[NF_SYSCTL_CT_MAX].mode = 0444;

... this patch seems untested?

But, removing this check would allow any netns to consume
arbitrary amount of kernel memory.

How do you prevent this?

