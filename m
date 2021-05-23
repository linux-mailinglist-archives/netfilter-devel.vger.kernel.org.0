Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17838DD06
	for <lists+netfilter-devel@lfdr.de>; Sun, 23 May 2021 23:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhEWVEu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 23 May 2021 17:04:50 -0400
Received: from mail.netfilter.org ([217.70.188.207]:55942 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhEWVEt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 23 May 2021 17:04:49 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id D56A96415F;
        Sun, 23 May 2021 23:02:22 +0200 (CEST)
Date:   Sun, 23 May 2021 23:03:20 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 4/4] netfilter: nf_tables: include table and
 chain name when dumping hooks
Message-ID: <20210523210320.GA14705@salvia>
References: <20210521113922.20798-1-fw@strlen.de>
 <20210521113922.20798-5-fw@strlen.de>
 <20210523085228.GA11701@salvia>
 <20210523185431.GA31080@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210523185431.GA31080@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, May 23, 2021 at 08:54:31PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > On Fri, May 21, 2021 at 01:39:22PM +0200, Florian Westphal wrote:
> > >   * @NFTA_HOOK_FUNCTION_NAME: hook function name (NLA_STRING)
> > >   * @NFTA_HOOK_MODULE_NAME: kernel module that registered this hook (NLA_STRING)
> > > + * @NFTA_HOOK_NFT_CHAIN_INFO: nft chain and table name (NLA_NESTED)
> > 
> > Probably NFTA_HOOK_CHAIN_INFO ?
> 
> I added _NFT_ to avoid ambiguity in case this would be extended
> to add xt-legacy chain info.  I can drop the _NFT_, let me know.

It's a NLA_NESTED, you might add a _TYPE field inside the nest to
describe what type of chain info is stored there, maybe?
