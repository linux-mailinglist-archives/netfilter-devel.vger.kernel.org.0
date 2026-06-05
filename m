Return-Path: <netfilter-devel+bounces-13065-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n6vdA/2PImrsaAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13065-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 10:59:41 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8233E646A35
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 10:59:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=UsHrb2PG;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13065-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13065-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CA3C30182CC
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jun 2026 08:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2237F74A;
	Fri,  5 Jun 2026 08:54:55 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C13FE667
	for <netfilter-devel@vger.kernel.org>; Fri,  5 Jun 2026 08:54:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649695; cv=none; b=knJ4uL+MnG+QIEtyGnknqZY/s24z7hhOj6Yi22klq9ah92/WpFPgCY/ZtSoNJ1M+Cr0IuZP0HsS+DQVDEGcoVcdqRfNYOidRfFYC+zkdr8dI/D5GpV4JzEZpby6uy3MzhukZGeqnDwGSeRU3MYzeORI865wmBVtgh8wpsIeo6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649695; c=relaxed/simple;
	bh=ChndUXNxjiGHGNfit4TqE+6yl1q1XBBh6eV+3RThzqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGaggnosOnSa/xVYVQ7pgI037WBOuhkYPxDDG+/EoHRNStweoFvhziD+QIYtkv96AHHCsj/pINYhGCmqVyeK/YnHf5wgFXiYmQFEoPPXprTAflDHSyce6YdhWISuniGnPyvTos6Wnb6ZGTWgxoEUqGbDMv/X2O68Ck87eKFhsPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=UsHrb2PG; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 336CC6017F;
	Fri,  5 Jun 2026 10:54:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780649684;
	bh=ekoWz7I6ZJOPiMjeRFCLQzI3w+G6NfJ7xcA1qoLN8Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsHrb2PGlV34IPip58KgPFz5gV2jkVgWKDn01P2fzmFiQ4C0ixM0WPZRUop5S1wbt
	 KlJaxPCjdcHbREQhMJGoDeNMm/C87D1hbG7umNKZOvowxy11hJQl3b6zfi6fg1pyUA
	 hlDt0yEDg7ml2zfttncQK2Q5lKs9azy+eX3b4TL2i2RsqDySS4BAXY/w37brxn1T2a
	 ok7CabJZ7vJhRUt7boi+NBNwzvqflwpXFOsEcQKkCmlcKveazmgYNte1opD7jr/EAd
	 LZsHru7iKqFZ6bmnnJrl5N0DvfqEte4IOQfZwQscpFWWP9HNPw8l2OUF9H5O2qS8Mw
	 0b/PSMEt8VXCQ==
Date: Fri, 5 Jun 2026 10:54:41 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: Possible device resouce leak in nf_offload infra
Message-ID: <aiKO0TxEgqgAZtve@chamomile>
References: <aiHPPts-fb3oG9Sx@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiHPPts-fb3oG9Sx@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13065-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netfilter.org:from_mime,netfilter.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8233E646A35

On Thu, Jun 04, 2026 at 09:17:42PM +0200, Florian Westphal wrote:
> Hi Pablo
> 
> net/netfilter/nf_dup_netdev.c :
> 
>  70 int nft_fwd_dup_netdev_offload(struct nft_offload_ctx *ctx,
>  71                                struct nft_flow_rule *flow,
>  72                                enum flow_action_id id, int oif)
>  73 {
>  74         struct flow_action_entry *entry;
>  75         struct net_device *dev;
>  76
>  77         /* nft_flow_rule_destroy() releases the reference on this device. */
> 
> This comment is no longer true.
> 
>  78         dev = dev_get_by_index(ctx->net, oif);
>  79         if (!dev)
>  80                 return -EOPNOTSUPP;
>  81
>  82         entry = nft_flow_action_entry_next(ctx, flow);
>  83         if (!entry)
>  84                 return -E2BIG;
> 
> ... because nft_flow_rule_destroy() cannot drop the device
> ref when we return here, as dev is not assigned to entry
> yet (and we got no entry).

Yes, it is a refcount leak in error path.

> AFAICS its safe to just swap this and have
> lines 77/78 moved after line 82.
> 
> nft_fwd_dup_netdev_offload() could also use some debug
> check to make sure this doesn't get called for actions
> other than FLOW_ACTION_REDIRECT/FLOW_ACTION_MIRRED as
> those are the only ones where nft_flow_rule_destroy() takes
> action.
> 
> (or accessors and comments that say that accesses to the
>  hidden union are illegal).
> 
> Is the analysis correct?  I can make a patch.

Yes, sure, go ahead. Thanks Florian

