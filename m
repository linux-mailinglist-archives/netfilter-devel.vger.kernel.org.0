Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CEF7A81EC
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Sep 2023 14:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjITMvG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 Sep 2023 08:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjITMvG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:51:06 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5755783;
        Wed, 20 Sep 2023 05:51:00 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qiwfQ-0006kz-Rn; Wed, 20 Sep 2023 14:50:56 +0200
Date:   Wed, 20 Sep 2023 14:50:56 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>, netfilter@vger.kernel.org,
        netfilter-devel@vger.kernel.org, sam@gentoo.org
Subject: Re: [ANNOUNCE] ipset 7.18 released
Message-ID: <20230920125056.GA25778@breakpoint.cc>
References: <55c2bf9d-ec58-8db-e457-8a36ebbbc4c0@blackhole.kfki.hu>
 <382279q3-6on5-32rq-po59-6r18os6934n9@vanv.qr>
 <0r045rnn-70s8-34pq-o5o3-nr3q48n9sq68@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0r045rnn-70s8-34pq-o5o3-nr3q48n9sq68@vanv.qr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jan Engelhardt <jengelh@inai.de> wrote:

You might want to CC author of that change.

> On Wednesday 2023-09-20 13:20, Jan Engelhardt wrote:
> >On Tuesday 2023-09-19 20:26, Jozsef Kadlecsik wrote:
> >>
> >>I'm happy to announce ipset 7.18, which brings a few fixes, backports, 
> >>tests suite fixes and json output support.
> >
> >The installation of the pkgconfig file is now broken.
> >
> >>  - lib/Makefile.am: fix pkgconfig dir (Sam James)
> >
> >Aaaaagh.. that change completely broke installation and must be reverted.
> 
> commit 326932be0c4f47756f9809cad5a103ac310f700d
> Author: Sam James <sam@gentoo.org>
> Date:   Sat Jan 28 19:23:54 2023 +0100
> 
>     lib/Makefile.am: fix pkgconfig dir
> 
>     Signed-off-by: Sam James <sam@gentoo.org>
>     Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
> 
> Can I just take a moment to vent about this some more.
> The change is, in the words of another Linux developer, utter garbage.
> ${libdir} contains ${prefix} and did so for eternities.
> 
> The commit message is utter garbage too, because it does not
> even try to make an argument to even _have_ the change in the
> first place. Allowing such an underdocumented change is a
> failure in the review process itself.
