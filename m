Return-Path: <netfilter-devel+bounces-8207-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27D8B1D5E4
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Aug 2025 12:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634CC3B3C0E
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Aug 2025 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA2A23815D;
	Thu,  7 Aug 2025 10:37:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CE42AA5
	for <netfilter-devel@vger.kernel.org>; Thu,  7 Aug 2025 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754563041; cv=none; b=q0Q4x+lcZGob1Vxns/ett9/7Q231SogtnJOlD/AmQH+QTPkNl983Mv8bDQchuLelryNvoTZKh6xZTAzCPEBaCD3jHXeCc6vsOH4qIz7CnH5EwWUR0gkShF8rmrx/gAbEKo8fxe6QERLBr1MmCYpWQZ9gc/0XM/EV2/b+VKAyyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754563041; c=relaxed/simple;
	bh=i3hKE1yGhsnTLqcYfQwZGi9zQSlZXpEEPJvdonvCMsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx5M83s7iJCFlbjV4C7G3iXBYjvCz3aer3SLq/8Fu4kh9NNccq5joeh1/VBEnlbN5InJyJLJrBXN+Rz/6IuxYnvEsKOWnbKvVy/Mc9i0MDl4kV8Pm4Jwgk60COMtsRQZH5dAoIZJS5tIHXg683QdcVRsTA7WugVM9E8Zkc6iGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id BB5496061F; Thu,  7 Aug 2025 12:37:08 +0200 (CEST)
Date: Thu, 7 Aug 2025 12:37:08 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_socket: remove WARN_ON_ONCE with giant
 cgroup tree
Message-ID: <aJSBzdY6FvFHvhZ9@strlen.de>
References: <20250807100516.1380006-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807100516.1380006-1-pablo@netfilter.org>

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> syzbot managed to reach this WARN_ON_ONCE with a giant cgroup tree,
> remove it.
> 
>   WARNING: CPU: 0 PID: 5853 at net/netfilter/nft_socket.c:220 nft_socket_init+0x2f4/0x3d0 net/netfilter/nft_socket.c:220

I looked at the repro and as far as i could see it just passes
a large NFTA_SOCKET_LEVEL attribute value.

I'd propose:

syzbot managed to reach this WARN_ON_ONCE by passing a huge level
value, remove it.

Patch is correct though.

Acked-by: Florian Westphal <fw@strlen.de>

