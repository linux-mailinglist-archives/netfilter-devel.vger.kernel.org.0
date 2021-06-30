Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7C3B8777
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Jun 2021 19:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhF3RPT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Jun 2021 13:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhF3RPS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:15:18 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A85AC061756
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Jun 2021 10:12:49 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1lydlW-0002rQ-Ag; Wed, 30 Jun 2021 19:12:46 +0200
Date:   Wed, 30 Jun 2021 19:12:46 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Eric Garver <e@erig.me>
Subject: Re: [PATCH nft v2 1/3] netlink_delinearize: add missing icmp
 id/sequence support
Message-ID: <20210630171246.GA3673@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>, Eric Garver <e@erig.me>
References: <20210615160151.10594-1-fw@strlen.de>
 <20210615160151.10594-2-fw@strlen.de>
 <20210630151319.GZ3673@orbyte.nwl.cc>
 <20210630155826.GE18022@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630155826.GE18022@breakpoint.cc>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hey,

On Wed, Jun 30, 2021 at 05:58:26PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Eric reported a testcase in which this patch seems to cause a segfault
> > (bisected). The test is as simple as:
> 
> I've pushed fix and a test case.

Awesome, thanks for the quick patch and test case!

Cheers, Phil
