Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0164F3D8F
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Apr 2022 22:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiDEOI6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Apr 2022 10:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381431AbiDEMya (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:54:30 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F15F2A25E
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Apr 2022 04:58:27 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 27F3F60196;
        Tue,  5 Apr 2022 13:54:48 +0200 (CEST)
Date:   Tue, 5 Apr 2022 13:58:24 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] meta time: use uint64_t instead of time_t
Message-ID: <Ykwu4PnorVaAG1Op@salvia>
References: <20220405101016.855221490@web.de>
 <20220405101026.867817071@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220405101026.867817071@web.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:41:14AM +0000, Lukas Straub wrote:
> time_t may be 32 bit on some platforms and thus can't fit a timestamp
> with nanoseconds resolution. This causes overflows and ultimatively
> breaks meta time expressions on such platforms.
> 
> Fix this by using uint64_t instead.

Applied, thanks
