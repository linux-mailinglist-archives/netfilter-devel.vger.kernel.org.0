Return-Path: <netfilter-devel+bounces-10829-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPFXMbj4m2mp+QMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10829-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Feb 2026 07:50:32 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C291725E6
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Feb 2026 07:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4B59301BD47
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Feb 2026 06:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBE344D91;
	Mon, 23 Feb 2026 06:50:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE7343203;
	Mon, 23 Feb 2026 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771829400; cv=none; b=qe0oDBZiZanHB4RPvCDlOo8BtoZa4nWN/AL0G9LF/9xLqF7ISU69GsE0chbo37ej/HPdZkebyWSN95uQ03dkbNT9DbFStah2MOOfcqEX4QlR5oKvg+MsJYKz+9QVsrbJMqeZRkh2HYOBLYJDvFCE7640vs3d5WNoRJ1VB72GE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771829400; c=relaxed/simple;
	bh=sjwgxeZjx5SSlamb871bLgvFyqx71+WMeyRCCGAccxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quyfrBKtK8zg6S5WyAv0hkubwW/GYYd3RarUFuqeq5q7jWSaO/uhlXMAL8puSAYm9Sh13cuwKgGKj3Ijl0Tb9IpprGZQk+Zd2rmn6EURocb7/m3cQGUpPCiBMEW0DZlTexXFWM4DOhxSpJ1KO/sjP7t3Gce8SrPYP+Ed6tCbnY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 63BD760490; Mon, 23 Feb 2026 07:49:56 +0100 (CET)
Date: Mon, 23 Feb 2026 07:49:52 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC v1 nf-next] netfilter: nf_flow_table_ip: Introduce
 nf_flow_vlan_push()
Message-ID: <aZv4kLUYBSzbWIxO@strlen.de>
References: <20260222155251.76886-1-ericwouds@gmail.com>
 <aZs8atSEZTjkzzQ3@strlen.de>
 <a4af5ff8-7aff-454d-8990-2922f1b9bbf3@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4af5ff8-7aff-454d-8990-2922f1b9bbf3@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10829-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.906];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: F3C291725E6
X-Rspamd-Action: no action

Eric Woudstra <ericwouds@gmail.com> wrote:
> I have run into this, when testing my branch for implementing the
> bridge-fastpath, not in the forward-fastpath. But anyway, no matter how
> packets are handled in the original path (forwarding or bridged), once
> going through the fastpath it would not matter, so it is broken in any
> fastpath.

Agree, it cannot work as-is.

> > Ok, I see, this opencodes a variant of skb_vlan_push().
> > Would it be possible to correct skb->data so it points to the mac header
> > temporarily?  skb->data always points to network header so this cannot
> > have worked, ever.
> 
> The code here for the inner header is an almost exact copy of
> nf_flow_pppoe_push(), which was also implemented at the same time.

Ah, I see.  Makes sense to me.

What aobut this:
Wait for a day or so to give others to provide feedback. If no more
comments, re-send this patch, targetting nf.git, and amend the commit
message to mention that the new function is closedly modelled on
existing nf_flow_pppoe_push().

Makes sense to you?

