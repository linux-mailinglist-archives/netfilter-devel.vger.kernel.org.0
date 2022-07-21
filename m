Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277C957C05B
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Jul 2022 00:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiGTW5c (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 Jul 2022 18:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGTW5b (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:57:31 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4996D54C93
        for <netfilter-devel@vger.kernel.org>; Wed, 20 Jul 2022 15:57:30 -0700 (PDT)
Date:   Thu, 21 Jul 2022 00:57:25 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: flowtable: prefer refcount_inc
Message-ID: <YtiIVUkTXsRQK95u@salvia>
References: <20220707193056.29833-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220707193056.29833-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jul 07, 2022 at 09:30:56PM +0200, Florian Westphal wrote:
> With refcount_inc_not_zero, we'd also need a smp_rmb or similar,
> followed by a test of the CONFIRMED bit.
> 
> However, the ct pointer is taken from skb->_nfct, its refcount must
> not be 0 (else, we'd already have a use-after-free bug).
> 
> Use refcount_inc() instead to clarify the ct refcount is expected to
> be at least 1.

Applied, thanks
