Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C360CB3F
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Oct 2022 13:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiJYLtR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Oct 2022 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiJYLtP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:49:15 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70E09181979
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Oct 2022 04:49:15 -0700 (PDT)
Date:   Tue, 25 Oct 2022 13:49:07 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_tables: reduce nft_pktinfo by 8
 bytes
Message-ID: <Y1fNM14tTqacKOGM@salvia>
References: <20221014222050.26304-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221014222050.26304-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Oct 15, 2022 at 12:20:50AM +0200, Florian Westphal wrote:
> structure is reduced from 32 to 24 bytes.  While at it, also check
> that iphdrlen is sane, this is guaranteed for NFPROTO_IPV4 but not
> for ingress or bridge, so add checks for this.

Applied to nf-next, thanks
