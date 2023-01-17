Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A74E66E1F2
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Jan 2023 16:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjAQPUM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Jan 2023 10:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjAQPTu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:19:50 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6DFD3FF0A
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Jan 2023 07:19:49 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:19:46 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, sbrivio@redhat.com
Subject: Re: [PATCH nf,v2 1/2] netfilter: nft_set_rbtree: Switch to node list
 walk for overlap detection
Message-ID: <Y8a8kkCJZlG58kWB@salvia>
References: <20230117112800.52379-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230117112800.52379-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jan 17, 2023 at 12:27:59PM +0100, Pablo Neira Ayuso wrote:
[...]
> Otherwise, with large sets, starting from rb_first() is slow (it takes
> 30s if I use rb_first() instead of this approach), because of the linear
> list walk.

This should be instead:

        Otherwise, with large sets, starting from rb_first() is slow (it takes
        30s if I use rb_first() instead of 3s), because of the linear list
        walk.

so it is 3 seconds with the speed up vs. 30 seconds starting from rb_first().
