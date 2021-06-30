Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22D3B86AB
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Jun 2021 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhF3QBy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Jun 2021 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbhF3QBC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:01:02 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A87C0613A3
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Jun 2021 08:58:28 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lycba-0001ju-KM; Wed, 30 Jun 2021 17:58:26 +0200
Date:   Wed, 30 Jun 2021 17:58:26 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Eric Garver <e@erig.me>
Subject: Re: [PATCH nft v2 1/3] netlink_delinearize: add missing icmp
 id/sequence support
Message-ID: <20210630155826.GE18022@breakpoint.cc>
References: <20210615160151.10594-1-fw@strlen.de>
 <20210615160151.10594-2-fw@strlen.de>
 <20210630151319.GZ3673@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630151319.GZ3673@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Eric reported a testcase in which this patch seems to cause a segfault
> (bisected). The test is as simple as:

I've pushed fix and a test case.
