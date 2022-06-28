Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8441555EA74
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jun 2022 19:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiF1RCs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jun 2022 13:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiF1RCW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:02:22 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E30E286DE
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jun 2022 10:01:55 -0700 (PDT)
Date:   Tue, 28 Jun 2022 19:01:49 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: avoid skb access on nf_stolen
Message-ID: <Yrsz88r5osn6nirQ@salvia>
References: <20220622144357.20162-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622144357.20162-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:43:57PM +0200, Florian Westphal wrote:
> When verdict is NF_STOLEN, the skb might have been freed.
> 
> When tracing is enabled, this can result in a use-after-free:
> 1. access to skb->nf_trace
> 2. access to skb->mark
> 3. computation of trace id
> 4. dump of packet payload
> 
> To avoid 1, keep a cached copy of skb->nf_trace in the
> trace state struct.
> Refresh this copy whenever verdict is != STOLEN.
> 
> Avoid 2 by skipping skb->mark access if verdict is STOLEN.
> 
> 3 is avoided by precomputing the trace id.
> 
> Only dump the packet when verdict is not "STOLEN".

Applied, thanks
