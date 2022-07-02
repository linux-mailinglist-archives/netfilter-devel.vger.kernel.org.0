Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379B5563DB5
	for <lists+netfilter-devel@lfdr.de>; Sat,  2 Jul 2022 04:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiGBCTw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 1 Jul 2022 22:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGBCTv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 1 Jul 2022 22:19:51 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 634A0205F9
        for <netfilter-devel@vger.kernel.org>; Fri,  1 Jul 2022 19:19:50 -0700 (PDT)
Date:   Sat, 2 Jul 2022 04:19:47 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_set_pipapo: release elements in clone
 from abort path
Message-ID: <Yr+rQ3pKsQBjJAep@salvia>
References: <20220628164527.101413-1-pablo@netfilter.org>
 <20220702003928.1ae75aaa@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220702003928.1ae75aaa@elisabeth>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jul 02, 2022 at 12:39:28AM +0200, Stefano Brivio wrote:
[...]
> Other than that, it looks good to me.
> 
> I would also specify in the commit message that we additionally look
> for elements pointers in the cloned matching data if priv->dirty is
> set, because that means that cloned data might point to additional
> elements we didn't commit to the working copy yet (such as the abort
> path case, but perhaps not limited to it).

This v2, I forgot to tag it properly:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20220702021631.796822-2-pablo@netfilter.org/

it is updating documentation and it also adds a paragraph to the
commit description as you suggested.
