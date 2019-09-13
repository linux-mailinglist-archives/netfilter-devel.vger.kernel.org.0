Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47012B26ED
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2019 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfIMU40 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Sep 2019 16:56:26 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:44400 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfIMU40 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:56:26 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1i8scA-0003l5-NC; Fri, 13 Sep 2019 22:56:22 +0200
Date:   Fri, 13 Sep 2019 22:56:22 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2] parser_bison: Fix 'exists' keyword on Big Endian
Message-ID: <20190913205622.GC9943@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190913184429.21605-1-phil@nwl.cc>
 <20190913205344.GD10656@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913205344.GD10656@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi!

On Fri, Sep 13, 2019 at 10:53:44PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Size value passed to constant_expr_alloc() must correspond with actual
> > data size, otherwise wrong portion of data will be taken later when
> > serializing into netlink message.
> > 
> > Booleans require really just a bit, but make type of boolean_keys be
> > uint8_t (introducing new 'val8' name for it) and pass the data length
> > using sizeof() to avoid any magic numbers.
> > 
> > While being at it, fix len value in parser_json.c as well although it
> > worked before due to the value being rounded up to the next multiple of
> > 8.
> 
> Looks good, thanks Phil.

So that's an ACK? :)

Cheers, Phil
