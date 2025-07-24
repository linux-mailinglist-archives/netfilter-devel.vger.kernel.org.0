Return-Path: <netfilter-devel+bounces-8016-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB80DB0FEA6
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Jul 2025 04:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7757D1C24953
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Jul 2025 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5603A19B5A7;
	Thu, 24 Jul 2025 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAbCZRdH"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD313D521;
	Thu, 24 Jul 2025 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322988; cv=none; b=XS4VPazQQn4o/f5vletwAX5SrjiiY9tFsG63L8QhuzJQssH38MoU5jw1kRFxx45ZcfCSoC1ZQAZjA46nfOZPX7ErN672KEkr0j/JnhPCOa5/WmkGVhbH7Oxj98w7StzMGLIamIYvpfizdaCISF68XLZs8W1T+A0rlg1OJuZ6AlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322988; c=relaxed/simple;
	bh=IY0X8qF9frVmQ0mysB6HXRZVHRrwqh0aGs9rdhilhjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hbP6eL9u9iIsapz1PEYaFy9kmG1PuMIeUx7IN80RRMsIsGiKdb9tAni+RNn79/u5qv5MMEqzD1hNT7lPRZb0zMJwCciEgl0sUV0om9h+kmHoCi7tfQg+SLZLZliQuUDVzBOzaPvJYw40xLdLlH7u58WnhDorRSPP6eDp7zU0nEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAbCZRdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42EAC4CEE7;
	Thu, 24 Jul 2025 02:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753322987;
	bh=IY0X8qF9frVmQ0mysB6HXRZVHRrwqh0aGs9rdhilhjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fAbCZRdHpuC+Uw2SxMKx44+sBHaq0UyB36fSazojmGTDij9MGZghXJUsqv8zv+hHt
	 1gInTbb0mtFRM1dEUCnFWWhPnn6Rzbk7jGMul4XvWfBuKTciqFsnjYAr/hpFJmdlAt
	 v1xo4Ol4EWdDFz6RaUyk+BcZbrJ1RrtFovs+/PM5U26MPMubfxZ2gsOsLI8KaHzOSX
	 gAfUbpb7CBHC2jpVvrYZsI5rmcMM9H6jrusNvv5GhcUHUIAMn0gScDRrTfuDmxQH+B
	 DtBGQjyS3pXOMNqseh4UO76DUzztyLrpO+RSZSXYjbdVdla2ZcZ1eMcO7K9hdAIVNm
	 wfq2qBDjE+96w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACA2383BF4E;
	Thu, 24 Jul 2025 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] bpf: Disable migration in nf_hook_run_bpf().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175332300576.1847444.11963207848328088857.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 02:10:05 +0000
References: <20250722224041.112292-1-kuniyu@google.com>
In-Reply-To: <20250722224041.112292-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, dxu@dxuuu.xyz,
 pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, kuni1840@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 22 Jul 2025 22:40:37 +0000 you wrote:
> syzbot reported that the netfilter bpf prog can be called without
> migration disabled in xmit path.
> 
> Then the assertion in __bpf_prog_run() fails, triggering the splat
> below. [0]
> 
> Let's use bpf_prog_run_pin_on_cpu() in nf_hook_run_bpf().
> 
> [...]

Here is the summary with links:
  - [v2,bpf] bpf: Disable migration in nf_hook_run_bpf().
    https://git.kernel.org/bpf/bpf-next/c/17ce3e5949bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



