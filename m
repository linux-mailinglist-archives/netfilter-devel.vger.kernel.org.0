Return-Path: <netfilter-devel+bounces-13218-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h+EDLTeRKmo+sgMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13218-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 12:43:03 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2009B670F2E
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 12:43:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="N/FVvvEV";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13218-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13218-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89A1032E2EC3
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD03D47AF;
	Thu, 11 Jun 2026 10:40:22 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A183A1E80;
	Thu, 11 Jun 2026 10:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174422; cv=none; b=kg/tR45phXklgbRXjMiAwc9bcFjNYarB7WdJBC6nkynz8aDmJBuvjzI9hgRJ8bJycDCWe++3FQbEoeCQSSupwguFQl80ua8OepfhLNnD0YqLGFW4FARAMzWj2kNCevoIR80UgcCD6DVt/5co1lPR6c2OWEgk85QUDP6x6EagfOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174422; c=relaxed/simple;
	bh=5tep4ZCqo8mD5ez7lhAPy8giA4HfEiACCxRP/SrgmdA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U62HNwFKYfwW7bRxguoAWikVsJ8dNV8Q77q81coFK9b54YPmnr7HdHw78A8HwehnFuXvkb4ewnjKxiEd6BvocqHzEdM5itepevEIO+wuZz2eG5gT39IYI3PGrfKMwd50y9tUMVI0Www4NUI7e6VHDLXeUTBwDPiVckbI35BpEZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/FVvvEV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E406F1F00893;
	Thu, 11 Jun 2026 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781174420;
	bh=sRyf/IRwECv7OLEXcVD6dn1iTbfDnqZtBreJDXUm4jA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N/FVvvEVIR4DWWnCmKEJ5Y0WQmR/nn8ENGu+qPpst1lpgVPbJSbhouk6ntcb/ndY1
	 EigJZSiAvFcvPfhB7mWYae83WiTYV8GE3eyNGI//pXtHUkEhQdeC3os6KHEiesxB1U
	 08HHzsQJbOiqnuID5tB+pl5S6SjBHQKhdCyDjXJlKZ/+wBgPQiNUMYFUArEYbO5OeR
	 t6f42XCccs8up0YioI7XEF/sDzQ/1ubovXKWJ3rrxgUTx9otHfXp0eLvYZPG0VPC/H
	 Ew9OK0bYElaixvuOMYqNgv+KvQSfHBPFoQB3GeCfGJAOtV0MlVaqi5x+ICNDqLrmMY
	 i995ArVQ8TDYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939263930E4A;
	Thu, 11 Jun 2026 10:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netfilter: nf_log: validate MAC header was set
 before
 dumping it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178117441822.3886909.10696734490273557626.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 10:40:18 +0000
References: <20260609225502.54239-1-xmei5@asu.edu>
In-Reply-To: <20260609225502.54239-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, fw@strlen.de,
 phil@nwl.cc, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, coreteam@netfilter.org, netdev@vger.kernel.org,
 bestswngs@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13218-lists,netfilter-devel=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2009B670F2E

Hello:

This patch was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Tue,  9 Jun 2026 15:55:02 -0700 you wrote:
> The fallback path of dump_mac_header() guards the MAC header access
> only with "skb->mac_header != skb->network_header", without checking
> skb_mac_header_was_set(). When the MAC header is unset, mac_header is
> 0xffff, so the test passes and skb_mac_header(skb) returns
> skb->head + 0xffff, ~64 KiB past the buffer; the loop then reads
> dev->hard_header_len bytes out of bounds into the kernel log.
> 
> [...]

Here is the summary with links:
  - [net,v2] netfilter: nf_log: validate MAC header was set before dumping it
    https://git.kernel.org/netdev/net/c/a84b6fedbc97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



