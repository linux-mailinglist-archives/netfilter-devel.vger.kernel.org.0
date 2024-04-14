Return-Path: <netfilter-devel+bounces-1772-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA88A2FB4
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Apr 2024 15:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A3C1C23B63
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Apr 2024 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03883CD8;
	Fri, 12 Apr 2024 13:40:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09883CD1;
	Fri, 12 Apr 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929253; cv=none; b=hfnvwObVChSCbaUzGnIqMhmk+H60oKc5SwTdgS3LggLde4JpIBLPPSCGOe/CPBm3uOwCQ2zO+FWaEBgiNYh6YVXgm5CsDQYJVlm2UJqFk6LivruyibDLmzGLITTdgakGLYq+CcYzk2gEH5uOFifGyH7Fg0H1hjua/fl4dzdcaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929253; c=relaxed/simple;
	bh=M6GpdF3l9nDUuFyd7w6GJ5Usgxo66azRNpRVHk8rMV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwvCJhzumSLFbBEaC6XegHuEGquGnM0/8z1qclYAZMqtQUH1ERgwRyVmg/R1chsGt6Ls9Dv0Zqy9GKiweydvylCgK9XBphQ43i40imXk84QFdy7Otgww34qkdyLJ34HI8jAD0uiKwq0b3rEqHhWFFGQuyJJSNsqx/25ImBrBaA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rvH95-0005tI-VH; Fri, 12 Apr 2024 15:40:47 +0200
Date: Fri, 12 Apr 2024 15:40:47 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net-next 00/15] selftests: move netfilter tests to net
Message-ID: <20240412134047.GA22157@breakpoint.cc>
References: <20240411233624.8129-1-fw@strlen.de>
 <20240411191651.515937b4@kernel.org>
 <20240412065330.GG18399@breakpoint.cc>
 <20240412063848.11b3bc51@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412063848.11b3bc51@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Jakub Kicinski <kuba@kernel.org> wrote:
> Alright, the workers are churning. For now I excluded this target from
> patchwork reporting, but they are running and showing up on the status
> page (in the ignored section).
> 
> Looks like most of the tests skip:
> https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-04-12--12-00&executor=vmksft-nf
>
> I looked at a few, they all said:
> # mnl_socket_open: Protocol not supported
> 
> The resulting kernel config is here:
> https://netdev-3.bots.linux.dev/vmksft-nf/results/548802/config

CONFIG_NETFILTER=n

I'll make sure that all tests skip in this case and will add it
to the config file.

