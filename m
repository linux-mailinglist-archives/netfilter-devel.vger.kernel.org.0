Return-Path: <netfilter-devel+bounces-13078-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AI4WCnTqImq+fAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13078-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 17:25:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F40649456
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 17:25:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=Uqg1e8sc;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13078-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13078-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 810DC30A54A7
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jun 2026 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47DA3B4439;
	Fri,  5 Jun 2026 15:17:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C835BDDB
	for <netfilter-devel@vger.kernel.org>; Fri,  5 Jun 2026 15:17:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672652; cv=none; b=t2DlUpiz0uROBQp7xoccdg6M8OHPVnwBoi2AI5D8UN5HjRLKjkhZqeFFGx6oLQO0yfA3Ttb5LJL3/S4i3Xb1FFgaXN8mu9K0faWJ9ngBzc3zHQfpZde/iXmLO9Txk2z9CDzw+AGw3cds0rVzoZ7vJJVjrz25dk99yKr7MiKOGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672652; c=relaxed/simple;
	bh=5wl2996vHzeZJO1WgtfgPvpebwtMnDuZhMx86GP0dc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sU5db7vvh7NA3ihPExC0Ljm+Y2cv8V6v0Ym3Td6PS3T9o2/EBykmyvHRNHUEcjvOuZ/kmxC4v2MmPnepXjqlXWBwtTYXFqxi3qThU7LbgPWyU6i9UipoHdzaPuN60HgkecdVEs+JtibPDR5Qm+UJrVuowccvCLV4rgkA4K1FRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Uqg1e8sc; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id C253060177;
	Fri,  5 Jun 2026 17:17:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780672647;
	bh=bayiGiowuExZeTtut7xI69ag0DwrQ+kkiDIdQ1EzFKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uqg1e8sc8rvU0FG+gYffZJ7ls5jbhh2Sp6rzWy3UsAy1GOsb/jSyVhExd3GFDOfg1
	 hNw0VjxXg3ynllOhyUbHKpSGeN2gmGzuvDNztFKRjLF+PDoug6RBYpPJ1leoGndcJz
	 ma9Hp+9/BX6TgIHPxIlHziQmYWCoRpJ/VYKqkFCWEMgGAWBzZratmEa7iyB/SNxHY6
	 AkqKvt8Ve137TnTvbW5izii4vizE5b2cKVboJ19qbOW4Sf+fqhdQOEG3PccFv0zuLt
	 m0bKDvLCwrRJhSv685n08shPiLHW9z62FAT0ePc3vIMNa1MdMmV6PerMn1xR31dpGF
	 EipXv1sG2soIQ==
Date: Fri, 5 Jun 2026 17:17:25 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: David Carlier <devnexen@gmail.com>, netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>, coreteam@netfilter.org
Subject: Re: [PATCH nf] netfilter: flowtable: fix IP6IP6 tunnel offset
 double-count with vlan/pppoe encap
Message-ID: <aiLohUmGT7Dto0TU@chamomile>
References: <20260604211700.253946-1-devnexen@gmail.com>
 <aiLU7j2jzBob9u-1@lore-desk>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiLU7j2jzBob9u-1@lore-desk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:devnexen@gmail.com,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,m:coreteam@netfilter.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13078-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,strlen.de,netfilter.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netfilter.org:from_mime,netfilter.org:dkim,chamomile:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5F40649456

On Fri, Jun 05, 2026 at 03:53:50PM +0200, Lorenzo Bianconi wrote:
> > nf_flow_ip6_tunnel_proto() stores the return value of ipv6_skip_exthdr()
> > directly into ctx->tun.hdr_size and then does ctx->offset +=
> > ctx->tun.hdr_size.
> > 
> > ipv6_skip_exthdr() returns an offset measured from skb->data, i.e. its
> > result already includes the "sizeof(*ip6h) + ctx->offset" start argument.
> > So hdr_size ends up containing ctx->offset, and the subsequent
> > "ctx->offset += ctx->tun.hdr_size" counts the encap offset twice.
> > 
> > This is harmless for a bare IP6IP6 packet, where ctx->offset is 0 on
> > entry, which is why it has gone unnoticed. But nf_flow_skb_encap_protocol()
> > advances ctx->offset by VLAN_HLEN / PPPOE_SES_HLEN before the tunnel
> > parser runs, so for an IP6IP6 flow carried over vlan or pppoe both
> > ctx->offset and ctx->tun.hdr_size are off by the encap length:
> > 
> >   - nf_flow_tuple_ipv6() then reads the inner header at the wrong offset,
> >     the computed tuple no longer matches the flowtable entry, and the
> >     packet silently falls back to the slow path (IP6IP6 rx acceleration
> >     stops working);
> >   - on the forward path nf_flow_ip_tunnel_pop() would skb_pull() past the
> >     inner header.
> > 
> > The IPv4 sibling nf_flow_ip4_tunnel_proto() does this correctly: it stores
> > a relative header length (iph->ihl << 2) and adds that to ctx->offset.
> > Make the IPv6 path symmetric by storing the relative size.
> > 
> > Fixes: d98103575dcd ("netfilter: flowtable: Add IP6IP6 rx sw acceleration")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> 
> Hi David,
> 
> thx for fixing it. I developed the IP6IP6 vlan support using the veth as
> underlying device. veth enables vlan rx/tx offload by default so I was
> not able to spot the issue.

One question when looking at this code:

In nf_flow_ip6_tunnel_proto():

        if (nexthdr == IPPROTO_IPV6) {
                ctx->tun.hdr_size = hdrlen - ctx->offset;
                ctx->tun.proto = IPPROTO_IPV6;
        }
        ctx->offset += ctx->tun.hdr_size;

ctx->offset is bumped out of the branch.

and nf_flow_ip4_tunnel_proto():

        if (iph->protocol == IPPROTO_IPIP) {
                ctx->tun.proto = IPPROTO_IPIP;
                ctx->tun.hdr_size = size;
                ctx->offset += size;
        }

I think these checks are superfluous at this stage:

if (nexthdr == IPPROTO_IPV6) {

if (iph->protocol == IPPROTO_IPIP) {

because only ipip and ip6ip6 is supported.

