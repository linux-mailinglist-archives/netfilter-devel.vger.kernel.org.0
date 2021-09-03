Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D9B400335
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Sep 2021 18:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhICQ0B (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Sep 2021 12:26:01 -0400
Received: from mail.netfilter.org ([217.70.188.207]:58728 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhICQ0A (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:26:00 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id BD454600A8;
        Fri,  3 Sep 2021 18:23:56 +0200 (CEST)
Date:   Fri, 3 Sep 2021 18:24:54 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc:     netfilter-devel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH nf] netfilter: socket: icmp6: fix use-after-scope
Message-ID: <20210903162454.GA13043@salvia>
References: <20210903132335.25355-1-benjamin.hesmans@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210903132335.25355-1-benjamin.hesmans@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 03, 2021 at 03:23:35PM +0200, Benjamin Hesmans wrote:
> Bug reported by KASAN:
> 
> BUG: KASAN: use-after-scope in inet6_ehashfn (net/ipv6/inet6_hashtables.c:40)
> Call Trace:
> (...)
> inet6_ehashfn (net/ipv6/inet6_hashtables.c:40)
> (...)
> nf_sk_lookup_slow_v6 (net/ipv6/netfilter/nf_socket_ipv6.c:91
> net/ipv6/netfilter/nf_socket_ipv6.c:146)
> 
> It seems that this bug has already been fixed by Eric Dumazet in the
> past in:
> commit 78296c97ca1f ("netfilter: xt_socket: fix a stack corruption bug")
> 
> But a variant of the same issue has been introduced in
> commit d64d80a2cde9 ("netfilter: x_tables: don't extract flow keys on early demuxed sks in socket match")
> 
> `daddr` and `saddr` potentially hold a reference to ipv6_var that is no
> longer in scope when the call to `nf_socket_get_sock_v6` is made.

Applied, thanks.
