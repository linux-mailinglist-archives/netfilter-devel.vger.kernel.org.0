Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E8F7E0A7C
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Nov 2023 21:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjKCUsW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Nov 2023 16:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCUsW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:48:22 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F41BF
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 13:48:19 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qz15U-0003D0-7a; Fri, 03 Nov 2023 21:48:16 +0100
Date:   Fri, 3 Nov 2023 21:48:16 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH iptables] arptables-nft: remove ARPT_INV flags usage
Message-ID: <ZUVckMM4c0Nb/dk1@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
References: <20231103163519.GE8035@breakpoint.cc>
 <20231103163548.27178-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103163548.27178-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 03, 2023 at 05:33:22PM +0100, Florian Westphal wrote:
> ARPT_ and IPT_INV flags are not interchangeable, e.g.:
> define IPT_INV_SRCDEVADDR	0x0080
> define ARPT_INV_SRCDEVADDR	0x0010
> 
> as these flags can be tested by libarp_foo.so such checks can yield
> incorrect results.
> 
> Because arptables-nft uses existing code, e.g. xt_mark, it makes
> sense to unify this completely by converting the last users of
> ARPT_INV_ constants.
> 
> Note that arptables-legacy does not do run-time module loading via
> dlopen(). Functionaliy implemented by "extensions" in the
> arptables-legacy git tree are built-in, so this doesn't break
> arptables-legacy binaries.
> 
> Fixes: 44457c080590 ("xtables-arp: Don't use ARPT_INV_*")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Patch applied, thanks!
