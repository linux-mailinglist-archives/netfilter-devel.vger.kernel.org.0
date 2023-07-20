Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC275B86C
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 Jul 2023 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGTUA0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 Jul 2023 16:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjGTUA0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FA9270B
        for <netfilter-devel@vger.kernel.org>; Thu, 20 Jul 2023 13:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7165B61C43
        for <netfilter-devel@vger.kernel.org>; Thu, 20 Jul 2023 20:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6BB5C433C7;
        Thu, 20 Jul 2023 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689883222;
        bh=LvhYmR5MI0Y93Db3DTx92Hny9qHPOPc7zMb7XD4ncqo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mrDG7Iz8atbCjY3ffJGouw3Gjo1suybCmXoYZR+f19M4J8eqJVyAEiX4t0B8XwlrQ
         aVoDXdzvCoPIDveKhQDaXNpBnajEzPSS0ne9/Otv3qfDnfVJccghhNeMYHsThyHCT/
         DRugrIp7VFB6DOs5MOKV7fXfLMwEE83sYK4Of32/IaFFUCj4VK/HaJpokRD8w8jyDA
         BCDrui194lPVufWrKwfF7Tz9D+KHnc1M5u3cZ8DK8IFGZxX4NBjfaw5swil6A3x0bV
         QzVUHEzlxQXx1UirmK0pz31cMEBr5kM3+Psv+EtMlo/X02Sx/QVeJkIRBd6omHs6w3
         bqkxZsQvGL+UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB23BE21EFF;
        Thu, 20 Jul 2023 20:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/5] netfilter: nf_tables: fix spurious set element
 insertion failure
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168988322269.13634.17225693802889324247.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jul 2023 20:00:22 +0000
References: <20230720165143.30208-2-fw@strlen.de>
In-Reply-To: <20230720165143.30208-2-fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org,
        netfilter-devel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Florian Westphal <fw@strlen.de>:

On Thu, 20 Jul 2023 18:51:33 +0200 you wrote:
> On some platforms there is a padding hole in the nft_verdict
> structure, between the verdict code and the chain pointer.
> 
> On element insertion, if the new element clashes with an existing one and
> NLM_F_EXCL flag isn't set, we want to ignore the -EEXIST error as long as
> the data associated with duplicated element is the same as the existing
> one.  The data equality check uses memcmp.
> 
> [...]

Here is the summary with links:
  - [net,1/5] netfilter: nf_tables: fix spurious set element insertion failure
    https://git.kernel.org/netdev/net/c/ddbd8be68941
  - [net,2/5] netfilter: nf_tables: can't schedule in nft_chain_validate
    https://git.kernel.org/netdev/net/c/314c82841602
  - [net,3/5] netfilter: nft_set_pipapo: fix improper element removal
    https://git.kernel.org/netdev/net/c/87b5a5c20940
  - [net,4/5] netfilter: nf_tables: skip bound chain in netns release path
    https://git.kernel.org/netdev/net/c/751d460ccff3
  - [net,5/5] netfilter: nf_tables: skip bound chain on rule flush
    https://git.kernel.org/netdev/net/c/6eaf41e87a22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


