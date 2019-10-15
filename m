Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 172D0D7AE3
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfJOQLg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 12:11:36 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:37118 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbfJOQLg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:11:36 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iKPQ6-0007rK-Ma; Tue, 15 Oct 2019 18:11:34 +0200
Date:   Tue, 15 Oct 2019 18:11:34 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 4/6] set: Don't bypass checks in
 nftnl_set_set_u{32,64}()
Message-ID: <20191015161134.GY12661@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191015141658.11325-1-phil@nwl.cc>
 <20191015141658.11325-5-phil@nwl.cc>
 <20191015155346.qgd55w7iypj44q6m@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015155346.qgd55w7iypj44q6m@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Tue, Oct 15, 2019 at 05:53:46PM +0200, Pablo Neira Ayuso wrote:
> On Tue, Oct 15, 2019 at 04:16:56PM +0200, Phil Sutter wrote:
> > By calling nftnl_set_set(), any data size checks are effectively
> > bypassed. Better call nftnl_set_set_data() directly, passing the real
> > size for validation.
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> 
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> Probably attribute((deprecated)) is better so we don't forget. Anyway,
> we can probably nuke this function in the next release.

But if we drop it, we break ABI, no? Sadly, nftables use(d) the symbol,
so we would break older nftables versions with the new libnftnl release.

Should I send a v2 setting attribute((deprecated))? I think it's worth
doing it.

Thanks, Phil
