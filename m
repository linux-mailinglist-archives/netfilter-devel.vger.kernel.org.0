Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1494A6FFC1D
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 May 2023 23:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbjEKVxG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 May 2023 17:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKVxF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 May 2023 17:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB90199E;
        Thu, 11 May 2023 14:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4594651E8;
        Thu, 11 May 2023 21:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28008C433D2;
        Thu, 11 May 2023 21:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683841983;
        bh=m0CtsbnNx09ecuLL1xr+f1RjBmeBMa49zsqKS4utvzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVejKHyvqUtDKs1ucX312cQy/b6ZjKUrBaQExTlQlO8tfyiKWl4P1X8caOs5WqeFH
         SHUnL2q9yG3gSRmqYuOn2TxK0ZNZRjnQGZ/dydy155+uGpBIhDafuVMYrF24vSed+S
         QD8Cd/wp4y3we5sESE8t7eoO+m7NDfuWr3wkq51mjs0anNY2VulC/5SQJLKTsafdnR
         fauuas3JYDjQ2h8SMF7KswR6aAyQomI4dGwGWqaMpw6VKpR0XgaZBn/R1ViLNkIVrS
         3wkxbIxrC+O4kQrQH7LZdYlY2fnAIbtmWj9QL/bWxQBjPLjBYv1VdBDtMM04dxOTBo
         SOB/b/oYwk4Sg==
Date:   Thu, 11 May 2023 17:53:02 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH netfilter -stable,4.14 0/6] stable fixes for 4.14
Message-ID: <ZF1jvgyRpOjwhIJv@sashalap>
References: <20230511154143.52469-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230511154143.52469-1-pablo@netfilter.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 11, 2023 at 05:41:37PM +0200, Pablo Neira Ayuso wrote:
>Hi Greg, Sasha,
>
>This is a backport of c1592a89942e ("netfilter: nf_tables: deactivate anonymous
>set from preparation phase") which fixes CVE-2023-32233. This patch requires
>dependency fixes which are not currently in the 4.14 branch.

Queued up, thanks!

-- 
Thanks,
Sasha
