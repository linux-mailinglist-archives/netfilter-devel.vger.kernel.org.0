Return-Path: <netfilter-devel+bounces-7789-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B46AFCC6F
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jul 2025 15:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A8481AD4
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jul 2025 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203942DEA7A;
	Tue,  8 Jul 2025 13:48:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3330226D0A
	for <netfilter-devel@vger.kernel.org>; Tue,  8 Jul 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982509; cv=none; b=vF2a6keGvW4UeKjUvDgijpzNrKUFE2zZYXwOYPhilATQeUFWRdCr1RfSb0oWyC0zLu/y+6Jb4n27kikbl1+XjiyV1welYmYSnbBxVpeu5/8nbKNX6hmNqi/mSQu5tNQgCegmdJyn4C9IDfmCKTuReGsgGW4z5oVMPMsLnjCAtuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982509; c=relaxed/simple;
	bh=AihFFP8ZmdrzequRNzzn/HNccQZz5LB5NCBwP4P+E60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgQx8rV0HzrDaVq59N68KgxAOBGwqvWZgIkpbVu8fSG/5gKzEQZRpTv3QqquMptsYOGSJvtHF4K+r1sKEYmxtOLpuxc/oHOGBTEBUdpm+abzj7W0B8jcS9VEdvNjozfOeIt/X6cvIin9ci0cu6kgLIW3ijoaQH7fmF5JF8wogUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id BF8406048A; Tue,  8 Jul 2025 15:48:24 +0200 (CEST)
Date: Tue, 8 Jul 2025 15:48:24 +0200
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] mnl: Support NFNL_HOOK_TYPE_NFT_FLOWTABLE
Message-ID: <aG0hqMPin_1AjNnT@strlen.de>
References: <20250708130442.16449-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708130442.16449-1-phil@nwl.cc>

Phil Sutter <phil@nwl.cc> wrote:
> New kernels dump info for flowtable hooks the same way as for base
> chains.

Reviewed-by: Florian Westphal <fw@strlen.de>

