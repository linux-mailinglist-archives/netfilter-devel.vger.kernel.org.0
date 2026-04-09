Return-Path: <netfilter-devel+bounces-11750-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBqUG8AK12nNKggAu9opvQ
	(envelope-from <netfilter-devel+bounces-11750-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 04:11:12 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A753C574A
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 04:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C64833013A9A
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Apr 2026 02:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C368367F26;
	Thu,  9 Apr 2026 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeFDhaJw"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A15366DB4;
	Thu,  9 Apr 2026 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775700651; cv=none; b=ZIkSKqzZqD8kJTcU3mWxfLnt83mWhrQkpHqWUyVHRIQcNNknZ/AQYw2qHFLXpwqxi/prYtWxFh3YSPBg+bZayzCHnPTZQ+LMNCSC8MTn4kHMGudHlGi1huCTG/UHj4oCEEuouRkoZgS9NVXgO5PfYavbZQwcyy/m8TR+n+fXVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775700651; c=relaxed/simple;
	bh=EaPrOgTxWoqU8C9XFfG15r7fDJrbShuNy2iejK1eBak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M68oRthZQzfDNl1bidedOL/mnMqVo9Y9b/ik0Utd+rkE4u/87cwjLuqgIA2oz9B78/7rMvXlLV7pKSNkFaalFM9Hmj7FnMkhR2wbJVGYEJVHcqRwyfmk1OisMF6OTetCuUyYb78fUqu5lFJl6P1Mxws5LuvTplHLXS2CaisY32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeFDhaJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033C4C19421;
	Thu,  9 Apr 2026 02:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775700651;
	bh=EaPrOgTxWoqU8C9XFfG15r7fDJrbShuNy2iejK1eBak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UeFDhaJwyBd6348KsvU8MxlCnDrGJoi6Onsd2rRbrO1I7b8xMVGCPTLS1/bhILQQb
	 yA2B5KFq5rgqSb4HxtzInplUu2bvblGhcu9QgJOgiDCaO6itZb/HFcqebmVif8Lfgr
	 uaIfYpmGJUBZGm3h5GZJ+WmtFlMdcN+2NPj8P/KMxrGuqa+1QkkA2bMcjMkHFdzxHl
	 ayxXis7HPFY8bAdom+IEXbiH/ppNaAnxOH+l1y3MISNDnPlSpMGtn3fmDq4ruq/t/T
	 Ol9JU7Mh3mzMEkLOM48k+2sQlcFJsN96LOcJjZK/JFMoBLjYFWd/i8Va802A21wvLD
	 x9tQaHNtO29jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD133930793;
	Thu,  9 Apr 2026 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL v2 net-next] netfilter: updates for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570062729.956260.4386026678361572614.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:10:27 +0000
References: <20260408060419.25258-1-fw@strlen.de>
In-Reply-To: <20260408060419.25258-1-fw@strlen.de>
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
	TAGGED_FROM(0.00)[bounces-11750-lists,netfilter-devel=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8A753C574A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 08:04:19 +0200 you wrote:
> No changes since v1, I only dropped the last patch (13/13).  This is also
> why I am not resending the individual patches again.
> 
> The following PR contains Netfilter updates for *net-next*:
> 
> 1) Fix ancient sparse warnings in nf conntrack nat modules, from
>    Sun Jian.
> 2) Fix typo in enum description, from Jelle van der Waa.
> 3) remove redundant refetch of netns pointer in nf_conntrack_sip.
> 4) add a deprecation warning for dccp match.
>    We can extend the deadline later if needed, but plan atm is to
>    remove the feature.
> 5) remove nf_conntrack_h323 debug code that can read out-of-bounds
>    with malformed messages. This code was commented out, but better
>    remove this.
> 6+7) add more netlink policy validations in netfilter.
>    This could theoretically cause issues when a client sends e.g.
>    unsupported feature flags that were previously ignored, so we
>    may have to relax some changes. For now, try to be stricter and
>    reject upfront.
> 8+9) minor code cleanup in nft_set_pipapo (an nftables set backend).
> 10) Add nftables matching support fro double-tagged vlan and pppoe
>     frames, from Pablo Neira Ayuso.
> 11) Fix up indentation of debug messages in nf_conntrack_h323 conntrack
>     helper, from David Laight.
> 12) Add a helper to iterate to next flow action and bail out if the
>     maximum number of actions is reached, also from Pablo.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL,v2,net-next] netfilter: updates for net-next
    https://git.kernel.org/netdev/net-next/c/1795654f0005

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



