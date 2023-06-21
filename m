Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF273875B
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jun 2023 16:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjFUOmE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Jun 2023 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjFUOmC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:42:02 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB0C31BD2
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Jun 2023 07:41:55 -0700 (PDT)
Date:   Wed, 21 Jun 2023 16:41:50 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] src: avoid IPPROTO_MAX for array definitions
Message-ID: <ZJMMLq8MAw6VLq4N@calendula>
References: <20230620200836.22041-1-fw@strlen.de>
 <ZJIpBfHFHYj6PWfx@calendula>
 <20230621111815.GC24035@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230621111815.GC24035@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:18:15PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > On Tue, Jun 20, 2023 at 10:08:36PM +0200, Florian Westphal wrote:
> > > ip header can only accomodate 8but value, but IPPROTO_MAX has been bumped
> > > due to uapi reasons to support MPTCP (262, which is used to toggle on
> > > multipath support in tcp).
> > 
> > Maybe use IPPROTO_RAW + 1, hopefully that won't ever change.
> 
> If you don't like UINT8_MAX+1, would you be fine with open-coding, i.e.
> [256] ?

UINT8_MAX+1 is OK with me
