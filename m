Return-Path: <netfilter-devel+bounces-13084-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 274tHBXZI2qZzgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13084-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 06 Jun 2026 10:23:49 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24D564CEB5
	for <lists+netfilter-devel@lfdr.de>; Sat, 06 Jun 2026 10:23:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13084-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13084-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 390D630378B2
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Jun 2026 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93E276038;
	Sat,  6 Jun 2026 08:21:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8A313E31
	for <netfilter-devel@vger.kernel.org>; Sat,  6 Jun 2026 08:21:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780734100; cv=none; b=sakmgxx7kGYmr55JmyOYLP4Xs56botDohyt/3tl28+L+3X6lCE8ygHqbXYgHItWQeDPLpUSLsJW/tdJwCIYr4HZJPS92MUX5Uia6PTpp1j8tF/Rcg4q6gXumgFpqap7MyQlkccpbpOP4u46PUOCKl1Zb5RpeWBL98+zdu0iLwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780734100; c=relaxed/simple;
	bh=KGaiIjELfsjrDD17Fw96eMzzOu6yY9SIPVjLf/e/kl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCAtKLJxbyu14vekOt1GGxaJulyCSg0le3tyUZpqYtWVsowAoJCkdkZpQFRz2H4tGeCBrBU/eNDKdCVB3Heayb6MoKJdJ/C9azGRrJGStwO4VpAuO6SghpYAQbgSxtUgghVL3x1Yhp8XixbYx678blk9MdanmT6oQAIXvqNAnbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id F1E4E60337; Sat, 06 Jun 2026 10:21:28 +0200 (CEST)
Date: Sat, 6 Jun 2026 10:21:24 +0200
From: Florian Westphal <fw@strlen.de>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, phil@nwl.cc,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, royenheart@gmail.com
Subject: Re: [PATCH nf v4 1/1] bridge: br_netfilter: pin bridge device while
 NFQUEUE holds fake dst
Message-ID: <aiPYhDrNiGuyRtGo@strlen.de>
References: <cbc3a29c0654e8fcee30cb021d57883fed77fafc.1780630094.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc3a29c0654e8fcee30cb021d57883fed77fafc.1780630094.git.royenheart@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13084-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:phil@nwl.cc,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:royenheart@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,gmail.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B24D564CEB5

Ren Wei <n05ec@lzu.edu.cn> wrote:
>  #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
>  	const struct sk_buff *skb = entry->skb;
> +	struct dst_entry *dst = skb_dst(skb);
> +	struct net_device *dev = NULL;
>  
>  	if (nf_bridge_info_exists(skb)) {
>  		entry->physin = nf_bridge_get_physindev(skb, entry->state.net);
> @@ -92,6 +95,17 @@ static void __nf_queue_entry_init_physdevs(struct nf_queue_entry *entry)
>  		entry->physin = NULL;
>  		entry->physout = NULL;
>  	}
> +
> +	if (entry->state.pf == NFPROTO_BRIDGE &&
> +	    nf_bridge_info_exists(skb) &&

Is this check redundant?

> +	    dst && (dst->flags & DST_FAKE_RTABLE))

... this should be enough.  In which cases can we have
FAKE_RTABLE and !nf_bridge_info_exists() ?

>  #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
> +	dev_hold(entry->bridge_dev);

LGTM, however, in last iteration sashiko complained that dev_cmp() in
nfnetlink_queue.c should gain a bridge_dev->ifindev check so that entries
are reaped in case bridge goes down.

Could you send a v5 that adds this test? Everything else here LGTM.

