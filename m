Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED85BE6E5
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Sep 2022 15:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiITNU2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Sep 2022 09:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiITNUJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:20:09 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED2D3E0C0
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Sep 2022 06:20:07 -0700 (PDT)
Date:   Tue, 20 Sep 2022 15:20:03 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] evaluate: un-break rule insert with intervals
Message-ID: <Yym+A27DQyryYtwE@salvia>
References: <20220920125726.5818-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920125726.5818-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 20, 2022 at 02:57:26PM +0200, Florian Westphal wrote:
> 'rule inet dscpclassify dscp_match  meta l4proto { udp }  th dport { 3478 }  th sport { 3478-3497, 16384-16387 } goto ct_set_ef'
> works with 'nft add', but not 'nft insert', the latter yields: "BUG: unhandled op 4".

That's my fault, thanks for the fix.

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

P.S: Please add a simple test for this regression.

> Fixes: 81e36530fcac ("src: replace interval segment tree overlap and automerge")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  src/evaluate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/evaluate.c b/src/evaluate.c
> index d9c9ca28a53a..edebd7bcd8ab 100644
> --- a/src/evaluate.c
> +++ b/src/evaluate.c
> @@ -1520,6 +1520,7 @@ static int interval_set_eval(struct eval_ctx *ctx, struct set *set,
>  	switch (ctx->cmd->op) {
>  	case CMD_CREATE:
>  	case CMD_ADD:
> +	case CMD_INSERT:
>  		if (set->automerge) {
>  			ret = set_automerge(ctx->msgs, ctx->cmd, set, init,
>  					    ctx->nft->debug_mask);
> -- 
> 2.35.1
> 
