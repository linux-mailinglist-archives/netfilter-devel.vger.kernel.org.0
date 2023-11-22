Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5BF7F4C47
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Nov 2023 17:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjKVQV7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Nov 2023 11:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjKVQV6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:21:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4014D8;
        Wed, 22 Nov 2023 08:21:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653BCC433C8;
        Wed, 22 Nov 2023 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700670114;
        bh=mux1i+1ImksDhtSNwdq1V6BXwyQob627pgil6Ldz/GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ov35IpjROkuy/u9/MFPUtqf8fxYSmFlA2GIQS5FBInscd3lp2Dc1vzG7lBUlzXDoB
         kr2aPrV4Uo8bh4zBTIDuf0lv90+B8TRL40FoFJnUGepj9Uogq4pLTZg1pH+mbXBodB
         r4UO0WmnEyjLuap4YXJXBrCGyejXUDyL0leIzrgoFWg3PFT0OWtyRdlJbqlYM6FUq5
         0NX6/Y99tq1hDVOJ6ull9+zIQRrsxZuX/JjSfUEOZdE5zA29DRS0SrC0N6IbAL7emE
         CZ8LB07yxk61Kt7IQn8zT3vfTYNWmJmlbY5PfbNO358cVq5UHEsE4DaAIlZIf86GE8
         fmHDDsgCl0t3w==
Date:   Wed, 22 Nov 2023 11:21:51 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH -stable,5.4 23/26] netfilter: nftables: update table
 flags from the commit phase
Message-ID: <ZV4qn2RI8a8cg3bL@sashalap>
References: <20231121121333.294238-1-pablo@netfilter.org>
 <20231121121333.294238-24-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231121121333.294238-24-pablo@netfilter.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:13:30PM +0100, Pablo Neira Ayuso wrote:
>commit 0ce7cf4127f14078ca598ba9700d813178a59409 upstream.
>
>Do not update table flags from the preparation phase. Store the flags
>update into the transaction, then update the flags from the commit
>phase.

We don't seem to have this or the following commits in the 5.10 tree,
are they just not needed there?
-- 
Thanks,
Sasha
