Return-Path: <netfilter-devel+bounces-13667-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nBsPHEqRS2qiVgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13667-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 13:28:10 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A7F70FD6A
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 13:28:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W8tOvrpS;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13667-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13667-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E06830F38A4
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jul 2026 10:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8223F65EA;
	Mon,  6 Jul 2026 10:50:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51613F39E8;
	Mon,  6 Jul 2026 10:50:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335043; cv=none; b=ijkJC5Wsvzq93AK2G8SWX9thg8ZwRpVewOQ8/ynDIynQCAhjxZ+PKT30mxtka7Qvv2auSQrij4QC49AeonvviYwmsQq9n3zZOcYvNaTrTcvYssVZTmnQ9gv1mVICPXtcB4fVJX/oTtglUt2doBbqmoXWMrXVs4TxgCE9CRDEAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335043; c=relaxed/simple;
	bh=yctoVFD91OFx4fFlRA1MPazNYejGlaXFotK29gkw3PE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JJLZ4WLeEpfQOBUIQjx+PhyZYn/heMQj1l5DPvu5DmDn/CGoP7j3olM74l9DcIfu0+6JCjs3xGpg45prqoNGp1BrYAAoBqOTmmxhurKUV/D3oQmCLfiMHhCrPsmd11VZP8cLWoA5z/cHeP4RdXn5jhR0Xj7EXPMnFajx0O7D5GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8tOvrpS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817EE1F000E9;
	Mon,  6 Jul 2026 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783335041;
	bh=yHJBd2n2Sa1J667oouse/pt4NTBKScB7z7klNN5CAW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W8tOvrpS0wE/XmOlbNX/4iDM9O9oBpzhAYZB9E4myqREVCZvlpm2ENicf4Umj1wgm
	 J+z78r96kEnsPoRAsugoIt0xPxGMxkje/OzsxYuTFeloZVOPjl6d4sGzE80X7ahbmC
	 9pQSe9gKu7dVDsuw7NolP6hD7mybDC+C6e8NImZHR30zndQ3Jv7RHJnbvThLjYsyLe
	 iFa/30wzdk4eqdYVWdX+vZbFnsjtNYNedX5FS4WnyioozbL4Jhs7SF6di65iWEG08/
	 dS7zZQVtGTbGDyqsx9bEOqnimCZiX8eKSM/SDGY0UXsRet013wt3w0TXdzg0gvGb3H
	 EiPO7dmRYfBaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B3C3ABD2A5;
	Mon,  6 Jul 2026 10:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipvs: fix PMTU for GUE/GRE tunnel ICMP errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333502188.500093.18161993584904393152.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 10:50:21 +0000
References: <20260702073430.67680-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260702073430.67680-1-zhaoyz24@mails.tsinghua.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13667-lists,netfilter-devel=lfdr.de,netdevbpf];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0A7F70FD6A

Hello:

This patch was applied to netdev/net.git (main)
by Florian Westphal <fw@strlen.de>:

On Thu,  2 Jul 2026 15:34:28 +0800 you wrote:
> When an ICMP Fragmentation Needed error is received for a tunneled IPVS
> connection, ip_vs_in_icmp() recomputes the MTU that the original packet
> can use by subtracting the tunnel overhead from the reported next-hop
> MTU.
> 
> The current code always subtracts sizeof(struct iphdr), which is only
> the IPIP overhead. For GUE and GRE tunnels, ipvs_udp_decap() and
> ipvs_gre_decap() already compute the additional tunnel header length,
> but that value is scoped to the decapsulation block and is lost before
> the ICMP_FRAG_NEEDED handling. As a result, the ICMP error sent back to
> the client advertises an MTU that is too large, so PMTUD can fail to
> converge for GUE/GRE-tunneled real servers.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipvs: fix PMTU for GUE/GRE tunnel ICMP errors
    https://git.kernel.org/netdev/net/c/6b335af0d0d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



