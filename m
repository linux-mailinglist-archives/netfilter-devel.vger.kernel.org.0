Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A321F77E5F8
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Aug 2023 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjHPQEz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Aug 2023 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344507AbjHPQEq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:04:46 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A942711
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Aug 2023 09:04:45 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qWJ0m-00013J-BM; Wed, 16 Aug 2023 18:04:44 +0200
Date:   Wed, 16 Aug 2023 18:04:44 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [nft PATCH v4 5/6] py: extract flags helper functions for
 set_debug()/get_debug()
Message-ID: <ZNzznHsHN1BlbNdQ@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Thomas Haller <thaller@redhat.com>,
        NetFilter <netfilter-devel@vger.kernel.org>
References: <20230803193940.1105287-1-thaller@redhat.com>
 <20230803193940.1105287-11-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803193940.1105287-11-thaller@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:35:22PM +0200, Thomas Haller wrote:
> Will be re-used for nft_ctx_input_set_flags() and
> nft_ctx_input_get_flags().
> 
> There are changes in behavior here.
> 
> - when passing an unrecognized string (e.g. `ctx.set_debug('foo')` or
>   `ctx.set_debug(['foo'])`), a ValueError is now raised instead of a
>   KeyError.
> 
> - when passing an out-of-range integer, now a ValueError is no raised.
>   Previously the integer was truncated to 32bit.
> 
> Changing the exception is an API change, but most likely nobody will
> care or try to catch a KeyError to find out whether a flag is supported.
> Especially, since such a check would be better performed via `'foo' in
> ctx.debug_flags`.
> 
> In other cases, a TypeError is raised as before.
> 
> Signed-off-by: Thomas Haller <thaller@redhat.com>

Reviewed-by: Phil Sutter <phil@nwl.cc>
