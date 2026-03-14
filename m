Return-Path: <netfilter-devel+bounces-11203-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHKhJ8mKtWkS1wAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11203-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Mar 2026 17:20:25 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5518B28DDC8
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Mar 2026 17:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B533F300B471
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Mar 2026 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1E31F7575;
	Sat, 14 Mar 2026 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djBJyWzv"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EEB3B2BA;
	Sat, 14 Mar 2026 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773505223; cv=none; b=fCXL7H5ICPG+Tvt/8jY0QFsu33vDMGqoFUcAhu7tQl+9cfm6LMErO4iscNdt25ykSvXBmBM9CcqOj4jtvkBeB9z83mUYYErTX8TktN1GV2db+2+a7bs5r4AzukHLN+akevIeUAPWVh4/ACAJ9LJxFBxIQfvFzQz6LTODT/pAVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773505223; c=relaxed/simple;
	bh=GxKGt4TpuCWaqIj5kx9pzVhWUWUVVAdlcAGDT9BLTeQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zf04nHfYAKWBIwBj/Pwq6IJwYK77ib7QciWuBX5iAhSApB3ASC4o7p+k9JqlVN3FHYCFpo2VQ1TeyBMApChmVtlBL0EEJmDH8zAsKSrkJ2aRkN/LI6RtqKly61K+4P192LJh+G2v6KjFjgMrDHAkVQb55GVegLIF7ItIum828vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djBJyWzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24149C116C6;
	Sat, 14 Mar 2026 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773505223;
	bh=GxKGt4TpuCWaqIj5kx9pzVhWUWUVVAdlcAGDT9BLTeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=djBJyWzvHMGGdDPUftzRqoiKOCGubZKROy/JeMIbqAozsFnPsqjWtOXPnz7DD+rE2
	 dTMD2tEAH1Ayz0Eh3D3E+dDV9qFCtMkohPPdPnVamaCY1oHAa0wOqUSC2Hi8eyABB6
	 KPu3lxbrzqnnyFvsylgaxtYOGyHSFKwArkhZaiXB0nfSJe/yCHLPu1WT6/acl4ArwT
	 ViCfFDHiNTvaSVJFR/ZgKwMNo8k8FqC1rmPETJrw/r8ubJ+SxHDzBro4Vz7E28vp0/
	 pH4bUFVuhgWpiNs2/KqijCZ0dNDQd6tmR3yHa1mQBK3MYZ3XL/nEfbEoRWE1wvD7IK
	 xqCEafuRuRZ8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF1C3808200;
	Sat, 14 Mar 2026 16:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/11] netfilter: ctnetlink: fix use-after-free in
 ctnetlink_dump_exp_ct()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177350521729.1725156.4722325556061962112.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 16:20:17 +0000
References: <20260313150614.21177-2-fw@strlen.de>
In-Reply-To: <20260313150614.21177-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 pablo@netfilter.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-11203-lists,netfilter-devel=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5518B28DDC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Florian Westphal <fw@strlen.de>:

On Fri, 13 Mar 2026 16:06:04 +0100 you wrote:
> From: Hyunwoo Kim <imv4bel@gmail.com>
> 
> ctnetlink_dump_exp_ct() stores a conntrack pointer in cb->data for the
> netlink dump callback ctnetlink_exp_ct_dump_table(), but drops the
> conntrack reference immediately after netlink_dump_start().  When the
> dump spans multiple rounds, the second recvmsg() triggers the dump
> callback which dereferences the now-freed conntrack via nfct_help(ct),
> leading to a use-after-free on ct->ext.
> 
> [...]

Here is the summary with links:
  - [net,01/11] netfilter: ctnetlink: fix use-after-free in ctnetlink_dump_exp_ct()
    https://git.kernel.org/netdev/net/c/5cb81eeda909
  - [net,02/11] netfilter: conntrack: add missing netlink policy validations
    https://git.kernel.org/netdev/net/c/f900e1d77ee0
  - [net,03/11] netfilter: nf_conntrack_sip: fix Content-Length u32 truncation in sip_help_tcp()
    https://git.kernel.org/netdev/net/c/fbce58e719a1
  - [net,04/11] netfilter: revert nft_set_rbtree: validate open interval overlap
    https://git.kernel.org/netdev/net/c/598adea720b9
  - [net,05/11] netfilter: nf_flow_table_ip: reset mac header before vlan push
    https://git.kernel.org/netdev/net/c/a3aca98aec9a
  - [net,06/11] netfilter: nf_conntrack_h323: fix OOB read in decode_int() CONS case
    https://git.kernel.org/netdev/net/c/1e3a3593162c
  - [net,07/11] nf_tables: nft_dynset: fix possible stateful expression memleak in error path
    https://git.kernel.org/netdev/net/c/0548a13b5a14
  - [net,08/11] netfilter: nft_ct: drop pending enqueued packets on removal
    https://git.kernel.org/netdev/net/c/36eae0956f65
  - [net,09/11] netfilter: xt_CT: drop pending enqueued packets on template removal
    https://git.kernel.org/netdev/net/c/f62a218a946b
  - [net,10/11] netfilter: xt_time: use unsigned int for monthday bit shift
    https://git.kernel.org/netdev/net/c/00050ec08cec
  - [net,11/11] netfilter: nf_conntrack_h323: check for zero length in DecodeQ931()
    https://git.kernel.org/netdev/net/c/f173d0f4c0f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



