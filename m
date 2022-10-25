Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012A260CB42
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Oct 2022 13:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJYLuU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Oct 2022 07:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiJYLuT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:50:19 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11E2F46200
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Oct 2022 04:50:18 -0700 (PDT)
Date:   Tue, 25 Oct 2022 13:50:13 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nf-next] netfilter: nf_tables: nft_objref: make it builtin
Message-ID: <Y1fNddxT0jo/6dQa@salvia>
References: <20221021141753.106524-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021141753.106524-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:17:53PM +0200, Florian Westphal wrote:
> nft_objref is needed to reference named objects, it makes
> no sense to disable it.
> 
> Before:
>    text	   data	    bss	    dec	 filename
>   4014	    424	      0	   4438	 nft_objref.o
>   4174	   1128	      0	   5302	 nft_objref.ko
> 359351	  15276	    864	 375491	 nf_tables.ko
> After:
>   text	   data	    bss	    dec	 filename
>   3815	    408	      0	   4223	 nft_objref.o
> 363161	  15692	    864	 379717	 nf_tables.ko

Applied to nf-next, thanks.

For the record, I have rebased the nft_inner support on top of this
patch.
