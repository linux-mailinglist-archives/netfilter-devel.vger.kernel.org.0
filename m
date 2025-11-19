Return-Path: <netfilter-devel+bounces-9824-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C51C6E91E
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Nov 2025 13:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5061B2DC35
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Nov 2025 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E2D30E855;
	Wed, 19 Nov 2025 12:45:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7442BE04C
	for <netfilter-devel@vger.kernel.org>; Wed, 19 Nov 2025 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556305; cv=none; b=DP/EPeYCRY7ny3Ig+v0XgqOKOR+OC5RL8HqZFzaBrjh8y/qpc2zv12i45Ye2paKqGfvI5iyhwfPiIFjRhoeBqGkWNEAoN7Jm+zE04/ks6uQBRCXtmUY7BqEbbRUKW0tS4BiUOM6BT9d7zWay3I8ILvBzbDF42VIbDi2Ji1D26p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556305; c=relaxed/simple;
	bh=yD5KsYtxhgOoAqJuIejvWybXRTkO5x91cno+URLzIVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maW0rxqGcj0CtxLGDLdk7KKpJdQ8F4ZWx7tsEo95QERliSP0EokcYC7/q2njlR//cnSMqHifNXG/o2tCbS82WA49p/5tlm3Z6xRc0ITLlgpx7Vpzo1flZlWDhlzkG//xrAcVEU2mjcpmEKLBYyD2RGyiGnSPZp3N1VDqH7Er2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B20B9604EF; Wed, 19 Nov 2025 13:44:58 +0100 (CET)
Date: Wed, 19 Nov 2025 13:45:00 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_tables: remove redundant chain
 validation on register store
Message-ID: <aR27zHy5Mp4x-rrL@strlen.de>
References: <20251119124205.124376-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119124205.124376-1-pablo@netfilter.org>

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> This validation predates the introduction of the state machine that
> determines when to enter slow path validation for error reporting.
> 
> Currently, table validation is perform when:
> 
> - new rule contains expressions that need validation.
> - new set element with jump/goto verdict.
> 
> Validation on register store skips most checks with no basechains, still
> this walks the graph searching for loops and ensuring expressions are
> called from the right hook. Remove this.
> 
> Fixes: a654de8fdc18 ("netfilter: nf_tables: fix chain dependency validation")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> Supersedes: ("netfilter: nf_tables: skip register jump/goto validation for non-base chain")
> 
> No rush to apply this, still running a few more tests here on it.

Thanks!  I wonder if this impacts error location reporting.

I agree its not needed from correctness p.o.v. since commit (or abort)
validates entire completed ruleset.

