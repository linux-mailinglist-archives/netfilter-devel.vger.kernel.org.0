Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078EA7A8654
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Sep 2023 16:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjITONv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 Sep 2023 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjITONu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:13:50 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ADE8F
        for <netfilter-devel@vger.kernel.org>; Wed, 20 Sep 2023 07:13:45 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qixxX-0003gg-M6; Wed, 20 Sep 2023 16:13:43 +0200
Date:   Wed, 20 Sep 2023 16:13:43 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 3/4] all: add free_const() and use it instead of
 xfree()
Message-ID: <ZQr+F7ChyFfArBYQ@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Thomas Haller <thaller@redhat.com>,
        NetFilter <netfilter-devel@vger.kernel.org>
References: <20230920131554.204899-1-thaller@redhat.com>
 <20230920131554.204899-4-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920131554.204899-4-thaller@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 20, 2023 at 03:13:40PM +0200, Thomas Haller wrote:
[...]
> There are many places that rightly cast away const during free. But not
> all of them. Add a free_const() macro, which is like free(), but accepts
> const pointers. We should always make an intentional choice whether to
> use free() or free_const(). Having a free_const() macro makes this very
> common choice clearer, instead of adding a (void*) cast at many places.

I wonder whether pointers to allocated data should be const in the first
place. Maybe I miss the point here? Looking at flow offload statement
for instance, should 'table_name' not be 'char *' instead of using this
free_const() to free it?

Cheers, Phil
