Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D303B4FF0
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Sep 2019 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfIQOI0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Sep 2019 10:08:26 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:53726 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfIQOI0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:08:26 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iAE9Y-0005Y3-8E; Tue, 17 Sep 2019 16:08:24 +0200
Date:   Tue, 17 Sep 2019 16:08:24 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 07/14] nft Increase mnl_talk() receive buffer
 size
Message-ID: <20190917140824.GG9943@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190916165000.18217-1-phil@nwl.cc>
 <20190916165000.18217-8-phil@nwl.cc>
 <20190917050038.mi4omfwlctacjfze@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917050038.mi4omfwlctacjfze@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Tue, Sep 17, 2019 at 07:00:38AM +0200, Pablo Neira Ayuso wrote:
> On Mon, Sep 16, 2019 at 06:49:53PM +0200, Phil Sutter wrote:
> > This improves cache population quite a bit and therefore helps when
> > dealing with large rulesets. A simple hard to improve use-case is
> > listing the last rule in a large chain.
> 
> You might consider extending the netlink interface too for this
> particularly case, GETRULE plus position attribute could be used for
> this I think. You won't be able to use this new operation from
> userspace anytime soon though, given there is no way so far to expose
> interface capabilities so far rather than probing.
> 
> If there are more particular corner cases like this, I would also
> encourage to extend the netlink interface.
> 
> Just a side note, not a comment specifically on this patch :-).

Thanks for suggesting, I didn't consider extending kernel to support the
index stuff yet. In general, I refrained from kernel changes simply
because of the compat problem. Implementing failure tolerance can
quickly turn into a mess, too.

Cheers, Phil
