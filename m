Return-Path: <netfilter-devel+bounces-11861-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHCqGLj63WlTlwkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11861-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 10:28:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1A23F748D
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 10:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43C6D302239E
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FB73A452D;
	Tue, 14 Apr 2026 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="elbW7Oxp"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6443A3839;
	Tue, 14 Apr 2026 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154934; cv=none; b=LfPVEZHId72dmasH2cFjCKz+iTuj12Vm96IE2sR65kti/qZU5KWHwMowvBdL5u7CM2zlijISf3j4GoIY7r9RSnxAkgksNiVmps5kOF+1c3M5cApIKqKwGuCosem3VlfTAbpSmpeveIR7XpBVq59Vvvmzabp/U8EH1z55CQ71cQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154934; c=relaxed/simple;
	bh=jzFtL9571vXvElbFd7wIzOrMLIAQ/iew9/sIZpTf3aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=re9KheOyeDT7kySLyq7WbIMPsOLEmFCv0vkiDZEHMKIpTqaz41EAdfnWY/PZ5DdtyPCs+YOPM/S2Y4Fl0ZnUu0lwkaNwD9A5GRTvaQb1RfbkNEJ6LBDbfMhH54Wq62hj9RIfPmT+t7f/Mb5tpidFDthwPOxMG5hr5I4u4Fa4xyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=elbW7Oxp; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 4BCDB60178;
	Tue, 14 Apr 2026 10:22:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776154928;
	bh=J9FV0tY3mNWxjj10m66z3B+d4DhWZVFBM8ZscCRdWTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elbW7OxpiAe+Z27qY0jt2Dpvk8t6MWKeMW6p+XySueZ8MfpS45N96AENwC2xRZZpm
	 Sln37rQbPais1+xYPv/zpPZJPc8LCH2SUxMEIzOfMwyUcEwL+lxCgR65QrmukfqHgh
	 tUeY+15l/kcrNPXLrEtz8YVRrKwWMscNfEl4tzObQ6C9v5CJKkWD+BfSCTXx0pZt99
	 FR3jVqPXMM5Lzc41fzBng9XZzM/A8ocUWnqUbCdI+EMVz7QFokvaJKs3pJo6UwRFGs
	 GYuAtjLCO/zMc+CzE0Ufukd0B+EPTiJGy4Z/dFVMHe+Tot9AH3hBhEB44x4p1fuMoW
	 nDoajlwrnb38g==
Date: Tue, 14 Apr 2026 10:22:06 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: "Kito Xu (veritas501)" <hxzene@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nfnetlink_osf: fix null-ptr-deref in
 nf_osf_ttl
Message-ID: <ad35LhIOSaEDJAhS@chamomile>
References: <20260414074556.2512750-1-hxzene@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414074556.2512750-1-hxzene@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11861-lists,netfilter-devel=lfdr.de];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:dkim]
X-Rspamd-Queue-Id: 6B1A23F748D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, Apr 14, 2026 at 03:45:56PM +0800, Kito Xu (veritas501) wrote:
> nf_osf_ttl() calls __in_dev_get_rcu(skb->dev) and passes the result
> to in_dev_for_each_ifa_rcu() without checking for NULL. When the
> receiving device has no IPv4 configuration (ip_ptr is NULL),
> __in_dev_get_rcu() returns NULL and in_dev_for_each_ifa_rcu()
> dereferences it unconditionally, causing a kernel crash.

How could skb->dev be NULL !?

This is run from prerouting, input and forward.

> This can happen when a packet arrives on a device that has had its
> IPv4 configuration removed (e.g., MTU set below IPV4_MIN_MTU causing
> inetdev_destroy) or on a device that was never assigned an IPv4
> address, while an xt_osf or nft_osf rule with TTL_LESS mode is
> active and the packet TTL exceeds the fingerprint TTL.
> 
> Add a NULL check for in_dev before the iteration. When in_dev is
> NULL, return 0 (no match) since source-address locality cannot be
> determined without IPv4 addresses on the device.
> 
> KASAN: null-ptr-deref in range
>  [0x0000000000000010-0x0000000000000017]
> RIP: 0010:nf_osf_match_one+0x204/0xa70

I cannot believe this, I think AI is mocking KASAN splat, if that is
the case, I am sorry to say, but it is too bad if you are doing this.

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
> Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
> ---
>  net/netfilter/nfnetlink_osf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
> index d64ce21c7b55..85dbd47dbbd4 100644
> --- a/net/netfilter/nfnetlink_osf.c
> +++ b/net/netfilter/nfnetlink_osf.c
> @@ -43,6 +43,9 @@ static inline int nf_osf_ttl(const struct sk_buff *skb,
>  	else if (ip->ttl <= f_ttl)
>  		return 1;
>  
> +	if (!in_dev)
> +		return 0;
> +
>  	in_dev_for_each_ifa_rcu(ifa, in_dev) {
>  		if (inet_ifa_match(ip->saddr, ifa)) {
>  			ret = (ip->ttl == f_ttl);
> -- 
> 2.43.0
> 

