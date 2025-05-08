Return-Path: <netfilter-devel+bounces-7051-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A59AAF090
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 May 2025 03:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CA11C03E15
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 May 2025 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6118FDAB;
	Thu,  8 May 2025 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2CZdu7A"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E282AE74;
	Thu,  8 May 2025 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667192; cv=none; b=tK2MVwT4DaW409RLbaXwnanncxnyxKe1yTuGGlwJEX0tR2NYDAe8pu1mOhAeZV4+v+J7C0ooJppUjIuGH7xgskND3ouZhOgLfHyO0sqtNRtDYH1AIUeZLFyynmGfz1rVyh9TZCKbf3oRYqM9k9mLZNiCSvqnURFnqRSJGwlAFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667192; c=relaxed/simple;
	bh=5phFERlThGjwvfIMDVUnnMK5a04hmOS4ukWIOXXzDuo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ocnbztqVwPWNrWfq6GZWPDmBc+TxaZbF11tI5eLcrM0u9y7E5sjbkUsnAqJl1GLdsECjpbCFXIYvcnrsLW+ijKyOoCUsvNpzsqNfoa4Q+5XQZXbFs8/ZqIjUB6nf7/H6c/aiOkJCl2jqYn0a0Hu0MLbCqUqJ1I3JLOGWVkzoAQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2CZdu7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3CDC4CEE2;
	Thu,  8 May 2025 01:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746667191;
	bh=5phFERlThGjwvfIMDVUnnMK5a04hmOS4ukWIOXXzDuo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b2CZdu7AWS4Mthpx0i9CEyqCLbNz4ycaLlYR3Y8tKnn5++0SUjznHXU2wQNizwP2R
	 cA7f29ZvbnxgBTaOAjhA2t1Dwa5WF8ExzTwU855rRdFWYzo+e3I8cC2+DrK4rSRr7l
	 8pb5SfZ9Qq+KkevWKFL3dI9p9QQdDR4Ty2KzI0+xeR7uyikRj0wP7ffKrH83qw4UOj
	 gSWe0ZTGFZB3rrSPEHB1YYoBV1tlyx34L1a6qn1eVj74qh0+zV5jzeyiMn74HDQj86
	 BVNvU4TqdVzbRMmpBeOFjnoTiwDV/NEw0U5vI9kaBaIhEJUI65F4IW7paifmaSOpWb
	 dDdbMFm6pzUhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8E380AA70;
	Thu,  8 May 2025 01:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] ipvs: fix uninit-value for saddr in do_output_route4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174666722975.2414619.17650170908657682743.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 01:20:29 +0000
References: <20250507221952.86505-2-pablo@netfilter.org>
In-Reply-To: <20250507221952.86505-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Thu,  8 May 2025 00:19:51 +0200 you wrote:
> From: Julian Anastasov <ja@ssi.bg>
> 
> syzbot reports for uninit-value for the saddr argument [1].
> commit 4754957f04f5 ("ipvs: do not use random local source address for
> tunnels") already implies that the input value of saddr
> should be ignored but the code is still reading it which can prevent
> to connect the route. Fix it by changing the argument to ret_saddr.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ipvs: fix uninit-value for saddr in do_output_route4
    https://git.kernel.org/netdev/net/c/e34090d7214e
  - [net,2/2] netfilter: ipset: fix region locking in hash types
    https://git.kernel.org/netdev/net/c/8478a729c046

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



