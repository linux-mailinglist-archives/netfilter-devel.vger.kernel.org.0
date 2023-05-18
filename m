Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6366E708A08
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 May 2023 23:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjERVEy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 May 2023 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjERVEx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 May 2023 17:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0368136
        for <netfilter-devel@vger.kernel.org>; Thu, 18 May 2023 14:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BEE06155F
        for <netfilter-devel@vger.kernel.org>; Thu, 18 May 2023 21:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91402C433EF;
        Thu, 18 May 2023 21:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684443891;
        bh=WO1/uXc1qhLL3pth/REVtKNVS77zKXLjrxpiV+QO2eI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZXv6DNRu4yO34k4t0F53YYl8jm7CeWBYYR88nKMhOBMc3BdxCrd5frnfuyjljAzAv
         AlT53Yn+GFRl555U2FfsQ7HmdJEPqivZ90jDQ+SDimP9mtBOq3307saZEloqOc4lS4
         /MnxN/tJ/NlJB0+FNqcv/Cb8m7Q9wRGOkSu/3KoWmOw21mn2Y08R/TprHobyk61o28
         wp34jW5PLhh+ui96ZVQib3ZMMrsf+1h58tANIYOwJP7FugRj8sbyPH5a6cWzn1iC34
         zsvlJpllBXLpRNY0TCcq6k/lycXCohAAcl3DgpQUDgDXLqnSQfC/LPNRfzMWEs3tyg
         VFy9TMt1rnf/Q==
Date:   Thu, 18 May 2023 14:04:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        Jeremy Sowden <jeremy@azazel.net>
Subject: Re: [PATCH net-next 3/9] netfilter: nft_exthdr: add boolean DCCP
 option matching
Message-ID: <20230518140450.07248e4c@kernel.org>
In-Reply-To: <20230518100759.84858-4-fw@strlen.de>
References: <20230518100759.84858-1-fw@strlen.de>
        <20230518100759.84858-4-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, 18 May 2023 12:07:53 +0200 Florian Westphal wrote:
> From: Jeremy Sowden <jeremy@azazel.net>
> 
> The xt_dccp iptables module supports the matching of DCCP packets based
> on the presence or absence of DCCP options.  Extend nft_exthdr to add
> this functionality to nftables.

Someone is actually using DCCP ? :o
