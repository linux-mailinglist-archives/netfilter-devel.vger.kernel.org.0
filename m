Return-Path: <netfilter-devel+bounces-13727-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /JldMFo5TmofJQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13727-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 13:49:46 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1406872602F
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 13:49:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13727-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13727-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C66E300E709
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AFD434E2C;
	Wed,  8 Jul 2026 11:46:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D93742B30F;
	Wed,  8 Jul 2026 11:45:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511161; cv=none; b=HnBCsmb8wWQLS6quWJQq0WXVfcB2anDb6ljctDM4VWfdqAiajZ9c7G8xaLJ/dEeDL2Z3SoIWtVCo0//ziaPgvCZEjmf8GDb0niSlpgcRla5IKRXgkOi+G+CPxdVdURxyh1upPaDnSBfY0/OAXd0E1xzhVrObUcj0zYWhEp0d/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511161; c=relaxed/simple;
	bh=mea4e5gKCQknIDxQ3PIurGaHdYWY5ez4ydVOLNKJiv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMWkbc4JpUet7lUsQVWq55cHZk/1c1osOVsBAdrpcKlppVcAl4WwtLMIkrC+4ni5+RMSnApxAruX4PRUvXzPudZ9xWEl+RmcUohgPDhlKc7xRPgQBPRykHH4cjTb83PJYwShWPJVoGk9aJCPJ52Ja4n/DJQxB3ex/Mr+WkCjaKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8CD7C6059E; Wed, 08 Jul 2026 13:45:50 +0200 (CEST)
Date: Wed, 8 Jul 2026 13:45:44 +0200
From: Florian Westphal <fw@strlen.de>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net] netfilter: bridge: fix stale prevhdr pointer in
 br_ip6_fragment()
Message-ID: <ak44aLdDrMZXb6fC@strlen.de>
References: <20260706232850.3333016-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706232850.3333016-1-xmei5@asu.edu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13727-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1406872602F

Xiang Mei (Microsoft) <xmei5@asu.edu> wrote:
> br_ip6_fragment() gets prevhdr, a pointer into the skb head, from
> ip6_find_1stfragopt(), then calls skb_checksum_help().  For a cloned skb
> skb_checksum_help() reallocates the head via pskb_expand_head(), leaving
> prevhdr dangling.  It is later dereferenced in ip6_frag_next(), causing a
> use-after-free write.
> 
> Re-find prevhdr after skb_checksum_help() so it points into the current
> head.
> 
>   BUG: KASAN: slab-use-after-free in ip6_frag_next (net/ipv6/ip6_output.c:857)
>   Write of size 1 at addr ffff888013ff5016 by task exploit/141
>   Call Trace:
>    ...
>    kasan_report (mm/kasan/report.c:595)
>    ip6_frag_next (net/ipv6/ip6_output.c:857)
>    br_ip6_fragment (net/ipv6/netfilter.c:212)
>    nf_ct_bridge_post (net/bridge/netfilter/nf_conntrack_bridge.c:407)
>    nf_hook_slow (net/netfilter/core.c:619)
>    br_forward_finish (net/bridge/br_forward.c:66)
>    __br_forward (net/bridge/br_forward.c:115)
>    maybe_deliver (net/bridge/br_forward.c:191)
>    br_flood (net/bridge/br_forward.c:245)
>    br_handle_frame_finish (net/bridge/br_input.c:229)
>    br_handle_frame (net/bridge/br_input.c:442)
>    ...
>    packet_sendmsg (net/packet/af_packet.c:3114)
>    ...
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fixes: 764dd163ac92 ("netfilter: nf_conntrack_bridge: add support for IPv6")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
>  net/ipv6/netfilter.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
> index 6d80f85e55fa..547879da9532 100644
> --- a/net/ipv6/netfilter.c
> +++ b/net/ipv6/netfilter.c
> @@ -147,6 +147,10 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>  	    (err = skb_checksum_help(skb)))
>  		goto blackhole;
>  
> +	err = ip6_find_1stfragopt(skb, &prevhdr);
> +	if (err < 0)
> +		goto blackhole;

Would you mind sending a v2 that solves this the same way that it was
fixed in ipv6 output engine?

See
ef0efcd3bd3f ("ipv6: Fix dangling pointer when ipv6 fragment")

Thanks!

