Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22742841F3
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Oct 2020 23:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgJEVNS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Oct 2020 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgJEVNS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:13:18 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715E4C0613CE
        for <netfilter-devel@vger.kernel.org>; Mon,  5 Oct 2020 14:13:18 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kPXnI-0001N8-Qv; Mon, 05 Oct 2020 23:13:16 +0200
Date:   Mon, 5 Oct 2020 23:13:16 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH 2/3] nft: Fix error reporting for refreshed
 transactions
Message-ID: <20201005211316.GD5213@breakpoint.cc>
References: <20201005144858.11578-1-phil@nwl.cc>
 <20201005144858.11578-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005144858.11578-3-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> When preparing a batch from the list of batch objects in nft_action(),
> the sequence number used for each object is stored within that object
> for later matching against returned error messages. Though if the
> transaction has to be refreshed, some of those objects may be skipped,
> other objects take over their sequence number and errors are matched to
> skipped objects. Avoid this by resetting the skipped object's sequence
> number to zero.

Reviewed-by: Florian Westphal <fw@strlen.de>
