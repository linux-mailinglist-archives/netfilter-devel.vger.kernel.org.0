Return-Path: <netfilter-devel+bounces-4147-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CAD9883DB
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Sep 2024 14:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC411C20B5F
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Sep 2024 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38CF18BBB6;
	Fri, 27 Sep 2024 12:04:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78261FCE;
	Fri, 27 Sep 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438650; cv=none; b=FCfuFb1J6s9+MSmyxAS7Rg7qSo5ruweJMXs46LlpaUXXyoR8JEXsMJKoy6lqDsIjj6PgaRslP3su4lOiBmdaBPv0HWhT97Yi9yrr0yN7esySvUT1AD1ydyG/d7owKe6yYJMoUE+flzS2qkoQX41WDG+sUYFq2vHosmoTpvjTd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438650; c=relaxed/simple;
	bh=mHTt9ZhXZ55tnBlwwbtfzR1OjeQw/pedqY/UToFTRLE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfkBX1/1YBNodMoLHqZ3YoeGSWMjh+KNOczpOcozSmkxNJlMMKtrajiNpAIz5tWT9TogYVXSWOQKSHbdfjmslzdGhmbs7ahxsa/TLCNq7dyBquruhENbcGCgqJtoE0M+dk/DsKygeEQHH9JMPtQG9W3xL8uIcFEC81+EC9rWcr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=58278 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1su9hb-002wPn-5g; Fri, 27 Sep 2024 14:04:05 +0200
Date: Fri, 27 Sep 2024 14:04:02 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>, zhangjiao2 <zhangjiao2@cmss.chinamobile.com>,
	kadlec@netfilter.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] selftests: netfilter: Add missing resturn value.
Message-ID: <ZvafMpchvuSt1MvY@calendula>
References: <20240927032205.7264-1-zhangjiao2@cmss.chinamobile.com>
 <Zvac4_L4THVtPv3g@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zvac4_L4THVtPv3g@orbyte.nwl.cc>
X-Spam-Score: -1.9 (-)

On Fri, Sep 27, 2024 at 01:54:11PM +0200, Phil Sutter wrote:
> On Fri, Sep 27, 2024 at 11:22:05AM +0800, zhangjiao2 wrote:
> > From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > 
> > There is no return value in count_entries, just add it.
> > 
> > Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Typo in $subject: resturn -> return
> Fixes: eff3c558bb7e ("netfilter: ctnetlink: support filtering by zone")

I amended this already, I found the same issues .

> Apart from that:
> 
> Acked-by: Phil Sutter <phil@nwl.cc>

But I pushed it out already without your tag, thanks for reviewing.

