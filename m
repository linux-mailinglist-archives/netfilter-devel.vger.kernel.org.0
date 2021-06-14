Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ACB3A66CF
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Jun 2021 14:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhFNMno (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Jun 2021 08:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbhFNMnn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:43:43 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8ECC061574
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Jun 2021 05:41:40 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1lsluM-0004fx-Sk; Mon, 14 Jun 2021 14:41:38 +0200
Date:   Mon, 14 Jun 2021 14:41:38 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables] evaluate: add set to cache once
Message-ID: <20210614124138.GQ22614@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20210614122454.27902-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614122454.27902-1-pablo@netfilter.org>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 14, 2021 at 02:24:54PM +0200, Pablo Neira Ayuso wrote:
> 67d3969a7244 ("evaluate: add set to the cache") re-adds the set into the
> cache again.
> 
> This bug was hidden behind 5ec5c706d993 ("cache: add hashtable cache for
> table") which broken set_evaluate() for anonymous sets.
> 
> Phil reported a gcc compilation warning which uncovered this problem.
> 
> Reported-by: Phil Sutter <phil@nwl.cc>
> Fixes: 67d3969a7244 ("evaluate: add set to the cache")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks for the quick fix!

Out of curiosity, did you not use set_is_anonymous() in commit
bbcc5eda7e588 on purpose?

Cheers, Phil
