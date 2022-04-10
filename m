Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398644FAE6E
	for <lists+netfilter-devel@lfdr.de>; Sun, 10 Apr 2022 17:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbiDJPW5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 10 Apr 2022 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDJPW4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:22:56 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA759FD03
        for <netfilter-devel@vger.kernel.org>; Sun, 10 Apr 2022 08:20:45 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 7813563045;
        Sun, 10 Apr 2022 17:16:47 +0200 (CEST)
Date:   Sun, 10 Apr 2022 17:20:42 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Martin Gignac <martin.gignac@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: py: Add meta time tests without 'meta' keyword
Message-ID: <YlL1yuSN6cFbK3SN@salvia>
References: <6251829e.xNu4VrF13GQsRBbt%martin.gignac@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6251829e.xNu4VrF13GQsRBbt%martin.gignac@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Apr 09, 2022 at 08:57:02AM -0400, Martin Gignac wrote:
> v1.0.2 of 'nft' fails on 'time < "2022-07-01 11:00:00"' but succeeds
> when 'meta' is specified ('meta time < "2022-07-01 11:00:00"'). This
> extends coverage by testing 'time' without 'meta'.

Applied, thanks.

I extended it to cover the json codebase too (./nft-test -j).
