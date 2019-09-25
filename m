Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB79BE7DF
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Sep 2019 23:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfIYVsA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Sep 2019 17:48:00 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45972 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfIYVsA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:48:00 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iDF8f-0005Xf-Vh; Wed, 25 Sep 2019 23:47:58 +0200
Date:   Wed, 25 Sep 2019 23:47:57 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 01/24] xtables_error() does not return
Message-ID: <20190925214757.GE22129@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190925212605.1005-1-phil@nwl.cc>
 <20190925212605.1005-2-phil@nwl.cc>
 <20190925213115.GA12491@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925213115.GA12491@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 25, 2019 at 11:31:15PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > It's a define which resolves into a callback which in turn is declared
> > with noreturn attribute. It will never return, therefore drop all
> > explicit exit() calls or other dead code immediately following it.
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> 
> Acked-by: Florian Westphal <fw@strlen.de>
> 
> Feel free to push this already.

DONE. :)

Thanks, Phil
