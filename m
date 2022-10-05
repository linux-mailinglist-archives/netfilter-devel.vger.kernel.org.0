Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9962B5F5CEF
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Oct 2022 00:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJEWxg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Oct 2022 18:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJEWxg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:53:36 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F7E82B63A
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Oct 2022 15:53:30 -0700 (PDT)
Date:   Thu, 6 Oct 2022 00:53:27 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 2/2] src: add ipip support
Message-ID: <Yz4K58ugmtD/U7gD@salvia>
References: <20221005224833.24056-1-pablo@netfilter.org>
 <20221005224833.24056-3-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221005224833.24056-3-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 06, 2022 at 12:48:33AM +0200, Pablo Neira Ayuso wrote:
> This generates an implicit dependency on NFT_META_L4PROTO for IPPROTO_IP.

s/IPPROTO_IP/IPPROTO_IPIP

> This does _not_ generate a dependendy for NFT_META_PROTOCOL on 0x800 (ip)
> because the tunnel protocol driver "ip6tnl" in the tree uses IPPROTO_IP

again:

s/IPPROTO_IP/IPPROTO_IPIP

> for IPv4 over IPv6 (ipip6).
