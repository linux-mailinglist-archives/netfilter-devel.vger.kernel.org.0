Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1005A7B9E
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Aug 2022 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiHaKqt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Aug 2022 06:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHaKqt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:46:49 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D3EC2E85
        for <netfilter-devel@vger.kernel.org>; Wed, 31 Aug 2022 03:46:47 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1oTLF1-0000S6-8n; Wed, 31 Aug 2022 12:46:39 +0200
Date:   Wed, 31 Aug 2022 12:46:39 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] src: allow burst 0 for byte ratelimit and use it as
 default
Message-ID: <Yw88D+Rck6h4XC4d@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20220830153746.94996-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830153746.94996-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 30, 2022 at 05:37:46PM +0200, Pablo Neira Ayuso wrote:
> Packet-based limit burst is set to 5, as in iptables. However,
> byte-based limit burst adds to the rate to calculate the bucket size,
> and this is also sets this to 5 (... bytes in this case). Update it to
> use zero byte burst by default instead.
> 
> This patch also updates manpage to describe how the burst value
> influences the kernel module's token bucket in each of the two modes.
> This documentation update is based on original text by Phil Sutter.
> 
> Adjust tests/py to silence warnings due to mismatching byte burst.
> 
> Fixes: 285baccfea46 ("src: disallow burst 0 in ratelimits")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Acked-by: Phil Sutter <phil@nwl.cc>

Thanks for taking over the man page adjustment!
