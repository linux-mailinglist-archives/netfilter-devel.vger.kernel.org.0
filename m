Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6146B120A11
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Dec 2019 16:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfLPPsn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Dec 2019 10:48:43 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50730 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728463AbfLPPsn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:43 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1igsbx-0006mt-Dn; Mon, 16 Dec 2019 16:48:41 +0100
Date:   Mon, 16 Dec 2019 16:48:41 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 0/3] typeof incremental enhancements
Message-ID: <20191216154841.GT795@breakpoint.cc>
References: <20191216124222.356618-1-pablo@netfilter.org>
 <20191216124749.GR795@breakpoint.cc>
 <20191216130034.256a44juaeey7umf@salvia>
 <20191216140336.GS795@breakpoint.cc>
 <20191216150158.clh27hvid7pi7ldg@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216150158.clh27hvid7pi7ldg@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > If its not a problem to display a non-restoreable ruleset
> > (e.g. unspecific 'type integer' shown as set keys) in that case
> > then the interger,width part can be omitted indeed.
> > 
> > Let me know.  For concatenations, we will be unable to show
> > a proper ruleset without the udata info anyway (concatentations
> > do not work at the moment for non-specific types anyway though).
> 
> Indeed, what scenario are you considering that set udata might be
> missing?

Any non-nft client/direct netlink user.

> We could still print it in such a case, even if we cannot parse it if
> you are willing to deal with. Just to provide some information to the
> user.

If udata is missing, we only have the type available.

If its a type with unspecific length (string, integer) we can use
the key length to get the bit size.

But for concatenation case, it might be ambigiuos.

So, I would remove the "type integer, length" format again so in
such case we would print

type string
or
type integer.

Users won't see this non-restoreable ruleset listed as long as the udata
is there.
