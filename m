Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3EC77AB3B
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jul 2019 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfG3Oln (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Jul 2019 10:41:43 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:42958 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729908AbfG3Oln (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:41:43 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hsTJt-0004Yv-BO; Tue, 30 Jul 2019 16:41:41 +0200
Date:   Tue, 30 Jul 2019 16:41:41 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de,
        bmastbergen@untangle.com
Subject: Re: [PATCH nft,RFC,PoC 2/2] src: restore typeof datatype when
 listing set definition
Message-ID: <20190730144141.k3dn37nlychhjk46@breakpoint.cc>
References: <20190730141620.2129-1-pablo@netfilter.org>
 <20190730141620.2129-3-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730141620.2129-3-pablo@netfilter.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> This is a proof-of-concept.
> 
> The idea behind this patch is to store the typeof definition
> so it can be restored when listing it back.
> 
> Better way to do this would be to store the typeof expression
> definition in a way that the set->key expression can be rebuilt.

Maybe we can store the raw netlink data that makes up the expression
in the tlv area?

That would probably allow more code reuse to get back the "proper"
type.

One problem with my patch is that while you can add a map that
returns "osf name", I could not find a way to easily re-lookup
a suitable expression.  Storing a string would work of course,
but I don't like it because we have no way to revalidate this.

If we can reuse libnftnl/libmnl to have the basic netlink validation
run on the blob we can at least be sure that its not complete garbage
before we attempt to interpret the blob.
