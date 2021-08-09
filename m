Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2912D3E4C52
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Aug 2021 20:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhHISqX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Aug 2021 14:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhHISqX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:46:23 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E5CC0613D3
        for <netfilter-devel@vger.kernel.org>; Mon,  9 Aug 2021 11:46:02 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1mDAHf-0002Al-BL; Mon, 09 Aug 2021 20:45:59 +0200
Date:   Mon, 9 Aug 2021 20:45:59 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH RFC] scanner: nat: Move to own scope
Message-ID: <20210809184559.GO607@breakpoint.cc>
References: <20210809140141.18976-1-phil@nwl.cc>
 <20210809151833.GM607@breakpoint.cc>
 <20210809162514.GA3673@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809162514.GA3673@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> > So, it is in IP scope, sees 'prefix' (which will be STRING as the
> > PREFIX scan rule is off) and that ends up in a parser error due to lack
> > of a 'IP STRING' rule.
> 
> OK, thanks. So does this mean we won't ever be able to move keywords
> opening a statement or expression out of INIT scope or is my case a
> special one?

We can move them out of INIT scope, but only if they remain within
the same scope.

For example, you could create a 'rule scope' or 'expression scope'
that contains all tokens (ip, tcp, etc.) that start a new expression.

I did not do this because there are too many cases where expressions are
permitted outside of rule scope, e.g. in set definitions (key, elements
...)

> To clarify, what I have in mind is a sample rule 'ip id 1 tcp dport 1'
> where 'tcp' must either be in INIT scope or part of SC_IP. 

IP and TCP need to be in the same scope (e.g. INIT).

In the given example I suspect that TCP doesn't have to be in SC_IP
scope since 'ip id 1' is a full expression and scope closure happens
before next token gets scanned.
