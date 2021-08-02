Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7473DD477
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Aug 2021 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhHBLGI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Aug 2021 07:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhHBLGI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:06:08 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E0C06175F
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Aug 2021 04:05:58 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1mAVlb-0005eM-9r; Mon, 02 Aug 2021 13:05:55 +0200
Date:   Mon, 2 Aug 2021 13:05:55 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] ebtables: Dump atomic waste
Message-ID: <20210802110555.GW3673@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20210730103715.20501-1-phil@nwl.cc>
 <20210802090404.GA1252@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802090404.GA1252@salvia>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 02, 2021 at 11:04:04AM +0200, Pablo Neira Ayuso wrote:
> Hi Phil,
> 
> On Fri, Jul 30, 2021 at 12:37:15PM +0200, Phil Sutter wrote:
> > With ebtables-nft.8 now educating people about the missing
> > functionality, get rid of atomic remains in source code. This eliminates
> > mostly comments except for --atomic-commit which was treated as alias of
> > --init-table. People not using the latter are probably trying to
> > atomic-commit from an atomic-file which in turn is not supported, so no
> > point keeping it.
> 
> That's fine.
> 
> If there's any need in the future for emulating this in the future, it
> should be possible to map atomic-save to ebtables-save and
> atomic-commit to ebtables-restore.

I had considered that, but the binary format of atomic-file drove me
off: If we can't support existing atomic-files easily, we better deny
unless someone has a strong argument to do it. And then I'd try to
support it fully, so it's not a half-ass solution with a catch. :)

> Anyway, this one of the exotic options in ebtables that makes it
> different from ip,ip6,arptables. Given there are better tools now that
> are aligned with the more orthodox approach, this should be OK.

Let's hope most users went with the familiar save/restore approach
instead of opening a whole new can for ebtables alone.

Thanks, Phil
