Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CA83E050A
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Aug 2021 17:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhHDP6A (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Aug 2021 11:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbhHDP6A (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:58:00 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C55BC0613D5
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Aug 2021 08:57:47 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1mBJH7-0005he-7X; Wed, 04 Aug 2021 17:57:45 +0200
Date:   Wed, 4 Aug 2021 17:57:45 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Shivani Bhardwaj <shivanib134@gmail.com>,
        Max Laverse <max@laverse.net>, kernel@openvz.org
Subject: Re: [PATCH iptables] ip6tables: masquerade: use fully-random so that
 nft can understand the rule
Message-ID: <20210804155745.GF607@breakpoint.cc>
References: <20210804155057.16829-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804155057.16829-1-ptikhomirov@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
> That's because nft list ruleset saves "random-fully" which is wrong
> format for nft -f, right should be "fully-random".

Right.  Patch is applied, thanks!
