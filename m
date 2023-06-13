Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F9172D6B0
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Jun 2023 03:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjFMBDW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Jun 2023 21:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjFMBDU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:03:20 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5852F101
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Jun 2023 18:03:19 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 7118258765BCB; Tue, 13 Jun 2023 03:03:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 6DD7160C594EF;
        Tue, 13 Jun 2023 03:03:17 +0200 (CEST)
Date:   Tue, 13 Jun 2023 03:03:17 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH xtables-addons] xt_ipp2p: change text-search algo to
 KMP
In-Reply-To: <20230612173133.795980-1-jeremy@azazel.net>
Message-ID: <0n5793p-s419-3n8q-r29p-57nspn92s981@vanv.qr>
References: <20230612173133.795980-1-jeremy@azazel.net>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Monday 2023-06-12 19:31, Jeremy Sowden wrote:

>The kernel's Boyer-Moore text-search implementation may miss matches in
>non-linear skb's, so use Knuth-Morris-Pratt instead.

Applied
