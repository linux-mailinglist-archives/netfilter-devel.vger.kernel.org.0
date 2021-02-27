Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985E0326DD0
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Feb 2021 17:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhB0QSu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 27 Feb 2021 11:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhB0QRo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 27 Feb 2021 11:17:44 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C01C06174A
        for <netfilter-devel@vger.kernel.org>; Sat, 27 Feb 2021 08:17:03 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lG2H5-0002Hz-6E; Sat, 27 Feb 2021 17:16:59 +0100
Date:   Sat, 27 Feb 2021 17:16:59 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH] netfilter: gpf inside xt_find_revision()
Message-ID: <20210227161659.GB17911@breakpoint.cc>
References: <75817029-1d99-0e41-1d5b-76fa4a45aafa@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75817029-1d99-0e41-1d5b-76fa4a45aafa@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Vasily Averin <vvs@virtuozzo.com> wrote:
> nested target/match_revfn() calls work with xt[NFPROTO_UNSPEC] lists
> without taking xt[NFPROTO_UNSPEC].mutex. This can race with module unload
> and cause host to crash:

Reviewed-by: Florian Westphal <fw@strlen.de>
