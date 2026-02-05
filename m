Return-Path: <netfilter-devel+bounces-10684-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KAoC6HLhGk45QMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10684-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 17:56:01 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D51F58C2
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 17:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5151D30490D6
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADCA43637F;
	Thu,  5 Feb 2026 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoAA+4iI"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B06355030;
	Thu,  5 Feb 2026 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310209; cv=none; b=UKNkHjI18Ar0Dc9R6rP0oLp/VZAECcQAtuHhjNeL5DcRcW4kOpH1f3OmRGOFSVIqat+arKcOcHTedM3AEiQw7ZV0F15YaQS443tVxKLjjRA8HvEIZ4p+tzrNIweqP+Ltw/CtVT80lJHGM/jly4dC52fMJDdJKg7/+wflBsfzATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310209; c=relaxed/simple;
	bh=+lqJkPRlZVrNbFLDywMJUxiG2RrzMjYqH0TlN3zmDHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YtKh1iU4sLJxbuqB1WXcXtylYbP4ewNMVqRUVb+yIzBidXCO8Fhum+ypMZ3RASs8w4hjHdp6atVu7UgpwGm4HOiRcCHK3Eg26ddEsPxFgiVRA8mhmQGgyFeG3P1Qh/8QuuqN63clBAU/gdniRMJLJ4TiuUomcTnodLa2mu9uo28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoAA+4iI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B8EC4CEF7;
	Thu,  5 Feb 2026 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770310208;
	bh=+lqJkPRlZVrNbFLDywMJUxiG2RrzMjYqH0TlN3zmDHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YoAA+4iIeEDMstoKQVsLQwwdo3c5ef9EAxj1i6TL2tLEWSlwsbvMhhhfz4VYkZT4B
	 dSS+e1EeXMOsD19zQig67MQAbvKPVluk1Ab+quU6lZJ2NlZpUI42X3tFL2JJOWddYs
	 rPbyo3UClPJbiY69Cg7zFiZU0PwX9MtI3QoITK9or9p8nTVvKzsUN97Opz0Oo7E49j
	 aoX8OvCadFKLA9E2g6pKVJFVleSPm15Kvg4fdzEw3ZTjiRjFkbKm58xqEXPR7WG+iB
	 /Y1DZoZJj2wEsKCP3HEMcSFHVvh4figxpdouYxd+dHiDULbjPK/3u2TvVwdLyv5qaA
	 qoRBdOhmUBjTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 853253808200;
	Thu,  5 Feb 2026 16:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] netfilter: nf_tables: fix inverted genmask check
 in
 nft_map_catchall_activate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177031020633.485120.17507212737106778136.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 16:50:06 +0000
References: <20260205074450.3187-2-fw@strlen.de>
In-Reply-To: <20260205074450.3187-2-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netfilter-devel@vger.kernel.org,
 pablo@netfilter.org
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10684-lists,netfilter-devel=lfdr.de,netdevbpf];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nist.gov:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: 74D51F58C2
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Florian Westphal <fw@strlen.de>:

On Thu,  5 Feb 2026 08:44:50 +0100 you wrote:
> From: Andrew Fasano <andrew.fasano@nist.gov>
> 
> nft_map_catchall_activate() has an inverted element activity check
> compared to its non-catchall counterpart nft_mapelem_activate() and
> compared to what is logically required.
> 
> nft_map_catchall_activate() is called from the abort path to re-activate
> catchall map elements that were deactivated during a failed transaction.
> It should skip elements that are already active (they don't need
> re-activation) and process elements that are inactive (they need to be
> restored). Instead, the current code does the opposite: it skips inactive
> elements and processes active ones.
> 
> [...]

Here is the summary with links:
  - [net,1/1] netfilter: nf_tables: fix inverted genmask check in nft_map_catchall_activate()
    https://git.kernel.org/netdev/net/c/f41c5d151078

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



