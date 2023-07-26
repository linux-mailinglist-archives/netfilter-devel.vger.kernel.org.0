Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D15762D93
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jul 2023 09:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjGZHam (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jul 2023 03:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjGZH3r (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:29:47 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98435B8
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Jul 2023 00:28:20 -0700 (PDT)
Received: from [46.222.121.5] (port=4644 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qOYwQ-005Bz1-9l; Wed, 26 Jul 2023 09:28:16 +0200
Date:   Wed, 26 Jul 2023 09:28:11 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: ulogd2 patch ping
Message-ID: <ZMDLC8QFOUH9z7xQ@calendula>
References: <20230725191128.GE84273@celephais.dreamlands>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230725191128.GE84273@celephais.dreamlands>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Jeremy,

On Tue, Jul 25, 2023 at 08:11:28PM +0100, Jeremy Sowden wrote:
> There is a ulogd2 patch of mine from the end of last that is still under
> review in Patchwork:
> 
>   https://patchwork.ozlabs.org/project/netfilter-devel/patch/20221208222208.681865-1-jeremy@azazel.net/
> 
> It would be great to get a yea or nay.

What plugins are still IPv4-only in ulogd2?

Maybe add _IPV4 | _IPV6 flags to plugins hence it is possible to
validate if user's stack is valid, otherwise bail out and provide a
reason via logging?

Regarding translation from network to host byte, I think it makes more
sense to keep IPv4 addres in network byte, so filter and output
plugings always expect them such way as you did in your patch?

Let me know, thanks!
