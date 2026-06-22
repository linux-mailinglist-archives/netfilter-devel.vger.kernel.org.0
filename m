Return-Path: <netfilter-devel+bounces-13395-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jIl+NbNzOWoptQcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13395-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 19:41:07 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4226B187C
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 19:41:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Iw5f3bwf;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13395-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13395-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3304C30247DA
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638A4340407;
	Mon, 22 Jun 2026 17:40:55 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC56264A97;
	Mon, 22 Jun 2026 17:40:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150055; cv=none; b=BRCSIY9VrQqIFryIciNiBTlVi4gRBrc62mph6YawEYZO/dxnDv6SrYKu1ypISCKCPdcm/5BKktcNYW02YCxxV7Dy3Pp+sS7E0H6uw8vraB9IMMxuPm6x0AAvVTfl7znSxUfCghxyAr+HQjr1kbix3qNj7PkyDEOSmIOU16yrLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150055; c=relaxed/simple;
	bh=lfAqB3BHO7Xj2vu2mh1qKKqvy7mMcgubBf6EOBGWlnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QjMfy+wEGdNJmFcruxPSQd4aqo9136epeameDvDPvWmDPVf++5I9iR7z4ynx5vvau2hKXhwDQNe0HA2U7EkWoK/kTayqG2um3/flRnvZvHBarSQN1hLejo6k5GXTJ/qDIgLa4/DPuKQuu8CYBceNuol50ZIEiWV49j9qwEm8A4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw5f3bwf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129751F000E9;
	Mon, 22 Jun 2026 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782150054;
	bh=Ay7ugMmiG3L7SvKqqUogfugM4qLAPccAyh4+6ylExWE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Iw5f3bwfGJ7zuq1gFGrj7iYdGdEaWnopnSm2ESbinHoFPcGO9AhT+oyJVRKCQGYf0
	 zYywqh9WX17pa8wn+EwAeiiAJSeLsiG9ZmyeXlrC75hDP8AhkMZjAjBuAm22hlQlg+
	 lHG5eGzeRyQezv+wzRDo9anjC0b9usHk/WmjqNOVn3nLRA/eKcQg2Ugj3dUTr2/R1i
	 ntR4xNyHM3mcCvqObPPpa6gctIz1scfsmnF/qsMF+yrQTZ8XMR20mnLIZpcTWJDF9c
	 BLSMHXLunTC3LvP5n+UCyDiJRdLSayOIyuganN+2CZdDOuZdbEDAclIPssVe1ROYx1
	 0jILUnML29tww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AA43930917;
	Mon, 22 Jun 2026 17:40:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/14] netfilter: flowtable: fix offloaded ct timeout
 never being extended
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178215004438.1337004.6008620482552986594.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 17:40:44 +0000
References: <20260620222738.112506-2-pablo@netfilter.org>
In-Reply-To: <20260620222738.112506-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-13395-lists,netfilter-devel=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B4226B187C

Hello:

This series was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Sun, 21 Jun 2026 00:27:25 +0200 you wrote:
> From: Adrian Bente <adibente@gmail.com>
> 
> OpenWrt has recently migrated many platforms to kernel 6.18. On the
> MediaTek platform, which supports hardware network offloading, WiFi
> connections accelerated via the WED path were observed to drop after
> roughly 300 seconds.
> 
> [...]

Here is the summary with links:
  - [net,01/14] netfilter: flowtable: fix offloaded ct timeout never being extended
    https://git.kernel.org/netdev/net/c/53b3e60edb67
  - [net,02/14] netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst
    https://git.kernel.org/netdev/net/c/c9c9b37f8c55
  - [net,03/14] netfilter: xt_cluster: reject template conntracks in hash match
    https://git.kernel.org/netdev/net/c/5feba91006ec
  - [net,04/14] netfilter: flowtable: fix and simplify IP6IP6 tunnel handling
    https://git.kernel.org/netdev/net/c/f4c2d8668d85
  - [net,05/14] netfilter: ipset: Don't use test_bit() in lockless RCU readers in hash types
    https://git.kernel.org/netdev/net/c/e4b4984e28c1
  - [net,06/14] netfilter: ipset: Don't use test_bit() in lockless RCU readers in bitmap types
    https://git.kernel.org/netdev/net/c/1171192ac9af
  - [net,07/14] netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
    https://git.kernel.org/netdev/net/c/3ca9982a8882
  - [net,08/14] netfilter: ipset: make sure gc is properly stopped
    https://git.kernel.org/netdev/net/c/4a597a87e2e2
  - [net,09/14] netfilter: nft_payload: reject offsets exceeding 65535 bytes
    https://git.kernel.org/netdev/net/c/213be32f46a2
  - [net,10/14] netfilter: nft_meta_bridge: add validate callback for get operations
    https://git.kernel.org/netdev/net/c/bff1c8b49a9c
  - [net,11/14] netfilter: nft_flow_offload: zero device address for non-ether case
    https://git.kernel.org/netdev/net/c/e409c23c2d06
  - [net,12/14] netfilter: nf_reject: skip iphdr options when looking for icmp header
    https://git.kernel.org/netdev/net/c/af8d6ae09c0a
  - [net,13/14] netfilter: nf_conntrack_expect: use conntrack GC to reap expectations
    https://git.kernel.org/netdev/net/c/b8b09dc2bf35
  - [net,14/14] netfilter: nft_meta_bridge: fix NFT_META_BRI_IIFPVID stack leak
    https://git.kernel.org/netdev/net/c/27dd2997746d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



