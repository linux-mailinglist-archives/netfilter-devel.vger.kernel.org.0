Return-Path: <netfilter-devel+bounces-12965-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC/yONBjHWpHaAkAu9opvQ
	(envelope-from <netfilter-devel+bounces-12965-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 01 Jun 2026 12:49:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4716161DDDA
	for <lists+netfilter-devel@lfdr.de>; Mon, 01 Jun 2026 12:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B8CD301D078
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jun 2026 10:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B40834F48F;
	Mon,  1 Jun 2026 10:31:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62832342509
	for <netfilter-devel@vger.kernel.org>; Mon,  1 Jun 2026 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309917; cv=none; b=SQSTlIt9t4QCJ/CObCE2qhBJtVI1kXQoJIb21aC6ckZvo7EvA6MqR7hfHnlZsm/PFj2/f3uttZhtqXYosVutujAa/KzO0tL/CRLwWSTrJAEyeOICLIWOAClEPu1hOv399Kb/HA24a4ETB5cgVAXetbBp86qO3X6TkVMwP0D0HMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309917; c=relaxed/simple;
	bh=128YcygP3By5a+jKgRXlThx/mW2wDpPabboQDxS5wRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJL4qyUucUVN4qcZklENjLJeyv2TLKdpsuyYZ9igIUFylVTHO6ei7yLb4Iu9aJZWD5/z4RAGAN5pVBHa1LuofpI7Oj2DQAqwBZK+JZ8KsIXznTHfqoH2+lvI9KVwqqVOXg0K1f8LXFOHfqAviR+7CMQtGh0cagP9bizsmfGL+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A1060604DC; Mon, 01 Jun 2026 12:31:53 +0200 (CEST)
Date: Mon, 1 Jun 2026 12:31:53 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, Hacking <eilaimemedsnaimel@gmail.com>
Subject: Re: [PATCH nf] netfilter: bridge: ebt_redirect: don't assume bridge
 port exists
Message-ID: <ah1fmV-PtReWT0y-@strlen.de>
References: <20260601095000.595383-1-fw@strlen.de>
 <ah1fBBvCPBOTQ93a@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah1fBBvCPBOTQ93a@chamomile>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-12965-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid,netfilter.org:email]
X-Rspamd-Queue-Id: 4716161DDDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Hi Florian,
> 
> On Mon, Jun 01, 2026 at 11:50:00AM +0200, Florian Westphal wrote:
> > ebt_redirect_tg() dereferences br_port_get_rcu() return without a
> > NULL check, causing a kernel panic when the bridge port has been
> > removed between the original hook invocation and an NFQUEUE
> > reinject.
> 
> Maybe more candidates for the same pattern?

Did not find any, but I only searched in net/bridge/netfilter.

Will send a v2.

> net/bridge/netfilter/nft_reject_bridge.c:       br_forward(br_port_get_rcu(dev), nskb, false, true);
> net/bridge/netfilter/nft_reject_bridge.c:       br_forward(br_port_get_rcu(dev), nskb, false, true);
> net/bridge/netfilter/nft_reject_bridge.c:       br_forward(br_port_get_rcu(dev), nskb, false, true);
> net/bridge/netfilter/nft_reject_bridge.c:       br_forward(br_port_get_rcu(dev), nskb, false, true);

br_forward(NULL, .. is safe.

> net/netfilter/nfnetlink_log.c:                                   htonl(br_port_get_rcu(indev)->br->dev->ifindex)))
> net/netfilter/nfnetlink_log.c:                                   htonl(br_port_get_rcu(outdev)->br->dev->ifindex)))
> net/netfilter/nfnetlink_queue.c:                                         htonl(br_port_get_rcu(indev)->br->dev->ifindex)))
> net/netfilter/nfnetlink_queue.c:                                         htonl(br_port_get_rcu(outdev)->br->dev->ifindex)))

Those aren't.

