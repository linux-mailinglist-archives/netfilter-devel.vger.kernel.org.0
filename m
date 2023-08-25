Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D89787EC2
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Aug 2023 05:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbjHYDwb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Aug 2023 23:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbjHYDwK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:52:10 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F671BEB
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Aug 2023 20:52:08 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qZNrj-0003Wc-0C; Fri, 25 Aug 2023 05:52:07 +0200
Date:   Fri, 25 Aug 2023 05:52:06 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Xiao Liang <shaw.leon@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_exthdr: Fix non-linear header
 modification
Message-ID: <20230825035206.GB9265@breakpoint.cc>
References: <20230825021432.6053-1-shaw.leon@gmail.com>
 <20230825031110.GA9265@breakpoint.cc>
 <CABAhCOTbKPmzg_5L7EkS+eivNNH=9hjG=q_aCGewB+H4QQgg=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABAhCOTbKPmzg_5L7EkS+eivNNH=9hjG=q_aCGewB+H4QQgg=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Xiao Liang <shaw.leon@gmail.com> wrote:
> > But I would prefer to not mix functional and non-functional changes.
> > Also, the use of the nft_tcp_header_pointer() helper is the reason why
> > this doesn't result in memory corruption.
> 
> I think this makes it explicit that
>     "we are modifying the original packet"
> rather than
>     "we are modifying the packet because above skb_ensure_writable() is enough"

OK, I won't argue here.

> > Just use the above in nft_exthdr_tcp_set_eval and place it before the loop?
> 
> In this case, all TCP headers will be pulled even if they don't have
> the target option.

Keep it simple.
