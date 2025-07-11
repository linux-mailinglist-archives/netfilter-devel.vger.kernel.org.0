Return-Path: <netfilter-devel+bounces-7860-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE9AB010EC
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Jul 2025 03:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D101C2854A
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Jul 2025 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A41B129A78;
	Fri, 11 Jul 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVcQ8Meb"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5001F5FDA7;
	Fri, 11 Jul 2025 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198593; cv=none; b=l1cbinfr7KX0VSPA/ZxaAL4gdm73M8lgWfJzYTCS+cmZo1C3HdLNBZeF/6D4mmpQBCwkcXauABPgfM8667hjBJ3XaClhufMUFN53PsdicMopThztCyBfgFDu9TTfw55oyl0QQU8FTIh/flyGwTLFFMLSHGvbxzNkZlptNq81rgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198593; c=relaxed/simple;
	bh=IXDhRTiNakjakhk5CZw60/pFwpNkh6VyN2vIdOg1/WY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tQ28AkWltM7gZ06jk3Ni9ZZYpOb+tW1UHh41NrVwuL+32heksmNG44yWnaH0E3bDrGqqI4atzuyAKK83v+R3f7r7t3FAV+UsXU4Hzh/YUANOmt3IM3LkmY2cTkU0ehjjXNGuksTdENpzg6SDjnwcR5x1jYevjUy+9bDY01JEwqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVcQ8Meb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D252FC4CEF4;
	Fri, 11 Jul 2025 01:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198592;
	bh=IXDhRTiNakjakhk5CZw60/pFwpNkh6VyN2vIdOg1/WY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZVcQ8MebsU2m+THSQXmGoE4LSmNri3WOLEZSd/OzeOFgTedFMujibYieZ13m941BN
	 UhFvjOfYqP2dVOMtBE3Z2IRv+wACIyC6yi/dF8V7oCOqfaRoPb0d948Xx+ilKUqb7O
	 KqUd0UKp/LsPCuuUMSiD+1i/zRKe/Z5j39kq3aiSBT4QkYPMnVNTY2S2zjc56bfWtS
	 nG3y17v4XkFqzMBj0LCbJewohwaMiXUnKzaHGWRjodmNYsAA/TsP5ctiYoPD4guJci
	 gCQcJqyGbDBlnsh6XBwokx4w/FE+F/pReTg+RrlffpX1B4jlkq9QdBaO0ICaxs2kNl
	 gfoLreB58yj2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BAC383B266;
	Fri, 11 Jul 2025 01:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: Netfilter updates for net-next (v2)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219861506.1732536.666957776852823992.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 01:50:15 +0000
References: <20250710010706.2861281-1-pablo@netfilter.org>
In-Reply-To: <20250710010706.2861281-1-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de, horms@kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Thu, 10 Jul 2025 03:07:02 +0200 you wrote:
> v2: missing Signed-off-by: tags in patch 2/4 and 3/4.
> 
> -o-
> 
> Hi,
> 
> The following series contains an initial small batch of Netfilter
> updates for net-next:
> 
> [...]

Here is the summary with links:
  - Netfilter updates for net-next (v2)
    (no matching commit)
  - [net-next,2/4] netfilter: nf_tables: Drop dead code from fill_*_info routines
    https://git.kernel.org/netdev/net-next/c/8080357a8c6c
  - [net-next,3/4] netfilter: nf_tables: Reintroduce shortened deletion notifications
    https://git.kernel.org/netdev/net-next/c/a1050dd07168
  - [net-next,4/4] netfilter: nf_tables: adjust lockdep assertions handling
    https://git.kernel.org/netdev/net-next/c/8df1b40de769

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



