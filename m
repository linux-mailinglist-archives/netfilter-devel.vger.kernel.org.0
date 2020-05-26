Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFBC1BFF00
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2020 16:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgD3OrT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Apr 2020 10:47:19 -0400
Received: from correo.us.es ([193.147.175.20]:52960 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgD3OrT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:47:19 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A18AFDA714
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2020 16:47:17 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8F379B7FF7
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2020 16:47:17 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 84B09DA736; Thu, 30 Apr 2020 16:47:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1C80CB7FFA;
        Thu, 30 Apr 2020 16:47:15 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 30 Apr 2020 16:47:15 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 01C2842EFB83;
        Thu, 30 Apr 2020 16:47:14 +0200 (CEST)
Date:   Thu, 30 Apr 2020 16:47:14 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] rule: memleak in __do_add_setelems()
Message-ID: <20200430144714.GA1454@salvia>
References: <20200430121845.10388-1-pablo@netfilter.org>
 <20200430130820.GA11056@salvia>
 <20200430135217.GJ15009@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430135217.GJ15009@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 30, 2020 at 03:52:17PM +0200, Phil Sutter wrote:
> Hi Pablo,
> 
> On Thu, Apr 30, 2020 at 03:08:20PM +0200, Pablo Neira Ayuso wrote:
> > On Thu, Apr 30, 2020 at 02:18:45PM +0200, Pablo Neira Ayuso wrote:
> > > This patch invokes interval_map_decompose() with named sets:
> > > 
> > > ==3402== 2,352 (128 direct, 2,224 indirect) bytes in 1 blocks are definitely lost in loss record 9 of 9
> > > ==3402==    at 0x483577F: malloc (vg_replace_malloc.c:299)
> > > ==3402==    by 0x48996A8: xmalloc (utils.c:36)
> > > ==3402==    by 0x4899778: xzalloc (utils.c:65)
> > > ==3402==    by 0x487CB46: expr_alloc (expression.c:45)
> > > ==3402==    by 0x487E2A0: mapping_expr_alloc (expression.c:1140)
> > > ==3402==    by 0x4898AA8: interval_map_decompose (segtree.c:1095)
> > > ==3402==    by 0x4872BDF: __do_add_setelems (rule.c:1569)
> > > ==3402==    by 0x4872BDF: __do_add_setelems (rule.c:1559)
> > > ==3402==    by 0x4877936: do_command (rule.c:2710)
> > > ==3402==    by 0x489F1CB: nft_netlink.isra.5 (libnftables.c:42)
> > > ==3402==    by 0x489FB07: nft_run_cmd_from_filename (libnftables.c:508)
> > > ==3402==    by 0x10A9AA: main (main.c:455)
> > > 
> > > Fixes: dd44081d91ce ("segtree: Fix add and delete of element in same batch")
> > 
> > This fixes the problem for anonymous sets, still named sets are
> > showing a memleak.
> 
> The change is strange: My fix (dd44081d91ce) was about anonymous sets.

It was about named sets, right?

# nft 'add element t s { 22-25 }; delete element t s { 22-25 }'

I think the cache update is still not needed for anonymous sets, even
if this was not the right fix indeed.

> Since you make the added code apply to non-anonymous sets only, I would
> expect for my testcase to start failing again (I didn't test it,
> though).
> 
> Are we maybe missing a free() somewhere instead?

I think I found the root cause:

https://marc.info/?l=netfilter-devel&m=158825784609307&w=2
