Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680233FB373
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Aug 2021 11:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhH3JzY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Aug 2021 05:55:24 -0400
Received: from mail.netfilter.org ([217.70.188.207]:42866 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhH3JzV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:55:21 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0C5CA60143;
        Mon, 30 Aug 2021 11:53:28 +0200 (CEST)
Date:   Mon, 30 Aug 2021 11:54:23 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 0/3] netfilter: conntrack: switch to siphash
Message-ID: <20210830095423.GA22849@salvia>
References: <20210826135422.31063-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210826135422.31063-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 26, 2021 at 03:54:18PM +0200, Florian Westphal wrote:
> Two recent commits switched inet rt and nexthop exception
> hashes from jhash to siphash.
> 
> If those two spots are problematic then conntrack is affected
> as well, so switch voer to siphash too.
> 
> While at it, add a hard upper limit on chain lengths and reject
> insertion if this is hit.

Applied, thanks.

I've taken this 3/3 version:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210826135422.31063-5-fw@strlen.de/
