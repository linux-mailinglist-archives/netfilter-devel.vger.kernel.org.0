Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0B7313A9B
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Feb 2021 18:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhBHRPt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Feb 2021 12:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbhBHRP1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:15:27 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B39C061786;
        Mon,  8 Feb 2021 09:14:47 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1l9A7Y-0005Oo-Qd; Mon, 08 Feb 2021 18:14:44 +0100
Date:   Mon, 8 Feb 2021 18:14:44 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Martin Gignac <martin.gignac@gmail.com>,
        netfilter@vger.kernel.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: Unable to create a chain called "trace"
Message-ID: <20210208171444.GH16570@breakpoint.cc>
References: <CANf9dFMJN5ZsihtygUnEWB_9T=WLbEHrZY1a5mTqLgN7J39D5w@mail.gmail.com>
 <20210208154915.GF16570@breakpoint.cc>
 <20210208164750.GM3158@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208164750.GM3158@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> In general, shells eating the quotes is problematic and users may not be
> aware of it. This includes scripts that mangle ruleset dumps by
> accident, etc. (Not sure if it is really a problem as we quote some
> strings already).
> 
> Using JSON, there are no such limits, BTW. I really wonder if there's
> really no fix for bison parser to make it "context aware".

Right.  We can probably make lots of keywords available for table/chain names
by only recognizing them while parsing rules, i.e. via 'start conditions'
in flex.  But I don't think there is anyone with the time to do the
needed scanner changes.
