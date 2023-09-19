Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9D67A659F
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 Sep 2023 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjISNoy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 19 Sep 2023 09:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjISNol (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:44:41 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDFDE45
        for <netfilter-devel@vger.kernel.org>; Tue, 19 Sep 2023 06:42:58 -0700 (PDT)
Received: from [78.30.34.192] (port=42378 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qib08-00Fxhp-T8; Tue, 19 Sep 2023 15:42:54 +0200
Date:   Tue, 19 Sep 2023 15:42:52 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 2/2] libnftables: move init-once guard inside
 xt_init()
Message-ID: <ZQmlXJA0qjRgGBAp@calendula>
References: <20230919123621.2770734-1-thaller@redhat.com>
 <20230919123621.2770734-2-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919123621.2770734-2-thaller@redhat.com>
X-Spam-Score: -1.7 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:36:17PM +0200, Thomas Haller wrote:
> A library should not restrict being used by multiple threads or make
> assumptions about how it's being used. Hence a "init_once" pattern
> without no locking is racy, a code smell and should be avoided.
> 
> Note that libxtables is full of global variables and when linking against
> it, libnftables cannot be used from multiple threads either. That is not
> easy to fix.
> 
> Move the ugliness of "init_once" away from nft_ctx_new(), so that the
> problem is concentrated closer to libxtables.

Also applied, thanks
