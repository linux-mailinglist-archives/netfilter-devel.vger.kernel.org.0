Return-Path: <netfilter-devel+bounces-13784-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aeL0EWdwT2rwggIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13784-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 11:56:55 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 962E972F32B
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 11:56:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Czt/6Vo+";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13784-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13784-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B4BB304DEB4
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1136440243B;
	Thu,  9 Jul 2026 09:50:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1883FBB69;
	Thu,  9 Jul 2026 09:50:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590654; cv=none; b=UvcEwgjsA5Mc18CumPnKPP39KSgVujylrfyNbhAfsIbTHPxY+Kw4wJ90+SUdAuFwVrJRrh1f6aY5CyL4lyg6pwf4j3StK/ljcEuPIhv/OyZykERLYhoALK435Ad8OgS6VnLZhyo26X9TVb5uekYlHeeTM/yAvpBqEYDcKl637sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590654; c=relaxed/simple;
	bh=muvquHUNF18hxMTX8gmYRYIf1eQSvehLDezpGhHBvBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pSFrBnzFVXncTHxXlp7bPPkcKHN+GlBJTcVo2kgn/4vVIKX9ebqe34WHSs6ri8wBcgK/BUHYIhzPXxgiYBxwLdu4Ricao23dSw5afL4IUazTI/c9MNalOLKqqbXH4+x99reHYoOGIevAtiN2TqsgZhn0orFBJzCQ1fqaAv8RevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czt/6Vo+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B043F1F000E9;
	Thu,  9 Jul 2026 09:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783590652;
	bh=OYI04CWeUX0RrY0bbXHHMJDfAnVT6RP1adWSYVMh5jY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Czt/6Vo+iT30JUB+Jk8UDTkjC0CaqXgublJJCoepgFiUzUgHSmJsRusYEnOjiQwaC
	 8tan+H8djVoHbG1kW1MqFD+M/9VnVNEhwFwH4O/Smwd5kFwzJZfXy/1QjrvVVPsi7a
	 Lo+noxDZIUT+9YoXaqll+c8/Xw2gD4FW9pfJIeQXynhzf3JF9iCYneqQAAjWAk/mNn
	 xGOEbEuRWdOk4obaCZpGFtam86Q4iao3lTCJchVhPLvsYOiAM2sWlKgUMEoPsiJZ/V
	 zynVUbhrpmx/xGEXKeWZSJPjtmxUuSOSIl025Rel7oOfzj8vaj1GtHvYpoUw5LCSdp
	 57MiB5NbiZq1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9394C393A57D;
	Thu,  9 Jul 2026 09:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/17] netfilter: nf_conntrack_reasm: guard mac_header
 adjustment after IPv6 defrag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178359063113.3372474.9367073912354621322.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 09:50:31 +0000
References: <20260708140309.19633-2-fw@strlen.de>
In-Reply-To: <20260708140309.19633-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 pablo@netfilter.org
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13784-lists,netfilter-devel=lfdr.de,netdevbpf];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,strlen.de:email,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 962E972F32B

Hello:

This series was applied to netdev/net.git (main)
by Florian Westphal <fw@strlen.de>:

On Wed,  8 Jul 2026 16:02:53 +0200 you wrote:
> From: Xiang Mei <xmei5@asu.edu>
> 
> nf_ct_frag6_reasm() slides the packet head forward to drop the IPv6
> fragment header and then unconditionally advances skb->mac_header:
> 
> 	skb->mac_header += sizeof(struct frag_hdr);
> 
> [...]

Here is the summary with links:
  - [net,01/17] netfilter: nf_conntrack_reasm: guard mac_header adjustment after IPv6 defrag
    https://git.kernel.org/netdev/net/c/3b08fed5b7e0
  - [net,02/17] netfilter: ebtables: terminate table name before find_table_lock()
    https://git.kernel.org/netdev/net/c/a622d2e9608c
  - [net,03/17] netfilter: ebtables: zero chainstack array
    https://git.kernel.org/netdev/net/c/cbfe53599eeb
  - [net,04/17] netfilter: ebtables: module names must be null-terminated
    https://git.kernel.org/netdev/net/c/084d23f81832
  - [net,05/17] netfilter: nft_lookup: fix catchall element handling with inverted lookups
    https://git.kernel.org/netdev/net/c/e6107a4c74b5
  - [net,06/17] netfilter: ipset: mark the rcu locked areas properly
    https://git.kernel.org/netdev/net/c/5d0c22e73656
  - [net,07/17] netfilter: ipset: exclude gc when resize is in progress
    https://git.kernel.org/netdev/net/c/cffcf57bf03c
  - [net,08/17] netfilter: ipset: cleanup the add/del backlog when resize failed
    https://git.kernel.org/netdev/net/c/672321302ed6
  - [net,09/17] netfilter: ipset: allocate the proper memory for the generic hash structure
    https://git.kernel.org/netdev/net/c/724f32699aea
  - [net,10/17] netfilter: flowtable: use dst in this direction when pushing IPIP header
    https://git.kernel.org/netdev/net/c/c328b90c17fc
  - [net,11/17] netfilter: flowtable: IPIP tunnel hardware offload is not yet support
    https://git.kernel.org/netdev/net/c/6c5dcab95f4c
  - [net,12/17] netfilter: flowtable: support IPIP tunnel with direct xmit
    https://git.kernel.org/netdev/net/c/fa7395c02d95
  - [net,13/17] netfilter: handle unreadable frags
    https://git.kernel.org/netdev/net/c/da5b58478a9c
  - [net,14/17] ipvs: pass parsed transport offset to state handlers
    https://git.kernel.org/netdev/net/c/bae7ce7bafb5
  - [net,15/17] ipvs: use parsed transport offset in TCP state lookup
    https://git.kernel.org/netdev/net/c/2500fa3958b1
  - [net,16/17] ipvs: use parsed transport offset in SCTP state lookup
    https://git.kernel.org/netdev/net/c/2f75c0faa336
  - [net,17/17] ipvs: ensure inner headers in ICMP errors are in headroom
    https://git.kernel.org/netdev/net/c/3f7a535ff0fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



