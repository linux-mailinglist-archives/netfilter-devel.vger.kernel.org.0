Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F73328CB22
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Oct 2020 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgJMJol (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Oct 2020 05:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgJMJol (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:44:41 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EF4C0613D0
        for <netfilter-devel@vger.kernel.org>; Tue, 13 Oct 2020 02:44:40 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kSGrH-0007Kh-Ix; Tue, 13 Oct 2020 11:44:39 +0200
Date:   Tue, 13 Oct 2020 11:44:39 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 04/10] nft: Eliminate nft_chain_list_get()
Message-ID: <20201013094439.GU13016@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200923174849.5773-1-phil@nwl.cc>
 <20200923174849.5773-5-phil@nwl.cc>
 <20201012120341.GD26845@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012120341.GD26845@salvia>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:03:41PM +0200, Pablo Neira Ayuso wrote:
> On Wed, Sep 23, 2020 at 07:48:43PM +0200, Phil Sutter wrote:
> > Since introduction of nft_cache_add_chain(), there is merely a single
> > user of nft_chain_list_get() left. Hence fold the function into its
> > caller.
> 
> Why this last update regarding nft_chain_list_get() and not in 02/10 ?

Ah yes, I could have reordered the patches a bit. In patch 3/10, there
are some nft_chain_list_get() removals, too. So I couldn't remove the
function in 2/10 already. I should move 3/10 to before 2/10 and then
combine that with 4/10. ACK?

Thanks, Phil
