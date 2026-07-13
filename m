Return-Path: <netfilter-devel+bounces-13884-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ktc7DUmjVGp0ogMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13884-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 10:35:21 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B50748C1E
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 10:35:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=EXzKMZna;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13884-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13884-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1529F3046995
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801173ACA5B;
	Mon, 13 Jul 2026 08:24:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D23932CE
	for <netfilter-devel@vger.kernel.org>; Mon, 13 Jul 2026 08:24:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931056; cv=none; b=WwICmK8fc0drb5abaHN2PYSNunlR+o+5bV09zTcLCNM/OLbHgujmprGPdSAHh/Bb8SvlSfkRYG+sSE90N+cDqxjUz3+dRZuMEslZq5CCbkzYW9htAuWm51ppNzdAqGCw79RSc9OqRtX7D0Id4QrX3g2bQo4DxlwJzQ5lVvWasK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931056; c=relaxed/simple;
	bh=yPMfS+hTtc/QyjxRPmG02j1xZX1C77vrMPBOn3WgMos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3xDRMm6IW6u0HSEqLSoc188oBxPEMaZ7jgO8WGg2iC8s06qaVFD3Ueuso5OSdB8tgHaIbavoKJIXSUAKklSCr/TkzQ+u2ZuutiJrFotDho6dPbzaC70If9kyekLuytjhud28f6+CvortPe152k3k7m19rcAb1BCPVk0xKh1Wb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=EXzKMZna; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id F12326017D;
	Mon, 13 Jul 2026 10:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783931050;
	bh=OEUBunrlkXT738nzXy77hWBAdQmGn4ek1ZNVVT+zcFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXzKMZnaObXjDYLMqCp/zdZV5zwJ3BPHyQc7PcxtT15aQdyqBG4VzfFmfBbteFrWA
	 wtuh2+yAoxvQDhm+x58KgRYp691Pu/lnEYpKQqaNGyx651SQdc7A1YeC0Cwvs3n4Fn
	 v+SD+0AC3ty4mE7AHInLCj+DyFZnACLLsGcLrClTgjQVWHLbGgqEk9tSGHgxNo/YJO
	 n6VYTquNqImtkH/2qRLuz0/kMlwIejaWCQAnLdh5aqFFILpkrFqbd6Cyx7t4YgL1fn
	 pC7wfM5uISqfB7TDhNhjwtJYGTZttPLvExc8qCn9PLwvwpbjRPVt47pGTMmW4Bpa4z
	 DZWrydTDZHGeg==
Date: Mon, 13 Jul 2026 10:24:07 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: netfilter-devel@vger.kernel.org, razor@blackwall.org, fw@strlen.de
Subject: Re: [PATCH nf-next,v2 3/3] netfilter: flowtable: initial bridge
 support
Message-ID: <alSgp8fee8DNzdrG@chamomile>
References: <20260710100729.1383580-1-pablo@netfilter.org>
 <20260710100729.1383580-4-pablo@netfilter.org>
 <9b423fa5-88cb-4197-9849-91e40901dd5b@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b423fa5-88cb-4197-9849-91e40901dd5b@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ericwouds@gmail.com,m:netfilter-devel@vger.kernel.org,m:razor@blackwall.org,m:fw@strlen.de,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13884-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77B50748C1E

On Sun, Jul 12, 2026 at 11:27:50AM +0200, Eric Woudstra wrote:
> On 7/10/26 12:07 PM, Pablo Neira Ayuso wrote:
[...]
> > +	this_tuple->iifidx = info.indev->ifindex;
> > +	for (i = info.num_encaps - 1; i >= 0; i--) {
> > +		this_tuple->encap[j].id = info.encap[i].id;
> > +		this_tuple->encap[j].proto = info.encap[i].proto;
> > +		j++;
> > +	}
> > +	this_tuple->encap_num = info.num_encaps;

nft_dev_fill_bridge_path() is called with indev for dir, but
dev_fill_forward() obtains the list of devices from indev.  This reverse
iteration gives us the expected encapsulation before such list of
devices for this direction in the ingress path.

> Until here, this_tuple needs to be the other_tuple.
> dev_fill_forward_path() does not traverse the bridge.
> See other comment in other patch. Also, need to copy
> the in_vlan_ingress bit.
> 
> So it becomes:
> 
> other_tuple->iifidx = info.indev->ifindex;
> for (i = info.num_encaps - 1; i >= 0; i--) {
> 	other_tuple->encap[j].id = info.encap[i].id;
> 	other_tuple->encap[j].proto = info.encap[i].proto;
> 	if (info.ingress_vlans & BIT(i))
> 		other_tuple->in_vlan_ingress |= BIT(j);
> 	j++;
> }
> other_tuple->encap_num = info.num_encaps;

I don't see how it can be this way.

