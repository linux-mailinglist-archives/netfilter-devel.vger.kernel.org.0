Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8A9558940
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jun 2022 21:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiFWTkW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jun 2022 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiFWTkH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:40:07 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCD96794D0
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Jun 2022 12:29:43 -0700 (PDT)
Date:   Thu, 23 Jun 2022 21:29:41 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
Cc:     netfilter-devel@vger.kernel.org, mikhail.sennikovsky@gmail.com
Subject: Re: [PATCH 3/6] tests/conntrack: invalid protocol values
Message-ID: <YrS/JZGtFo0EzibA@salvia>
References: <20220623175000.49259-1-mikhail.sennikovskii@ionos.com>
 <20220623175000.49259-4-mikhail.sennikovskii@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220623175000.49259-4-mikhail.sennikovskii@ionos.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 23, 2022 at 07:49:57PM +0200, Mikhail Sennikovsky wrote:
> Testcases covering passing invalid protocol values via -p parameter.
> * -p 256 should fail
> * -p foo should fail
> which does not work properly at the moment.
> Fix included in the next commit.

Please, collapse this to next patch 4/6 in v2.

> Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
> ---
>  tests/conntrack/testsuite/00create | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/conntrack/testsuite/00create b/tests/conntrack/testsuite/00create
> index 9962e23..9fb3a0b 100644
> --- a/tests/conntrack/testsuite/00create
> +++ b/tests/conntrack/testsuite/00create
> @@ -61,3 +61,8 @@
>  -D -s 0.0.0.0 -d 224.0.0.22 -r 224.0.0.22 -q 0.0.0.0 -p 200 ; OK
>  # delete again
>  -D -s 0.0.0.0 -d 224.0.0.22 -r 224.0.0.22 -q 0.0.0.0 -p 200 ; BAD
> +# Invalid protocol values
> +# 256 should fail
> +-I -t 10 -s 1.1.1.1 -d 2.2.2.2 -r 2.2.2.2 -q 1.1.1.1 -p 256 ; BAD
> +# take some invalid protocol name
> +-I -t 10 -s 0.0.0.0 -d 224.0.0.22 -r 224.0.0.22 -q 0.0.0.0 -p foo ; BAD
> -- 
> 2.25.1
> 
