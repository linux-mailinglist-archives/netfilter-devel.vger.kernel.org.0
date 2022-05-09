Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C2951F46A
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 May 2022 08:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiEIGY6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 May 2022 02:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiEIGUM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 May 2022 02:20:12 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB1362AC5B
        for <netfilter-devel@vger.kernel.org>; Sun,  8 May 2022 23:16:18 -0700 (PDT)
Date:   Mon, 9 May 2022 08:16:03 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Sven Auhagen <Sven.Auhagen@voleatech.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] nf_flowtable: nft_flow_route use more data for reverse
 route
Message-ID: <Ynixo9mxKqMbq3Ie@salvia>
References: <20220427071515.qfgqbs6uzoowwnkg@SvensMacbookPro.hq.voleatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220427071515.qfgqbs6uzoowwnkg@SvensMacbookPro.hq.voleatech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:15:15AM +0200, Sven Auhagen wrote:
> When creating a flow table entry, the reverse route is looked
> up based on the current packet.
> There can be scenarios where the user creates a custom ip rule
> to route the traffic differently.
> In order to support those scenarios, the lookup needs to add
> more information based on the current packet.
> The patch adds multiple new information to the route lookup.

Applied, thanks
