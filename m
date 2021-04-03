Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA393533C7
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Apr 2021 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhDCLcE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 3 Apr 2021 07:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbhDCLcE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 3 Apr 2021 07:32:04 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4451C0613E6
        for <netfilter-devel@vger.kernel.org>; Sat,  3 Apr 2021 04:32:01 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lSeVT-0004Ds-RD; Sat, 03 Apr 2021 13:31:59 +0200
Date:   Sat, 3 Apr 2021 13:31:59 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] nft: Increase BATCH_PAGE_SIZE to support huge
 rulesets
Message-ID: <20210403113159.GM13699@breakpoint.cc>
References: <20210401145307.29927-1-phil@nwl.cc>
 <20210402053810.GI13699@breakpoint.cc>
 <20210403084940.GA3158@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403084940.GA3158@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> > Isn't that library code?  At the very least this should use
> > nft_print().
> 
> Good point, but for the upcoming identical change to nftables! ;)
> There I'm still undecided about the best way to handle it. For iptables,
> I guess this minimal error reporting to stderr for a case that shouldn't
> happen is fine. ACK?

Oh right.
