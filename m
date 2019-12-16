Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6DF1207E1
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Dec 2019 15:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfLPODi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Dec 2019 09:03:38 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50178 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727906AbfLPODi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:03:38 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1igqyG-00061p-6S; Mon, 16 Dec 2019 15:03:36 +0100
Date:   Mon, 16 Dec 2019 15:03:36 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 0/3] typeof incremental enhancements
Message-ID: <20191216140336.GS795@breakpoint.cc>
References: <20191216124222.356618-1-pablo@netfilter.org>
 <20191216124749.GR795@breakpoint.cc>
 <20191216130034.256a44juaeey7umf@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216130034.256a44juaeey7umf@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> The listing path should be easier, since it's just parsing the TLVs
> instead of invoking the nft parsing and evaluation phases.
> 
> > If you think its the way to go, then ok, I can rework it but
> > I will be unable to add the extra steps for other expression types
> > for some time I fear.
> 
> If you send a v3 including this work, I'll finishing the remaining
> expressions.

Ok, will respin.

> One more thing regarding your patchset is:
> 
>         integer,128
> 
> If the typeof works for all of the existing selectors, then I think
> there is not need to expose this raw type, right?

How would you handle the 'udate missing' case?

If its not a problem to display a non-restoreable ruleset
(e.g. unspecific 'type integer' shown as set keys) in that case
then the interger,width part can be omitted indeed.

Let me know.  For concatenations, we will be unable to show
a proper ruleset without the udata info anyway (concatentations
do not work at the moment for non-specific types anyway though).
