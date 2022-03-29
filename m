Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110274EB54A
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Mar 2022 23:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiC2VaF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Mar 2022 17:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiC2VaE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:30:04 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 538ED398
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Mar 2022 14:28:20 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 76D8B63032;
        Tue, 29 Mar 2022 23:25:06 +0200 (CEST)
Date:   Tue, 29 Mar 2022 23:28:16 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnfnetlink PATCH 1/2] include: Silence gcc warning in
 linux_list.h
Message-ID: <YkN58F+wl/ugYF/6@salvia>
References: <20220325173426.11493-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325173426.11493-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 25, 2022 at 06:34:25PM +0100, Phil Sutter wrote:
> Compiler complained about empty prefetch() macro:
> 
> | ../include/linux_list.h:385:66: warning: right-hand operand of comma expression has no effect [-Wunused-value]
> |   385 |         for (pos = list_entry((head)->next, typeof(*pos), member),      \
> |       |                                                                  ^
> 
> Use nftables' variant instead which gcc seems to like more.

LGTM, thanks

> Fixes: 36d2ed3de20a3 ("major cleanup of index2name infrastructure: use linux list (and fix leak in the nlif_close path)")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
