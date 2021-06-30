Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91E3B805F
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Jun 2021 11:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhF3JwZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Jun 2021 05:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhF3JwY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:52:24 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBB4C061756;
        Wed, 30 Jun 2021 02:49:56 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lyWqr-0008HK-CP; Wed, 30 Jun 2021 11:49:49 +0200
Date:   Wed, 30 Jun 2021 11:49:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Taehee Yoo <ap420073@gmail.com>, Julian Anastasov <ja@ssi.bg>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH NETFILTER] netfilter: nfnetlink: suspicious RCU usage in
 ctnetlink_dump_helpinfo
Message-ID: <20210630094949.GA18022@breakpoint.cc>
References: <65205a04-f1a3-9901-f6b7-eab8f482f37f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65205a04-f1a3-9901-f6b7-eab8f482f37f@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Vasily Averin <vvs@virtuozzo.com> wrote:
> Two patches listed below removed ctnetlink_dump_helpinfo call from under
> rcu_read_lock. Now its rcu_dereference generates following warning:
> =============================
> WARNING: suspicious RCU usage
> 5.13.0+ #5 Not tainted
> -----------------------------
> net/netfilter/nf_conntrack_netlink.c:221 suspicious rcu_dereference_check() usage!

Reviewed-by: Florian Westphal <fw@strlen.de>
