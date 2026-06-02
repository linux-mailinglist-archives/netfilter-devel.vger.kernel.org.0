Return-Path: <netfilter-devel+bounces-13002-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e7xGLU4sH2qRiQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13002-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 02 Jun 2026 21:17:34 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF6631585
	for <lists+netfilter-devel@lfdr.de>; Tue, 02 Jun 2026 21:17:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hV+3uf3a;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13002-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13002-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C03F3302BBBD
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jun 2026 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52C53A48E2;
	Tue,  2 Jun 2026 19:10:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F56288C2C;
	Tue,  2 Jun 2026 19:10:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427420; cv=none; b=lqvCSX+GnZ6cPsISs/Gf8qmnpSQ9YHKJ1niQQ4GznVD25tT0OOz51fvUkP/zFqQ0zHXoWTYKRiSMD/zwRKr79HpZhDEnzUf7rcZ/DIH7uYT+1aTE/NV4xWoKu7fzsJ7h4d9RFojnqlhwQXyo3x/zKZKmIRJHoysxI0DnrtwjIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427420; c=relaxed/simple;
	bh=Wxm+ic9/esR2PVwyyETe+0Loc103q2DsCNpRaa9fVNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RybcRMRM6xNT+SRNN2GXRWho/9B4TftKRaNr93MeKD2LxW7KmejffXHPO5UePBOz1Q9g/2caqY/5QtuyP7st/rTQ8rj+h7Krm/5M3j0BTbI+ALzuTN59TpMVY2EzUEO2ehL8O63T3iHBjBJIntw4hhDV7oDcEBKcy7pGvwbDen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV+3uf3a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3AE1F00893;
	Tue,  2 Jun 2026 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780427419;
	bh=JtGt++R/f8bgq6fQ3CReSoelNNyd2mwUPWmDDgrIImo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hV+3uf3aELKEVBVbvk75S6L4xoSn5MR7u1gR1824C0DkQbJI0+Y1cKVs9vhlV+Kd5
	 RABcY4qL54W9MJyNkGk8Rzxj4j8pKtPMgtf9Ni2HtLNHe4xpTkKSCQiJtwg9fPfzvp
	 Lcxq+38Py5pmULr55ldprN52j7SqOFQHrzfbZ3LLhadh7nWX/G/VLjMbN1IuQfqgKp
	 IeRX0A3NrvY1S6BYA0Lzl7ANTebPSaf5SGI3AJ0Q/ITpvDncD9Ol7QWAPhggYftpkt
	 hK3dtgkoiTlitEHNQQS4gv22fFeGny3pfTBkYey36F6BBAWSaCmm1WYQkPh+BfZitU
	 YOjUtIVTz/Xbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568E83811A6C;
	Tue,  2 Jun 2026 19:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/9] netfilter: xt_NFQUEUE: prefer
 raw_smp_processor_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042742088.1010994.13923507851088748199.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:10:20 +0000
References: <20260601115923.433946-2-pablo@netfilter.org>
In-Reply-To: <20260601115923.433946-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-13002-lists,netfilter-devel=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DBF6631585

Hello:

This series was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Mon,  1 Jun 2026 13:59:15 +0200 you wrote:
> From: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> With PREEMPT_RCU this triggers a splat because smp_processor_id() can be
> preempted while inside a RCU critical section. If xt_NFQUEUE target is
> invoked via nft_compat_eval() path, we are inside a RCU critical
> section.
> 
> [...]

Here is the summary with links:
  - [net,1/9] netfilter: xt_NFQUEUE: prefer raw_smp_processor_id
    https://git.kernel.org/netdev/net/c/c6c5327dd18b
  - [net,2/9] ipvs: clear the svc scheduler ptr early on edit
    https://git.kernel.org/netdev/net/c/193989cc6d80
  - [net,3/9] netfilter: nft_fib_ipv6: bail out of sibling walk if rt got unlinked
    https://git.kernel.org/netdev/net/c/36d29ceec32c
  - [net,4/9] netfilter: synproxy: add mutex to guard hook reference counting
    https://git.kernel.org/netdev/net/c/2fcba19caaeb
  - [net,5/9] netfilter: conntrack_irc: fix possible out-of-bounds read
    https://git.kernel.org/netdev/net/c/66eba0ffce3b
  - [net,6/9] netfilter: nft_tunnel: fix use-after-free on object destroy
    https://git.kernel.org/netdev/net/c/c32b26aaa2f9
  - [net,7/9] netfilter: nft_ct: bail out on template ct in get eval
    https://git.kernel.org/netdev/net/c/3027ecbdb5fd
  - [net,8/9] netfilter: bridge: make ebt_snat ARP rewrite writable
    https://git.kernel.org/netdev/net/c/67ba971ae025
  - [net,9/9] netfilter: nft_byteorder: remove multi-register support
    https://git.kernel.org/netdev/net/c/bb061d3de417

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



