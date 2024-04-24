Return-Path: <netfilter-devel+bounces-1951-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CAE8B160E
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Apr 2024 00:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94D81C2271A
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Apr 2024 22:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617FD161B6B;
	Wed, 24 Apr 2024 22:20:15 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B213AD0D;
	Wed, 24 Apr 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997215; cv=none; b=XvkSJHbd01Pn7xBg/guPjhX0mzhpavQ8ZbqS/14hLBfCLWBTV1MZTEoRNa8Bh/WKM1XZIvTzMGSIh0z17mcQhHt2EXiXIscMuAieeBbjkJ1D2gUXOEg8nWjOe2RokF5JE27AEe2HoAI4kWG0VHYUZdJSlmwjaWL1JcsOIl44J2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997215; c=relaxed/simple;
	bh=2SanSr9ivrXvN7XrjSoc2KbOt8Z+ZjzTk7lp7LZ4U1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKMB7uwYGZ9tP2a/bg/VzeGHOuknfV8mjcM/5RwLjOXfEggl2JMbVWBUEAoqh98jaqSjpQVYT/pQ1eOWNXZoWZZr5Mjpu3q381WW21pET6wG98mejh5gMhxOZfG+ENcKnoCduNZlupxz/HrZi5qgCP7bPWzzExLFqmiavv8yfjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Thu, 25 Apr 2024 00:20:09 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: linke li <lilinke99@qq.com>, xujianhao01@gmail.com,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: mark racy access on ext->gen_id
Message-ID: <ZimFmQDa4WdibJec@calendula>
References: <tencent_284407955020261D1B2BD142194A87C9EB0A@qq.com>
 <20240423120309.GA18954@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240423120309.GA18954@breakpoint.cc>

On Tue, Apr 23, 2024 at 02:03:09PM +0200, Florian Westphal wrote:
> linke li <lilinke99@qq.com> wrote:
> > In __nf_ct_ext_find(), ext->gen_id can be changed by 
> > nf_ct_ext_valid_post(), using WRITE_ONCE. Mark data races on ext->gen_id
> > as benign using READ_ONCE. 
> > 
> > This patch is aimed at reducing the number of benign races reported by
> > KCSAN in order to focus future debugging effort on harmful races.
> 
> Acked-by: Florian Westphal <fw@strlen.de>
> 
> Should proably go to nf tree.

Can I get a Fixes: tag for this one?

