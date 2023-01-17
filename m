Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA02A66DCD3
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Jan 2023 12:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbjAQLsN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Jan 2023 06:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbjAQLsM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:48:12 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B321F32E5A
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Jan 2023 03:48:11 -0800 (PST)
Date:   Tue, 17 Jan 2023 12:48:08 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Long Xin <lxin@redhat.com>,
        Claudio Porfiri <claudio.porfiri@ericsson.com>
Subject: Re: [PATCH 2/3] netfilter: conntrack: fix bug in for_each_sctp_chunk
Message-ID: <Y8aK+OmsbeaYRhO9@salvia>
References: <20230116093556.9437-1-sriram.yagnaraman@est.tech>
 <20230116093556.9437-3-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230116093556.9437-3-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jan 16, 2023 at 10:35:55AM +0100, Sriram Yagnaraman wrote:
> skb_header_pointer() will return NULL if offset + sizeof(_sch) exceeds
> skb->len, so this offset < skb->len test is redundant.
> 
> if sch->length == 0, this will end up in an infinite loop, add a check
> for sch->length > 0

If this is broken since the beginning, then:

Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")

is sufficiently old for -stable kernels to pick up this.

Let me know if this looks good to you, thanks
