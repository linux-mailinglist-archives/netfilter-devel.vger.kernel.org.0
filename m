Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7567EBFA3
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Nov 2023 10:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjKOJmK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Nov 2023 04:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjKOJmJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:42:09 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E63D109
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Nov 2023 01:42:06 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1r3CPM-0006Ag-Lr; Wed, 15 Nov 2023 10:42:04 +0100
Date:   Wed, 15 Nov 2023 10:42:04 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 2/3] parser: remove "const" from argument of
 input_descriptor_destroy()
Message-ID: <20231115094204.GB23632@breakpoint.cc>
References: <20231109190032.669575-1-thaller@redhat.com>
 <20231109190032.669575-2-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109190032.669575-2-thaller@redhat.com>
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
> It's not a const pointer, as the destroy() function clearly
> modifies/free is. Drop the const from the argument of
> input_descriptor_destroy().
> 
> Signed-off-by: Thomas Haller <thaller@redhat.com>
> ---
>  src/scanner.l | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/scanner.l b/src/scanner.l
> index 00a09485d420..31284d7358fa 100644
> --- a/src/scanner.l
> +++ b/src/scanner.l
> @@ -1258,11 +1258,11 @@ void *scanner_init(struct parser_state *state)
>  	return scanner;
>  }
>  
> -static void input_descriptor_destroy(const struct input_descriptor *indesc)
> +static void input_descriptor_destroy(struct input_descriptor *indesc)
>  {
>  	if (indesc->name)
>  		free_const(indesc->name);
> -	free_const(indesc);
> +	free(indesc);

I don't agree, this is fine as-is.
