Return-Path: <netfilter-devel+bounces-13665-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DCUgO1yjS2obXgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13665-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 14:45:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5AA710B54
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 14:45:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Onzed0Ey;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13665-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13665-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 321E73499F81
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jul 2026 10:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0593DDDC3;
	Mon,  6 Jul 2026 10:50:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED93DC852;
	Mon,  6 Jul 2026 10:50:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335039; cv=none; b=Prn6p/T//RGlgsNcULoyUUh20y8lsdwGjcan+DOuaED461QzzjDow3yK2zeMrzV6LNItRZyQiERZvofzAmZj/9SD5pd/D/VhtG5Im6JOiD/mmd8PHZcMgqxlPJ/lcySngbw5J4Nb3SPr3QSdy9pMdMwHY5wkTwnD9sRtuNJZD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335039; c=relaxed/simple;
	bh=Z4ELmo9MEWlYiApwu5QIhUGqOzqG193QuEkEslfhYjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NGM4+ByrMlVhTeU8tWClwgagItpFjuKaVvAHJ6SX6jAqLUTJbqE9dX+RW3e5JyQbO7nIuY5OPOzGW8WjNE4yqtv3PRWXOpSM/rs+JiufTwZX5SxT2GBexkDtLjJrUO21NNph8pjRDg4ofTH7OYBDL/LVH2tospxACzGoUO/yeJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onzed0Ey; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0707F1F000E9;
	Mon,  6 Jul 2026 10:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783335037;
	bh=fGMnIZozpGLzsIivQPg0TjggSvulpvqr6PDXfZXNOzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Onzed0EynogY4zJYYVUfViJeUN19Hd8DJ8vAM6UE8XKkpetEhOqU6IpVV/TSBId/S
	 I9QjCNPdz8O0aHClC1XJ7Uu4ot4fG+CmKl/p3sxP0xzY1O6/YGE2/VflV/j1PjQLF0
	 +/qusJ7G93tjMn049UYbY5hzAGMAO71RLuaSp4eYogf//zKh3mGSzz+1gX8wa/Rul6
	 rG0B1F0vLhXpXhIedFu2sn54GZHKAcByS10kttafBzDcUghX9VQYjgj2RTrmtHzyGx
	 JvPBMBt8SdHq2DM0SwiMd3yzLbfztSp9TPxtFUpPSSagPKN2jhPjSKDx0BZjwVKTwX
	 KahNWrZgdxk0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A573ABD2A5;
	Mon,  6 Jul 2026 10:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipvs: reset full ip_vs_seq structs in ip_vs_conn_new
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333501739.500093.9836567879441424973.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 10:50:17 +0000
References: <20260702112837.81121-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260702112837.81121-1-zhaoyz24@mails.tsinghua.edu.cn>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, horms@verge.net.au, ja@ssi.bg,
 pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 yangyx22@mails.tsinghua.edu.cn, wangao@seu.edu.cn, fengxw06@126.com,
 qli01@tsinghua.edu.cn, xuke@tsinghua.edu.cn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13665-lists,netfilter-devel=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,verge.net.au,ssi.bg,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:horms@verge.net.au,m:ja@ssi.bg,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,out_seq.delta:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA5AA710B54

Hello:

This patch was applied to netdev/net.git (main)
by Florian Westphal <fw@strlen.de>:

On Thu,  2 Jul 2026 19:28:36 +0800 you wrote:
> Commit 9a05475cebdd ("ipvs: avoid kmem_cache_zalloc in
> ip_vs_conn_new") changed ip_vs_conn_new() to allocate an ip_vs_conn
> object with kmem_cache_alloc().  The function then initializes many
> fields explicitly, but only resets in_seq.delta and out_seq.delta in the
> two struct ip_vs_seq members.
> 
> That leaves init_seq and previous_delta uninitialized.  This is normally
> harmless while the corresponding IP_VS_CONN_F_IN_SEQ or
> IP_VS_CONN_F_OUT_SEQ flag is clear.  For connections learned from a sync
> message, however, ip_vs_proc_conn() preserves those flags from
> IP_VS_CONN_F_BACKUP_MASK and passes opt=NULL when the message omits
> IPVS_OPT_SEQ_DATA.  In that case the new connection can be hashed with
> SEQ flags set but with the rest of in_seq/out_seq still containing stale
> slab data.
> 
> [...]

Here is the summary with links:
  - [net] ipvs: reset full ip_vs_seq structs in ip_vs_conn_new
    https://git.kernel.org/netdev/net/c/2975324d164c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



