Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36FC74DAF1
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Jul 2023 18:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjGJQWO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Jul 2023 12:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjGJQWN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:22:13 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9069094
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jul 2023 09:22:11 -0700 (PDT)
Date:   Mon, 10 Jul 2023 18:22:08 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [nft PATCH 0/4] libnftables: minor cleanups initalizing nf_sock
 instance of nft_ctx
Message-ID: <ZKwwMCk1AsIYr3Mz@calendula>
References: <20230710084926.172198-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230710084926.172198-1-thaller@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 10, 2023 at 10:45:15AM +0200, Thomas Haller wrote:
> There is some unnecessary or redundant code in "src/libnftables.c".
> Clean up.
> 
> This was motivated by an attempt to add a new flag for nft_ctx_new(),
> beside NFT_CTX_DEFAULT. The current "if (flags == NFT_CTX_DEFAULT)"
> check is an odd usage for flags (because we would want that behavior for
> all flags).

Series applied, thanks
