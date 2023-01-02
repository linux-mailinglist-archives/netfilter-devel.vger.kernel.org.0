Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551D565B33C
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Jan 2023 15:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjABONX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Jan 2023 09:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjABONW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:13:22 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 915466586
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Jan 2023 06:13:21 -0800 (PST)
Date:   Mon, 2 Jan 2023 15:13:18 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/2] ipset patches for nf
Message-ID: <Y7LmfgCItoF49tSY@salvia>
References: <20221230122438.1618153-1-kadlec@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221230122438.1618153-1-kadlec@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Dec 30, 2022 at 01:24:36PM +0100, Jozsef Kadlecsik wrote:
> Hi Pablo,
> 
> Please pull the next patches into your nf tree.
> 
> - The first patch fixes a hang when 0/0 subnets is added to a
>   hash:net,port,net type of set. Except hash:net,port,net and
>   hash:net,iface, the set types don't support 0/0 and the auxiliary
>   functions rely on this fact. So 0/0 needs a special handling in
>   hash:net,port,net which was missing (hash:net,iface was not affected
>   by this bug).
> - When adding/deleting large number of elements in one step in ipset,
>   it can take a reasonable amount of time and can result in soft lockup
>   errors. This patch is a complete rework of the previous version in order
>   to use a smaller internal batch limit and at the same time removing
>   the external hard limit to add arbitrary number of elements in one step.

Series applied to nf.git

I added a Fixes: tag to the first patch and removed a duplicated
Signed-off-by: line in the second.

Just a minor nitpick, nothing important.

Thanks for your fixes.
