Return-Path: <netfilter-devel+bounces-6853-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6AAA88D28
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Apr 2025 22:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9C217D1A1
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Apr 2025 20:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241C1ACED9;
	Mon, 14 Apr 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="FvcfuvCP";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="JoIkPnE3"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1719066D;
	Mon, 14 Apr 2025 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744662764; cv=none; b=VnuFeiIJ8z+xy5c/2vn+d3b/ynXYNN9yjdTxiPF54kn/iRReaqGSZ+FyxAJnKUo8MQhtAf9TJLFo7d8jcwPc0MRDES+zSrk/SN2FtYgnQB5U/XNcJBGI0EpUX60MrIf4tw/EuaeLCXO50ZYvtyA54o5jeTyeD9mZEoHeCDZ0HWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744662764; c=relaxed/simple;
	bh=FAvrI2+m9SRMjZdjbPKUQYqu62HVLXW/dyjOnPTju6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+mD4hkQibNT02GISP1NVcZmNkRiy9sz8YKSCNCq7TDYO5bep3l+wBuzrrOJGDzTHTVbx4qxPysidd19llLV/wy+0AziSFADvl4MWURjHI1ox0Re5hqDSJYEoScljFRe5LJS/ZJpeQkA92KMnprSO4wP6F6V5ek0MFaGGRHdDWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=FvcfuvCP; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=JoIkPnE3; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 1AC88609FF; Mon, 14 Apr 2025 22:32:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1744662759;
	bh=nsfIOXTKuMcZA2mXx7SBErN3cQD88AzyBR8Ope7Dbuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FvcfuvCPWbmRxWHbaleWS1OE5twelvFgRZ6Jo60MNtvRQ7ToPjRxyzHn/TMUJzwVp
	 wFt86bb8BwegrOfHjeZgEwU4dbsjc157gNYI4UMM/4h2A/0swQsjVkyNGBzec91G3l
	 aknRu/yB03yTeJ4HSMcEPRRCLbng7qi4J3vtv2aVZVmrODum1dKOz9s8yO9vg86EbQ
	 3JjhAYW9I6tuYcolCkENH7bM//s1h5vdPNLgXZfsVLxeljPvp6QU1cUv5wkjahXAEU
	 UM5tcxS+g6N9GoJ0np2fEA9KCqNCIeVQKGEWUGWM/PAkzQQT+Xdk6a1S8IvI5Hyp/J
	 ekkPAAlb766pg==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id BC244609FF;
	Mon, 14 Apr 2025 22:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1744662757;
	bh=nsfIOXTKuMcZA2mXx7SBErN3cQD88AzyBR8Ope7Dbuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoIkPnE3swugdox9+bHKQVnRtgTmbXescMH4Zd/YKH8ko2MeYJ05OBdsCf+lVSyTy
	 3482RDG62YK1gGXRFX4v0EsR6xeby+qF7fovIyPU0g1zTv1NJOoI070d37X2IUtrzV
	 2rDNyE41wP6JZ10JxDal2s1G3Rsfke71DrG7Elo0Zyk87S5qKUDF86uzM50U9JZ8Vm
	 5HGOl/KGulg+9YW0zdrHV1EXlA+sDE1+iY5JevAj8kAG/sAe/goktTm6t+cPdfGwO4
	 gv+rRMW9+pGe/ysVYTDT4frB+GUEmyzNYw8t5X9QQL4Y0wmPCzXr4ptc5FeV4EmIOj
	 i0BV/zcO45jhw==
Date: Mon, 14 Apr 2025 22:32:34 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jan Engelhardt <ej@inai.de>
Cc: netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org,
	netfilter-announce@lists.netfilter.org, lwn@lwn.net,
	netdev@vger.kernel.org
Subject: Re: [ANNOUNCE] nftables 1.1.2 release
Message-ID: <Z_1w4l06ggfxT9b4@calendula>
References: <Z_1KxMUDT0D8e6wH@calendula>
 <oo77o28s-265o-8pn2-q790-9p64522on819@vanv.qr>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <oo77o28s-265o-8pn2-q790-9p64522on819@vanv.qr>

On Mon, Apr 14, 2025 at 10:19:48PM +0200, Jan Engelhardt wrote:
> 
> On Monday 2025-04-14 19:49, Pablo Neira Ayuso wrote:
> >You can download this new release from:
> >https://www.netfilter.org/pub/nftables/
> >[ NOTE: We have switched to .tar.xz files for releases. ]
> 
> $ tar -tf nftables-1.1.2.tar.xz|grep main.nf
> nftables-1.1.2/files/nftables/main.nft
> 
> This file I do not see it in the git repo.
> main.nft is not autogenerated when running the usual
> autoreconf/configure procedure from the git repo either.
> 
> main.nft was part of my earlier patch about adding a systemd unit,
> but that was not applied yet either.

That was my release script, it did not pick up on a clean clone,
it has picked up on tree including this leftover after local revert.

