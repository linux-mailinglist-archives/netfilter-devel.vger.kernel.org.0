Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F9A4F95F3
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Apr 2022 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiDHMmn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 8 Apr 2022 08:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiDHMmm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:42:42 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16972182D86
        for <netfilter-devel@vger.kernel.org>; Fri,  8 Apr 2022 05:40:38 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ncnum-0002BY-Hg; Fri, 08 Apr 2022 14:40:36 +0200
Date:   Fri, 8 Apr 2022 14:40:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Martin Gignac <martin.gignac@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: py: extend meta time coverage
Message-ID: <20220408124036.GA7920@breakpoint.cc>
References: <20220408083332.19976-1-pablo@netfilter.org>
 <CANf9dFOApCzgHjHdfdByykzV38Q+gJ7wVJznWRQ+-5keqqvQ1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANf9dFOApCzgHjHdfdByykzV38Q+gJ7wVJznWRQ+-5keqqvQ1g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Martin Gignac <martin.gignac@gmail.com> wrote:
> By the way, I have just noticed that while this gives an error on 1.0.2:
> 
>     add rule inet filter input iif lo time < "2022-07-01 11:00" accept
> 
> This does not:
> 
>     add rule inet filter input iif lo meta time < "2022-07-01 11:00" accept
> 
> The use of 'meta' in front of 'time' works around the bug.
> 
> Should the tests include a few statements *without* 'meta'?

Yes, please consider sending a patch to extend the tests.
