Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63617A7A72
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Sep 2023 13:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjITLaO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 Sep 2023 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjITLaN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:30:13 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CEEA9;
        Wed, 20 Sep 2023 04:30:07 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 1B3505939DCA9; Wed, 20 Sep 2023 13:30:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 155D660BDEC6D;
        Wed, 20 Sep 2023 13:30:06 +0200 (CEST)
Date:   Wed, 20 Sep 2023 13:30:06 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
cc:     netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [ANNOUNCE] ipset 7.18 released
In-Reply-To: <382279q3-6on5-32rq-po59-6r18os6934n9@vanv.qr>
Message-ID: <0r045rnn-70s8-34pq-o5o3-nr3q48n9sq68@vanv.qr>
References: <55c2bf9d-ec58-8db-e457-8a36ebbbc4c0@blackhole.kfki.hu> <382279q3-6on5-32rq-po59-6r18os6934n9@vanv.qr>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Wednesday 2023-09-20 13:20, Jan Engelhardt wrote:
>On Tuesday 2023-09-19 20:26, Jozsef Kadlecsik wrote:
>>
>>I'm happy to announce ipset 7.18, which brings a few fixes, backports, 
>>tests suite fixes and json output support.
>
>The installation of the pkgconfig file is now broken.
>
>>  - lib/Makefile.am: fix pkgconfig dir (Sam James)
>
>Aaaaagh.. that change completely broke installation and must be reverted.

commit 326932be0c4f47756f9809cad5a103ac310f700d
Author: Sam James <sam@gentoo.org>
Date:   Sat Jan 28 19:23:54 2023 +0100

    lib/Makefile.am: fix pkgconfig dir

    Signed-off-by: Sam James <sam@gentoo.org>
    Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>

Can I just take a moment to vent about this some more.
The change is, in the words of another Linux developer, utter garbage.
${libdir} contains ${prefix} and did so for eternities.

The commit message is utter garbage too, because it does not
even try to make an argument to even _have_ the change in the
first place. Allowing such an underdocumented change is a
failure in the review process itself.
