Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345254FAE8A
	for <lists+netfilter-devel@lfdr.de>; Sun, 10 Apr 2022 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiDJPjH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 10 Apr 2022 11:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiDJPjH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:39:07 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20189286E4
        for <netfilter-devel@vger.kernel.org>; Sun, 10 Apr 2022 08:36:57 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id C992560187;
        Sun, 10 Apr 2022 17:32:58 +0200 (CEST)
Date:   Sun, 10 Apr 2022 17:36:54 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH nf] netfilter: nft_socket: make cgroup match work in
 input too
Message-ID: <YlL5lu/FFXOHNJ0V@salvia>
References: <20220409112019.12113-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220409112019.12113-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Apr 09, 2022 at 01:20:19PM +0200, Florian Westphal wrote:
> cgroupv2 helper function ignores the already-looked up sk
> and uses skb->sk instead.
> 
> Just pass sk from the calling function instead; this will
> make cgroup matching work for udp and tcp in input even when
> edemux did not set skb->sk already.

Fixes: e0bb96db96f8 ("netfilter: nft_socket: add support for cgroupsv2")

> Cc: Topi Miettinen <toiwoton@gmail.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>
