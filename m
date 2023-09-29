Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06E47B2FCE
	for <lists+netfilter-devel@lfdr.de>; Fri, 29 Sep 2023 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjI2KQB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 29 Sep 2023 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjI2KP7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:15:59 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD8FC0
        for <netfilter-devel@vger.kernel.org>; Fri, 29 Sep 2023 03:15:58 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qmAXM-0007K4-FB; Fri, 29 Sep 2023 12:15:56 +0200
Date:   Fri, 29 Sep 2023 12:15:56 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nf PATCH v2 1/8] netfilter: nf_tables: Don't allocate
 nft_rule_dump_ctx
Message-ID: <ZRaj3Gc2gfCJFcQx@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20230928165244.7168-1-phil@nwl.cc>
 <20230928165244.7168-2-phil@nwl.cc>
 <ZRXKvYUATXz1cIDG@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRXKvYUATXz1cIDG@calendula>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 28, 2023 at 08:49:33PM +0200, Pablo Neira Ayuso wrote:
> On Thu, Sep 28, 2023 at 06:52:37PM +0200, Phil Sutter wrote:
> [...]
> 
> This whole chunk below looks like a cleanup to remove one indentation
> level? Please add an initial patch for this.

Actually, it changes nft_rule_dump_ctx from being allocated to being
cast over the general purpose part in netlink_callback. But I like your
suggestion, it will reduce this patch to the relevant bits.

Thanks, Phil
