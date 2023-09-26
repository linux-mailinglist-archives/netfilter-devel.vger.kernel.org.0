Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086887AF491
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Sep 2023 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjIZT6U (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Sep 2023 15:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbjIZT6T (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:58:19 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F1192
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Sep 2023 12:58:10 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qlEC8-00074E-Sm; Tue, 26 Sep 2023 21:58:08 +0200
Date:   Tue, 26 Sep 2023 21:58:08 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] tests: shell: features: Fix table owner flag check
Message-ID: <ZRM30FNtiEbjfsGv@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20230926195622.31984-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926195622.31984-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 26, 2023 at 09:56:22PM +0200, Phil Sutter wrote:
> The keyword is "flags", not "flag". Resulted in a false-negative:
> 
> features/table_flag_owner.nft:4:2-5: Error: syntax error, unexpected string
> 	flag owner;
> 	^^^^
> 
> Fixes: 10373f0936cd3 ("tests: shell: skip flowtable-uaf if we lack table owner support")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.
