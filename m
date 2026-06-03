Return-Path: <netfilter-devel+bounces-13013-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HU4+CDv4H2qztQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13013-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 03 Jun 2026 11:47:39 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE216364B2
	for <lists+netfilter-devel@lfdr.de>; Wed, 03 Jun 2026 11:47:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=WFSM4T+g;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13013-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13013-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E053130A5E2D
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jun 2026 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A9E372EF7;
	Wed,  3 Jun 2026 09:40:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05432F748;
	Wed,  3 Jun 2026 09:40:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479632; cv=none; b=Hem3EzDYE3u3fyQAYoaqyxh2VwiQUnKNAefNqLr/V68ko5RTxHWgipQYvGYzKgOtgbTA2cUfNxdLAwHFok0bvdBjig8/X29xBocnQXK5o9NP1uOOb8XGhj9UNJ/yElXuFLT0uOZ4p5DvIfpMXhgmJjxtbGEyEPCmBSQELMoIn1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479632; c=relaxed/simple;
	bh=yQU5uxKCuvTWj9NYbGX9RJsxegG7Qa2aqWfLUsaX0PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKG8ryZnq9KG2/w6d1chITgkSnmiDZND/zWggVJmPgjfk8UyTTDsl4+o2d0SQx1xRSM+5CvgFeTdsD9Icaa6xZSdCY1TKUDKIN0wXOSLnsnqY+qAge0xvdi693LZJF1w/wzFlNzWXjbJcMKKw6neVgl+X5xptuOxNWggACN4jDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=WFSM4T+g; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 7B1D760181;
	Wed,  3 Jun 2026 11:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780479627;
	bh=IL1jl4vJrDFDGOhV9fUmeyIYcPAKb510iG1fLGUGpUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFSM4T+gquf0QdAQNjlrXj93e45nR4irbXwFgpJVMrXs7y1nvWma/FXTqx+TUAdLT
	 01unEORz2XGjRsvsB8AcZj831NB+iLaIWCEIDfxJE/r5vta0I5YUtuevR7yKTChq2e
	 GWKHr0DyloybsDT3Es9zu8JzpNkqSR6UU3WwPBtmxNjmYYvGtTpLnvMElGr7YaUBRT
	 JIurpVUDN2xxOXYtOYyz9AyV1Q9EEcqFJkfGbEYD84s7d4vcey1RrANf64xzeCn1fj
	 7hfhraimGpe8pPytWzNj4YdbPCWwdg6t6+iEmQBSnwoO9F9Hgk16DNrfkucykcgPG5
	 9YVbU9unOMuig==
Date: Wed, 3 Jun 2026 11:40:25 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: fw@strlen.de, phil@nwl.cc, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH nf] netfilter: nf_conntrack: destroy stale expectfn
 expectations on unregister
Message-ID: <ah_2idoVuJMG38PN@chamomile>
References: <20260603073815.2159603-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603073815.2159603-3-bestswngs@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:fw@strlen.de,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13013-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chamomile:mid,asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:from_mime,netfilter.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FE216364B2

