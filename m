Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0B22219
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 May 2019 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfERHga (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 May 2019 03:36:30 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:57980 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbfERHga (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 May 2019 03:36:30 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hRttM-0002cd-3I; Sat, 18 May 2019 09:36:28 +0200
Date:   Sat, 18 May 2019 09:36:28 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Refcounts in libnftnl?
Message-ID: <20190518073628.GH4851@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi!

Probably the best way to fix for the segfaults caused by Florian's cache
rebuild logic in iptables-nft is to introduce reference counts so we
don't have to care about whether a given object is present only in cache
or also in a batch job.

Unlike nftables, iptables-nft code uses libnftnl data structures instead
of its own ones.

I wonder if it is OK to add refcounts to libnftnl types instead of
implementing wrapper structures for everything in iptables-nft. What do
you think?

Cheers, Phil
