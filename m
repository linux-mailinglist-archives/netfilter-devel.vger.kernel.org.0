Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF2352C22
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Apr 2021 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhDBPIY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Apr 2021 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbhDBPIX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:08:23 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D837C0613E6
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Apr 2021 08:08:21 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lSLPG-0008L6-33; Fri, 02 Apr 2021 17:08:18 +0200
Date:   Fri, 2 Apr 2021 17:08:18 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc:     netfilter-devel@vger.kernel.org, pablo@netfilter.org, fw@strlen.de
Subject: Re: [iptables PATCH v5 1/2] extensions: libxt_conntrack: print xlate
 state as set
Message-ID: <20210402150818.GJ13699@breakpoint.cc>
References: <20210401134708.34288-1-alexander.mikhalitsyn@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401134708.34288-1-alexander.mikhalitsyn@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com> wrote:
> Currently, state_xlate_print function prints statemask as comma-separated sequence of enabled
> statemask flags. But if we have inverted conntrack ctstate condition then we have to use more
> complex expression because nft not supports syntax like "ct state != related,established".

Applied, thanks.
