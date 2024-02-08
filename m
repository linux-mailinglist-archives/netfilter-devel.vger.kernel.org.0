Return-Path: <netfilter-devel+bounces-956-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB9C84DAFF
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Feb 2024 09:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3582868E6
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Feb 2024 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB81F69E00;
	Thu,  8 Feb 2024 08:07:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp2-kfki.kfki.hu (smtp2-kfki.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D26A00D;
	Thu,  8 Feb 2024 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379639; cv=none; b=aWxX2U5nhK2hK2vFqK3qFnpDY4ai4LSqxdryddbTlWinonrgL/O10GEQq001dQMANRUQ88YMt9xa/+Imfe8xXMbFIdAtW7kD9Z7Ysa9RR7fAPtS9clYucmSGALUDOYrQOBbv2+mnwDJ+W0PchvEYhhx5MjjzyN8lKRKxp0MNef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379639; c=relaxed/simple;
	bh=V4Bw8Qj+uqtX499d2ys+i3DQhkzLLfT/SECS4cP3Tv0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sjG4whi4e5Fqx5t/99zphdZw8aH+I2dG24sW0WUNWhfuLageEZeepcU2r/lYtT1v/LJ29WX9h3CXvWdtLVz44WkTkcnDCxoabRIwoOYfJh5ZTwjl4A0uJe23TC/xXZb+aexgnPQ09b+Y+GO5yss8wG9RVk86dxOhcchywQwil0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=148.6.0.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 2AE45CC02CD;
	Thu,  8 Feb 2024 09:07:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
	by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP; Thu,  8 Feb 2024 09:07:04 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
	by smtp2.kfki.hu (Postfix) with ESMTP id DDD5CCC0102;
	Thu,  8 Feb 2024 09:07:02 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id DDD53343167; Thu,  8 Feb 2024 09:07:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id DBAFE343166;
	Thu,  8 Feb 2024 09:07:02 +0100 (CET)
Date: Thu, 8 Feb 2024 09:07:02 +0100 (CET)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Pablo Neira Ayuso <pablo@netfilter.org>, 
    NetFilter <netfilter-devel@vger.kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the netfilter tree
In-Reply-To: <20240208155740.24c6ada7@canb.auug.org.au>
Message-ID: <73b75396-dd59-13eb-cee5-e77c4068ea02@netfilter.org>
References: <20240208155740.24c6ada7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Thu, 8 Feb 2024, Stephen Rothwell wrote:

> In commit
> 
>   6099505cd2a2 ("netfilter: ipset: Missing gc cancellations fixed")
> 
> Fixes tag
> 
>   Fixes: fdb8e12cc2cc ("netfilter: ipset: fix performance regression in swap operation")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant:
> 
> Fixes: 97f7cf1cd80e ("netfilter: ipset: fix performance regression in swap operation")

Yes, exactly. Accidentally I used the tag from my git tree and that caused 
the incorrect tag value. If that's OK, I'll send a fix for the nf-next 
tree when the patch reaches it.

Best regards,
Jozsef
-- 
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary

