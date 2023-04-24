Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AC56DF655
	for <lists+netfilter-devel@lfdr.de>; Wed, 12 Apr 2023 15:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjDLNBZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 12 Apr 2023 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjDLNBY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:01:24 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF14697
        for <netfilter-devel@vger.kernel.org>; Wed, 12 Apr 2023 06:01:23 -0700 (PDT)
Date:   Wed, 12 Apr 2023 14:54:15 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nftables 8/8] test: py: add tests for shifted nat
 port-ranges
Message-ID: <ZDap93NxS3SQIu9E@calendula>
References: <20230305101418.2233910-1-jeremy@azazel.net>
 <20230305101418.2233910-9-jeremy@azazel.net>
 <20230324225904.GB17250@breakpoint.cc>
 <ZDUaIa0N2R1Ay7o/@calendula>
 <20230411123604.GF21051@breakpoint.cc>
 <ZDaUi172jznQL5l9@calendula>
 <20230412114351.GA2135@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412114351.GA2135@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 12, 2023 at 01:43:51PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > I think my proposal provides a simple way to support this, it just a
> > new flag in the NAT engine, few lines to handle it and new userspace
> > code to handle -/+offset in a map.
> 
> Yes, thanks for clarifying this. I'm fine with your proposal.
> 
> I think it might even be possible to rework the iptables target
> (the only user of the current shift/offset infra) to work with
> the 'new' delta approach, to avoid cluttering the NAT engine with
> both appraoaches.

Agreed.

> > Your idea of doing it via payload + math is also good, but it would
> > just require more work to support this NAT port-shift feature in
> > userspace.
> 
> Indeed, its a lot more work.
>
> > Does this help clarify? I am talking about a completely different
> > design for this feature, not so iptablish.
> 
> Yes, it does.  Agree its better solution compared to the existing
> one.

OK, let's move on then :)
