Return-Path: <netfilter-devel+bounces-11874-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBSwEAMo3mltoQkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11874-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 13:41:55 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD5A3F97DD
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 13:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6BE93027E66
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 11:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC033DD52B;
	Tue, 14 Apr 2026 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="eqBfu3eJ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBCC3DDDDC;
	Tue, 14 Apr 2026 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166730; cv=none; b=YHb9PJFsaFm9Z16inKcm/KmJ2k4cL6D5xsWSrzYjQMJvnxd2DizpJbzWvVhsMWohA6UEdn7p88zYJPLFvRnTc4cKm4M1oaG4AXM9SEDur9EobaPOfjFF4yjX5r1NLT2mC8xb/40W0Wbj/Pa3gxAzHJHY9oT4ZvUCMur59jC3BH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166730; c=relaxed/simple;
	bh=vCVZ+zoZqp6gSO0rlh0JkfvkZttK9T2KZQPt5CRzo08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9xvbZRAgYiVIYGG2S2Ls+MadjkDpifVLq8AyR4ovzfebvXjDl5WJWlUVs1HhrR9ukwd9wT/rGW6h8+1T3wgAL1amAdXH2ju4yqBljV8ddkcjBcM4tphMQeaaEgxbHCC4vBGOgSnGLyKCOwshMTcGaKxLGl+WJHzHr2KeXd9gIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=eqBfu3eJ; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 7E42060178;
	Tue, 14 Apr 2026 13:38:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776166726;
	bh=PWRJlL0OVFizlyMCQKPwkDnirKlbpiCXOQ5Rhc5nwV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqBfu3eJekn02WH2Cjycm1MtG9kVy7FUZsSGWkyYNSjCJKYZ4/dEPs+pFhR9FbH9M
	 g+odOVG5STPI0jfMmLY7Dvk2KwfAppFlLf9Cy6ukoh3HLDFVmndNUnfROrnD786adt
	 s2fn7mV8SooVT59lVcRALbWGCYBTZBhfCXy8NSwDM/Lhcb/0PBvQM5O+zm+cclZnEM
	 5rb4G19TjkCw/noTdinqR6k0VG+OWn3EsulHKUiyzoBKZDzMsAWvF/qdASuislnP0v
	 F0pD1N8Tv4iTRTARlYhsJcwcfE3wLh6vASHff5UyYRMxf3zxQ7/mOCOUkUyXDF8T03
	 SvbBQARsKW8Sw==
Date: Tue, 14 Apr 2026 13:38:43 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 nf] netfilter: nf_flow_table_ip: Introduce
 nf_flow_vlan_push()
Message-ID: <ad4nQzsbeF1S53zt@chamomile>
References: <20260414112120.248744-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414112120.248744-1-ericwouds@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11874-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:dkim]
X-Rspamd-Queue-Id: 4AD5A3F97DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 01:21:20PM +0200, Eric Woudstra wrote:
> Calling skb_reset_mac_header() before calling skb_vlan_push() does
> remove the error:
> 
> "skb_vlan_push got skb with skb->data not at mac header (offset 18)"
> 
> But the inner vlan tag is still not inserted correctly.
> 
> skb_vlan_push() uses __vlan_insert_inner_tag() to insert the tag
> at offset ETH_HLEN. But the inner tag should only be pushed, without
> offset, similar to nf_flow_pppoe_push().

It is doubled-tagged-vlan that is broken, right? I observed this once
but I have been burdened into a few things.

> Fixes: c653d5a78f34 ("netfilter: flowtable: inline vlan encapsulation in xmit path")
> Fixes: a3aca98aec9a ("netfilter: nf_flow_table_ip: reset mac header before vlan push")
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> 
> ---
> 
>  net/netfilter/nf_flow_table_ip.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
> index fd56d663cb5b..0086f8a1a0d6 100644
> --- a/net/netfilter/nf_flow_table_ip.c
> +++ b/net/netfilter/nf_flow_table_ip.c
> @@ -544,6 +544,26 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
>  	return 1;
>  }
>  
> +static int nf_flow_vlan_push(struct sk_buff *skb, __be16 proto, u16 id)
> +{
> +	if (skb_vlan_tag_present(skb)) {
> +		struct vlan_hdr *vhdr;
> +
> +		if (skb_cow_head(skb, VLAN_HLEN))
> +			return -1;
> +
> +		__skb_push(skb, VLAN_HLEN);
> +		skb_reset_network_header(skb);
> +		vhdr = (struct vlan_hdr *)(skb->data);
> +		vhdr->h_vlan_TCI = htons(id);
> +		vhdr->h_vlan_encapsulated_proto = skb->protocol;
> +		skb->protocol = proto;
> +	} else {
> +		__vlan_hwaccel_put_tag(skb, proto, id);
> +	}
> +	return 0;
> +}
> +
>  static int nf_flow_pppoe_push(struct sk_buff *skb, u16 id)
>  {
>  	int data_len = skb->len + sizeof(__be16);
> @@ -738,9 +758,8 @@ static int nf_flow_encap_push(struct sk_buff *skb,
>  		switch (tuple->encap[i].proto) {
>  		case htons(ETH_P_8021Q):
>  		case htons(ETH_P_8021AD):
> -			skb_reset_mac_header(skb);
> -			if (skb_vlan_push(skb, tuple->encap[i].proto,
> -					  tuple->encap[i].id) < 0)
> +			if (nf_flow_vlan_push(skb, tuple->encap[i].proto,
> +					      tuple->encap[i].id) < 0)
>  				return -1;
>  			break;
>  		case htons(ETH_P_PPP_SES):
> -- 
> 2.53.0
> 

