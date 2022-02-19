Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26394BC892
	for <lists+netfilter-devel@lfdr.de>; Sat, 19 Feb 2022 14:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiBSN0L (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 19 Feb 2022 08:26:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiBSN0K (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 19 Feb 2022 08:26:10 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D7945789
        for <netfilter-devel@vger.kernel.org>; Sat, 19 Feb 2022 05:25:50 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nLPkB-0007Uh-Rz; Sat, 19 Feb 2022 14:25:47 +0100
Date:   Sat, 19 Feb 2022 14:25:47 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH] netfilter: conntrack: Relax helper
 auto-assignment warning for nftables
Message-ID: <20220219132547.GA27537@breakpoint.cc>
References: <20220219132024.29328-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219132024.29328-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> With nftables, no template is being used and instead helper assignment
> happens after conntrack initialization. With helper auto assignment
> being disabled by default, this leads to this spurious kernel log
> suggesting to use iptables CT target.
>
> To avoid the bogus and confusing message, check helper's refcount: It is
> initialized to 1 by nf_conntrack_helper_register() and incremented by
> nf_conntrack_helper_try_module_get() during nft_ct_helper_obj_init(). So
> if its value is larger than 1, it must be in use *somewhere*.

Why not set cnet->auto_assign_helper_warned = true; from nft_ct.c?
