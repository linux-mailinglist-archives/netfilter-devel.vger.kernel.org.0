Return-Path: <netfilter-devel+bounces-12025-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KqAKLet5GnLYAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12025-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Apr 2026 12:25:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DBA423A75
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Apr 2026 12:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4983300CC92
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Apr 2026 10:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360EE33859C;
	Sun, 19 Apr 2026 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="iSJ8aMgU"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90509175A6D;
	Sun, 19 Apr 2026 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776594355; cv=none; b=szJRGLX5veaWtXR3iNirxoMGUDK0hIJYt9l1DTFkSVdbYcw3LekMzZMWZsjP/TliYKIds2xeLFk7hcpwXb4vmBj04wULJUXkEo7BV/c9+EI4hTf/4qVABIQUGhoBVO8r5OvCm612zGCAW3nv5JfNBrCrt6H9E9pPGqpVMzkikPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776594355; c=relaxed/simple;
	bh=pGf27fHB6NDXa24eN9IR6YBaNfutpVi61d7JnshfYsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haO0uFN1r3YVODMgqIBJltL7bPCtxTzhcVLzJOEdB/y/CcT3Us07/KZIpEPQLTwviW2NadmVRx9thOwptOKGY9F7MSCqySFNaM4n/pJ+MmzbnNbFV0E1rICiOl2RfLJDh0QiYTMm5mUu9AHEQ6c9+8YyNLkPF6HvgzmiSKdLVGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=iSJ8aMgU; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id EE6D56024E;
	Sun, 19 Apr 2026 12:25:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776594352;
	bh=Q2TWX1Ir+hevOyb+K2P0n8+5uFgS+pe9UMNdMlJNWao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSJ8aMgUrwLpJWTeiD7gUthxly7avQrbnxnjIgQqlZEGFIHEW8lURIPV9xja/E2+a
	 pbodt28T4g3BTHbqGoRdQO4np1t+RhHshG4UL/KAom5QN92wlxN1iZLdUeoV53Vtss
	 KlPA7/U15GQFeZ28jl471FPmbKKEtkpH2Pi/UlMKBmRKm73F+PinvYnDSDyZ1M07bN
	 wN3wQe6I6H3Ree5bCOKi7UuC368Ix3iFJS3nIaVUNkdiisoF5pAEu1w11KCHw3hdv7
	 z1gGZYQNiQoMJ5Sn7McA2hjYCcPLirixBnToktrs/iZ5vLss5op1FnuT5omG6DU0+f
	 TvHzfmqx/W3AA==
Date: Sun, 19 Apr 2026 12:25:48 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Weiming Shi <bestswngs@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH nf] netfilter: xt_TCPMSS: check skb_dst before path-MTU
 clamping
Message-ID: <aeStrD8wZmxViWOE@chamomile>
References: <20260418163057.2611503-2-bestswngs@gmail.com>
 <aePiSwmP6YEQ4mNE@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aePiSwmP6YEQ4mNE@strlen.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12025-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nwl.cc,vger.kernel.org,netfilter.org,asu.edu];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11DBA423A75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 09:58:03PM +0200, Florian Westphal wrote:
> Weiming Shi <bestswngs@gmail.com> wrote:
> > When TCPMSS with CLAMP_PMTU is used via nft_compat in a non-base
> > chain, par->hook_mask is set to 0, bypassing the checkentry hook
> > validation. The target can then run at PRE_ROUTING where skb_dst is
> > NULL, causing a null-ptr-deref in tcpmss_mangle_packet():
> > 
> >  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> >  RIP: 0010:tcpmss_mangle_packet (include/net/dst.h:219 net/netfilter/xt_TCPMSS.c:105)
> >   tcpmss_tg4 (net/netfilter/xt_TCPMSS.c:202)
> >   nft_target_eval_xt (net/netfilter/nft_compat.c:87)
> >   nft_do_chain (net/netfilter/nf_tables_core.c:287)
> >   nf_hook_slow (net/netfilter/core.c:623)
> > 
> > Check skb_dst() for NULL before calling dst_mtu().
> 
> FWIW I will apply this patch even though its wrong.

And no please, do not apply this.

This needs to be fixes from the chain graph detection.

