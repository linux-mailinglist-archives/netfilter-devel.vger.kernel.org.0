Return-Path: <netfilter-devel+bounces-13330-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MqjQKAIsNGpFQgYAu9opvQ
	(envelope-from <netfilter-devel+bounces-13330-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 19:33:54 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 008E36A1F42
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 19:33:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13330-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13330-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18BEF30570D5
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 17:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2CE32B110;
	Thu, 18 Jun 2026 17:33:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786D2C21D0
	for <netfilter-devel@vger.kernel.org>; Thu, 18 Jun 2026 17:32:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803980; cv=none; b=kN/h0SGoQu/Qcrp9xdLtV4YTuMqUd8YWvclHdxEm/yGo5YNjnG6H2XYqMBiE4zE0SYolkLa3j14FJewNXebn271ix0uUTzYRYxKnaTL893ijX/dsosASwCb059lRZUZvOKTszOgA0BiJNZjTKVgz5DqW7CGd486cmhlrykj5nJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803980; c=relaxed/simple;
	bh=OrZEEHQkl38wB/X5WsxSpNXLEKhcVHLJrDM81sOj84s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWaDwp5wVkj3m45aVSCQx5IUfpj9Hqy9KTxSpCDy3j1k/SLwnwNVobxpTlQnK9e+70qec9ejb0O5oFUpPXtwW1zJg8aX7bJmVtSORinAWPZmso4opo+Leb0zpJkn9B5z7OXFZUUwt2M+nRHxBsVVTBQFuBlx0VT/CEXHPuWe5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 81D3B60541; Thu, 18 Jun 2026 19:32:56 +0200 (CEST)
Date: Thu, 18 Jun 2026 19:32:50 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	phil@nwl.cc
Subject: Re: [PATCH 4/9 nf-next] netfilter: conntrack: use
 DEBUG_NET_WARN_ON_ONCE on packet paths
Message-ID: <ajQrwgb0GkKG-utR@strlen.de>
References: <20260601193049.8131-1-fmancera@suse.de>
 <20260601193049.8131-5-fmancera@suse.de>
 <ajQmsQsCbwJb5P7W@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQmsQsCbwJb5P7W@chamomile>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fmancera@suse.de,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:phil@nwl.cc,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-13330-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,netfilter.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 008E36A1F42

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > diff --git a/net/netfilter/nf_conntrack_proto_icmp.c b/net/netfilter/nf_conntrack_proto_icmp.c
> > index 32148a3a8509..0f39cb147c4f 100644
> > --- a/net/netfilter/nf_conntrack_proto_icmp.c
> > +++ b/net/netfilter/nf_conntrack_proto_icmp.c
> > @@ -117,7 +117,8 @@ int nf_conntrack_inet_error(struct nf_conn *tmpl, struct sk_buff *skb,
> >  	enum ip_conntrack_dir dir;
> >  	struct nf_conn *ct;
> >  
> > -	WARN_ON(skb_nfct(skb));
> > +	if (unlikely(skb_nfct(skb)))
> > +		DEBUG_NET_WARN_ON_ONCE(1);

Should be
DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb)));
?

> nf_conntrack_in
>  [ reset skb->nfct ]
>  nf_conntrack_handle_icmp
>   nf_conntrack_icmpv4_error
>    nf_conntrack_inet_error
> 
> There is nf_conntrack_inet_error() which performs the ct lookup.
> There is resolve_normal_ct() too, but these two are coming later.
> 
> [ ... snippet that resets skb->nfct ... ]
> unsigned int
> nf_conntrack_in(struct sk_buff *skb, const struct nf_hook_state *state)
> {
>         enum ip_conntrack_info ctinfo;
>         struct nf_conn *ct, *tmpl;
>         u_int8_t protonum;
>         int dataoff, ret;
>  
>         tmpl = nf_ct_get(skb, &ctinfo);
>         if (tmpl || ctinfo == IP_CT_UNTRACKED) {
>                 /* Previously seen (loopback or untracked)?  Ignore. */
>                 if ((tmpl && !nf_ct_is_template(tmpl)) ||
>                      ctinfo == IP_CT_UNTRACKED)
>                         return NF_ACCEPT;
>                 skb->_nfct = 0; <---------  this is reset here.
>         }
> [ end of snippet ]
> 
> I don't remember to have seen this WARN_ON, so remove it.

I would keep the DEBUG_NET_WARN_ON_ONCE(), else this gives a
refcount leak.

Or, move it closer to the end:

191         /* Update skb to refer to this connection */
	HERE.
192         nf_ct_set(skb, ct, ctinfo);
193         return NF_ACCEPT;
194 }

