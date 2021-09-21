Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99D412AB9
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Sep 2021 03:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhIUB5P (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Sep 2021 21:57:15 -0400
Received: from mail.netfilter.org ([217.70.188.207]:39598 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbhIUBtG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:49:06 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0325463EAA;
        Tue, 21 Sep 2021 03:46:18 +0200 (CEST)
Date:   Tue, 21 Sep 2021 03:47:32 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+f31660cf279b0557160c@syzkaller.appspotmail.com
Subject: Re: [PATCH nf] netfilter: nf_tables: unlink table before deleting it
Message-ID: <YUk5tHTsPmkqHK6E@salvia>
References: <000000000000a3958805cbdb8102@google.com>
 <20210913124233.16520-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913124233.16520-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 13, 2021 at 02:42:33PM +0200, Florian Westphal wrote:
> syzbot reports following UAF:
> BUG: KASAN: use-after-free in memcmp+0x18f/0x1c0 lib/string.c:955
>  nla_strcmp+0xf2/0x130 lib/nlattr.c:836
>  nft_table_lookup.part.0+0x1a2/0x460 net/netfilter/nf_tables_api.c:570
>  nft_table_lookup net/netfilter/nf_tables_api.c:4064 [inline]
>  nf_tables_getset+0x1b3/0x860 net/netfilter/nf_tables_api.c:4064
>  nfnetlink_rcv_msg+0x659/0x13f0 net/netfilter/nfnetlink.c:285
>  netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
> 
> Problem is that all get operations are lockless, so the commit_mutex
> held by nft_rcv_nl_event() isn't enough to stop a parallel GET request
> from doing read-accesses to the table object even after synchronize_rcu().
> 
> To avoid this, unlink the table first and store the table objects in
> on-stack scratch space.

Applied, thanks.
