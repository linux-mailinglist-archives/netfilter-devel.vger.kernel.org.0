Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78566A1A91
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Feb 2023 11:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBXKso (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 Feb 2023 05:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBXKsm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:48:42 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE014225
        for <netfilter-devel@vger.kernel.org>; Fri, 24 Feb 2023 02:48:39 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pVVcy-0005Aw-2y; Fri, 24 Feb 2023 11:48:36 +0100
Date:   Fri, 24 Feb 2023 11:48:36 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH nft v2] meta: introduce broute expression
Message-ID: <20230224104836.GG26596@breakpoint.cc>
References: <20230224095735.19317-1-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224095735.19317-1-sriram.yagnaraman@est.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sriram Yagnaraman <sriram.yagnaraman@est.tech> wrote:
> nft userspace tool support broute meta statment proposed in [1].
> 
> [1]: https://patchwork.ozlabs.org/project/netfilter-devel/patch/20230224095251.11249-1-sriram.yagnaraman@est.tech/

LGTM.

Can you make a followup patch that adds a test case to
tests/py/bridge/meta.t

and a new test file, e.g.
tests/py/bridge/redirect.t ?

First one is expected to fail (only input is tested),
but second one should pass.

Make sure this works with -j (json as well).

Thanks.
