Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51AC666283
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Jan 2023 19:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAKSJP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Jan 2023 13:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbjAKSIl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:08:41 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC231DDCB
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Jan 2023 10:08:21 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pFfWM-0005JB-9S; Wed, 11 Jan 2023 19:08:18 +0100
Date:   Wed, 11 Jan 2023 19:08:18 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [libnetfilter_conntrack PATCH] conntrack: increase the length of
 `l4proto_map`
Message-ID: <20230111180818.GD27644@breakpoint.cc>
References: <20221223123806.2685611-1-jeremy@azazel.net>
 <Y7758rNEafF9XurG@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7758rNEafF9XurG@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Fri, Dec 23, 2022 at 12:38:06PM +0000, Jeremy Sowden wrote:
> > With addition of MPTCP `IPPROTO_MAX` is greater than 256, so extend the
> > array to account for the new upper bound.
> 
> Applied, thanks.
> 
> I don't expect we will ever see IPPROTO_MPTCP in this path though.
> To my understanding, this definition is targeted at the
> setsockopt/getsockopt() use-case. IP headers and the ctnetlink
> interface also assumes 8-bits protocol numbers.

Yes, this is an uapi thing:

socket(AF_INET, SOCK_STREAM, IPPROTO_TCP); vs.
socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);

Only second version results in a multipath-tcp aware socket.

If mptcp is active (both peers need to support it), tcp frames will
have an 'mptcp' option, but its still tcp (6) on wire.
