Return-Path: <netfilter-devel+bounces-11303-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK2hBrANvGkirwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11303-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 15:52:32 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6B2CD360
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 15:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A4A731D1B7E
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168C93D5658;
	Thu, 19 Mar 2026 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suZNdFJ2"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1F40DFD2;
	Thu, 19 Mar 2026 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931818; cv=none; b=nwJ7vYf9DhpXMhPNa1ASFbjJypIMNWyyK+oTd98q6Hejg11Pp6BZxqKPa7iMKf5VIYoRoXH6etYebCpjW3ZwTkD4NhOCupvaQ6xFZsKZgafEZUOjelhFnxoCoiWK0JMytoaGGOPRJdMLYHZD4mTfpwHNW/soa7MmHxHirc+ICW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931818; c=relaxed/simple;
	bh=DXPkNAGv8MCVHqmAHf7Sip8GWPPfcvMdeFaBt53M8fg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hkvf1R27Hi0VNrwcX/uoE1vlubHtZHPI1bTLb1yCxlTBkBhYLFi0MdIHXN2+yMEA24UKKbG/ATRke4DjM4KoI7HC2gPAcoCJs7gCurcoluebi+Dtwkz0FBxRQIfX2wept6bnRQajbT7qR7w/9U8c8dLpus5qQLuSY8COLtPvKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suZNdFJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C423FC19424;
	Thu, 19 Mar 2026 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773931817;
	bh=DXPkNAGv8MCVHqmAHf7Sip8GWPPfcvMdeFaBt53M8fg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=suZNdFJ2AM2tJ5JvMtZlrMLI2ysFQtaeUfJVHV3rdJ2kX21ZWnvQvApKN/LDzDGVL
	 cdoeNwpe3j1G/a4OLbmt4vRzCPc+YF97kkjYjxYP/qxySNJoa4JkEdnQlgUu8a1ANE
	 0oF/ePEHyX3KIR0HIpjAxOgphu6DI3SH2HVMFBPNiAKO5FTi/+03TK2vU32Hj9CRCQ
	 6Vm7x6FzujwQAfxmUoJZFFJIn1T4DgboHFN5DS0yX3rrFGHr8bv+wvM5HMYlKROH3f
	 +gQVIgHwDIoI+NUm0htFnygZNZp/zfEY3eXmo9rqN94TYLwtGVpHGsd/ljGhd97q+p
	 7CcpY9Uka0xHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DFD380692A;
	Thu, 19 Mar 2026 14:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] netfilter: bpf: defer hook memory release until
 rcu
 readers are done
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177393180879.1521029.11143484797740188911.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 14:50:08 +0000
References: <20260319093834.19933-2-fw@strlen.de>
In-Reply-To: <20260319093834.19933-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 pablo@netfilter.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-11303-lists,netfilter-devel=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: 73F6B2CD360
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Florian Westphal <fw@strlen.de>:

On Thu, 19 Mar 2026 10:38:32 +0100 you wrote:
> Yiming Qian reports UaF when concurrent process is dumping hooks via
> nfnetlink_hooks:
> 
> BUG: KASAN: slab-use-after-free in nfnl_hook_dump_one.isra.0+0xe71/0x10f0
> Read of size 8 at addr ffff888003edbf88 by task poc/79
> Call Trace:
>  <TASK>
>  nfnl_hook_dump_one.isra.0+0xe71/0x10f0
>  netlink_dump+0x554/0x12b0
>  nfnl_hook_get+0x176/0x230
>  [..]
> 
> [...]

Here is the summary with links:
  - [net,1/3] netfilter: bpf: defer hook memory release until rcu readers are done
    https://git.kernel.org/netdev/net/c/24f90fa3994b
  - [net,2/3] netfilter: nf_tables: release flowtable after rcu grace period on error
    https://git.kernel.org/netdev/net/c/d73f4b53aaae
  - [net,3/3] nfnetlink_osf: validate individual option lengths in fingerprints
    https://git.kernel.org/netdev/net/c/dbdfaae96096

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



