Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5601B7F2D5C
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Nov 2023 13:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjKUMiG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Nov 2023 07:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjKUMiF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:38:05 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F55112A
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Nov 2023 04:38:01 -0800 (PST)
Received: from [78.30.43.141] (port=55946 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r5Q0q-007har-Ka; Tue, 21 Nov 2023 13:37:58 +0100
Date:   Tue, 21 Nov 2023 13:37:55 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v2 0/5] add infrastructure for unit tests
Message-ID: <ZVykozlfXpddm7V2@calendula>
References: <20231105150955.349966-1-thaller@redhat.com>
 <792015e09808892af632b8297195dd6bc449b1ae.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <792015e09808892af632b8297195dd6bc449b1ae.camel@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:34:54PM +0100, Thomas Haller wrote:
> Hi Pablo,
> 
> any concerns about this? Could it be merged?

Sorry. JSON support is not working, I had to locally revert those
patches to run tests on -stable 5.4 here.

Let's agree on some basic rule from now on: One series at a time only,
anything else coming after will be marked as deferred in patchwork.

Thanks.
