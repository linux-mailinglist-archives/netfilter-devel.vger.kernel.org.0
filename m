Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710A06F5275
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 May 2023 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjECIAZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 May 2023 04:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjECIAY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 May 2023 04:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD93C3E
        for <netfilter-devel@vger.kernel.org>; Wed,  3 May 2023 01:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F06B462709
        for <netfilter-devel@vger.kernel.org>; Wed,  3 May 2023 08:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CF91C433A4;
        Wed,  3 May 2023 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683100821;
        bh=hs/2ZMPXNyQHVQBAjvuBziSuly5LxIFID8MWydHsfGQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XI31lsKOk5daDIkD32JiljILIqbHR2Up9/f0ZN7z4jAEHINFJWdcjD9fKrZCyS5/T
         gUcKceBjC4wlenJ27bY7tI78JN4p87dwbRCPRRRs3tPYRCzQdT5f8J986YyrWpMizm
         pDN4OQm/5XdWMcbLFKIkW2j+oZDuyRplRR4EXMnFFTiNCm37vAu1euTPJCXvka7W3N
         l1fsMVMwUw6AKsXy6Pp6Frg/sWm2aIuoLfaBPqJLeEebeZsg/0gFdkeGdUvXU9DjBV
         sCYWfc4POEteQ27Go5iFKVzgPxe8o/o5ueNBkdUJrkGZ/dJuhH67UQ+chxNGE0h4pH
         6kGSQbVFGV2WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 434C2E5FFC9;
        Wed,  3 May 2023 08:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] netfilter: nf_tables: hit ENOENT on unexisting
 chain/flowtable update with missing attributes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168310082126.9142.6120600309430037427.git-patchwork-notify@kernel.org>
Date:   Wed, 03 May 2023 08:00:21 +0000
References: <20230503063250.13700-2-pablo@netfilter.org>
In-Reply-To: <20230503063250.13700-2-pablo@netfilter.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Wed,  3 May 2023 08:32:48 +0200 you wrote:
> If user does not specify hook number and priority, then assume this is
> a chain/flowtable update. Therefore, report ENOENT which provides a
> better hint than EINVAL. Set on extended netlink error report to refer
> to the chain name.
> 
> Fixes: 5b6743fb2c2a ("netfilter: nf_tables: skip flowtable hooknum and priority on device updates")
> Fixes: 5efe72698a97 ("netfilter: nf_tables: support for adding new devices to an existing netdev chain")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> [...]

Here is the summary with links:
  - [net,1/3] netfilter: nf_tables: hit ENOENT on unexisting chain/flowtable update with missing attributes
    https://git.kernel.org/netdev/net/c/8509f62b0b07
  - [net,2/3] selftests: netfilter: fix libmnl pkg-config usage
    https://git.kernel.org/netdev/net/c/de4773f0235a
  - [net,3/3] netfilter: nf_tables: deactivate anonymous set from preparation phase
    https://git.kernel.org/netdev/net/c/c1592a89942e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


