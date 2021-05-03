Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314E637223C
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 May 2021 23:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhECVIb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 May 2021 17:08:31 -0400
Received: from mail.netfilter.org ([217.70.188.207]:41022 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhECVIb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 May 2021 17:08:31 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 56B0F63087;
        Mon,  3 May 2021 23:06:54 +0200 (CEST)
Date:   Mon, 3 May 2021 23:07:34 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ali Abdallah <ali.abdallah@suse.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] Avoid potentially erroneos RST check
Message-ID: <20210503210702.GA13695@salvia>
References: <20210428131147.w2ppmrt6hpcjin5i@Fryzen495>
 <20210428143041.GA24118@salvia>
 <20210430092729.66f4jldpyqxedvpz@Fryzen495>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210430092729.66f4jldpyqxedvpz@Fryzen495>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Apr 30, 2021 at 11:27:29AM +0200, Ali Abdallah wrote:
> On 28.04.2021 16:30, Pablo Neira Ayuso wrote:
> > I did not apply:
> > 
> > https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210420122415.v2jtayiw3n4ds7t7@Fryzen495/
> > 
> > as you requested to send a v2.
> > 
> > Would it make sense to squash this patch and ("Reset the max ACK flag
> > on SYN in ignore state") in one single patch?
> > 
> > Thanks.
> 
> Yes, I will send a single patch then. Thanks.

Thanks.

There are three patches in patchwork now (they come with no
versioning, not sure if one of these is replaced by another).

So which ones below should be consider to be applied upstream?

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210420122415.v2jtayiw3n4ds7t7@Fryzen495/
https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210428130911.cteglt52r5if7ynp@Fryzen495/
https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210430093601.zibczc4cjnwx3qwn@Fryzen495/
