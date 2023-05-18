Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39BA707950
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 May 2023 06:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjEREuZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 May 2023 00:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjEREuZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 May 2023 00:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6720E2120
        for <netfilter-devel@vger.kernel.org>; Wed, 17 May 2023 21:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0419E64C67
        for <netfilter-devel@vger.kernel.org>; Thu, 18 May 2023 04:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53236C433D2;
        Thu, 18 May 2023 04:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684385423;
        bh=D/Oaem/VVS63r2Tw/fU9ZK5jSJDotUZfhZiA5ZUmFVY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NYQBnHf6PR8zR6VEnJEnfS9AMF4HE0eLuOWzo/Am/NSmcExWzHnpj/hCNTQmh/P56
         IN8gh59RUR871rytDoKzSjuUMz67XeyrEg8t0Eg2ke1b07UQeVnrN+FaTFHRBPWMP4
         6DJAWPSq7FLz2RGk7DhTJ1dJPBcAaw64JOAOVPe75ti191bEsO6oyPALPw0vxOP2FQ
         P/W0pnEoHz19947KgcKE0bDaFJprYrPmicaKftNkNtHweEYJZI92jrZmgyJjeH6ucS
         IYCjYD3p0s7yv072lUhKhqB0Eq15a6C49+gLbza1WYmN8mOgiiWBcuERWgipWKg3Oy
         r6bJj4wCuSfIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F277C32795;
        Thu, 18 May 2023 04:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] netfilter: conntrack: define variables
 exp_nat_nla_policy and any_addr with CONFIG_NF_NAT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168438542318.13974.5481728025451850960.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 04:50:23 +0000
References: <20230517123756.7353-2-fw@strlen.de>
In-Reply-To: <20230517123756.7353-2-fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org,
        netfilter-devel@vger.kernel.org, trix@redhat.com,
        simon.horman@corigine.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Florian Westphal <fw@strlen.de>:

On Wed, 17 May 2023 14:37:54 +0200 you wrote:
> From: Tom Rix <trix@redhat.com>
> 
> gcc with W=1 and ! CONFIG_NF_NAT
> net/netfilter/nf_conntrack_netlink.c:3463:32: error:
>   ‘exp_nat_nla_policy’ defined but not used [-Werror=unused-const-variable=]
>  3463 | static const struct nla_policy exp_nat_nla_policy[CTA_EXPECT_NAT_MAX+1] = {
>       |                                ^~~~~~~~~~~~~~~~~~
> net/netfilter/nf_conntrack_netlink.c:2979:33: error:
>   ‘any_addr’ defined but not used [-Werror=unused-const-variable=]
>  2979 | static const union nf_inet_addr any_addr;
>       |                                 ^~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net,1/3] netfilter: conntrack: define variables exp_nat_nla_policy and any_addr with CONFIG_NF_NAT
    https://git.kernel.org/netdev/net/c/224a876e3754
  - [net,2/3] netfilter: nf_tables: fix nft_trans type confusion
    https://git.kernel.org/netdev/net/c/e3c361b8acd6
  - [net,3/3] netfilter: nft_set_rbtree: fix null deref on element insertion
    https://git.kernel.org/netdev/net/c/61ae320a29b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


