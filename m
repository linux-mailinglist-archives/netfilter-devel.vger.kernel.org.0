Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4127103E1C
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Nov 2019 16:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfKTPQ5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 Nov 2019 10:16:57 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:48366 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbfKTPQ5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:16:57 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iXRiv-00064q-No; Wed, 20 Nov 2019 16:16:53 +0100
Date:   Wed, 20 Nov 2019 16:16:53 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Kadlecsik =?iso-8859-15?Q?J=F3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>, Phil Sutter <phil@nwl.cc>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Jay Ligatti <ligatti@usf.edu>,
        Ori Rottenstreich <or@cs.technion.ac.il>,
        Kirill Kogan <kirill.kogan@gmail.com>
Subject: Re: [PATCH nf-next 8/8] nft_set_pipapo: Introduce AVX2-based lookup
 implementation
Message-ID: <20191120151653.GD20235@breakpoint.cc>
References: <cover.1574119038.git.sbrivio@redhat.com>
 <367e77e2a0097a0c1b715919b8d21f7a51a10429.1574119038.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367e77e2a0097a0c1b715919b8d21f7a51a10429.1574119038.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Stefano Brivio <sbrivio@redhat.com> wrote:
> If the AVX2 set is available, we can exploit the repetitive
> characteristic of this algorithm to provide a fast, vectorised
> version by using 256-bit wide AVX2 operands for bucket loads and
> bitwise intersections.
> 
> In most cases, this implementation consistently outperforms rbtree
> set instances despite the fact they are configured to use a given,
> single, ranged data type out of the ones used for performance
> measurements by the nft_concat_range.sh kselftest.

I think in that case it makes sense to remove rbtree once this new
set type has had some upstream exposure and let pipapo handle the
range sets.

Stefano, if I understand this right then we could figure out which
implementation (C or AVX) is used via "grep avx2 /proc/cpuinfo".

If not, I think we might want to expose some additional debug info
on set dumps.
