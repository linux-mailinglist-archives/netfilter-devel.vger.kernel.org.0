Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA92C731687
	for <lists+netfilter-devel@lfdr.de>; Thu, 15 Jun 2023 13:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbjFOL3r (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 15 Jun 2023 07:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjFOL3n (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:29:43 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C090F273C
        for <netfilter-devel@vger.kernel.org>; Thu, 15 Jun 2023 04:29:42 -0700 (PDT)
Date:   Thu, 15 Jun 2023 13:29:39 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jacek Tomasiak <jacek.tomasiak@gmail.com>
Cc:     netfilter-devel@vger.kernel.org,
        Jacek Tomasiak <jtomasiak@arista.com>, fw@strlen.de
Subject: Re: [conntrack-tools PATCH] conntrack: Don't override mark in
 non-list mode
Message-ID: <ZIr2IyskRJKgSo5H@calendula>
References: <20230614162405.30885-1-jacek.tomasiak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614162405.30885-1-jacek.tomasiak@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

Cc'ing Florian.

On Wed, Jun 14, 2023 at 06:24:05PM +0200, Jacek Tomasiak wrote:
> When creating new rules with (e.g. with `conntrack -I -m 123 -u UNSET ...`),
> the mark from `-m` was overriden by value from `-u`. Additional
> condition ensures that this happens only in list mode.
> 
> This behavior was introduced in 1a5828f491c6a1593f30cb5f1551fe9f9cf76a8d
> ("conntrack: enable kernel-based status filtering with -L -u STATUS") for
> filtering the output of `-L` option but caused a regression in other cases.

In 1a5828f491c6a:

          tmpl->mark.value = status;
          tmpl->filter_status_kernel.val = tmpl->mark.value;

Not sure what the mark has to do this the -L -u STATUS filtering.

> Signed-off-by: Jacek Tomasiak <jtomasiak@arista.com>
> Signed-off-by: Jacek Tomasiak <jacek.tomasiak@gmail.com>
> ---
>  src/conntrack.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/conntrack.c b/src/conntrack.c
> index bf72739..78d3a07 100644
> --- a/src/conntrack.c
> +++ b/src/conntrack.c
> @@ -3007,7 +3007,9 @@ static void do_parse(struct ct_cmd *ct_cmd, int argc, char *argv[])
>  			if (tmpl->filter_status_kernel.mask == 0)
>  				tmpl->filter_status_kernel.mask = status;
>  
> -			tmpl->mark.value = status;
> +			// set mark only in list mode to not override value from -m
> +			if (command & CT_LIST)
> +				tmpl->mark.value = status;

The existing code also means that -L -u STATUS cannot be combined with
-L -m mark, right?

>  			tmpl->filter_status_kernel.val = tmpl->mark.value;
>  			tmpl->filter_status_kernel_set = true;
>  			break;
> -- 
> 2.35.3
> 
