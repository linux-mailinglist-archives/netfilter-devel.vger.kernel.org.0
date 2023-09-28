Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D97B259A
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Sep 2023 21:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjI1TAr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Sep 2023 15:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjI1TAr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:00:47 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BF21A1
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Sep 2023 12:00:45 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qlwFg-0007B7-8O; Thu, 28 Sep 2023 21:00:44 +0200
Date:   Thu, 28 Sep 2023 21:00:44 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf PATCH v2 1/8] netfilter: nf_tables: Don't allocate
 nft_rule_dump_ctx
Message-ID: <20230928190044.GF19098@breakpoint.cc>
References: <20230928165244.7168-1-phil@nwl.cc>
 <20230928165244.7168-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928165244.7168-2-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Eliminate the direct use of netlink_callback::args when dumping rules by
> casting nft_rule_dump_ctx over netlink_callback::ctx as suggested in
> the struct's comment.
> 
> The value for 's_idx' has to be stored inside nft_rule_dump_ctx now and
> make it hold the 'reset' boolean as well.
> 
> Note how this patch removes the zeroing of netlink_callback::args[1-5] -
> none of the rule dump callbacks seem to make use of them.

Do you think we can fix the reset race in -next instead of -nf?

If yes, you could detach preparation patches like this one and
split the series in several batches.
