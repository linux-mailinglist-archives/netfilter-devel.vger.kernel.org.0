Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983953EC997
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Aug 2021 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbhHOOhK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 15 Aug 2021 10:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhHOOhJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 15 Aug 2021 10:37:09 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A2C061764
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Aug 2021 07:36:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1mFHFd-0000Le-AZ; Sun, 15 Aug 2021 16:36:37 +0200
Date:   Sun, 15 Aug 2021 16:36:37 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, Jan Engelhardt <jengelh@inai.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptabes-nft] iptables-nft: allow removal of empty builtin
 chains
Message-ID: <20210815143637.GK607@breakpoint.cc>
References: <20210814174643.130760-1-fw@strlen.de>
 <84q02320-o5pp-8q8q-q646-473ssq92n552@vanv.qr>
 <20210814205314.GF607@breakpoint.cc>
 <20210815131223.GA30503@salvia>
 <20210815132733.GI607@breakpoint.cc>
 <20210815134922.GA10659@salvia>
 <20210815141414.GJ607@breakpoint.cc>
 <20210815142734.GA31050@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815142734.GA31050@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > We could check if policy is still set to accept before implicit
> > removal in the "iptables-nft -X" case.
> 
> That's possible yes, but why force the user to change the policy from
> DROP to ACCEPT to delete an empty basechain right thereafter?

Ok, so I will just send a simplified version of this patch that
will remove all empty basechains for -X too.

Thanks!
