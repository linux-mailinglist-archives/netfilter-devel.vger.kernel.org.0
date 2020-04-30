Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746BF1BFCC0
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2020 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgD3NwX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Apr 2020 09:52:23 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40460 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbgD3NwW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:52:22 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jU9bt-0006I2-L8; Thu, 30 Apr 2020 15:52:17 +0200
Date:   Thu, 30 Apr 2020 15:52:17 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] rule: memleak in __do_add_setelems()
Message-ID: <20200430135217.GJ15009@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200430121845.10388-1-pablo@netfilter.org>
 <20200430130820.GA11056@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430130820.GA11056@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Thu, Apr 30, 2020 at 03:08:20PM +0200, Pablo Neira Ayuso wrote:
> On Thu, Apr 30, 2020 at 02:18:45PM +0200, Pablo Neira Ayuso wrote:
> > This patch invokes interval_map_decompose() with named sets:
> > 
> > ==3402== 2,352 (128 direct, 2,224 indirect) bytes in 1 blocks are definitely lost in loss record 9 of 9
> > ==3402==    at 0x483577F: malloc (vg_replace_malloc.c:299)
> > ==3402==    by 0x48996A8: xmalloc (utils.c:36)
> > ==3402==    by 0x4899778: xzalloc (utils.c:65)
> > ==3402==    by 0x487CB46: expr_alloc (expression.c:45)
> > ==3402==    by 0x487E2A0: mapping_expr_alloc (expression.c:1140)
> > ==3402==    by 0x4898AA8: interval_map_decompose (segtree.c:1095)
> > ==3402==    by 0x4872BDF: __do_add_setelems (rule.c:1569)
> > ==3402==    by 0x4872BDF: __do_add_setelems (rule.c:1559)
> > ==3402==    by 0x4877936: do_command (rule.c:2710)
> > ==3402==    by 0x489F1CB: nft_netlink.isra.5 (libnftables.c:42)
> > ==3402==    by 0x489FB07: nft_run_cmd_from_filename (libnftables.c:508)
> > ==3402==    by 0x10A9AA: main (main.c:455)
> > 
> > Fixes: dd44081d91ce ("segtree: Fix add and delete of element in same batch")
> 
> This fixes the problem for anonymous sets, still named sets are
> showing a memleak.

The change is strange: My fix (dd44081d91ce) was about anonymous sets.
Since you make the added code apply to non-anonymous sets only, I would
expect for my testcase to start failing again (I didn't test it,
though).

Are we maybe missing a free() somewhere instead?

Cheers, Phil
