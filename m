Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9B6294C2
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Nov 2022 10:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbiKOJrk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Nov 2022 04:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbiKOJrb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:47:31 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFE1D1FFBF
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Nov 2022 01:47:28 -0800 (PST)
Date:   Tue, 15 Nov 2022 10:47:28 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH nf-next] netfilter: conntrack: add __force annotation to
 silence harmless warning
Message-ID: <Y3NgMP/3llw6vJMP@salvia>
References: <20221114104841.29891-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221114104841.29891-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Nov 14, 2022 at 11:48:41AM +0100, Florian Westphal wrote:
> nf_conntrack_core.c:222:14: sparse: cast from restricted __be16
> nf_conntrack_core.c:222:55: sparse: restricted __be16 degrades to integer
> 
> no need to convert anything, just add __force to silence the warning.

Squashed into original patch, thanks
