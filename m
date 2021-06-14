Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690773A672B
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Jun 2021 14:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhFNMzw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Jun 2021 08:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhFNMzn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:55:43 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A369C061574
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Jun 2021 05:53:39 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1lsm5y-0004q0-17; Mon, 14 Jun 2021 14:53:38 +0200
Date:   Mon, 14 Jun 2021 14:53:38 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables] src: add xzalloc_array() and use it to allocate
 the expression hashtable
Message-ID: <20210614125338.GR22614@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20210614125056.11913-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614125056.11913-1-pablo@netfilter.org>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 14, 2021 at 02:50:56PM +0200, Pablo Neira Ayuso wrote:
> Otherwise, assertion to ensure that no colission occur is hit due to
> uninitialized hashtable memory area:
> 
> nft: netlink_delinearize.c:1741: expr_handler_init: Assertion `expr_handle_ht[hash] == NULL' failed.

Oh, stupid mistake. Thanks for the fix!

> Fixes: c4058f96c6a5 ("netlink_delinearize: Fix suspicious calloc() call")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Acked-by: Phil Sutter <phil@nwl.cc>

Cheers, Phil
