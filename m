Return-Path: <netfilter-devel+bounces-13064-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SdHXFLwMImqsRwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13064-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 01:39:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0FF643F7D
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 01:39:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13064-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13064-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A01530107C9
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Jun 2026 23:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3447830D3E7;
	Thu,  4 Jun 2026 23:36:59 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3FD31326F
	for <netfilter-devel@vger.kernel.org>; Thu,  4 Jun 2026 23:36:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616219; cv=none; b=qrhom9I3VFxT1cl7OU1lh3kUUxkHtB7/6WIiScYPfoq493GOZNhIpc/thYAMpyjywlFrI9pjWHDuZ935JApR1lNuobvMLOYU2joz68UgNSXluT74LR2iwfzzosvgN1mMC4etT7j+ufXMzqGsvf4XCUs5/SIpYUALuEcMLgImuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616219; c=relaxed/simple;
	bh=ZtxXTJJhb0vluUrG6/+eUYkCzR/8D4p1g41FBC7D92A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6e0lH0V4cIfBCryVruEzGPcgWsNs7FtmBeyPFR3L9X7sFLbD0gOAKceKabyDuawIexTqjrcqL54qgVPoT0aZD2ykGPOmUbvANkF3ur904b22tMtPD8PV9wk09mf0D8OmZfa3Hhf92JJjkNFtG9wNPlmQAVKJrIyXTohw8E5hMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D5CB46021A; Fri, 05 Jun 2026 01:36:48 +0200 (CEST)
Date: Fri, 5 Jun 2026 01:36:43 +0200
From: Florian Westphal <fw@strlen.de>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, phil@nwl.cc,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, royenheart@gmail.com
Subject: Re: [PATCH nf v3 1/1] bridge: br_netfilter: pin bridge device while
 NFQUEUE holds fake dst
Message-ID: <aiIMC2RP7pB2mFDk@strlen.de>
References: <fe4fc3d462679ba10bf85e574921ecf861000d66.1780590147.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4fc3d462679ba10bf85e574921ecf861000d66.1780590147.git.royenheart@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,gmail.com,lzu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13064-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:phil@nwl.cc,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:royenheart@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D0FF643F7D

Ren Wei <n05ec@lzu.edu.cn> wrote:
> The bridge netfilter fake rtable is embedded in struct net_bridge and is
> attached to bridged packets with skb_dst_set_noref(). If such a packet is
> queued to NFQUEUE, __nf_queue() upgrades that fake dst with
> skb_dst_force().

Ok, I think I understand why this mess exists. Ideally we could rip out
the fake rtable and alloc it as separate object with distinct lifetime,
this FAKE_RTABLE crap needs to die...  But I understand its more
intrusive / harder to fix it that way (performance considerations don't
matter however, br_netfilter can be pessimized).

> +#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
> +static struct net_device *nf_queue_bridge_dev(const struct sk_buff *skb,
> +					      const struct nf_hook_state *state)
> +{
> +	struct dst_entry *dst = skb_dst(skb);
> +	struct net_device *dev;
> +
> +	if (state->pf != NFPROTO_BRIDGE || !nf_bridge_info_exists(skb))
> +		return NULL;
> +

I guess what you are saying is that if br_netfilter hack is on,
skb->dst can be fake rtable while packet is sent to nfnetlink_queue
from a *bridge* family hook where in/outdev are the physical ports
yet skb->dev isn't the bridge device either.  The forced ref on the
dst is useless in that case, because netdevice_removal frees the
net_device regardless of the fake rtable dst entries refcounts.

If thats correct, could you please streamline this patch slightly?

Something like this (totally untested and misses dev_put part); and
that comment might be a bit more verbose.

diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -84,6 +84,8 @@ static void __nf_queue_entry_init_physdevs(struct nf_queue_entry *entry)
 {
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
        const struct sk_buff *skb = entry->skb;
+       struct dst_entry *dst = skb_dst(skb);
+       struct net_device *dev = NULL;
 
        if (nf_bridge_info_exists(skb)) {
                entry->physin = nf_bridge_get_physindev(skb, entry->state.net);
@@ -92,6 +94,17 @@ static void __nf_queue_entry_init_physdevs(struct nf_queue_entry *entry)
                entry->physin = NULL;
                entry->physout = NULL;
        }
+
+       if (dst && (dst->flags & DST_FAKE_RTABLE)) {
+               dev = dst_dev_rcu(dst);
+               if (dev == blackhole_netdev) [ Q: Is that really needed? I don't think so ]
+                       dev = NULL;
+       }
+
+       /* Must hold reference on the bridge device: the fake rtable
+        * is embedded within, dst_hold() is not sufficient.
+        */
+       entry->br_dev = dev;
 #endif
 }
 
@@ -108,6 +121,7 @@ bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
        dev_hold(state->out);
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+       dev_hold(entry->br_dev);
        dev_hold(entry->physin);
        dev_hold(entry->physout);
 #endif

Thanks!

