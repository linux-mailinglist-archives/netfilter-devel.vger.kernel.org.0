Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE63651365
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Dec 2022 20:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiLSTlz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Dec 2022 14:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiLSTls (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:41:48 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9545613E8D
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Dec 2022 11:41:47 -0800 (PST)
Date:   Mon, 19 Dec 2022 20:41:44 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: Re: [PATCH nf,v2 4/4] netfilter: nf_tables: honor set timeout and
 garbage collection updates
Message-ID: <Y6C+eL5sXc6GT0Cg@salvia>
References: <20221219192844.212253-1-pablo@netfilter.org>
 <20221219192844.212253-5-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221219192844.212253-5-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Dec 19, 2022 at 08:28:44PM +0100, Pablo Neira Ayuso wrote:
> Set timeout and garbage collection interval updates are ignored on
> updates. Add transaction to update global set element timeout and
> garbage collection interval.

I posted an incomplete version of 4/4, I'll follow up with a new
version for this one.
