Return-Path: <netfilter-devel+bounces-13280-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PAAaLrFsMGqqSwUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13280-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 23:20:49 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBC168A26E
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 23:20:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DT0zOsE0;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13280-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13280-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0359E300809C
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4733A5E6F;
	Mon, 15 Jun 2026 21:20:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C5439524E;
	Mon, 15 Jun 2026 21:20:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558442; cv=none; b=IdlyIEZm6ETSeSxOBZdPYMq02tFHFOqtWYLpcB4A7Nd1dPkEooZm2s7//MQyiIKTmgG8hwnZkCeEphqcLqvQx6s8u+WiNBF2GJQoktA/ywbTm6jidWcE4lQbUp2rqZb0fMUW44e0it7vpzeaZ5mqGKBw0t6jQiuF5pIiJdRPh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558442; c=relaxed/simple;
	bh=/UPlBpgi7VhPmT8JbMLOPei/oFmnqBzhSMcuxIhH+ok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dBLbVotGycDCf77y7SOtqYA4vut/S04TxpZxvDQEXusFpPBjXEE3FoJoW97sdXKFesn7y8o6vbUbO8NkRSKql3n/3286Z8P6hL8DZ1jFTz1PVI0IMcR5ZJ2m1tFya7IYbq2l8DNNlWQOknQ6C7iRxqCEY3pLT/+qmBNmwxtX4Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT0zOsE0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120CE1F000E9;
	Mon, 15 Jun 2026 21:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558441;
	bh=TShMPVpuwyA7WLtOxzwnDuVG1ofCLhti/tuFrKiBGoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DT0zOsE0ZqYmd1FJM04sMNS7/D/0Stw65ZNSb2VfH9Wl2HYEMakYMEbdkK2GOBuBd
	 bg0vRSEI7ADU4ANDnLxqXARYXnzST+lPEOeVfJn1Six90lH8G+IrAvaYvJbvRgWJpY
	 h/vr+3FdYGUIuZOwoobjr/1HCt3HRT3kQ9Iz+La8ygrhWnx8OJGb0xoYTtJHXYbTXn
	 MuW7yaMBUQg4TW8OQZQX8J9WPw5Yf3NgcAAg3OlGP7hDilX+S48Q7S8JSP81q9SySG
	 S5h+wjnsEQKWYnFAXpqRR3KXhnnexmig/mmVWHM8mVLPVIqWLmqt9GdLCaWvCevnqw
	 QgjA358e4x2rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5685E3839A06;
	Mon, 15 Jun 2026 21:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/11] ipvs: Replace use of system_unbound_wq
 with
 system_dfl_long_wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155843618.301119.5062848421589308847.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 21:20:36 +0000
References: <20260614114605.474783-2-pablo@netfilter.org>
In-Reply-To: <20260614114605.474783-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13280-lists,netfilter-devel=lfdr.de,netdevbpf];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,netfilter.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBBC168A26E

Hello:

This series was applied to netdev/net-next.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Sun, 14 Jun 2026 13:45:55 +0200 you wrote:
> From: Marco Crivellari <marco.crivellari@suse.com>
> 
> This patch continues the effort to refactor workqueue APIs, which has
> begun with the changes introducing new workqueues and a new
> alloc_workqueue flag:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] ipvs: Replace use of system_unbound_wq with system_dfl_long_wq
    https://git.kernel.org/netdev/net-next/c/30877f3da910
  - [net-next,02/11] netfilter: nf_tables: use DEBUG_NET_WARN_ON_ONCE in packet and control paths
    https://git.kernel.org/netdev/net-next/c/42eb1ca711b6
  - [net-next,03/11] netfilter: nf_conncount: callers must hold rcu read lock
    https://git.kernel.org/netdev/net-next/c/64d7d5abe216
  - [net-next,04/11] netfilter: nf_conncount: use per nf_conncount_data spinlocks
    https://git.kernel.org/netdev/net-next/c/eae341ecfc24
  - [net-next,05/11] netfilter: nf_conncount: split count_tree_node rbtree walk into helper
    https://git.kernel.org/netdev/net-next/c/2e064ae85942
  - [net-next,06/11] netfilter: nf_conncount: add sequence counter to detect tree modifications
    https://git.kernel.org/netdev/net-next/c/635a10f6d076
  - [net-next,07/11] netfilter: nf_conncount: gc and rcu fixes
    https://git.kernel.org/netdev/net-next/c/4eb7c3db5b85
  - [net-next,08/11] netfilter: conntrack: check NULL when retrieving ct extension
    https://git.kernel.org/netdev/net-next/c/e3cd138e5607
  - [net-next,09/11] netfilter: flowtable: bail out if forward path cannot be discovered
    https://git.kernel.org/netdev/net-next/c/871df5007eda
  - [net-next,10/11] ipvs: fix doc syntax for conn_max sysctl
    https://git.kernel.org/netdev/net-next/c/0e2a5d02f1d1
  - [net-next,11/11] netfilter: nf_dup_netdev: add nf_dev_xmit_recursion*() helpers and use them
    https://git.kernel.org/netdev/net-next/c/2354e975932d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



