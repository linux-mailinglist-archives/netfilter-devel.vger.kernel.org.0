Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62F97EBF6C
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Nov 2023 10:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjKOJ1o (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Nov 2023 04:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjKOJ1o (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:27:44 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEDB9B
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Nov 2023 01:27:41 -0800 (PST)
Received: from [78.30.43.141] (port=49878 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r3CBM-00B8S8-1y
        for netfilter-devel@vger.kernel.org; Wed, 15 Nov 2023 10:27:38 +0100
Date:   Wed, 15 Nov 2023 10:27:34 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: libnfnetlink dependency elimination (doc)
Message-ID: <ZVSPBsJOILgw3c0m@calendula>
References: <20231112065922.3414-1-duncan_roe@optusnet.com.au>
 <ZVORGxjxolo3vnz1@calendula>
 <ZVP9D9KPgMkxLiB/@slk15.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVP9D9KPgMkxLiB/@slk15.local.net>
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

On Wed, Nov 15, 2023 at 10:04:47AM +1100, Duncan Roe wrote:
> Hi Pablo,
> 
> On Tue, Nov 14, 2023 at 04:24:11PM +0100, Pablo Neira Ayuso wrote:
> > On Sun, Nov 12, 2023 at 05:59:21PM +1100, Duncan Roe wrote:
> > > Some of these documented changes haven't happened yet.
> >
> > Then we have to start by changes first, not the other way around.
> 
> Yes I know that, obviously:)
> 
> The point here is that nfnl_rcvbufsiz() has been advertised in the main page of
> libnetfilter_queue HTML for a long time and there are likely a number of systems
> out there that use it. When libnfnetlink is removed, libnetfilter_queue will
> have to provide nfnl_rcvbufsiz() or those systems will start failing.

There is nfq_fd() and setsockopt() that you can use:

        setsockopt(fd, SOL_SOCKET, SO_RCVBUFFORCE, &size, socklen);
        setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &size, socklen);

libnfnetlink is **deprecated** and it will be removed at some point,
the git log shows that it has less and less users.

main libnfnetlink users are the libnetfilter_* libraries.

No new application should be using libnfnetlink in 2023.
