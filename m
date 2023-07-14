Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC947537C2
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 Jul 2023 12:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjGNKQs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 14 Jul 2023 06:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbjGNKQk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:16:40 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9071B3A9D
        for <netfilter-devel@vger.kernel.org>; Fri, 14 Jul 2023 03:16:11 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qKFqK-0008M8-Kf; Fri, 14 Jul 2023 12:16:08 +0200
Date:   Fri, 14 Jul 2023 12:16:08 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [nft v2 PATCH 1/3] nftables: add input flags for nft_ctx
Message-ID: <ZLEgaNIH/ZD4hnf3@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Thomas Haller <thaller@redhat.com>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
References: <ZKxG23yJzlRRPpsO@calendula>
 <20230714084943.1080757-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714084943.1080757-1-thaller@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 14, 2023 at 10:48:51AM +0200, Thomas Haller wrote:
[...]
> +=== nft_ctx_input_get_flags() and nft_ctx_input_set_flags()
> +The flags setting controls the input format.

Note how we turn on JSON input parsing if JSON output is enabled.

I think we could tidy things up by introducing NFT_CTX_INPUT_JSON and
flip it from nft_ctx_output_set_flags() to match NFT_CTX_OUTPUT_JSON for
compatibility?

Cheers, Phil
