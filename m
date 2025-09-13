Return-Path: <netfilter-devel+bounces-8795-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (unknown [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB0B56307
	for <lists+netfilter-devel@lfdr.de>; Sat, 13 Sep 2025 23:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E195642DF
	for <lists+netfilter-devel@lfdr.de>; Sat, 13 Sep 2025 21:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF6B273800;
	Sat, 13 Sep 2025 21:07:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C858272E4E;
	Sat, 13 Sep 2025 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757797672; cv=none; b=KOWG0VDXHhCxf4eD5yvOkcy/gPpGAeNxAFh7qkEJJwxY/5Turmttjl7TAN7DuXBzbpO0rNQkgeqMmruvl2N35PjQWG9rLD7MqwSXib3wk5Vmk5M+0bHv9u5AbojrqE/6Dd7J+Td12SwhcOpFv/2vRblPlFwEGhQFwyZCR5kRxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757797672; c=relaxed/simple;
	bh=TpPJV+z8X31oEQr5H7IMxdmgDk0MXe32JdWl3kgMHdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTk30gALJ+Mhhf+a+BmPRwZte6vGL66PZxBR1JhC7cAjcmbTAyTED7zu9xwk7Azuj7Sq1crh1nqH4JMWXD4ed7XlSCvN/ale6WfpSHTs13ci6LzJBfrCp/wmM4/RCEwOq50K9p1P1AVC43bmJ4A4+T0rvC0p1r5A5k3IjV8i5t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3447F6014E; Sat, 13 Sep 2025 23:07:48 +0200 (CEST)
Date: Sat, 13 Sep 2025 23:07:47 +0200
From: Florian Westphal <fw@strlen.de>
To: Julian Anastasov <ja@ssi.bg>
Cc: Slavin Liu <slavin452@gmail.com>, Simon Horman <horms@verge.net.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	lvs-devel@vger.kernel.org, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ipvs: Defer ip_vs_ftp unregister during netns cleanup
Message-ID: <aMXdI110cKP1bwsx@strlen.de>
References: <20250911175759.474-1-slavin452@gmail.com>
 <0effae4a-4b9d-552e-5de7-756af4627451@ssi.bg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0effae4a-4b9d-552e-5de7-756af4627451@ssi.bg>

Julian Anastasov <ja@ssi.bg> wrote:
> > Fixes: 61b1ab4583e2 ("IPVS: netns, add basic init per netns.")
> > Suggested-by: Julian Anastasov <ja@ssi.bg>
> > Signed-off-by: Slavin Liu <slavin452@gmail.com>
> 
> 	Looks good to me for the nf tree after above text is
> changed, thanks!

Thaks Julian for reviewing, i pushed it to nf:testing.

