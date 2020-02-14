Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459A415EF49
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 Feb 2020 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389270AbgBNRqt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 14 Feb 2020 12:46:49 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:40622 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389254AbgBNQCJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:02:09 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1j2dPq-0002xp-75; Fri, 14 Feb 2020 17:02:06 +0100
Date:   Fri, 14 Feb 2020 17:02:06 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Kadlecsik =?utf-8?Q?J=C3=B3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>
Subject: Re: [PATCH nft v5] tests: Introduce test for set with concatenated
 ranges
Message-ID: <20200214160206.GQ20005@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Stefano Brivio <sbrivio@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Kadlecsik =?utf-8?Q?J=C3=B3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>
References: <546dccfe97760ba910676b84799b15d38164e192.1581693171.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546dccfe97760ba910676b84799b15d38164e192.1581693171.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 14, 2020 at 04:27:25PM +0100, Stefano Brivio wrote:
> This test checks that set elements can be added, deleted, that
> addition and deletion are refused when appropriate, that entries
> time out properly, and that they can be fetched by matching values
> in the given ranges.
> 
> v5:
>  - speed this up by performing the timeout test for one single
>    permutation (Phil Sutter), by decreasing the number of
>    permutations from 96 to 12 if this is invoked by run-tests.sh
>    (Pablo Neira Ayuso) and by combining some commands into single
>    nft calls where possible: with dash 0.5.8 on AMD Epyc 7351 the
>    test now takes 1.8s instead of 82.5s
>  - renumber test to 0043, 0042 was added meanwhile
> v4: No changes
> v3:
>  - renumber test to 0042, 0041 was added meanwhile
> v2:
>  - actually check an IPv6 prefix, instead of specifying everything
>    as explicit ranges in ELEMS_ipv6_addr
>  - renumber test to 0041, 0038 already exists
> 
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>

Acked-by: Phil Sutter <phil@nwl.cc>

Thanks!
