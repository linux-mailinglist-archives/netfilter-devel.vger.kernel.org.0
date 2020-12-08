Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A3B2D2897
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Dec 2020 11:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgLHKMa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Dec 2020 05:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgLHKMa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:12:30 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008D6C06138C
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Dec 2020 02:11:48 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kmZyD-0004Ew-AJ; Tue, 08 Dec 2020 11:11:45 +0100
Date:   Tue, 8 Dec 2020 11:11:45 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 5/5] netfilter: nftables: netlink support for
 several set element expressions
Message-ID: <20201208101145.GB31101@breakpoint.cc>
References: <20201207181651.18771-1-pablo@netfilter.org>
 <20201207181651.18771-6-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207181651.18771-6-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
  
> +	if ((tb[NFTA_DYNSET_EXPR] || tb[NFTA_DYNSET_EXPR]) &&
> +	    !(set->flags & NFT_SET_EVAL))
> +		return -EINVAL;

Hmm, same expression on both sides of ||, one of those should have been
NFTA_DYNSET_EXPRESSIONS?
