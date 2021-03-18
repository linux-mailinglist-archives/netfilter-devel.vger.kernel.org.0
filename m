Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F99D34072F
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Mar 2021 14:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhCRNwH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Mar 2021 09:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhCRNv7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:51:59 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AEEC06174A
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Mar 2021 06:51:58 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1lMt48-0000gP-Pd; Thu, 18 Mar 2021 14:51:56 +0100
Date:   Thu, 18 Mar 2021 14:51:56 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 6/6] src: allow arbitary chain name in implicit rule
 add case
Message-ID: <20210318135156.GA25339@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20210316234039.15677-1-fw@strlen.de>
 <20210316234039.15677-7-fw@strlen.de>
 <20210318120019.GH6306@orbyte.nwl.cc>
 <20210318123724.GB22603@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318123724.GB22603@breakpoint.cc>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 18, 2021 at 01:37:24PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > > Another alternative is to deprecate implicit rule add altogether
> > > so users would have to move to 'nft add rule ...'.
> > 
> > Isn't this required for nested syntax? I didn't check, but does your
> > arbitrary table/chain name support work also when restoring a ruleset in
> > that nested syntax?
> 
> Whats 'nested syntax'?
> 
> You mean "table bla { chain foo {"?

Yes, exactly.

> > Another interesting aspect might be arbitrary set
> > names - 'set' is also a valid keyword used in rules, this fact killed my
> > approach with start conditions. ;)
> 
> Right, arbitrary set names are needed as well, I forgot about them.
> 
> It should be possible by using two "set" rules in flex.
> 
> One in the INITIAL scope (to handle set bla {), and one in
> 'rule' or 'expression scope'.
> 
> The former would switch to an exclusive start condition (expect
> STRING, close condition on '{', just like CHAIN is handled here.
> 
> The latter would not change state and just return SET token.

Yes, that might work.

Thanks, Phil
