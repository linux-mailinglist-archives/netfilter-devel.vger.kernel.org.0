Return-Path: <netfilter-devel+bounces-11870-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GExWJ4sh3mk1ngkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11870-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 13:14:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFB23F932B
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 13:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C927300D0F2
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7760F3D811C;
	Tue, 14 Apr 2026 11:14:15 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD620DE3;
	Tue, 14 Apr 2026 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165255; cv=none; b=F73oiXm30CFlLiTWSs/uCGl3SvfwKfsfxWCNLJJfe7pDyMnObjDEHO3oxGK+i9Qfd427dUbQ8JORtvz+FvnvjXYXLoriXHSPQxhGDhgyKlq88ncbeP9AwCvfOIQt6XQv/IbNzqn4Qmcrl0rE0N9qVPsp4ul1woPIZVGASD0wDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165255; c=relaxed/simple;
	bh=09uiMZRs7r7SYhGOfTyq/qJWTKsO/uLe3Dd56LS2Js4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4JfR/CtQII0adH0ULXIUO8fj9KR6TMpdUe//GDwDSdBbOAZmJtYjCreTTR1tQV8FVnkF9JbjhOEFDZmiJyVGoyX9b8xFMoRAntENea5uUehAR20jcv11G2biNfiFygQhDIsV3WOUn5rdm7grhobEUBG+mhIEnadQYGnyQN3MqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E1E2360490; Tue, 14 Apr 2026 13:14:11 +0200 (CEST)
Date: Tue, 14 Apr 2026 13:14:11 +0200
From: Florian Westphal <fw@strlen.de>
To: "Kito Xu (veritas501)" <hxzene@gmail.com>
Cc: pablo@netfilter.org, coreteam@netfilter.org, davem@davemloft.net,
	edumazet@google.com, ffmancera@riseup.net, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	pabeni@redhat.com, phil@nwl.cc
Subject: Re: [PATCH v2] netfilter: nfnetlink_osf: fix null-ptr-deref in
 nf_osf_ttl
Message-ID: <ad4hg4Wm90sVb1OB@strlen.de>
References: <20260414074556.2512750-1-hxzene@gmail.com>
 <20260414104900.2617863-1-hxzene@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414104900.2617863-1-hxzene@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11870-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DFB23F932B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kito Xu (veritas501) <hxzene@gmail.com> wrote:
> nf_osf_ttl() calls __in_dev_get_rcu(skb->dev) and passes the result
> to in_dev_for_each_ifa_rcu() without checking for NULL. When the
> receiving device has no IPv4 configuration (ip_ptr is NULL),
> __in_dev_get_rcu() returns NULL and in_dev_for_each_ifa_rcu()
> dereferences it unconditionally, causing a kernel crash.
> 
> This can happen when a packet arrives on a device that has had its
> IPv4 configuration removed (e.g., MTU set below IPV4_MIN_MTU causing
> inetdev_destroy) or on a device that was never assigned an IPv4
> address, while an xt_osf or nft_osf rule with TTL_LESS mode is
> active and the packet TTL exceeds the fingerprint TTL.
> 
> Add a NULL check for in_dev before using it. When in_dev is NULL,
> return 0 (no match) since source-address locality cannot be
> determined without IPv4 addresses on the device.
> 
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> RIP: 0010:nf_osf_match_one+0x204/0xa70
> Call Trace:
>  <IRQ>
>  nf_osf_match+0x2f8/0x780
>  xt_osf_match_packet+0x11c/0x1f0
>  ipt_do_table+0x7fe/0x12b0
>  nf_hook_slow+0xac/0x1e0
>  ip_rcv+0x123/0x370
>  __netif_receive_skb_one_core+0x166/0x1b0
>  process_backlog+0x197/0x590
>  __napi_poll+0xa1/0x540
>  net_rx_action+0x401/0xd80
>  handle_softirqs+0x19f/0x610
>  </IRQ>
> 
> Fixes: a218dc82f0b5 ("netfilter: nft_osf: Add ttl option support")
> Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>

The other __in_dev_get_rcu() callers in netfilter check return value, so:

Reviewed-by: Florian Westphal <fw@strlen.de>

