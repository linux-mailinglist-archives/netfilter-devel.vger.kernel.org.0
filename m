Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E313A34EFE2
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Mar 2021 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhC3Rj2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Mar 2021 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhC3RjD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:39:03 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40EEC061574
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Mar 2021 10:39:02 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lRIKS-0005xp-T3; Tue, 30 Mar 2021 19:39:00 +0200
Date:   Tue, 30 Mar 2021 19:39:00 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc:     netfilter-devel@vger.kernel.org, pablo@netfilter.org, fw@strlen.de
Subject: Re: [iptables PATCH v2 2/2] extensions: libxt_conntrack: print xlate
 status as set
Message-ID: <20210330173900.GB17285@breakpoint.cc>
References: <20210330141524.747259-1-alexander.mikhalitsyn@virtuozzo.com>
 <20210330141524.747259-2-alexander.mikhalitsyn@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330141524.747259-2-alexander.mikhalitsyn@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com> wrote:
> status_xlate_print function prints statusmask
> without { ... } around. But if ctstatus condition is
> negative, then we have to use { ... } after "!=" operator in nft

Not really.

> Reproducer:
> $ iptables -A INPUT -d 127.0.0.1/32 -p tcp -m conntrack ! --ctstatus expected,assured -j DROP
> $ nft list ruleset
> ...
> meta l4proto tcp ip daddr 127.0.0.1 ct status != expected,assured counter packets 0 bytes 0 drop
> ...

Yes, nft can't parse that.

But ct status { expect, assured } is NOT The same as 'ct status expect,assured'.

expect, assured etc. are all bit flags, so when negating this needs to be something
like  'ct status & (expected|assured) == 0'. (ct is neither expected nor assured).
