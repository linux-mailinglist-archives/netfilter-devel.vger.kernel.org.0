Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BD624E3C4
	for <lists+netfilter-devel@lfdr.de>; Sat, 22 Aug 2020 01:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHUXGZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Aug 2020 19:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHUXGY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:06:24 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC66C061573
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Aug 2020 16:06:23 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1k9G6x-0007CQ-Nj; Sat, 22 Aug 2020 01:06:15 +0200
Date:   Sat, 22 Aug 2020 01:06:15 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: nfnetlink: Busy-loop in nfnetlink_rcv_msg()
Message-ID: <20200821230615.GW23632@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

Starting firewalld with two active zones in an lxc container provokes a
situation in which nfnetlink_rcv_msg() loops indefinitely, because
nc->call_rcu() (nf_tables_getgen() in this case) returns -EAGAIN every
time.

I identified netlink_attachskb() as the originator for the above error
code. The conditional leading to it looks like this:

| if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
|      test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
|         [...]
|         if (!*timeo) {

*timeo is zero, so this seems to be a non-blocking socket. Both
NETLINK_S_CONGESTED bit is set and sk->sk_rmem_alloc exceeds
sk->sk_rcvbuf.

From user space side, firewalld seems to simply call sendto() and the
call never returns.

How to solve that? I tried to find other code which does the same, but I
haven't found one that does any looping. Should nfnetlink_rcv_msg()
maybe just return -EAGAIN to the caller if it comes from call_rcu
backend?

This happening only in an lxc container may be due to some setsockopt()
calls not being allowed. In particular, setsockopt(SO_RCVBUFFORCE)
returns EPERM.

The value of sk_rcvbuf is 425984, BTW. sk_rmem_alloc is 426240. In user
space, I see a call to setsockopt(SO_RCVBUF) with value 4194304. No idea
if this is related and how.

Cheers, Phil
