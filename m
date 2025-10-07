Return-Path: <netfilter-devel+bounces-9074-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC1BC116E
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Oct 2025 13:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E9D54F54D9
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Oct 2025 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103252D8388;
	Tue,  7 Oct 2025 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="qcxRcdK3";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="h6nbr56Q"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0124165F16;
	Tue,  7 Oct 2025 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835294; cv=none; b=EBehxCOe3qbwj7veksfv42U17vt7IJpCgikplTD7EcQnyYzXpxFI4ylOkvUDwrlqtadKRxTdeUO+Gm0paCWxIk3XxnIB6rKEDDd5GHTVOWZDcDBfm24cu+U/LEbNW0TYnkjPJuO8tYpImLH/1ET/ekE2UdlBd1HfbSsPn5tg3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835294; c=relaxed/simple;
	bh=TlzaEHv2Kypr40jJY1wIdrwQoo+uK/cxkq+U4OldIUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6ZFalXFH0uIADxExdVWYms1wUnYULAp8khNwn/EgM/CrMyKpI4IOhlhfVgGEKDZujnaU/1kcKIXa52YqaaXxs9ugJsqP4fqHYWiVf7L2Lpqi1CMtsm2lRRuAP5owgnrGboEFmQM9gKJ5wv/ctJqvaNYMFgUpwJQB9IaNosZQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=qcxRcdK3; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=h6nbr56Q; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 8EB826026D; Tue,  7 Oct 2025 13:08:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1759835283;
	bh=+g3fL2cw06Ac2SbpkzNP/E42Y27Abj0WqG9P/o6zQtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcxRcdK37bbLd5J5D+lC+0+w2sdszpbNiegbdT6wmJS9mf4aOH6vNBx9Xm+NZrKnh
	 ElwbHOZAX0EycF5AmNR9gI4Ul6AuNhiF5Q1Fj7MdlREBRsmS3+CS0gFLOnTWfmYkYp
	 bMhGM9jIVLvBKeNG86UipsaQuXIgwxI1Ovgo03wmTvu5N8/q3WY/SOOWytjp0N+eYG
	 ngmKGGg53BNh/01cvoTn6Qd2gXYCrCsrL14LeDoFa4ixV8zS11+Stpv98KLEkmD5Vn
	 M0jTD8/yt9RQ0HgAbsL9CGUZytVU+s6mKxwiGP9cbOsx3wH44mJbr/XafU6YnzAchG
	 +F7M/kCOpS0fA==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id BAB29600B9;
	Tue,  7 Oct 2025 13:08:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1759835280;
	bh=+g3fL2cw06Ac2SbpkzNP/E42Y27Abj0WqG9P/o6zQtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6nbr56QAFP7HKiIsitfy90E9iSweZogqtKnlEzd2YAWYFnDihlEyfJg2ZuK1tHvV
	 lKOEt5+wSfnfa1llF7pE6HFv8uE0MX9C3tq/dawAJ+BnzGoRmJyys70WaLMAK9LlDk
	 Ga2ApCf7U3OvqoIIe3AzQLJNDXrrJ/wj6PHUi71Vnztnt2Ixth4W+A8m2toEK8ccMY
	 VQN9+ddX1Ob5HqUNaERGsQsI06FbGpmgZAiEXl+yieektPw2E3+BaYPKUfAFCqQ7uQ
	 nlIuE06ZzK7EIUpoOUxHndRRERM+h0gYeNuGVHqNPfIrI62j+wNeSE9IJLQVC2im/p
	 CuTlrBdy/kDoA==
Date: Tue, 7 Oct 2025 13:07:57 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v1 nf] bridge: br_vlan_fill_forward_path_pvid: use
 br_vlan_group_rcu()
Message-ID: <aOT0jTumQq39V7p2@calendula>
References: <20251007081501.6358-1-ericwouds@gmail.com>
 <aOTm6AUL8qeOw0Sp@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOTm6AUL8qeOw0Sp@strlen.de>

On Tue, Oct 07, 2025 at 12:09:51PM +0200, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
> > Bug: br_vlan_fill_forward_path_pvid uses br_vlan_group() instead of
> > br_vlan_group_rcu(). Correct this bug.
> 
> @netdev maintainers:
> 
> In case you wish to take this via net tree:
> 
> Reviewed-by: Florian Westphal <fw@strlen.de>
> 
> Else I will apply this to nf.git and will pass it to -net
> in next PR.

There are more fixes cooking, probably we can prepare a batch.

