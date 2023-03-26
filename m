Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3776C97C5
	for <lists+netfilter-devel@lfdr.de>; Sun, 26 Mar 2023 22:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCZUjs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 26 Mar 2023 16:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZUjq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:39:46 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E66A5FD4
        for <netfilter-devel@vger.kernel.org>; Sun, 26 Mar 2023 13:39:45 -0700 (PDT)
Date:   Sun, 26 Mar 2023 22:39:42 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nftables 8/8] test: py: add tests for shifted nat
 port-ranges
Message-ID: <ZCCtjm1rgpa5Z+Sr@salvia>
References: <20230305101418.2233910-1-jeremy@azazel.net>
 <20230305101418.2233910-9-jeremy@azazel.net>
 <20230324225904.GB17250@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324225904.GB17250@breakpoint.cc>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:59:04PM +0100, Florian Westphal wrote:
> Jeremy Sowden <jeremy@azazel.net> wrote:
> > +ip daddr 10.0.0.1 tcp dport 55900-55910 dnat ip to 192.168.127.1:5900-5910/55900;ok
> > +ip6 daddr 10::1 tcp dport 55900-55910 dnat ip6 to [::c0:a8:7f:1]:5900-5910/55900;ok
> 
> This syntax is horrible (yes, I know, xtables fault).
> 
> Do you think this series could be changed to grab the offset register from the
> left edge of the range rather than requiring the user to specify it a
> second time?  Something like:
> 
> ip daddr 10.0.0.1 tcp dport 55900-55910 dnat ip to 192.168.127.1:5900-5910
> 
> I'm open to other suggestions of course.

Not only syntax, main problema is that this port shift support has to
work with NAT maps, otherwise this needs N rules for different
mappings which takes us back to linear rule inspection.

Jeremy, may I suggest you pick up on the bitwise _SREG2 support?
I will post a v4 with small updates for ("mark statement support for
non-constant expression") tomorrow. Probably you don't need the new
AND and OR operations for this? Only the a new _SREG2 to specify that
input comes from non-constant?
