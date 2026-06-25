Return-Path: <netfilter-devel+bounces-13462-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3iiTOvaZPGr2pggAu9opvQ
	(envelope-from <netfilter-devel+bounces-13462-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2026 05:01:10 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3836C280E
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2026 05:01:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KrvsSS8p;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13462-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13462-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7EE1300A675
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2026 03:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5717274B3B;
	Thu, 25 Jun 2026 03:01:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11431C5D7D;
	Thu, 25 Jun 2026 03:01:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782356465; cv=none; b=fZBUOiJC1223IHhEb+LTUndsjOD9QClnd+Iyoy0z3rJiLqmPy2wB2yUT0qx9xHnmomd6FwZDwWuhULpdQPU7rW+8r3G5bYePzl1O/T3mlGrEWGObT665EVSxtuo+R0wrfTQzyoUoLnj1lAI5jONSjiolU/LFElgP2JqWQ2mK1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782356465; c=relaxed/simple;
	bh=iOx1W5zAagyQBnCJPKhp5RLxhWWIS0l0OlYgJLe7swk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L5JOBarSP7lReD0j3XIWHyrYZXipTQvO7PljVJE4y5UAw5I8owMPZWvM/eMm+nvjKU/dTNoozHoEB+FxumNYFzjQTGXGIzNpuB5PsmbWjTYQJd8XE4R61erw5p5huzqVRiBdd+n7p+1tX32TIwToBskl49hUvq0M7yR4fljJGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrvsSS8p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5C51F000E9;
	Thu, 25 Jun 2026 03:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782356464;
	bh=QA7S1YhYp6ZEsHZIL7RaiWi31oy+OEz6zPCT8KWRmf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KrvsSS8pNpl+XmBWgDJfKQAohexDoA8zrdhWs1rPQSBBO2R6o21sHt74CPjHQjhbH
	 tZ6roVLUWSLkD3FHpSsdwjvXXblEgbgUXJBVKIrK07GRJJVQ21xOzM0Fhre/EzZqAh
	 8mB7Jbh63/Xjj4hM4i+xKjPTX6ZMvNmbHAyklV8w9hB2Macv4ELvvDsU1kKMR7NZcA
	 9KPufrP09bweZTddOCfgADtamDdQP8eEX0VqGzJz7LdGdQn8f7QYDhyf7GRF09P9ct
	 PYVnCjBO5QkjVqcjc0e5nvAaLYdeJsnFbAeRYzPNbPe8v+0QniCjUMfnQ6yC5xMJKh
	 msfDPSj6S/H/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A353AAA6F3;
	Thu, 25 Jun 2026 03:00:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/14] netfilter: nf_nat: avoid invalid nat_net
 pointer
 use on failed nf_nat_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235645227.3097853.18361949927690415910.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 03:00:52 +0000
References: <20260623221548.701545-2-pablo@netfilter.org>
In-Reply-To: <20260623221548.701545-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13462-lists,netfilter-devel=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,grsecurity.net:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE3836C280E

Hello:

This series was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Wed, 24 Jun 2026 00:15:34 +0200 you wrote:
> From: Mathias Krause <minipli@grsecurity.net>
> 
> We ran into below KASAN splat, which is mostly uninteresting, beside
> for having nf_nat_register_fn() in the call chain as a cause for the
> offending access:
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in nf_nat_register_fn+0x5f9/0x640
> Read of size 8 at addr ffff890031e54c20 by task iptables/9510
> 
> [...]

Here is the summary with links:
  - [net,01/14] netfilter: nf_nat: avoid invalid nat_net pointer use on failed nf_nat_init()
    https://git.kernel.org/netdev/net/c/069cfe3de2a5
  - [net,02/14] netfilter: nf_conncount: prevent connlimit drops for early confirmed ct
    https://git.kernel.org/netdev/net/c/c8b6f36f7669
  - [net,03/14] netfilter: flowtable: Validate iph->ihl in nf_flow_ip4_tunnel_proto()
    https://git.kernel.org/netdev/net/c/84460b644329
  - [net,04/14] netfilter: x_tables.h: fix all kernel-doc warnings
    https://git.kernel.org/netdev/net/c/22f9dbed18bc
  - [net,05/14] netfilter: nft_synproxy: stop bypassing the priv->info snapshot
    https://git.kernel.org/netdev/net/c/11d4bc4e26fb
  - [net,06/14] selftests: netfilter: conntrack_sctp_collision.sh: Introduce SCTP INIT collision test
    https://git.kernel.org/netdev/net/c/a49a8e51eebc
  - [net,07/14] netfilter: nft_compat: ebtables emulation must reject non-bridge targets
    https://git.kernel.org/netdev/net/c/9dbba7e694ec
  - [net,08/14] selftests: nft_queue.sh: add a bridge queue test
    https://git.kernel.org/netdev/net/c/8a2cfe7951f6
  - [net,09/14] netfilter: ctnetlink: do not allow to reset helper on existing conntrack
    https://git.kernel.org/netdev/net/c/aaa0cd698ffa
  - [net,10/14] netfilter: conntrack: add deprecation warnings for irc and pptp trackers
    https://git.kernel.org/netdev/net/c/57f940017a77
  - [net,11/14] netfilter: nf_conntrack_expect: store master_tuple in expectation
    https://git.kernel.org/netdev/net/c/979c13114c0b
  - [net,12/14] netfilter: nf_conntrack_expect: run expectation eviction with no helper
    https://git.kernel.org/netdev/net/c/be57dd9c1c17
  - [net,13/14] netfilter: nft_ct: expectation timeouts are passed in milliseconds
    https://git.kernel.org/netdev/net/c/6fb421bd07f1
  - [net,14/14] netfilter: nf_conntrack_helper: cap maximum number of expectation at helper registration
    https://git.kernel.org/netdev/net/c/397c8300972f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



