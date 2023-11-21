Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8737F2D7D
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Nov 2023 13:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjKUMpa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Nov 2023 07:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjKUMp3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:45:29 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA03138
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Nov 2023 04:45:25 -0800 (PST)
Received: from [78.30.43.141] (port=53794 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r5Q81-007jeq-9j; Tue, 21 Nov 2023 13:45:23 +0100
Date:   Tue, 21 Nov 2023 13:45:20 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     Phil Sutter <phil@nwl.cc>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 1/1] tests/shell: sanitize "handle" in JSON output
Message-ID: <ZVymYDwWLQBQUAAg@calendula>
References: <20231117171948.897229-1-thaller@redhat.com>
 <ZVgjLFGvHqoXXvjd@orbyte.nwl.cc>
 <f4b86e5318556be07a8c86c3fdd551ad5e22a831.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4b86e5318556be07a8c86c3fdd551ad5e22a831.camel@redhat.com>
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

Hi Thomas,

On Tue, Nov 21, 2023 at 01:10:11PM +0100, Thomas Haller wrote:
> On Sat, 2023-11-18 at 03:36 +0100, Phil Sutter wrote:
> > On Fri, Nov 17, 2023 at 06:18:45PM +0100, Thomas Haller wrote:
[...]
> > > Note that only a few .json-nft files are adjusted, because
> > > otherwise the
> > > patch is too large. Before applying, you need to adjust them all,
> > > by
> > > running `./tests/shell/run-tests.sh -g`.
> > 
> > Just put the bulk change into a second patch?
> 
> it would require 3 patches to stay below the limit.
> 
> Also, it blows up the inbox by everybody on the list by 850K (57k
> gzipped). The rest of the patch is generated. Just generate it.

Excuse for jumping through this, just a submission style notice:

Please, Cc maintainers with big patches that don't fit in into the
mailing list in the future.

> Alternatively,
> 
>   git fetch https://gitlab.freedesktop.org/thaller/nftables df984038a33c6da5b159e6f6458351c4fa673bf1
>   git merge FETCH_HEAD

I'd suggest you place this also in the cover letter, so at least there
is a record on the mailing list archive that some patches could not
get through but there was an alternative way to take them for others.
As for maintainers, they can collect the large patch as attachment
from the email.

Thanks.
