Return-Path: <netfilter-devel+bounces-9573-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920A6C22B55
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 Oct 2025 00:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E711A228D9
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Oct 2025 23:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658EA2E8B9C;
	Thu, 30 Oct 2025 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="G4xu24wY"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934382550AF
	for <netfilter-devel@vger.kernel.org>; Thu, 30 Oct 2025 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761867044; cv=none; b=JQur+xt5ViXissgyhit50sgpRzeXZg5XMImEslD5bjap8/W896oadpiK+ivH2Ybxu8EyHkQdim3fDYs/ayp+evEHIEuSvq9cF7wEMwmnm1tGabFFOcJezDzl4pk8/c2vdtPj04ZxtQHW3yJxlnLmGXoUVtOs+0Wz5TyED8ba4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761867044; c=relaxed/simple;
	bh=AS2v74IS3unpKfBMpop6+0nhasFdhXL3KBWfp0Wqwso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GREe+gZ6wF/FkmihdK4/DQaTG/sWc50lp6zk2MIaicQ31/nrdNSM61pGSRZawwM0mrt8DSv8C+9HjKUusPP/+9PBQ2pMffNPrFW6TV4IcuY2mT6vKI05zY05l7wP52Z855LIXRJ3jDRy5N+XVklzjYnjb1++IUSWSPNwhx/6DCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=G4xu24wY; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 63D586026F;
	Fri, 31 Oct 2025 00:30:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1761867040;
	bh=W5C3t/qqaNxswcLk2JukL8U8t7j7F29AXAS1h8RTZGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4xu24wYaETB/tadRqJ/vjGPoDBqbfP3eBH756qXuyWk4EBX0E7mOy7tzjRYa/fv9
	 3N0z69rm6wy3mDt5hbtkyXUwiojBRMcdpzhMKTlJ4D1j/y/zCQKNWcpmD6SWf5klUY
	 LJBpbMe+fErdaJb0zkHlzxeuUMoxiEKHtDcPWHyQvBCV5n09ywuc3urKB814Dujr16
	 1/JiD6W5QNRJsM+W2OsuLvklUNTvKa8f9tVZoAy0FjeO7EG7KxpINYhLnSp4x7sZfE
	 U9pPYYPhQnFWC6p8OpZ+uFnhGa3dTOzxNH+hvQxky8DKGUxKQJ5ZmsbBRSMuzd42CQ
	 2LcS+MHFuKL+Q==
Date: Fri, 31 Oct 2025 00:30:37 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: nftables.service hardening ideas
Message-ID: <aQP1HRqdYtTFxQD8@calendula>
References: <71e8f96ac2cd1ee0ab8676facb04b40870a095a1.camel@scientia.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71e8f96ac2cd1ee0ab8676facb04b40870a095a1.camel@scientia.org>

On Mon, Oct 27, 2025 at 04:36:08AM +0100, Christoph Anton Mitterer wrote:
> Hey.
> 
> This would be ideas about further hardening nftables.service, primarily
> using the options from systemd.exec(5).

Thanks, it general I would prefer if this nftables.service in the tree
remains simple.

For more advanced configurations, probably we can provide a list of
extra configurations for the paranoid users that they can apply to
refine in some other form (wiki page?).

Thanks.

