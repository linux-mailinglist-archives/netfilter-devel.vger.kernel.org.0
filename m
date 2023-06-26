Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737E473E302
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jun 2023 17:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjFZPQN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Jun 2023 11:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjFZPQM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:16:12 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C6EC10DC
        for <netfilter-devel@vger.kernel.org>; Mon, 26 Jun 2023 08:16:07 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:16:03 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nf v2] lib/ts_bm: reset initial match offset for every
 block of text
Message-ID: <ZJmrs+G4mNuoVnMs@calendula>
References: <20230619190657.1905910-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230619190657.1905910-1-jeremy@azazel.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 19, 2023 at 08:06:57PM +0100, Jeremy Sowden wrote:
> The `shift` variable which indicates the offset in the string at which
> to start matching the pattern is initialized to `bm->patlen - 1`, but it
> is not reset when a new block is retrieved.  This means the implemen-
> tation may start looking at later and later positions in each successive
> block and miss occurrences of the pattern at the beginning.  E.g.,
> consider a HTTP packet held in a non-linear skb, where the HTTP request
> line occurs in the second block:
> 
>   [... 52 bytes of packet headers ...]
>   GET /bmtest HTTP/1.1\r\nHost: www.example.com\r\n\r\n
> 
> and the pattern is "GET /bmtest".
> 
> Once the first block comprising the packet headers has been examined,
> `shift` will be pointing to somewhere near the end of the block, and so
> when the second block is examined the request line at the beginning will
> be missed.
> 
> Reinitialize the variable for each new block.

Applied to nf.git, thanks
