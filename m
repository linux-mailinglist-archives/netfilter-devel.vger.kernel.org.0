Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CFB64A160
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Dec 2022 14:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiLLNjs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Dec 2022 08:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiLLNj0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:39:26 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6F3D14D25
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Dec 2022 05:38:22 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:38:19 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 0/3] fix map update with concatenation and timeouts
Message-ID: <Y5cuyyDLt6SD0QXk@salvia>
References: <20221212100436.84116-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221212100436.84116-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Dec 12, 2022 at 11:04:33AM +0100, Florian Westphal wrote:
> When "update" is used with a map, nft will ignore a given timeout.
> Futhermore, listing is broken, only the first data expression
> gets decoded:
> 
> in:
>  meta l4proto tcp update @pinned { ip saddr . ct original proto-src : ip daddr . ct original proto-dst timeout 90s }
> out:
>  meta l4proto tcp update @pinned { ip saddr . ct original proto-src : ip daddr }
> 
> Missing timeout is input bug (never passed to kernel), mussing
> "proto-dst" is output bug.
> 
> Also add a test case.

Series LGTM, thanks.

I might follow up to restrict the timeout to the key side unless you
would like to look into this.
