Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7E569F3A0
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Feb 2023 12:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjBVLtE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Feb 2023 06:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBVLtE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:49:04 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C51132CEA
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Feb 2023 03:49:03 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pUncL-0006kZ-TH; Wed, 22 Feb 2023 12:49:01 +0100
Date:   Wed, 22 Feb 2023 12:49:01 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [RFC nf-next PATCH] netfilter: nft: introduce broute chain type
Message-ID: <20230222114901.GF12484@breakpoint.cc>
References: <20230222110337.15951-1-sriram.yagnaraman@est.tech>
 <20230222113731.GE12484@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222113731.GE12484@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> The br_netfilter_broute flag is required, but I don't like a new chain
> type for this, nor keeping the drop/accept override.
> 
> I'd add a new "broute" expression that sets the flag in the skb cb
> and sets NF_ACCEPT, useable in bridge family -- I think that this would
> be much more readable.

Or, even simpler, extend nft_meta_bridge.c and extend nft userspace to
support:

  nft ... meta broute set 1 accept

We also support nftrace this way, so there is precedence for it.
