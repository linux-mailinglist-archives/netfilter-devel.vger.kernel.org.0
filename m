Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A046C4D0B5C
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Mar 2022 23:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbiCGWrh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Mar 2022 17:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbiCGWrg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:47:36 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3835E6BDF3
        for <netfilter-devel@vger.kernel.org>; Mon,  7 Mar 2022 14:46:40 -0800 (PST)
Received: from netfilter.org (unknown [87.190.248.243])
        by mail.netfilter.org (Postfix) with ESMTPSA id 30826601DB;
        Mon,  7 Mar 2022 23:44:49 +0100 (CET)
Date:   Mon, 7 Mar 2022 23:46:35 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Vlad Buslov <vladbu@nvidia.com>
Cc:     netfilter-devel@vger.kernel.org, kadlec@netfilter.org,
        fw@strlen.de, ozsh@nvidia.com, paulb@nvidia.com
Subject: Re: [PATCH net-next 4/8] netfilter: introduce total count of hw
 offload 'add' workqueue tasks
Message-ID: <YiaLS9rBYKiRmi3B@salvia>
References: <20220222151003.2136934-1-vladbu@nvidia.com>
 <20220222151003.2136934-5-vladbu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220222151003.2136934-5-vladbu@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Feb 22, 2022 at 05:09:59PM +0200, Vlad Buslov wrote:
> To improve hardware offload debuggability and allow capping total amount of
> offload 'add' in-flight entries on workqueue in following patch extend
> struct netns_nftables with 'count_wq_add' counter and expose it to
> userspace as 'nf_flowtable_count_wq_add' sysctl entry. Increment the
> counter when allocating new workqueue task and decrement it after
> flow_offload_work_add() is finished.

No objections to expose stats as described in patches 4/8, 6/8 and 7/8.
