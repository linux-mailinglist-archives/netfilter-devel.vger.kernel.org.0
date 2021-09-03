Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C84000E6
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Sep 2021 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhICOB4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Sep 2021 10:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhICOB4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:01:56 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD79C061575
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Sep 2021 07:00:56 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1mM9kS-0003qc-IO; Fri, 03 Sep 2021 16:00:52 +0200
Date:   Fri, 3 Sep 2021 16:00:52 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc:     netfilter-devel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH nf] netfilter: socket: icmp6: fix use-after-scope
Message-ID: <20210903140052.GC23554@breakpoint.cc>
References: <20210903132335.25355-1-benjamin.hesmans@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903132335.25355-1-benjamin.hesmans@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Benjamin Hesmans <benjamin.hesmans@tessares.net> wrote:
> Bug reported by KASAN:
> 
> BUG: KASAN: use-after-scope in inet6_ehashfn (net/ipv6/inet6_hashtables.c:40)
> Call Trace:
> (...)
> inet6_ehashfn (net/ipv6/inet6_hashtables.c:40)
> (...)
> nf_sk_lookup_slow_v6 (net/ipv6/netfilter/nf_socket_ipv6.c:91
> net/ipv6/netfilter/nf_socket_ipv6.c:146)

Similar construct in the branch above is fine because
sport and dport are copied (rather than passing pointer to address).

Reviewed-by: Florian Westphal <fw@strlen.de>
