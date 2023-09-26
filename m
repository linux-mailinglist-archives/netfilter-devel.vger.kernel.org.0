Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A967AEFC7
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Sep 2023 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjIZPg5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Sep 2023 11:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjIZPg5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:36:57 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D601EB
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Sep 2023 08:36:50 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qlA7E-0004al-JW; Tue, 26 Sep 2023 17:36:48 +0200
Date:   Tue, 26 Sep 2023 17:36:48 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 2/3] json: expose dynamic flag
Message-ID: <ZRL6kFI10OF/I39h@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20230926152500.30571-1-pablo@netfilter.org>
 <20230926152500.30571-2-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926152500.30571-2-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 26, 2023 at 05:24:59PM +0200, Pablo Neira Ayuso wrote:
> The dynamic flag is not exported via JSON, this triggers spurious
> ENOTSUPP errors when restoring rulesets in JSON with dynamic flags
> set on.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Fixes: 6e45b102650a2 ("nft: set: print dynamic flag when set")
Acked-by: Phil Sutter <phil@nwl.cc>
