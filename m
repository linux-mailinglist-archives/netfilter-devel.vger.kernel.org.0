Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF27E6265
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Nov 2023 03:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjKICue (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 8 Nov 2023 21:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjKICud (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:50:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7521BFF
        for <netfilter-devel@vger.kernel.org>; Wed,  8 Nov 2023 18:50:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F9BEC433CB;
        Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699498231;
        bh=VAnSgq2vHO6r9GYdHRDXUWM7fSo8b2tlS7BMYakyjOA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T/UouuWPy0q7EJrEfUQ9Sm4r4PensBcRonos19dwtzB8nuIOvArIf3/BeTgG8cPef
         6peKg/k/AMPg3Am4bDHkf58q/c/irzJll5hSRq/BX+9iGm24Wpl79smbMu1lqweBgK
         vksqEZV84gVoWO6NeRpAPmT4jpXqyMj6PG+fYq8sMqYS3wqYm8j6WO11dZzv1FwTMi
         Sq/VBIMvT4kwPIvLJRLTc8aw2670hzSzMqvrCpjFUXdJLsazOJYAzoWPYFhZuSnfnz
         EPokmjgsUiOUti78aNAjA2DcRmi5g2hapsVgm1wUBAgs1HXYh/ezJPEDEIgXQWoPLm
         77mdcXZVSLISw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08080E00084;
        Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/5] netfilter: add missing module descriptions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169949823102.3016.9749220544999389931.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Nov 2023 02:50:31 +0000
References: <20231108155802.84617-2-pablo@netfilter.org>
In-Reply-To: <20231108155802.84617-2-pablo@netfilter.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, fw@strlen.de, kadlec@netfilter.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Wed,  8 Nov 2023 16:57:58 +0100 you wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> W=1 builds warn on missing MODULE_DESCRIPTION, add them.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> [...]

Here is the summary with links:
  - [net,1/5] netfilter: add missing module descriptions
    https://git.kernel.org/netdev/net/c/94090b23f3f7
  - [net,2/5] netfilter: nf_tables: remove catchall element in GC sync path
    https://git.kernel.org/netdev/net/c/93995bf4af2c
  - [net,3/5] ipvs: add missing module descriptions
    https://git.kernel.org/netdev/net/c/17cd01e4d1e3
  - [net,4/5] netfilter: xt_recent: fix (increase) ipv6 literal buffer length
    https://git.kernel.org/netdev/net/c/7b308feb4fd2
  - [net,5/5] netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses
    https://git.kernel.org/netdev/net/c/80abbe8a8263

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


