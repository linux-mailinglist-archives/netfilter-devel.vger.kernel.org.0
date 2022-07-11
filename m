Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89975705BF
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 Jul 2022 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiGKOgy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 11 Jul 2022 10:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKOgx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:36:53 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5583565D7C
        for <netfilter-devel@vger.kernel.org>; Mon, 11 Jul 2022 07:36:53 -0700 (PDT)
Date:   Mon, 11 Jul 2022 16:36:50 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Vlad Buslov <vladbu@nvidia.com>
Cc:     netfilter-devel@vger.kernel.org, kadlec@netfilter.org,
        fw@strlen.de, ozsh@nvidia.com, paulb@nvidia.com
Subject: Re: [PATCH net-next v4 0/2] Conntrack offload debuggability
 improvements
Message-ID: <Ysw1grKWm/OUO0qx@salvia>
References: <20220615104355.391249-1-vladbu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220615104355.391249-1-vladbu@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 15, 2022 at 12:43:53PM +0200, Vlad Buslov wrote:
> Current conntrack offload implementation doesn't provide much visibility
> and control over offload code. There is no way to determine current load
> on workqueues that process the offload tasks which makes it hard to
> debug the cases where offload is significantly delayed due to rate of
> new connections being higher than driver or hardware offload rate.
> 
> Improve the debuggability by introducing procfs for current total of
> workqueue tasks for nf_ft_offload_add, nf_ft_offload_del and
> nf_ft_offload_stats queues. This allows visibility for flow offload
> delay due to system scheduling offload tasks faster than driver/hardware
> can process them.

Series applied, thanks
