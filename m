Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821287E027B
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Nov 2023 13:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjKCMFU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Nov 2023 08:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjKCMFT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:05:19 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E3CD61
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 05:05:12 -0700 (PDT)
Received: from [78.30.35.151] (port=39508 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qysvB-00EkUX-N7; Fri, 03 Nov 2023 13:05:10 +0100
Date:   Fri, 3 Nov 2023 13:05:04 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Sam James <sam@gentoo.org>
Cc:     thaller@redhat.com, fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2 4/7] build: no recursive make for
 "files/**/Makefile.am"
Message-ID: <ZUTh8DdiOnah18PB@calendula>
References: <174b4dbc0df7fec4d0fdbe2c9cb96d4fca5ecd5b.camel@redhat.com>
 <87cywrrrse.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cywrrrse.fsf@gentoo.org>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 03, 2023 at 11:37:16AM +0000, Sam James wrote:
> Keep in mind for the concerns wrt large Makefiles, you can do 'include'
> with automake too which keeps things flat in terms of what automake
> generates and what make ultimately runs.

That would be good to restore if it helps restore modularity to some extend.

A few notes:

- Python support also depends on one option.
- There is nftables/tests/build/run-tests.sh to test for all configurare
  options, I am not sure if Thomas run this test.
