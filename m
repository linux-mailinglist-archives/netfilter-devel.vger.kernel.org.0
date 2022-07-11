Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A635705B1
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 Jul 2022 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiGKOfR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 11 Jul 2022 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGKOfR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:35:17 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 536DB65D57
        for <netfilter-devel@vger.kernel.org>; Mon, 11 Jul 2022 07:35:16 -0700 (PDT)
Date:   Mon, 11 Jul 2022 16:35:12 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: conntrack: use fallthrough to cleanup
Message-ID: <Ysw1IH0/EaR/pLPm@salvia>
References: <20220525023215.422470-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220525023215.422470-1-liu.yun@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 25, 2022 at 10:32:15AM +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> These cases all use the same function. we can simplify the code through
> fallthrough.
> 
> $ size net/netfilter/nf_conntrack_core.o
> 
>         text	   data	    bss	    dec	    hex	filename
> before  81601	  81430	    768	 163799	  27fd7	net/netfilter/nf_conntrack_core.o
> after   80361	  81430	    768	 162559	  27aff	net/netfilter/nf_conntrack_core.o
> 
> Arch: aarch64
> Gcc : gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1)

Applied, thanks
