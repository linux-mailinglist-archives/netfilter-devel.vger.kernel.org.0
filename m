Return-Path: <netfilter-devel+bounces-8006-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A655B0E7F3
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Jul 2025 03:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8931897906
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Jul 2025 01:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632CA15B0EF;
	Wed, 23 Jul 2025 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="j31g/adN";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="j31g/adN"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145F4A1A
	for <netfilter-devel@vger.kernel.org>; Wed, 23 Jul 2025 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753233260; cv=none; b=Psqhlx7wYMn3oiqj7pbPbu5PPZFPcAq69CVMwjdff8rycQtNjnOD5TfS8QVhe07Sn+2GapSCJecT4Pon2eonD4GesNdIPavfjk1TWNc3U1VuqZXY5PUt9yrBEFr9XOV00Em/pBIYLm3rY/CxhANLR4MHNQiPZEgLwzi41tZb1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753233260; c=relaxed/simple;
	bh=WwPMdf1ZK2At6prB5+4fq/UtZMQvE/ArVa1+Tr+MiJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSxO4usgqSCWXZo/ybVkAEaoHWid6Mt7ehl8+brkVcVLfvJss8gZ0SgmmRme7ksi48puNoKtTc3hjcwfLVkSE8yCYLAL1dAdP/TOvuiCDo7U3sLxRD4YjTwx0XTYH5vv02vVMLEmVG2XN7pKYOS5PondVo7WFC0eIYT9sqlmlhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=j31g/adN; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=j31g/adN; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id A19DA60276; Wed, 23 Jul 2025 03:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1753233256;
	bh=DinyTYXiVCxiMIib2PM3NI2goWKphIf2lNiHn6rKN4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j31g/adNKR14t1n+qnEokEy+DMluaaTSPBFoqe/hJpY1qOF3x70n7qc+Ju6fvl1Bl
	 MTuAjgKpdnnJ1s9ihMUlDOkMD9ifwDQOJw+Y9aGzAxz20DDbSuoLkI0YgkZseWl2qz
	 EEgft/BgLAb+0r69+koqnLSVWr8N8u0QyO0e+lyAfDXjsD801INdEzX93cggA5uIxo
	 zaZm/LkGtDSoLrQgpacaL5uuenowXri/5nJ6lghsbVX6wf5DblFgrchUKjwvFWRVWM
	 5QjLDHPKgzV/NcsTAdVDSUai6Q4GFKrCN9LTXET9+aPkIiwQKYZSiCx5VrbBG6fFI8
	 VZ51Ds5HcVAYw==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id AB1236026C;
	Wed, 23 Jul 2025 03:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1753233256;
	bh=DinyTYXiVCxiMIib2PM3NI2goWKphIf2lNiHn6rKN4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j31g/adNKR14t1n+qnEokEy+DMluaaTSPBFoqe/hJpY1qOF3x70n7qc+Ju6fvl1Bl
	 MTuAjgKpdnnJ1s9ihMUlDOkMD9ifwDQOJw+Y9aGzAxz20DDbSuoLkI0YgkZseWl2qz
	 EEgft/BgLAb+0r69+koqnLSVWr8N8u0QyO0e+lyAfDXjsD801INdEzX93cggA5uIxo
	 zaZm/LkGtDSoLrQgpacaL5uuenowXri/5nJ6lghsbVX6wf5DblFgrchUKjwvFWRVWM
	 5QjLDHPKgzV/NcsTAdVDSUai6Q4GFKrCN9LTXET9+aPkIiwQKYZSiCx5VrbBG6fFI8
	 VZ51Ds5HcVAYw==
Date: Wed, 23 Jul 2025 03:14:11 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2 0/5] netfilter: nft_set updates
Message-ID: <aIA3Y3OjzhZ_hQVD@calendula>
References: <20250709170521.11778-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709170521.11778-1-fw@strlen.de>

Hi Florian,

On Wed, Jul 09, 2025 at 07:05:11PM +0200, Florian Westphal wrote:
> v2: minor kdoc updates.  I copied Stefanos RvB tags.
> 
> This series serves as preparation to make pipapos avx2 functions
> available from the control plane.
> 
> First patch removes a few unused arguments.
> Second and third patch simplify some of the set api functions.

Although it is a bit lengthy, I like this simplification.

> The fourth patch is the main change, it removes the control-plane
> only C implementation of the pipapo lookup algorithm.
> 
> The last patch allows the scratch maps to be backed by vmalloc.

This clashes with:

  netfilter: nft_set_pipapo: Use nested-BH locking for nft_pipapo_scratch

https://patchwork.ozlabs.org/project/netfilter-devel/list/?series=463248

It seems you and Sebastian have been working on the same area at the
same time.

Do you have a preference on how to proceed with this clash?

