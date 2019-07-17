Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531166C1F0
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2019 22:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGQULf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jul 2019 16:11:35 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:56054 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfGQULf (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:11:35 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hnqGy-0004iG-D9; Wed, 17 Jul 2019 22:11:32 +0200
Date:   Wed, 17 Jul 2019 22:11:32 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nf PATCH RFC] net: nf_tables: Support auto-loading inet family
 nat chain
Message-ID: <20190717201132.GI31548@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20190717171743.14754-1-phil@nwl.cc>
 <20190717183515.yym6aageq3d3imlu@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717183515.yym6aageq3d3imlu@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, Jul 17, 2019 at 08:35:15PM +0200, Pablo Neira Ayuso wrote:
[...]
> Please, use (2, "nat") instead like in other extensions.
> 
>         MODULE_ALIAS_NFT_CHAIN(2, "nat");        /* NFPROTO_INET */

I sent a non-RFC patch which uses fixed value 1. Thanks for the
suggestion!

> Yes, it's not nice, but this is so far what we have.
> 
> I agree we should fix this, problem is that NFPROTO_* are enum, and
> IIRC this doesn't mix well with the existing macros.

Ah, right. The __stringify() thing bites us then. In order to use
NFPROTO_* names, those would have to be redefined as macro. And not just
like netinet/in.h does for IPPROTO_* names but with actual value.

Cheers, Phil
