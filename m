Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5687056C9DE
	for <lists+netfilter-devel@lfdr.de>; Sat,  9 Jul 2022 16:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGIORg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 9 Jul 2022 10:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIORf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:17:35 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80BE7CE32
        for <netfilter-devel@vger.kernel.org>; Sat,  9 Jul 2022 07:17:34 -0700 (PDT)
Date:   Sat, 9 Jul 2022 16:17:30 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf,v2 1/2] netfilter: nf_tables: release element key when
 parser fails
Message-ID: <YsmN+h5c6OazXBgn@salvia>
References: <20220708100633.18896-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220708100633.18896-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 08, 2022 at 12:06:32PM +0200, Pablo Neira Ayuso wrote:
> Call nft_data_release() to release the element keys otherwise this
> might leak chain reference counter.
> 
> Fixes: 7b225d0b5c6d ("netfilter: nf_tables: add NFTA_SET_ELEM_KEY_END attribute")
> Fixes: ba0e4d9917b4 ("netfilter: nf_tables: get set elements via netlink")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> v2: coalesce two similar patches:
>     https://patchwork.ozlabs.org/project/netfilter-devel/patch/20220708084453.11066-1-pablo@netfilter.org/
>     https://patchwork.ozlabs.org/project/netfilter-devel/patch/20220708085805.12310-1-pablo@netfilter.org/

Scratch this. nft_data_release() is noop for NFT_DATA_VERDICT case.
Calling this is good for consistency, but let's schedule this patch
for nf-next instead.
