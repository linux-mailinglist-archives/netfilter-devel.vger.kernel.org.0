Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D97E0716
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Nov 2023 17:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjKCQ5q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Nov 2023 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjKCQ5p (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:57:45 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884BCD57
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 09:57:42 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qyxUK-0006ym-HF; Fri, 03 Nov 2023 17:57:40 +0100
Date:   Fri, 3 Nov 2023 17:57:40 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v3 1/2] json: drop handling missing json() hook in
 expr_print_json()
Message-ID: <20231103165740.GF8035@breakpoint.cc>
References: <20231103162937.3352069-1-thaller@redhat.com>
 <20231103162937.3352069-2-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103162937.3352069-2-thaller@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thomas Haller <thaller@redhat.com> wrote:
> --- a/src/expression.c
> +++ b/src/expression.c
> @@ -321,6 +321,7 @@ static const struct expr_ops symbol_expr_ops = {
>  	.type		= EXPR_SYMBOL,
>  	.name		= "symbol",
>  	.print		= symbol_expr_print,
> +	.json		= NULL, /* expr_print_json() must never be called. */

I'd suggest to add a json callback that BUG()s instead,
with a comment explaining that these do not exist anymore
after the initial eval stage.  (symbols will be resolved
to numeric value for example).
