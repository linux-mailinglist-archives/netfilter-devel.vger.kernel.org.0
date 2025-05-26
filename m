Return-Path: <netfilter-devel+bounces-7333-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3575CAC3F5F
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 May 2025 14:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82CE3AD42D
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 May 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C0C20298D;
	Mon, 26 May 2025 12:32:09 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD6202C21
	for <netfilter-devel@vger.kernel.org>; Mon, 26 May 2025 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748262729; cv=none; b=Zgb4oUtxhGkSOL6siv4jEPkGrBFoLod6JQDhNXLGQ9TYgNklBUGeErPkUT9ITdcm9UkhQGhiR74ORXgAau37bvEWu06JXGLIU+cBnimBbyk3eXQcWYv2yBBCGTiHSpUG/hFX5tKzzgYTGFX7fIoZ9kGpRv5mnHUX/1xwirONS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748262729; c=relaxed/simple;
	bh=FBsYQ8+ww/WokZHkiHNznAD6eoyUNX3RscIn/DkHjVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1ar8gYBM55e+M/pPyh9KXhKpzsOo2D6K1sCoPJE7ZTAfqMv1kWYFSsWin3rLVn6HYJas1wg4EOCQZYCBrQ6JkijBRbmBz4tFEUmiVJIEZpx8sPOFj1NucdHfZonFV/cP1j1zMozgJRQO+o4EkUVsNUutcgNL9TVjABhgk78tyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EFD4B602B1; Mon, 26 May 2025 14:32:03 +0200 (CEST)
Date: Mon, 26 May 2025 16:14:25 +0200
From: Florian Westphal <fw@strlen.de>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/3] netfilter: nf_set_pipapo_avx2: fix initial
 map fill
Message-ID: <aDR3QTIqNJC3E546@strlen.de>
References: <20250523122051.20315-1-fw@strlen.de>
 <20250526141439.28a25297@elisabeth>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526141439.28a25297@elisabeth>

Stefano Brivio <sbrivio@redhat.com> wrote:
> > Because the selftest data path test does:
> >    .... @test counter name ...
> > 
> > .. and then checks if the counter has been incremented, the selftest
> > first needs to be reworked to use per-element counters.
> 
> That makes sense indeed, I didn't even know they existed. Actually, I
> just learnt about 'nft reset element', that's quite neat.

Pipapo predates the per element counters so no wonder you did
not use them in the original selftest :-)

Thanks for reviewing!

