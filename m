Return-Path: <netfilter-devel+bounces-12674-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLRGD+qSC2ohJgUAu9opvQ
	(envelope-from <netfilter-devel+bounces-12674-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 00:30:02 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A721F574741
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 00:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 621BA303CA5F
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 22:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F83ACA77;
	Mon, 18 May 2026 22:29:17 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E274215A85A
	for <netfilter-devel@vger.kernel.org>; Mon, 18 May 2026 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143356; cv=none; b=HG6E/Iiwx80wdRWmyc6RQsPDUrEeSFkTop7qh9/Xru3unOd1mAzzPUCOwbqPw8QKnxPvCrgfeokum+aa6NkThePrZU9EtcYr6u4BCZSeDxGBm9CHfnjrzowUQE8b3nU5Ex7Pz7+gYTk0tT47d7Ofukl5MNBGazSquw92diFmRP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143356; c=relaxed/simple;
	bh=htBbReYfPRGO9i/v8//YvaJyBinaqCsUQxGraVth5uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toxd8rkNjHrjaxdPJzrGGKVWDN7t/3M8SaHQd7F3HGmpxSjfCkmlLq3gHQFoONeXI97mjmSmFKZjP3R3DrJ9LnWJCnLfQ7Ty8p8f1ex1rsKw2t8GO3MNBGW3UQNHh4aKC5wKeYZxvclYi9pxDj6efof1taRJeNFamPTVbg19kAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0BDC7607E9; Tue, 19 May 2026 00:29:12 +0200 (CEST)
Date: Tue, 19 May 2026 00:17:56 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 4/3 nf,v4] netfilter: nf_conntrack_helper: call
 .destroy() when helper is unregistered
Message-ID: <aguQFExPbJtWeapP@strlen.de>
References: <20260518194752.1063189-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518194752.1063189-1-pablo@netfilter.org>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid,strlen.de:email];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-12674-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A721F574741
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> When the helper is removed, call .destroy to release the pptp binding
> with gre conntrack entries, otherwise the gre keymap stays with stale
> list entries.
> 
> Fixes: f09943fefe6b ("[NETFILTER]: nf_conntrack/nf_nat: add PPTP helper port")
> Reported-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  net/netfilter/nf_conntrack_helper.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
> index 9a10b3449957..b226291a5c7f 100644
> --- a/net/netfilter/nf_conntrack_helper.c
> +++ b/net/netfilter/nf_conntrack_helper.c
> @@ -241,9 +241,17 @@ EXPORT_SYMBOL_GPL(__nf_ct_try_assign_helper);
>  static int unhelp(struct nf_conn *ct, void *me)
>  {
>  	struct nf_conn_help *help = nfct_help(ct);
> +	struct nf_conntrack_helper *helper;
> +
> +	if (!help)
> +		return 0;
>  
> -	if (help && rcu_dereference_raw(help->helper) == me) {
> +	helper = rcu_dereference_raw(help->helper);
> +	if (helper == me) {
>  		nf_conntrack_event(IPCT_HELPER, ct);
> +		if (helper->destroy)
> +			helper->destroy(ct);
> +

There is a nf_ct_helper_destroy() helper that could be used here instead
of open-coding.  Other than that this looks correct.

