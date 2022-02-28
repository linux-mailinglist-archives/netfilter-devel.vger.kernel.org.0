Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE52B4C7C18
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Feb 2022 22:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiB1VfJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Feb 2022 16:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiB1VfI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:35:08 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8F5B1375BB
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Feb 2022 13:34:29 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id E86B360201;
        Mon, 28 Feb 2022 22:33:03 +0100 (CET)
Date:   Mon, 28 Feb 2022 22:34:24 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH nf] netfilter: egress: silence egress hook lockdep splats
Message-ID: <Yh0/4G8oqlvF/JjK@salvia>
References: <20220228031805.32347-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220228031805.32347-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 28, 2022 at 04:18:05AM +0100, Florian Westphal wrote:
> Netfilter assumes its called with rcu_read_lock held, but in egress
> hook case it may be called with BH readlock.
> 
> This triggers lockdep splat.
> 
> In order to avoid to change all rcu_dereference() to
> rcu_dereference_check(..., rcu_read_lock_bh_held()), wrap nf_hook_slow
> with read lock/unlock pair.

Applied, thanks
