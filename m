Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B71F4CB2F7
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Mar 2022 00:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiCBXsY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Mar 2022 18:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiCBXsV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:48:21 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF4DC80918
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Mar 2022 15:47:23 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 9ED7462FE6;
        Thu,  3 Mar 2022 00:28:04 +0100 (CET)
Date:   Thu, 3 Mar 2022 00:29:33 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Toshiaki Makita <toshiaki.makita1@gmail.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Paul Blakey <paulb@nvidia.com>
Subject: Re: [PATCH nf-next v2 0/3] Conntrack GRE offload
Message-ID: <Yh/93TOu7at8428k@salvia>
References: <20220225015309.2576980-1-toshiaki.makita1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220225015309.2576980-1-toshiaki.makita1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 25, 2022 at 10:53:06AM +0900, Toshiaki Makita wrote:
> Conntrack offload currently only supports TCP and UDP.
> Thus TC/nftables/OVS cannot offload GRE packets.

Series applied to nf-next, thanks

If you prefer to route this through different tree, just let me know.
