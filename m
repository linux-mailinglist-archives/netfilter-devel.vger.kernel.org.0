Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA46E581420
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Jul 2022 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiGZN1J (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Jul 2022 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiGZN1J (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:27:09 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A9283A6
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Jul 2022 06:27:04 -0700 (PDT)
Date:   Tue, 26 Jul 2022 15:26:58 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Domingo Dirutigliano <pwnzer0tt1@proton.me>
Subject: Re: [PATCH nf] netfilter: nf_queue: do not allow packet truncation
 below transport header offset
Message-ID: <Yt/roiIPwtTFbVXk@salvia>
References: <20220726104206.2036-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220726104206.2036-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:42:06PM +0200, Florian Westphal wrote:
> Domingo Dirutigliano and Nicola Guerrera report kernel panic when
> sending nf_queue verdict with 1-byte nfta_payload attribute.
> 
> The IP/IPv6 stack pulls the IP(v6) header from the packet after the
> input hook.
> 
> If user truncates the packet below the header size, this skb_pull() will
> result in a malformed skb (skb->len < 0).
> 
> Fixes: 7af4cc3fa158 ("[NETFILTER]: Add "nfnetlink_queue" netfilter queue handler over nfnetlink")
> Reported-by: Domingo Dirutigliano <pwnzer0tt1@proton.me>

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

> Signed-off-by: Florian Westphal <fw@strlen.de>
