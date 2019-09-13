Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B628DB2880
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Sep 2019 00:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404061AbfIMWfp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Sep 2019 18:35:45 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:57084 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404036AbfIMWfp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:35:45 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i8uAI-0005Jt-8K; Sat, 14 Sep 2019 00:35:42 +0200
Date:   Sat, 14 Sep 2019 00:35:42 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2] parser_bison: Fix 'exists' keyword on Big Endian
Message-ID: <20190913223542.GE10656@breakpoint.cc>
References: <20190913184429.21605-1-phil@nwl.cc>
 <20190913205344.GD10656@breakpoint.cc>
 <20190913205622.GC9943@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913205622.GC9943@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> On Fri, Sep 13, 2019 at 10:53:44PM +0200, Florian Westphal wrote:
> > Phil Sutter <phil@nwl.cc> wrote:
> > > Size value passed to constant_expr_alloc() must correspond with actual
> > > data size, otherwise wrong portion of data will be taken later when
> > > serializing into netlink message.
> > > 
> > > Booleans require really just a bit, but make type of boolean_keys be
> > > uint8_t (introducing new 'val8' name for it) and pass the data length
> > > using sizeof() to avoid any magic numbers.
> > > 
> > > While being at it, fix len value in parser_json.c as well although it
> > > worked before due to the value being rounded up to the next multiple of
> > > 8.
> > 
> > Looks good, thanks Phil.
> 
> So that's an ACK? :)

Yes, feel free to push this.
