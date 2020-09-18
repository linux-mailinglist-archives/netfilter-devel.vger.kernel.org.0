Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00D526FF9A
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Sep 2020 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRONy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Sep 2020 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRONy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:13:54 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BAEC0613CE
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Sep 2020 07:13:54 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kJH94-0007Vs-D5; Fri, 18 Sep 2020 16:13:50 +0200
Date:   Fri, 18 Sep 2020 16:13:50 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Serhey Popovych <serhe.popovych@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, willem.j.debruijn@gmail.com
Subject: Re: [PATCH iptables 1/4] xtables: Do not register matches/targets
 with incompatible revision
Message-ID: <20200918141350.GB19674@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Serhey Popovych <serhe.popovych@gmail.com>,
        netfilter-devel@vger.kernel.org, willem.j.debruijn@gmail.com
References: <1520413843-24456-1-git-send-email-serhe.popovych@gmail.com>
 <1520413843-24456-2-git-send-email-serhe.popovych@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520413843-24456-2-git-send-email-serhe.popovych@gmail.com>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Serhey,

On Wed, Mar 07, 2018 at 11:10:40AM +0200, Serhey Popovych wrote:
> If kernel tells revision isn't found/supported at the moment we should
> keep entity in pending list, not register or bail to do so later.

This causes a problem in particular with conntrack match (but others may
be affected as well): If the kernel doesn't support an older revision of
the match, it stays in pending list and is retried for each new rule
using the match.

> Kernel might still load module for entity we asking it for and this
> could be slow on some embedded devices.

Is this a speculative problem or did you see it in reality? I'm
wondering because kernel uses try_then_request_module() to load the
missing extension which calls __request_module() with 'wait' parameter
set to true. So unless the called usermode helper is behaving unexpected
(e.g. fork and load in background), the call to
compatible_match_revision() should block until the module has been
loaded, no?

> Catch double registration attempts by checking me->next being non-NULL
> in xtables_register_match() and xtables_register_target().

Is this a side-effect of the above or an independent fix?

Cheers, Phil
