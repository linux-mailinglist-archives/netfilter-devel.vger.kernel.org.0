Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542A65ABF2C
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Sep 2022 15:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiICNyv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 3 Sep 2022 09:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiICNyt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:54:49 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8777913D11
        for <netfilter-devel@vger.kernel.org>; Sat,  3 Sep 2022 06:54:48 -0700 (PDT)
Date:   Sat, 3 Sep 2022 15:54:43 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] json: add table map statement support
Message-ID: <YxNco/Ts3RkmrKSM@salvia>
References: <20220902105204.36066-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220902105204.36066-1-ffmancera@riseup.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 02, 2022 at 12:52:04PM +0200, Fernando Fernandez Mancera wrote:
> When listing a map with statements with JSON support, the statement list were
> ignored.
> 
> Output example:
> 
> {
>   "map": {
>     "family": "ip",
>     "name": "m",
>     "table": "t",
>     "type": "ipv4_addr",
>     "handle": 1,
>     "map": "mark",
>     "stmt": [
>       {
>         "counter": {
>           "packets": 0,
>           "bytes": 0
>         }
>       }
>     ]
>   }
> }

Applied, thanks
