Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D078D7EB2FB
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Nov 2023 16:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjKNPCg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Nov 2023 10:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNPCg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:02:36 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F7B114
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Nov 2023 07:02:31 -0800 (PST)
Received: from [78.30.43.141] (port=59278 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r2uvq-0070pe-Ep; Tue, 14 Nov 2023 16:02:28 +0100
Date:   Tue, 14 Nov 2023 16:02:25 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libmnl v2] nlmsg: fix false positives when validating
 buffer sizes
Message-ID: <ZVOMAUFOnC7EFzHV@calendula>
References: <20231104230154.2006144-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231104230154.2006144-1-jeremy@azazel.net>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Nov 04, 2023 at 11:01:54PM +0000, Jeremy Sowden wrote:
> The `len` parameter of `mnl_nlmsg_ok`, which holds the buffer length and
> is compared to the size of the object expected to fit into the buffer,
> is signed because the function validates the length, and it can be
> negative in the case of malformed messages.  Comparing it to unsigned
> operands used to lead to compiler warnings:
> 
>   msg.c: In function 'mnl_nlmsg_ok':
>   msg.c:136: warning: comparison between signed and unsigned
>   msg.c:138: warning: comparison between signed and unsigned
> 
> and so commit 73661922bc3b ("fix warning in compilation due to different
> signess") added casts of the unsigned operands to `int`.  However, the
> comparison to `nlh->nlmsg_len`:
> 
>   (int)nlh->nlmsg_len <= len
> 
> is problematic, since `nlh->nlmsg_len` is of type `__u32` and so may
> hold values greater than `INT_MAX`.  In the case where `len` is positive
> and `nlh->nlmsg_len` is greater than `INT_MAX`, the cast will yield a
> negative value and `mnl_nlmsg_ok` will incorrectly return true.
> 
> Instead, assign `len` to an unsigned local variable, check for a
> negative value first, then use the unsigned local for the other
> comparisons, and remove the casts.

Applied, thanks Jeremy
