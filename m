Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D977A88E6
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Sep 2023 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjITPuU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 Sep 2023 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjITPuT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:50:19 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A454EAF
        for <netfilter-devel@vger.kernel.org>; Wed, 20 Sep 2023 08:50:12 -0700 (PDT)
Received: from [78.30.34.192] (port=35976 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qizSq-004ViM-PZ; Wed, 20 Sep 2023 17:50:10 +0200
Date:   Wed, 20 Sep 2023 17:50:07 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>, fw@strlen.de
Subject: Re: [PATCH nft 3/3] tests/shell: run `nft --check` on persisted dump
 files
Message-ID: <ZQsUr2WyabtFCt9C@calendula>
References: <20230918195933.318893-1-thaller@redhat.com>
 <20230918195933.318893-3-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918195933.318893-3-thaller@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 18, 2023 at 09:59:24PM +0200, Thomas Haller wrote:
> "nft --check" will trigger a rollback in kernel. The existing dump files
> might hit new code paths. Take the opportunity to call the command on
> the existing files.
> 
> And alternative would be to write a separate tests, that iterates over
> all files. However, then we can only run all the commands sequentially
> (unless we do something smart). That might be slower than the
> opportunity to run the checks in parallel. More importantly, it would be
> nice if the check for the dump file is clearly tied to the file's test.
> So run it right after the test, from the test wrapper.

I am already using this patch in my tests.

Applied, thanks.