On Wed, Jun 03, 2026 at 12:38:17AM -0700, Weiming Shi wrote:
> NAT helpers such as nf_nat_h323 store a raw pointer to module text in
> exp->expectfn (e.g. ip_nat_q931_expect). nf_ct_helper_expectfn_unregister()
> only unlinks the callback descriptor and never walks the expectation table,
> so an expectation pending at module removal survives with a dangling
> exp->expectfn into freed module text.
> 
> When the expected connection arrives, init_conntrack() invokes
> exp->expectfn(), now a stale pointer into the unloaded module. Reproduced
> on a KASAN build by loading the H.323 helpers, creating a Q.931
> expectation, unloading nf_nat_h323, then connecting to the expected port:
> 
>  Oops: int3: 0000 [#1] SMP KASAN NOPTI
>  RIP: 0010:0xffffffffa06102d1
>   init_conntrack.isra.0 (net/netfilter/nf_conntrack_core.c:1862)
>   nf_conntrack_in (net/netfilter/nf_conntrack_core.c:2049)
>   ipv4_conntrack_local (net/netfilter/nf_conntrack_proto.c:223)
>   nf_hook_slow (net/netfilter/core.c:619)
>   __ip_local_out (net/ipv4/ip_output.c:120)
>   __tcp_transmit_skb (net/ipv4/tcp_output.c:1715)
>   tcp_connect (net/ipv4/tcp_output.c:4374)
>   tcp_v4_connect (net/ipv4/tcp_ipv4.c:345)
>   __sys_connect (net/socket.c:2167)
>  Modules linked in: nf_conntrack_h323 [last unloaded: nf_nat_h323]
> 
> Reaching the dangling state requires CAP_SYS_MODULE in the initial user
> namespace to remove a NAT helper that still has live expectations, so this
> is a robustness fix; leaving an expectation pointing at freed text is wrong
> regardless.
> 
> Add nf_ct_helper_expectfn_destroy(), which walks the expectation table and
> drops every expectation whose ->expectfn matches the descriptor being torn
> down. Call it from each NAT helper's exit path after the existing RCU grace
> period, so no expectation outlives the code it points at and no extra
> synchronize_rcu() is introduced. With the fix, the same reproducer runs to
> completion without the Oops.

Missing unregistration, patch LGTM.

> Fixes: f587de0e2feb ("[NETFILTER]: nf_conntrack/nf_nat: add H.323 helper port")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  include/net/netfilter/nf_conntrack_helper.h |  1 +
>  net/ipv4/netfilter/nf_nat_h323.c            |  2 ++
>  net/netfilter/nf_conntrack_helper.c         | 19 +++++++++++++++++++
>  net/netfilter/nf_nat_core.c                 |  2 ++
>  net/netfilter/nf_nat_sip.c                  |  1 +
>  5 files changed, 25 insertions(+)
> 
> diff --git a/include/net/netfilter/nf_conntrack_helper.h b/include/net/netfilter/nf_conntrack_helper.h
> index de2f956abf34..24cf3d2d9745 100644
> --- a/include/net/netfilter/nf_conntrack_helper.h
> +++ b/include/net/netfilter/nf_conntrack_helper.h
> @@ -155,6 +155,7 @@ void nf_ct_helper_log(struct sk_buff *skb, const struct nf_conn *ct,
>  
>  void nf_ct_helper_expectfn_register(struct nf_ct_helper_expectfn *n);
>  void nf_ct_helper_expectfn_unregister(struct nf_ct_helper_expectfn *n);
> +void nf_ct_helper_expectfn_destroy(const struct nf_ct_helper_expectfn *n);
>  struct nf_ct_helper_expectfn *
>  nf_ct_helper_expectfn_find_by_name(const char *name);
>  struct nf_ct_helper_expectfn *
> diff --git a/net/ipv4/netfilter/nf_nat_h323.c b/net/ipv4/netfilter/nf_nat_h323.c
> index faee20af4856..10e1b0837731 100644
> --- a/net/ipv4/netfilter/nf_nat_h323.c
> +++ b/net/ipv4/netfilter/nf_nat_h323.c
> @@ -555,6 +555,8 @@ static void __exit nf_nat_h323_fini(void)
>  	nf_ct_helper_expectfn_unregister(&q931_nat);
>  	nf_ct_helper_expectfn_unregister(&callforwarding_nat);
>  	synchronize_rcu();
> +	nf_ct_helper_expectfn_destroy(&q931_nat);
> +	nf_ct_helper_expectfn_destroy(&callforwarding_nat);
>  }
>  
>  /****************************************************************************/
> diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
> index 17e971bd4c74..2c5a71735561 100644
> --- a/net/netfilter/nf_conntrack_helper.c
> +++ b/net/netfilter/nf_conntrack_helper.c
> @@ -283,6 +283,25 @@ void nf_ct_helper_expectfn_unregister(struct nf_ct_helper_expectfn *n)
>  }
>  EXPORT_SYMBOL_GPL(nf_ct_helper_expectfn_unregister);
>  
> +static bool expect_iter_expectfn(struct nf_conntrack_expect *exp, void *data)
> +{
> +	const struct nf_ct_helper_expectfn *n = data;
> +
> +	/* Relies on registered expectfn descriptors having unique ->expectfn
> +	 * pointers, which holds for the in-tree NAT helpers.
> +	 */
> +	return exp->expectfn == n->expectfn;
> +}
> +
> +/* Destroy expectations still pointing at @n->expectfn; call after the
> + * caller's RCU grace period so none outlives the (often modular) callback.
> + */
> +void nf_ct_helper_expectfn_destroy(const struct nf_ct_helper_expectfn *n)
> +{
> +	nf_ct_expect_iterate_destroy(expect_iter_expectfn, (void *)n);
> +}
> +EXPORT_SYMBOL_GPL(nf_ct_helper_expectfn_destroy);
> +
>  /* Caller should hold the rcu lock */
>  struct nf_ct_helper_expectfn *
>  nf_ct_helper_expectfn_find_by_name(const char *name)
> diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
> index 74ec224ce0d6..2bbf5163c0e2 100644
> --- a/net/netfilter/nf_nat_core.c
> +++ b/net/netfilter/nf_nat_core.c
> @@ -1341,6 +1341,7 @@ static int __init nf_nat_init(void)
>  		RCU_INIT_POINTER(nf_nat_hook, NULL);
>  		nf_ct_helper_expectfn_unregister(&follow_master_nat);
>  		synchronize_net();
> +		nf_ct_helper_expectfn_destroy(&follow_master_nat);
>  		unregister_pernet_subsys(&nat_net_ops);
>  		kvfree(nf_nat_bysource);
>  	}
> @@ -1358,6 +1359,7 @@ static void __exit nf_nat_cleanup(void)
>  	RCU_INIT_POINTER(nf_nat_hook, NULL);
>  
>  	synchronize_net();
> +	nf_ct_helper_expectfn_destroy(&follow_master_nat);
>  	kvfree(nf_nat_bysource);
>  	unregister_pernet_subsys(&nat_net_ops);
>  }
> diff --git a/net/netfilter/nf_nat_sip.c b/net/netfilter/nf_nat_sip.c
> index 9fbfc6bff0c2..00838c0cc5bb 100644
> --- a/net/netfilter/nf_nat_sip.c
> +++ b/net/netfilter/nf_nat_sip.c
> @@ -655,6 +655,7 @@ static void __exit nf_nat_sip_fini(void)
>  	RCU_INIT_POINTER(nf_nat_sip_hooks, NULL);
>  	nf_ct_helper_expectfn_unregister(&sip_nat);
>  	synchronize_rcu();
> +	nf_ct_helper_expectfn_destroy(&sip_nat);
>  }
>  
>  static const struct nf_nat_sip_hooks sip_hooks = {
> -- 
> 2.43.0
> 

