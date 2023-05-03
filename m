Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4B36F5759
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 May 2023 13:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjECLtj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 May 2023 07:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjECLtg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 May 2023 07:49:36 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7D5B5592
        for <netfilter-devel@vger.kernel.org>; Wed,  3 May 2023 04:49:34 -0700 (PDT)
Date:   Wed, 3 May 2023 13:49:30 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>,
        Rvfg <i@rvf6.com>
Subject: Re: [PATCH nf] netfilter: nf_tables: fix ct untracked match breakage
Message-ID: <ZFJKSmEMis6a867U@calendula>
References: <20230503100018.74845-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230503100018.74845-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 03, 2023 at 12:00:18PM +0200, Florian Westphal wrote:
> "ct untracked" no longer works properly due to erroneous NFT_BREAK.
> We have to check ctinfo enum first.

Applied, thanks
