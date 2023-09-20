Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97BA7A895C
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Sep 2023 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjITQWy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 Sep 2023 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjITQWx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:22:53 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8DCF
        for <netfilter-devel@vger.kernel.org>; Wed, 20 Sep 2023 09:22:47 -0700 (PDT)
Received: from [78.30.34.192] (port=36076 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qizyN-004ejV-Cl; Wed, 20 Sep 2023 18:22:45 +0200
Date:   Wed, 20 Sep 2023 18:22:42 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 6/9] netlink: handle invalid etype in set_make_key()
Message-ID: <ZQscUjZ2uQJrHYVT@calendula>
References: <20230920142958.566615-1-thaller@redhat.com>
 <20230920142958.566615-7-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920142958.566615-7-thaller@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 20, 2023 at 04:26:07PM +0200, Thomas Haller wrote:
> It's not clear to me, what ensures that the etype is always valid.
> Handle a NULL.

Applied, thanks
