Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9E06D02C7
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Mar 2023 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjC3LQS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Mar 2023 07:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjC3LQR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:16:17 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83D41709
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Mar 2023 04:16:00 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1phqG5-0005WO-Mt; Thu, 30 Mar 2023 13:15:57 +0200
Date:   Thu, 30 Mar 2023 13:15:57 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] xt: Fix translation error path
Message-ID: <ZCVvbQa0Rm7+liyF@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20230328122616.14100-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328122616.14100-1-phil@nwl.cc>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:26:16PM +0200, Phil Sutter wrote:
> If xtables support was compiled in but the required libxtables DSO is
> not found, nft prints an error message and leaks memory:
> 
> | counter packets 0 bytes 0 XT target MASQUERADE not found
> 
> This is not as bad as it seems, the output combines stdout and stderr.
> Dropping stderr produces an incomplete ruleset listing, though. While
> this seemingly inline output can't easily be avoided, fix a few things:
> 
> * Respect octx->error_fp, libnftables might have been configured to
>   redirect stderr somewhere else.
> * Align error message formatting with others.
> * Don't return immediately, but free allocated memory and fall back to
>   printing the expression in "untranslated" form.
> 
> Fixes: 5c30feeee5cfe ("xt: Delay libxtables access until translation")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.
