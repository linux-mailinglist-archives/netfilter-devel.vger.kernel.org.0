Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031D7288C62
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Oct 2020 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbgJIPQt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 9 Oct 2020 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387978AbgJIPQt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:16:49 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094FC0613D2
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Oct 2020 08:16:48 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kQu8T-00058w-7i; Fri, 09 Oct 2020 17:16:45 +0200
Date:   Fri, 9 Oct 2020 17:16:45 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] libiptc: Avoid gcc-10 zero-length array warning
Message-ID: <20201009151645.GM13016@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Jan Engelhardt <jengelh@inai.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20201008130116.25798-1-phil@nwl.cc>
 <s95qopq1-3o5o-oo9-1qso-osp024914p67@vanv.qr>
 <20201008145822.GA13016@orbyte.nwl.cc>
 <q9379q5-3n1-p1r-1ro4-n5q2r086574q@vanv.qr>
 <20201008160714.GB13016@orbyte.nwl.cc>
 <9437p77p-4rp3-q1rn-745q-9267q7osor7s@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9437p77p-4rp3-q1rn-745q-9267q7osor7s@vanv.qr>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 08, 2020 at 06:46:40PM +0200, Jan Engelhardt wrote:
> On Thursday 2020-10-08 18:07, Phil Sutter wrote:
> >> iptables does not rely or even do such embedding nonsense. When we
> >> have a flexible array member T x[0] or T x[] somewhere, we really do
> >> mean that Ts follow, not some Us like in the RDMA case.
> >
> >In fact, struct ipt_replace has a zero-length array as last field of
> >type struct ipt_entry which in turn has a zero-length array as last
> >field. :)
> 
> In the RDMA thread, I was informed that the trailing members' only
> purpose is to serve as something of a shorthand:
> 
> Shortcut:
> 	struct ipt_entry *e = replace->elements;
> The long way:
> 	struct ipt_entry *e = (void *)((char *)replace + sizeof(*replace));
> 
> But such gritty detail is often stowed away in some nice accessor
> functions or macros. That's what's currently missing in spots
> apprently.
> 
> 	struct ipt_entry *next = get_next_blah(replace);
> 
> Then the get_next can do that arithmetic, we won't need
> ipt_replace::elements, and could do away with the flexible array
> member altogether, especially when it's not used with equal-sized
> elements, and ipt_entry is of variadic size.

Since this is UAPI though, we can't get rid of the problematic fields,
no?

Cheers, Phil
