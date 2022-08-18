Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65295988F8
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Aug 2022 18:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbiHRQef (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Aug 2022 12:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbiHRQef (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:34:35 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD60E79622
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Aug 2022 09:34:33 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oOiTX-0001GG-TR; Thu, 18 Aug 2022 18:34:31 +0200
Date:   Thu, 18 Aug 2022 18:34:31 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Xiao Liang <shaw.leon@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft] src: Don't parse string as verdict in map
Message-ID: <20220818163431.GA32331@breakpoint.cc>
References: <20220818100623.22601-1-shaw.leon@gmail.com>
 <20220818133231.GB24008@breakpoint.cc>
 <CABAhCOR-YpTt6YNhOvnf3dtVEDjx52SfRb-R_YvzntEp=yHb-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABAhCOR-YpTt6YNhOvnf3dtVEDjx52SfRb-R_YvzntEp=yHb-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Xiao Liang <shaw.leon@gmail.com> wrote:
> On Thu, Aug 18, 2022 at 9:32 PM Florian Westphal <fw@strlen.de> wrote:
> >
> > Can you explain what this is fixing?
> 
> See this example:
> table t {
>     map foo {
>         type ipv4_addr : verdict
>         elements = {
>             192.168.0.1 : bar
>         }
>     }
>     chain output {
>         type filter hook output priority mangle;
>         ip daddr vmap @foo
>     }
> }
> 
> Though "bar" is not a valid verdict (should be "jump bar" or
> something), the string is taken as the element value. Then
> NFTA_DATA_VALUE is sent to the kernel instead of NFTA_DATA_VERDICT.
> Recent kernel checks the type and returns error, but olders (e.g.
> v5.4.x) doesn't, causing a warning when the rule is hit:
> 
> [5120263.467627] WARNING: CPU: 12 PID: 303303 at
> net/netfilter/nf_tables_core.c:229 nft_do_chain+0x394/0x500
> [nf_tables]

Thanks.  All of this info should be included in the commit message.

Perhaps adding a test case is warrented as well.
