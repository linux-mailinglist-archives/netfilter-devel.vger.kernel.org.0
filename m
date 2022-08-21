Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47D559B554
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Aug 2022 18:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiHUQC7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 21 Aug 2022 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHUQC5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 21 Aug 2022 12:02:57 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4F22E43
        for <netfilter-devel@vger.kernel.org>; Sun, 21 Aug 2022 09:02:56 -0700 (PDT)
Date:   Sun, 21 Aug 2022 18:02:52 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 1/3] netfilter: nft_dup: validate family and chains
Message-ID: <YwJXLLQ1oeQXw6lN@salvia>
References: <20220821155401.197971-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220821155401.197971-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Aug 21, 2022 at 05:53:59PM +0200, Pablo Neira Ayuso wrote:
> This only supports for netdev family and ingress and egress hooks.

Not really required since this is already restricted to
NFPROTO_NETDEV, withdraw.
