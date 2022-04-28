Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111475136A4
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Apr 2022 16:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348220AbiD1OSi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Apr 2022 10:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiD1OSh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:18:37 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E021985673
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Apr 2022 07:15:22 -0700 (PDT)
Date:   Thu, 28 Apr 2022 16:15:17 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH v2 nf] netfilter: nft_socket: only do sk lookups when
 indev is available
Message-ID: <YmqhdQjqndZXVee8@salvia>
References: <20220428073921.14483-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220428073921.14483-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 28, 2022 at 09:39:21AM +0200, Florian Westphal wrote:
> Check if the incoming interface is available and NFT_BREAK
> in case neither skb->sk nor input device are set.
> 
> Because nf_sk_lookup_slow*() assume packet headers are in the
> 'in' direction, use in postrouting is not going to yield a meaningful
> result.  Same is true for the forward chain, so restrict the use
> to prerouting, input and output.
> 
> Use in output work if a socket is already attached to the skb.

Applied to nf.git, thanks
