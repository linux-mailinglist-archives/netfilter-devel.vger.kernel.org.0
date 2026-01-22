Return-Path: <netfilter-devel+bounces-10377-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HdIIFzuqcWnYLAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10377-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Jan 2026 05:40:27 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA94461C07
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Jan 2026 05:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48EC34E20F0
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Jan 2026 04:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E2B3F23AC;
	Thu, 22 Jan 2026 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY1LWIeL"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CBD28A1D5;
	Thu, 22 Jan 2026 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769056820; cv=none; b=YCIKW71t0UOag+99fN375+MRsHhSUmuOtkixkDI1d2SZ4Bm46AqPoN2N/jsrt4vwFqzuwfzU7a8OmCn1vsqWUxjqISBCmiC3guXeAFKhe/PZ8VImhl5Nzno/0GVZRp0lh38jrXdRK/fyP2tp84Qw6kA+KOVvnwxaQBv6vd6JdhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769056820; c=relaxed/simple;
	bh=AI8dbuGL/HePhE8XRMZqTuwcBec9gvAnEVPmRRXeqCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sMaoA54wRqg3qc2giSsJTQvxTlIzhIKldRCpndfIrgqpF5fcZRZW+CWVa0vjDYu04kkj7LYsmi1ySc+1v7P9PTitzWmak5s3ngtPKqxGQ+0B1F89rlc5oAAlOfoM/LbTaETbl4cmzuFXNU6Yzci/fyV/UDShMXGOX0HWZ7uTjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY1LWIeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C13C116C6;
	Thu, 22 Jan 2026 04:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769056819;
	bh=AI8dbuGL/HePhE8XRMZqTuwcBec9gvAnEVPmRRXeqCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sY1LWIeLbe9PtnsZ2TXCkVlrxGKCxhUOr4JSyJeR1qit1DXQrZqISJkVQ2pnwOc3i
	 wT3xghpz10ALVOWHtMdNnMfrqGEnGUVIVjp+mrAHM3FfZoen+JHUz8Sd0HCJBxfHJp
	 Qji+TSQna8VPDJHHCnKnkYFkD2w++8y1XzEo+nnVGpSmVoWo2lT7GcGtrGcr2Wf7mh
	 cMBgSCrgUxI/1LftFYqHCdsrRzVTDdvqorq/bvBYKX3oa2++3YuHdUAwp/O+Ij8c5D
	 u2dhu/e7jxdwtWXpk5tSzLpxb4OKyvWbsswsdwHe7wgKqDvkyGTvGwFvYGdRBctpXb
	 WcI0rRIr75xoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11E403808200;
	Thu, 22 Jan 2026 04:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/10] netfilter: nf_tables: reset table
 validation
 state on abort
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905681585.1558231.4991951813231134524.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 04:40:15 +0000
References: <20260120191803.22208-2-fw@strlen.de>
In-Reply-To: <20260120191803.22208-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 pablo@netfilter.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10377-lists,netfilter-devel=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: BA94461C07
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Florian Westphal <fw@strlen.de>:

On Tue, 20 Jan 2026 20:17:54 +0100 you wrote:
> If a transaction fails the final validation in the commit hook, the table
> validation state is changed to NFT_VALIDATE_DO and a replay of the batch is
> performed.  Every rule insert will then do a graph validation.
> 
> This is much slower, but provides better error reporting to the user
> because we can point at the rule that introduces the validation issue.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] netfilter: nf_tables: reset table validation state on abort
    https://git.kernel.org/netdev/net-next/c/6f93616a7323
  - [net-next,02/10] netfilter: nf_conntrack: Add allow_clash to generic protocol handler
    https://git.kernel.org/netdev/net-next/c/8a49fc8d8a3e
  - [net-next,03/10] netfilter: nf_conncount: increase the connection clean up limit to 64
    https://git.kernel.org/netdev/net-next/c/21d033e47273
  - [net-next,04/10] netfilter: nf_conntrack: enable icmp clash support
    https://git.kernel.org/netdev/net-next/c/f7becf0dad8f
  - [net-next,05/10] netfilter: don't include xt and nftables.h in unrelated subsystems
    https://git.kernel.org/netdev/net-next/c/910d27122775
  - [net-next,06/10] netfilter: nf_conntrack: don't rely on implicit includes
    https://git.kernel.org/netdev/net-next/c/d00453b6e3a3
  - [net-next,07/10] netfilter: nfnetlink_queue: nfqnl_instance GFP_ATOMIC -> GFP_KERNEL_ACCOUNT allocation
    https://git.kernel.org/netdev/net-next/c/a4400a5b343d
  - [net-next,08/10] netfilter: nft_compat: add more restrictions on netlink attributes
    https://git.kernel.org/netdev/net-next/c/cda26c645946
  - [net-next,09/10] netfilter: nf_conncount: fix tracking of connections from localhost
    https://git.kernel.org/netdev/net-next/c/de8a70cefcb2
  - [net-next,10/10] netfilter: xt_tcpmss: check remaining length before reading optlen
    https://git.kernel.org/netdev/net-next/c/735ee8582da3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



