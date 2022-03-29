Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB244EB566
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Mar 2022 23:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiC2ViR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Mar 2022 17:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiC2ViQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:38:16 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 767E4122225
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Mar 2022 14:36:33 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8CE476019D;
        Tue, 29 Mar 2022 23:33:19 +0200 (CEST)
Date:   Tue, 29 Mar 2022 23:36:30 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [nf PATCH v2] netfilter: bitwise: fix reduce comparisons
Message-ID: <YkN73i59zcEJjaOi@salvia>
References: <20220327215223.73014-1-jeremy@azazel.net>
 <20220327223625.134198-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220327223625.134198-1-jeremy@azazel.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Mar 27, 2022 at 11:36:25PM +0100, Jeremy Sowden wrote:
> The `nft_bitwise_reduce` and `nft_bitwise_fast_reduce` functions should
> compare the bitwise operation in `expr` with the tracked operation
> associated with the destination register of `expr`.  However, instead of
> being called on `expr` and `track->regs[priv->dreg].selector`,
> `nft_expr_priv` is called on `expr` twice, so both reduce functions
> return true even when the operations differ.

Good catch, applied thanks
