Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A099393FAC
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 May 2021 11:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhE1JRa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 May 2021 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbhE1JR3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 May 2021 05:17:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CF3C061574
        for <netfilter-devel@vger.kernel.org>; Fri, 28 May 2021 02:15:55 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lmYat-0008AL-6K; Fri, 28 May 2021 11:15:51 +0200
Date:   Fri, 28 May 2021 11:15:51 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ali Abdallah <ali.abdallah@suse.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: conntrack: add new sysctl to disable RST check
Message-ID: <20210528091551.GA30879@breakpoint.cc>
References: <20210526092444.lca726ghsrli5fpx@Fryzen495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526092444.lca726ghsrli5fpx@Fryzen495>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ali Abdallah <ali.abdallah@suse.com> wrote:
> This patch adds a new sysctl tcp_ignore_invalid_rst to disable marking
> out of segments RSTs as INVALID.

Just for archives:
I am not sure this is still needed after the recent change, but I can
see why its desirable to keep NAT working even when RST is invalid.

I think that the more fundamental problem is the inability to permit
setting a conntrack as INVALID while allowing NAT to work, i.e. move
drop decision to ruleset.

However, I see that this isn't easy to change.  Therefore,

Reviewed-by: Florian Westphal <fw@strlen.de>
