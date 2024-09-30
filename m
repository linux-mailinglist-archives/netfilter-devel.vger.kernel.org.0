Return-Path: <netfilter-devel+bounces-4163-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4C6989E34
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Sep 2024 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3591F222E7
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Sep 2024 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24D7188737;
	Mon, 30 Sep 2024 09:29:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3E188739
	for <netfilter-devel@vger.kernel.org>; Mon, 30 Sep 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688577; cv=none; b=vE2nH2eYOEP8oZuOA/yfczFSCy3rU7mt1/rLdvqW/7H+xvBafN+jDDmEaF9e4YEtbCvgE96+EuSamKXVkQCFWA3x+9RJzF8Z+6LjN1w28avM0aj94KTXnqDCXPhpkKWNjzy6rvzJu+0pGI6P2oVu08QkP7/TSeaQvzO7/Dk/pkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688577; c=relaxed/simple;
	bh=HjpUA+4kgOTweSHcZ1D+9BpyfGzZETR/nBTYJDHME0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9eIUVdp/To4PMj04RFB2hoTOkDh0s2XxXdIljCm47bVQ0/KNppPTA3bOYvtotYL5ujqXlHJLLuBrhVwSPuqDlKeRlA2mKJcvU2wbryxdCfFIt8uh+u3cIC0GNmiEYahMuRTSABYJPulfb7kuB5maS/q17tBk2FMdoM18YwhpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1svCic-0003VH-OW; Mon, 30 Sep 2024 11:29:26 +0200
Date: Mon, 30 Sep 2024 11:29:26 +0200
From: Florian Westphal <fw@strlen.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	netfilter-devel@vger.kernel.org, Michal Kubecek <mkubecek@suse.de>
Subject: Re: [PATCH] nf_conntrack_proto_udp: do not accept packets with
 IPS_NAT_CLASH
Message-ID: <20240930092926.GA13391@breakpoint.cc>
References: <20240930085326.144396-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930085326.144396-1-hare@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hannes Reinecke <hare@kernel.org> wrote:
> Commit c46172147ebb changed the logic when to move to ASSURED if
> a NAT CLASH is detected. In particular, it moved to ASSURED even
> if a NAT CLASH had been detected,

I'm not following.  The code you are removing returns early
for nat clash case.

Where does it move to assured if nat clash is detected?

> However, under high load this caused the timeout to happen too
> slow causing an IPVS malfunction.

Can you elaborate?

> This patch revert part of that patch, as for NAT CLASH we
> should not move to ASSURED at all.

>  		nf_ct_refresh_acct(ct, ctinfo, skb, extra);
>  
> -		/* never set ASSURED for IPS_NAT_CLASH, they time out soon */
> -		if (unlikely((status & IPS_NAT_CLASH)))
> -			return NF_ACCEPT;
> -
>  		/* Also, more likely to be important, and not a probe */
>  		if (stream && !test_and_set_bit(IPS_ASSURED_BIT, &ct->status))
>  			nf_conntrack_event_cache(IPCT_ASSURED, ct);

AFAICS with this patch we now do move to assured unconditionally?

The changelog and patch seem contradictory to me.

