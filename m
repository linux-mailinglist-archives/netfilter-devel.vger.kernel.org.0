Return-Path: <netfilter-devel+bounces-13666-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ab4+CVyRS2qlVgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13666-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 13:28:28 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F170FD75
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 13:28:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="W2ZI/8Q0";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13666-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13666-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6691130CD879
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jul 2026 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77793E8C77;
	Mon,  6 Jul 2026 10:50:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89D374E62;
	Mon,  6 Jul 2026 10:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335039; cv=none; b=noETmncyq700BhHM+yPL69lDAOGuQacv2u38rDZPyFXWWuT/39xQbxSwBFVdK75+rMASQo7nxBZJ/3hgqDrgpB2r3npw1RB3grb3La7gOqWrc/DbhLOYU4zCxhMvtHbrAOrco1YWTN/F4RRXSWs++k9vF09DjY2KaDJCwRFTJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335039; c=relaxed/simple;
	bh=0SfjWWi2FdxRDkLwAikkvJxxafvQ2v2iRdqA/o5xgd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g5yN5fhY239j6FBU2UYyOtEYwyVvDe3WNHlO4Ou5InnNIXDMAT6Ag/C1lrdBHKpr9U4xoVcqxvrvOer9yKwvuK49uvTF62+XbI2dXMaW9yEo1c0TqxGp5zX+u6hy9MI/Eovkf6x6sMiBys0yFEvDtpd0ftWPcDFe2hUxCbde43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2ZI/8Q0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FED91F00A3D;
	Mon,  6 Jul 2026 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783335038;
	bh=BAwMDfIxB5vte5HzFAg81ak7nUvwa8s8kWgiqNRyoTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W2ZI/8Q0/IKEcAcYLlM2jT6oG0m0r764Ynw8MeAsSzkiBF9njVM0zD+hzTjjNtKX8
	 N+0rPwv9eGvJCKcK/PmmpC5Yg13zQ46sGVD0nJqJCGYlTRs63QZKNsbaQKP35urgf9
	 OCiOF+LcBiQvC95ZgDu4oqP7ehQedQZ5r4f876gQYgOYBjEaLec3gcdNpsMXHqPYeP
	 RUKyxjDVogom8v6brg8Y9jQuKIkDlz5NLE8URubvnCdZZbBvuV7irWZygTkwe7W0tq
	 jyRu5NTXpS5hmH8jU2KWMZ3Oz6oCSv51RwvAvyh75PESrj37Sc2kjypVS6yCBGJWiQ
	 SvQpUUGUqJ6ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568133ABD2A5;
	Mon,  6 Jul 2026 10:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/9] netfilter: nf_nat_sip: reload possible stale data
 pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333501888.500093.1798331659151868625.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 10:50:18 +0000
References: <20260703125709.16493-2-fw@strlen.de>
In-Reply-To: <20260703125709.16493-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 pablo@netfilter.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13666-lists,netfilter-devel=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 833F170FD75

Hello:

This series was applied to netdev/net.git (main)
by Florian Westphal <fw@strlen.de>:

On Fri,  3 Jul 2026 14:57:01 +0200 you wrote:
> quoting sashiko:
>  ------------------------------------------------------------------------
>  [..] noticed a potential memory bug and header corruption involving the
>  SIP NAT helper.
> 
>  In net/netfilter/nf_nat_sip.c:nf_nat_sip():
> 	if (skb_ensure_writable(skb, skb->len)) {
> 		nf_ct_helper_log(skb, ct, "cannot mangle packet");
> 		return NF_DROP;
> 	}
> 	uh = (void *)skb->data + protoff;
> 	uh->dest = ct_sip_info->forced_dport;
> 	if (!nf_nat_mangle_udp_packet(skb, ct, ctinfo, protoff,
> 				      0, 0, NULL, 0)) {
> 
> [...]

Here is the summary with links:
  - [net,1/9] netfilter: nf_nat_sip: reload possible stale data pointer
    https://git.kernel.org/netdev/net/c/77e43bcb7ec1
  - [net,2/9] netfilter: xt_u32: reject invalid shift counts
    https://git.kernel.org/netdev/net/c/64cdf7d30ac1
  - [net,3/9] netfilter: xt_rateest: fix u64 truncation in xt_rateest_mt()
    https://git.kernel.org/netdev/net/c/444853cd4382
  - [net,4/9] netfilter: nfnetlink_cthelper: cap to maximum number of expectation per master on updates
    https://git.kernel.org/netdev/net/c/278296b69fae
  - [net,5/9] netfilter: ip6tables: mark malformed IPv6 extension headers for hotdrop
    https://git.kernel.org/netdev/net/c/43ccc20b5a73
  - [net,6/9] netfilter: nft_set_rbtree: get command skips end element with open interval
    https://git.kernel.org/netdev/net/c/d63611cbe8af
  - [net,7/9] ipvs: fix PMTU for GUE/GRE tunnel ICMP errors
    https://git.kernel.org/netdev/net/c/6b335af0d0d1
  - [net,8/9] ipvs: reset full ip_vs_seq structs in ip_vs_conn_new
    https://git.kernel.org/netdev/net/c/2975324d164c
  - [net,9/9] netfilter: xt_connmark: reject invalid shift parameters
    https://git.kernel.org/netdev/net/c/1b47026fb4b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



