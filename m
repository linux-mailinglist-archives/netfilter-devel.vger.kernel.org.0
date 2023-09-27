Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2842E7B0D0B
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Sep 2023 21:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjI0T7L (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Sep 2023 15:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjI0T7K (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:59:10 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D4110E
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Sep 2023 12:59:09 -0700 (PDT)
Received: from [78.30.34.192] (port=46706 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qlagc-00ETge-82; Wed, 27 Sep 2023 21:59:08 +0200
Date:   Wed, 27 Sep 2023 21:59:05 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 1/1] include: include <string.h> in <nft.h>
Message-ID: <ZRSJiZmMJOMnsgxG@calendula>
References: <20230927195133.3677265-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927195133.3677265-1-thaller@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:51:15PM +0200, Thomas Haller wrote:
> <string.h> provides strcmp(), as such it's very basic and used
> everywhere.
> 
> Include it via <nft.h>.
> 
> The benefit of this will be to add  a static-inline function
> nft_strcmp0() to <nft.h>, which calls strcmp() but handles that strings
> might be NULL. Such a basic utility will be useful, and <nft.h> is the
> right place. So we will need <string.h> there. Regardless of that, not
> including the same header basically everywhere, is already a benefit.

Applied, thanks
