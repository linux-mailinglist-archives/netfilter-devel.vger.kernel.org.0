Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8806C2DA1
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Mar 2023 10:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCUJJk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Mar 2023 05:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCUJJi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:09:38 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E9514EAE
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Mar 2023 02:09:01 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1peXzG-0001Rj-P9; Tue, 21 Mar 2023 10:08:58 +0100
Date:   Tue, 21 Mar 2023 10:08:58 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 1/2] Reduce signature of do_list_table()
Message-ID: <ZBl0KmRg7TG70Mx7@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20230320134659.13731-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320134659.13731-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Mar 20, 2023 at 02:46:58PM +0100, Phil Sutter wrote:
> Since commit 16fac7d11bdf5 ("src: use cache infrastructure for rule
> objects"), the function does not use the passed 'cmd' object anymore.
> Remove it to affirm correctness of a follow-up fix and simplification in
> do_list_ruleset().
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Series applied.
