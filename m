Return-Path: <netfilter-devel+bounces-11755-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ7AKJ1512kQOwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11755-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 12:04:13 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F48C3C8E37
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 12:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9666E300827A
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Apr 2026 10:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3E395253;
	Thu,  9 Apr 2026 10:04:11 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C99A2AD10
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Apr 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729051; cv=none; b=l8YF24FiYbb1r92tdwkVUjTdThl1uqQM1IAuYoKmQoBr1O/B/a1Hb+GAuPofWDwXKcdp+RCpYZWiq0BsVKX0lYXnaOHvpSifqfU7mOGYBKQv0c2sAPAXQGBHS8IgBZkS/vLmOiWe5aB/efUo+aqonSCb4dEek0J2TshrDDXhVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729051; c=relaxed/simple;
	bh=jx4W/6539d0IyYyi6BMGFTWaxYJLxBFGZYwmWoZqTek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTNIkEb3Oy//bt0csVmDAJhvTaH2JbSovAUeDOiRXy5B/W3rMyDZFUxaNsA+4SxyvQgAQdX3qrjla/V0VJOlvHpA9bYhJ9UyJBSG7/pYD1iJkDPWhJNTxSsz/W7kHDA1AFRJLXAnKSpUbo+ZeSP5flzKrjGmAvyJA4ElnMo4kU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0736C604AA; Thu, 09 Apr 2026 12:04:04 +0200 (CEST)
Date: Thu, 9 Apr 2026 12:04:04 +0200
From: Florian Westphal <fw@strlen.de>
To: David Baum <davidbaum461@gmail.com>
Cc: netfilter-devel@vger.kernel.org, kadlec@netfilter.org
Subject: Re: [PATCH] netfilter: ipset: harden payload calculation in call_ad()
Message-ID: <add5lL88z9oJqTJY@strlen.de>
References: <20260313180132.75655-1-davidbaum461@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313180132.75655-1-davidbaum461@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11755-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F48C3C8E37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Baum <davidbaum461@gmail.com> wrote:
> call_ad() computes the netlink error payload size with
> min(SIZE_MAX, sizeof(*errmsg) + nlmsg_len(nlh)), but min(SIZE_MAX, x)
> is always x, so the guard is a no-op.
> 
> Replace it with an explicit negative-length check and
> check_add_overflow() so the addition is validated before being passed
> to nlmsg_new().

Jozsef, are you ok with this patch?
Full quote below.

> Signed-off-by: David Baum <davidbaum461@gmail.com>
> ---
>  net/netfilter/ipset/ip_set_core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
> index a2fe711cb5e3..11d3854d9b11 100644
> --- a/net/netfilter/ipset/ip_set_core.c
> +++ b/net/netfilter/ipset/ip_set_core.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/ip.h>
> +#include <linux/overflow.h>
>  #include <linux/skbuff.h>
>  #include <linux/spinlock.h>
>  #include <linux/rculist.h>
> @@ -1763,13 +1764,18 @@ call_ad(struct net *net, struct sock *ctnl, struct sk_buff *skb,
>  		struct nlmsghdr *rep, *nlh = nlmsg_hdr(skb);
>  		struct sk_buff *skb2;
>  		struct nlmsgerr *errmsg;
> -		size_t payload = min(SIZE_MAX,
> -				     sizeof(*errmsg) + nlmsg_len(nlh));
> +		int nlmsg_payload_len = nlmsg_len(nlh);
> +		size_t payload;
>  		int min_len = nlmsg_total_size(sizeof(struct nfgenmsg));
>  		struct nlattr *cda[IPSET_ATTR_CMD_MAX + 1];
>  		struct nlattr *cmdattr;
>  		u32 *errline;
>  
> +		if (nlmsg_payload_len < 0 ||
> +		    check_add_overflow(sizeof(*errmsg),
> +				       (size_t)nlmsg_payload_len, &payload))
> +			return -ENOMEM;
> +
>  		skb2 = nlmsg_new(payload, GFP_KERNEL);
>  		if (!skb2)
>  			return -ENOMEM;


