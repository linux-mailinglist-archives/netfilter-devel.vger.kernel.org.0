Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64437B30E3
	for <lists+netfilter-devel@lfdr.de>; Fri, 29 Sep 2023 12:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjI2Kyq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 29 Sep 2023 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjI2Kyp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:54:45 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493C911F
        for <netfilter-devel@vger.kernel.org>; Fri, 29 Sep 2023 03:54:43 -0700 (PDT)
Received: from [78.30.34.192] (port=37528 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qmB8n-008o4l-KZ; Fri, 29 Sep 2023 12:54:39 +0200
Date:   Fri, 29 Sep 2023 12:54:37 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft,v3] tests: shell: fix spurious errors in
 sets/0036add_set_element_expiration_0
Message-ID: <ZRas7X4kXRHPvp4n@calendula>
References: <20230927163937.757167-1-pablo@netfilter.org>
 <ZRWUpn963dk3Eaey@orbyte.nwl.cc>
 <ZRXRQO44pxHRa53x@calendula>
 <ZRadurgX7F84B4Vb@orbyte.nwl.cc>
 <ZRaenVh3EYWv1nKD@calendula>
 <ZRao1z4V20Lc2U0Y@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRao1z4V20Lc2U0Y@orbyte.nwl.cc>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:37:11PM +0200, Phil Sutter wrote:
> No need, I was merely nit-picking. If the test is stable now, it's
> entirely sufficient.

Thanks, agreed.
