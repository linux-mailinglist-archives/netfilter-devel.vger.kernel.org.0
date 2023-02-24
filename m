Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6666A137F
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Feb 2023 00:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBWXG7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Feb 2023 18:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBWXG6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:06:58 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F8A5D44F
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Feb 2023 15:06:54 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pVKfs-000212-9P; Fri, 24 Feb 2023 00:06:52 +0100
Date:   Fri, 24 Feb 2023 00:06:52 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH nft] meta: introduce broute expression
Message-ID: <20230223230652.GE26596@breakpoint.cc>
References: <20230223202942.16459-1-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223202942.16459-1-sriram.yagnaraman@est.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sriram Yagnaraman <sriram.yagnaraman@est.tech> wrote:
>  static bool meta_key_is_unqualified(enum nft_meta_keys key)
> diff --git a/src/parser_bison.y b/src/parser_bison.y
> index 824e5db8..e3440b2b 100644
> --- a/src/parser_bison.y
> +++ b/src/parser_bison.y
> @@ -528,6 +528,7 @@ int nft_lex(void *, void *, void *);
>  %token OIFGROUP			"oifgroup"
>  %token CGROUP			"cgroup"
>  %token TIME			"time"
> +%token BROUTE 			"broute"

I think you don't need to add a new token.
meta_key_parse() should pick this up from the meta_template
array automatically.

> index bc5b5b62..f1ffa053 100644
> --- a/src/scanner.l
> +++ b/src/scanner.l
> @@ -721,6 +721,7 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
>  "iifgroup"		{ return IIFGROUP; }
>  "oifgroup"		{ return OIFGROUP; }
>  "cgroup"		{ return CGROUP; }
> +"broute"		{ return BROUTE; }

and this should not be needed either.
