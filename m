Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D8105B51
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 21:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKUUqQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 15:46:16 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:56076 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfKUUqQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:46:16 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iXtLA-0007UW-78; Thu, 21 Nov 2019 21:46:12 +0100
Date:   Thu, 21 Nov 2019 21:46:12 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Stefano Brivio <sbrivio@redhat.com>, Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org,
        Kadlecsik =?iso-8859-15?Q?J=F3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Jay Ligatti <ligatti@usf.edu>,
        Ori Rottenstreich <or@cs.technion.ac.il>,
        Kirill Kogan <kirill.kogan@gmail.com>
Subject: Re: [PATCH nf-next 8/8] nft_set_pipapo: Introduce AVX2-based lookup
 implementation
Message-ID: <20191121204612.GM20235@breakpoint.cc>
References: <cover.1574119038.git.sbrivio@redhat.com>
 <367e77e2a0097a0c1b715919b8d21f7a51a10429.1574119038.git.sbrivio@redhat.com>
 <20191120151653.GD20235@breakpoint.cc>
 <20191120160800.GN8016@orbyte.nwl.cc>
 <20191121205510.0068551b@redhat.com>
 <20191121202232.e6enl4ck7ynjekty@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121202232.e6enl4ck7ynjekty@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Probably, at some point we can start exposing knobs, but I'd rather
> see a bit more discussions on how to provide a good autotuning. By
> exposing all knobs, then such discussion might not ever happen?

My remarks were not aimed at exposing knobs but to provide some
debugging aid.

Say e.g. there is a bug in the avx implementation that isn't present
in the C version, or vice versa.  Or in rhashtable but not hashtable.

Right now it requires some guesswork to figure out what set backend is
actually used for @myset, and it might make things easier for debugging
if one could query the kernel for some information wrt. what set backend
is used.  I would try to avoid to expose anything that can't be ripped
out again, so e.g. names or even just %pF of ->lookup() would perhaps be
enough.
