Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F784538642
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 May 2022 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiE3Ql2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 May 2022 12:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbiE3Ql1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 May 2022 12:41:27 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 194BE70374
        for <netfilter-devel@vger.kernel.org>; Mon, 30 May 2022 09:41:27 -0700 (PDT)
Date:   Mon, 30 May 2022 18:41:23 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Chander Govindarajan <mail@chandergovind.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] nft: simplify chain lookup in do_list_chain
Message-ID: <YpTzszIxgiL8s14e@salvia>
References: <9e9387c5-7416-3325-32c0-49b21b95b21e@chandergovind.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e9387c5-7416-3325-32c0-49b21b95b21e@chandergovind.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 25, 2022 at 03:25:43PM +0530, Chander Govindarajan wrote:
> use the chain_cache_find function for faster lookup of chain instead of
> iterating over all chains in table

Applied, thanks
