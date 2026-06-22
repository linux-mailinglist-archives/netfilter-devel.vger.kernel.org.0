Return-Path: <netfilter-devel+bounces-13400-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id srpUN+nAOWocxAcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13400-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 01:10:33 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D96B2C98
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 01:10:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YvFK7JRp;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13400-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13400-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72E72302F9B0
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C847340408;
	Mon, 22 Jun 2026 23:10:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4BD29CB24;
	Mon, 22 Jun 2026 23:10:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169826; cv=none; b=RsQ2+WzX3OJhoU5tuwIYcwLTG3KVIoryjNPNwxdEBVxFudS8Dsk3l6PZ6XskQVR7K8/iJ1ld+sJTU3NCZ8ArTFigU3sHV08tYZm87kuAzVlLx4ED9729X9Mks2EBFI+JN1xokLzdam5du3GfxbWAPMj7GkOUjJpmxEmxsE1N4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169826; c=relaxed/simple;
	bh=STEl2Z4kxI31gKGBfK6tI5IIEAw0GWWLYzl89Bb6H/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZiV99OGY7sDACqV2df6vcRqZ52ml2POhfpkOASDHp/1CNmX9wYLgXC2/mpgARARaHuK4g48FX2WZ51vRAU2LsQ33RZbo+/KK19YicUzEJcIAescC1i8WtiYdfhlmrOL8Mqq7DvPCaHMR8n4FyZT6cMJUdbOSThmGkXy1HzMWqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvFK7JRp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D27D1F000E9;
	Mon, 22 Jun 2026 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782169824;
	bh=BS9saIHILXZPG3mQmL5nkidGhQkkaqt9SX8BVeZ56Hw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YvFK7JRpQN8Qgv5LGY1fk35fwyKlLYjlyML2+zEiUpUDhDFqzM2+qGLv4UWx8w6w4
	 ys8qHvyQkW0BIcgXZW5bcC8xAwraAeH2Hx/iomYHdaD2lZ1L6S1o5anEWZWrRcIKjj
	 GqHFHWYx8wM62CWVcS58nv+5sDR3Y+4cdCwMcsa7PfxU8Os5YM6kZAfDTJ3n71WdSw
	 eFnct4qA3MtMNLGcA+dj+150UIF+MQvlLFuzAZJAT24QoKU+TJ1W91d7+/p8KlpXxe
	 bvlzGSw54QFQm2OfqF+IEhHnMj8lx5BOAYXNCc9CR0cp3RDLSRz1V6KcinRCuYhu3c
	 OoiONX7C+peAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19917393098A;
	Mon, 22 Jun 2026 23:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Guard conntrack opts error writes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178216981480.1454866.14973638867733224422.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 23:10:14 +0000
References: <cover.1781765747.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <cover.1781765747.git.chenyy23@mails.tsinghua.edu.cn>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org,
 fw@strlen.de, phil@nwl.cc, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org,
 kartikey406@gmail.com, coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-13400-lists,netfilter-devel=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,etsalapatis.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_RECIPIENTS(0.00)[m:chenyy23@mails.tsinghua.edu.cn,m:bpf@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:kartikey406@gmail.com,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 746D96B2C98

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 18 Jun 2026 10:18:42 +0000 you wrote:
> The conntrack lookup/allocation kfuncs expose an opts/opts__sz pair.
> The verifier checks the caller-provided opts__sz range, but the wrappers
> currently write opts->error after internal errors even when opts__sz is too
> small to include that field.
> 
> Patch 1 writes opts->error only when opts__sz includes it, and uses a
> single helper to fold ERR_PTR returns into the kfunc ABI result while keeping
> the local nfct result variable in each wrapper.
> Patch 2 adds a bpf_nf regression check that keeps a guard in opts->error
> while passing opts__sz covering only netns_id.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Guard conntrack opts error writes
    https://git.kernel.org/bpf/bpf/c/6f6183a39533
  - [bpf-next,v2,2/2] selftests/bpf: Cover small conntrack opts error writes
    https://git.kernel.org/bpf/bpf/c/38ba6d43af38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



