Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D206AE12
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jul 2019 19:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfGPR5P (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Jul 2019 13:57:15 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51054 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPR5O (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:57:14 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hnRhQ-00058i-MF; Tue, 16 Jul 2019 19:57:12 +0200
Date:   Tue, 16 Jul 2019 19:57:12 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, charles@ccxtechnologies.com,
        Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: Re: [PATCH nft] evaluate: bogus error when refering to existing
 non-base chain
Message-ID: <20190716175712.GG1628@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, charles@ccxtechnologies.com,
        Fernando Fernandez Mancera <ffmancera@riseup.net>
References: <20190716115120.21710-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716115120.21710-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 16, 2019 at 01:51:20PM +0200, Pablo Neira Ayuso wrote:
>  add rule ip testNEW test6 jump test8
>                                 ^^^^^
>  Error: invalid verdict chain expression value

Note that I can't reproduce this issue locally.

[...]
> -			if ((stmt->expr->chain->etype != EXPR_SYMBOL &&
> -			    stmt->expr->chain->etype != EXPR_VALUE) ||
> -			    stmt->expr->chain->symtype != SYMBOL_VALUE) {
> -				return stmt_error(ctx, stmt,
> -						  "invalid verdict chain expression %s\n",
> -						  expr_name(stmt->expr->chain));
> -			}

So I guess the problem is that for an etype of EXPR_VALUE, symtype is
still checked. The latter is used by EXPR_SYMBOL only, but since
SYMBOL_VALUE is 0 (implicitly, it's the first item in enum
symbol_types) this probably works by accident.

I still don't understand why it doesn't work for you, but I guess the
bug is found. So probably

| if ((stmt->expr->chain->etype != EXPR_SYMBOL ||
|       stmt->expr->chain->symtype != SYMBOL_VALUE) &&
|     stmt->expr->chain->etype != EXPR_VALUE)) {

is right.

Cheers, Phil
