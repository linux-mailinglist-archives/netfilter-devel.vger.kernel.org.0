Return-Path: <netfilter-devel+bounces-9365-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E0EC00D77
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Oct 2025 13:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EEF1891690
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Oct 2025 11:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE02D30F53F;
	Thu, 23 Oct 2025 11:44:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A430EF94;
	Thu, 23 Oct 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219871; cv=none; b=mv6cAoafbs3X7yy+d6hej53Ew7xP1E+chDb2Fb5t34WOA5OD6Hq0AN/d1vCtJHMU49S7iwEiSwI1/9xNhRYMRDloa921N7w2vxX5+K1AuaJeAZjs7KIKcKvSfF2lR/zjc2VHonik6p+wgHvTpLsomgzBaLlkU8IspiaskHSw2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219871; c=relaxed/simple;
	bh=040xscu4wa14076/gbRvelsiIP4rodklZm6AhgAIFMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtxP5vvTRmYIYMgbB3awtsOwI+tgGMrvvx1Z+g84nlZL5tgKnroX5xJ8We5R3FkriaEbthD3wTRDHX6cGkkwjxvll+2hLBBYNd8wAiVq9ei5fpm4aEFGziVV6qJMZMLsRtNRsZi23V/ZhTGhat52mwULm6LDmUGB27S/shyVZ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 143F7602B6; Thu, 23 Oct 2025 13:44:21 +0200 (CEST)
Date: Thu, 23 Oct 2025 13:44:12 +0200
From: Florian Westphal <fw@strlen.de>
To: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Dust Li <dust.li@linux.alibaba.com>,
	Jiejian Wu <jiejian@linux.alibaba.com>, rcu@vger.kernel.org
Subject: Re: [PATCHv6 net-next 01/14] rculist_bl: add
 hlist_bl_for_each_entry_continue_rcu
Message-ID: <aPoVDMXeakOsRGK1@strlen.de>
References: <20251019155711.67609-1-ja@ssi.bg>
 <20251019155711.67609-2-ja@ssi.bg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019155711.67609-2-ja@ssi.bg>

Julian Anastasov <ja@ssi.bg> wrote:
> Change the old hlist_bl_first_rcu to hlist_bl_first_rcu_dereference
> to indicate that it is a RCU dereference.
> 
> Add hlist_bl_next_rcu and hlist_bl_first_rcu to use RCU pointers
> and use them to fix sparse warnings.
> 
> Add hlist_bl_for_each_entry_continue_rcu.
> 
> Signed-off-by: Julian Anastasov <ja@ssi.bg>
> ---
>  include/linux/rculist_bl.h | 49 +++++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 9 deletions(-)

Are the RCU maintainers OK with this?
An explicit Ack or RvB would be good to have.

