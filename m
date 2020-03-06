Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0407E17C30D
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Mar 2020 17:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCFQeu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Mar 2020 11:34:50 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:35846 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFQeu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:34:50 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jAFvz-0002bD-Uh; Fri, 06 Mar 2020 17:34:47 +0100
Date:   Fri, 6 Mar 2020 17:34:47 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Eric Garver <eric@garver.life>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] parser_json: Support ranges in concat expressions
Message-ID: <20200306163447.GB1630@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Eric Garver <eric@garver.life>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200306152210.14971-1-phil@nwl.cc>
 <20200306161446.n5xm7bnxgqe55qth@egarver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306161446.n5xm7bnxgqe55qth@egarver>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Eric,

On Fri, Mar 06, 2020 at 11:14:46AM -0500, Eric Garver wrote:
> Thanks for taking a look at this.
> 
> On Fri, Mar 06, 2020 at 04:22:10PM +0100, Phil Sutter wrote:
> > Duplicate commit 8ac2f3b2fca38's changes to bison parser into JSON
> > parser by introducing a new context flag signalling we're parsing
> > concatenated expressions.
> > 
> > Fixes: 8ac2f3b2fca38 ("src: Add support for concatenated set ranges")
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> 
> I was able to verify this change allows "prefix" inside "concat", but it
> introduces issues with other matches, e.g. payload and meta.
> 
> The below incremental allows those to work, but there are probably
> issues with other match fields.

Oh crap, you're right - I forgot to add the flag to what previously was
caught as primary expression. Thanks for the quick test, I'll respin.

Thanks, Phil
