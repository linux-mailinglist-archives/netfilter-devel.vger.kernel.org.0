Return-Path: <netfilter-devel+bounces-2337-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63488CF16D
	for <lists+netfilter-devel@lfdr.de>; Sat, 25 May 2024 23:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7B61F2152D
	for <lists+netfilter-devel@lfdr.de>; Sat, 25 May 2024 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086CA1292F3;
	Sat, 25 May 2024 21:30:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283D4AEDD;
	Sat, 25 May 2024 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716672604; cv=none; b=qiooFyn4eiqNUMdrSknk/57Gzf+DMiVbqXdY7qmLIHztWr/AVgHKGpjHWIgAUth4e4XoQX4Xiz1k9ZRZ398x3fGKwdP29eRybAFAo5z0rqkp0td/J2hcgujSjPGeHjbc3zLldVmEqK5fnK3iHCGv9bM581OqF3Rru/tmg9Z+qFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716672604; c=relaxed/simple;
	bh=uMa4nezDbDnXB+oUokmDIbyPw/eWo46wVQCYCJUScDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O91A6yVsnU6UdOy5kz+7T5cTPquzqkNJ0AyBJIOn9+ecuJ14CjyG6bJ9Fgvr59rCWahmA7GnSR4Mf1jJy/OMos6l1Mhx1UgrOAHIjRVObK9g2L31voDPS2giB5qWGTgrUFg8kG+Q9F5vHXlOZiZD4H3iDHtyBt41y47GqvDKkyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Sat, 25 May 2024 23:29:51 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, fw@strlen.de
Subject: Re: [PATCH net 0/6,v2] Netfilter fixes for net
Message-ID: <ZlJYT2-sjA8gypwO@calendula>
References: <20240523162019.5035-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523162019.5035-1-pablo@netfilter.org>

Hi,

On Thu, May 23, 2024 at 06:20:13PM +0200, Pablo Neira Ayuso wrote:
> v2: fixes sparse warnings due to incorrect endianness in vlan mangling fix
>     reported by kbuild robot and Paolo Abeni.

I realized checkpatch complains on use of spaces instead of
indentation in patch 4/6.

I can repost the series as v3. Apologies for this comestic issue.

Thanks.

> -o-
> 
> Hi,
> 
> The following patchset contains Netfilter fixes for net:
> 
> Patch #1 syzbot reports that nf_reinject() could be called without
>          rcu_read_lock() when flushing pending packets at nfnetlink
>          queue removal, from Eric Dumazet.
> 
> Patch #2 flushes ipset list:set when canceling garbage collection to
>          reference to other lists to fix a race, from Jozsef Kadlecsik.
> 
> Patch #3 restores q-in-q matching with nft_payload by reverting
>          f6ae9f120dad ("netfilter: nft_payload: add C-VLAN support").
> 
> Patch #4 fixes vlan mangling in skbuff when vlan offload is present
>          in skbuff, without this patch nft_payload corrupts packets
>          in this case.
> 
> Patch #5 fixes possible nul-deref in tproxy no IP address is found in
>          netdevice, reported by syzbot and patch from Florian Westphal.
> 
> Patch #6 removes a superfluous restriction which prevents loose fib
>          lookups from input and forward hooks, from Eric Garver.
> 
> My assessment is that patches #1, #2 and #5 address possible kernel
> crash, anything else in this batch fixes broken features.
> 
> Please, pull these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-24-05-23
> 
> Thanks.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit 4b377b4868ef17b040065bd468668c707d2477a5:
> 
>   kprobe/ftrace: fix build error due to bad function definition (2024-05-17 19:17:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-24-05-23
> 
> for you to fetch changes up to ece92825a1fa31cf704a5898fd599daab5cb6573:
> 
>   netfilter: nft_fib: allow from forward/input without iif selector (2024-05-23 17:56:31 +0200)
> 
> ----------------------------------------------------------------
> netfilter pull request 24-05-23
> 
> ----------------------------------------------------------------
> Alexander Maltsev (1):
>       netfilter: ipset: Add list flush to cancel_gc
> 
> Eric Dumazet (1):
>       netfilter: nfnetlink_queue: acquire rcu_read_lock() in instance_destroy_rcu()
> 
> Eric Garver (1):
>       netfilter: nft_fib: allow from forward/input without iif selector
> 
> Florian Westphal (1):
>       netfilter: tproxy: bail out if IP has been disabled on the device
> 
> Pablo Neira Ayuso (2):
>       netfilter: nft_payload: restore vlan q-in-q match support
>       netfilter: nft_payload: skbuff vlan metadata mangle support
> 
>  net/ipv4/netfilter/nf_tproxy_ipv4.c   |  2 +
>  net/netfilter/ipset/ip_set_list_set.c |  3 ++
>  net/netfilter/nfnetlink_queue.c       |  2 +
>  net/netfilter/nft_fib.c               |  8 ++-
>  net/netfilter/nft_payload.c           | 95 ++++++++++++++++++++++++++---------
>  5 files changed, 82 insertions(+), 28 deletions(-)
> 

