Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D922517705
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 May 2022 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387000AbiEBTCb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 May 2022 15:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386995AbiEBTCa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 May 2022 15:02:30 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0782654C
        for <netfilter-devel@vger.kernel.org>; Mon,  2 May 2022 11:59:00 -0700 (PDT)
Date:   Mon, 2 May 2022 20:58:56 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 0/3] nftables: add support for wildcard interfaces
Message-ID: <YnAp8E2JIjD8fm/6@salvia>
References: <20220429183239.5569-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429183239.5569-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Apr 29, 2022 at 08:32:36PM +0200, Florian Westphal wrote:
> First patch is needed so kernel doesn't think end is before start,
> second patch allows to dump "x .foo*" correctly, without this
> nft tries to represent the start/end "name" with a range.
> This doesn't work well because end range uses \ff padding.
> 
> Patch 3 adds tests.

LGTM, thanks
