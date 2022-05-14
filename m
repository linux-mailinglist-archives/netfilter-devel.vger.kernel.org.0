Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58BC52733E
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 May 2022 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiENRKD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 14 May 2022 13:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiENRKC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 14 May 2022 13:10:02 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B3815A12
        for <netfilter-devel@vger.kernel.org>; Sat, 14 May 2022 10:10:00 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1npvHD-0007u5-8o; Sat, 14 May 2022 19:09:59 +0200
Date:   Sat, 14 May 2022 19:09:59 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Nick Hainke <vincent@systemli.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables 2/2] xshared: fix compilation with musl
Message-ID: <Yn/iZyTrZvj++6ZA@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Nick Hainke <vincent@systemli.org>, netfilter-devel@vger.kernel.org
References: <20220514163325.54266-1-vincent@systemli.org>
 <20220514163325.54266-2-vincent@systemli.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514163325.54266-2-vincent@systemli.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, May 14, 2022 at 06:33:25PM +0200, Nick Hainke wrote:
> Gcc complains about missing types. Include <sys/types.h> to fix it.
> 
> Fixes errors in the form of:
> In file included from xtables-legacy-multi.c:5:
> xshared.h:83:56: error: unknown type name 'u_int16_t'; did you mean 'uint16_t'?
>    83 | set_option(unsigned int *options, unsigned int option, u_int16_t *invflg,
>       |                                                        ^~~~~~~~~
>       |                                                        uint16_t
> make[6]: *** [Makefile:712: xtables_legacy_multi-xtables-legacy-multi.o] Error 1

Does it work if you change the type to uint16_t instead? This looks like
fixing for a typo in f647f61f273a1 ("xtables: Make invflags 16bit wide")
which I didn't notice.

Thanks, Phil
