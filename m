Return-Path: <netfilter-devel+bounces-101-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4BE7FCC3F
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Nov 2023 02:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C9B283211
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Nov 2023 01:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8FEDD;
	Wed, 29 Nov 2023 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="IDpieYk/"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220ACF9
	for <netfilter-devel@vger.kernel.org>; Tue, 28 Nov 2023 17:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ahYgtOc5zKRIpVZuqsLRMqBvmWh1V2ihxs3INep42ME=; b=IDpieYk/QcRczPlQFthD1pHZrX
	Zm1fn2AXd7AGX/lo+WcckQ5lAxk8j9LWJaA+Spkm7nNJ+TRtHH4Zmz6q4WVK5Bj826viNkIhoMISU
	ASQKs3bMKgQXnREZ9oVY8R90/myN1IiaAWy3PtyqH65sOioNzPxih70J6VhtpJWPs+Y0+VTx0rCuB
	09TYFKKcRs7gPGv6TLd/OnaDfUBjXXqABl2qaOvQwLLShy/7ylkDer9n91z5HxgkUlOz10ff2UxpV
	J1ExxB14+/uhLbCfn6hAr9YO//nD14WQi655JETVzT/4UrK/OVV+ZxtI8ksZhgKg8UPoAzkXjWYi1
	VLKGWLNQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
	(envelope-from <phil@nwl.cc>)
	id 1r89GL-0007nv-IO
	for netfilter-devel@vger.kernel.org; Wed, 29 Nov 2023 02:21:13 +0100
Date: Wed, 29 Nov 2023 02:21:13 +0100
From: Phil Sutter <phil@nwl.cc>
To: netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 0/3] Review interface parsing and printing
Message-ID: <ZWaSCQcO6a5owE4Y@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org
References: <20231124112834.5363-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124112834.5363-1-phil@nwl.cc>

On Fri, Nov 24, 2023 at 12:28:31PM +0100, Phil Sutter wrote:
> Take advantage of the fact that interface name masks are needed only
> when submitting a legacy rule to the kernel. Drop all the code dealing
> with them and instead introduce a function to call from legacy variants
> if needed.
> 
> Phil Sutter (3):
>   xshared: Entirely ignore interface masks when saving rules
>   xshared: Do not populate interface masks per default
>   nft: Leave interface masks alone when parsing from kernel

Series applied.

