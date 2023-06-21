Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D45738887
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jun 2023 17:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjFUPMs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Jun 2023 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFUPM2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:12:28 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 280A25B87
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Jun 2023 08:08:08 -0700 (PDT)
Date:   Wed, 21 Jun 2023 16:49:27 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] cli: Make valgrind happy
Message-ID: <ZJMN90PRXDIdL83N@calendula>
References: <20230620140352.21633-1-phil@nwl.cc>
 <ZJHOEff+hNaj6g8e@calendula>
 <ZJLpQ0Wxnek0dtVQ@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJLpQ0Wxnek0dtVQ@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 21, 2023 at 02:12:51PM +0200, Phil Sutter wrote:
> On Tue, Jun 20, 2023 at 06:04:33PM +0200, Pablo Neira Ayuso wrote:
> > On Tue, Jun 20, 2023 at 04:03:52PM +0200, Phil Sutter wrote:
> > > Missing call to nft_ctx_free() upsets valgrind enough to suspect
> > > possible losses, add them where sensible. This fixes reports with
> > > readline-lined builds at least. The same code is shared for libedit
> > > though, and there's an obvious spot for linenoise.
> > 
> > Maybe call nft_ctx_free() from cli_exit() ?
> 
> That's doable, but linenoise code does not use the static global cli_nft
> variable and thus cli_exit() can't access the struct nft_ctx pointer.
> 
> At first, I tried to make main() not exit after calling cli_init() so
> final cleanup takes place. But the different CLI variants are a bit of a
> mess in that regard: While there are code-paths returning to caller,
> most don't. I'm tempted to fix that instead. What do you think?

That's also fine, go ahead update and test all these cli variants.
