Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336442841E3
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Oct 2020 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgJEVHi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Oct 2020 17:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgJEVHi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:07:38 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330AC0613CE
        for <netfilter-devel@vger.kernel.org>; Mon,  5 Oct 2020 14:07:38 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kPXhn-0001J5-Ie; Mon, 05 Oct 2020 23:07:35 +0200
Date:   Mon, 5 Oct 2020 23:07:35 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH 1/3] nft: Make batch_add_chain() return the
 added batch object
Message-ID: <20201005210735.GC5213@breakpoint.cc>
References: <20201005144858.11578-1-phil@nwl.cc>
 <20201005144858.11578-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005144858.11578-2-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Do this so in a later patch the 'skip' field can be adjusted.
> 
> While being at it, simplify a few callers and eliminate the need for a
> 'ret' variable.

Reviewed-by: Florian Westphal <fw@strlen.de>
