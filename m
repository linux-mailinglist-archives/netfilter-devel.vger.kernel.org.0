Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313C56F099
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jul 2019 22:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfGTUWn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 16:22:43 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:41390 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfGTUWn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 16:22:43 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hovsO-0007qE-Pn; Sat, 20 Jul 2019 22:22:40 +0200
Date:   Sat, 20 Jul 2019 22:22:40 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 2/2] nfnl_osf: Silence string truncation gcc warnings
Message-ID: <20190720202240.GH32501@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190720185226.8876-1-phil@nwl.cc>
 <20190720185226.8876-2-phil@nwl.cc>
 <20190720193628.fysp5cdofer2vi32@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720193628.fysp5cdofer2vi32@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jul 20, 2019 at 09:36:28PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Albeit a bit too enthusiastic, gcc is right in that these strings may be
> > truncated since the destination buffer is smaller than the source one.
> > Get rid of the warnings (and the potential problem) by specifying a
> > string "precision" of one character less than the destination. This
> > ensures a terminating nul-character may be written as well.
> 
> Fernando sent a patch for this already, with the notable difference
> of altering the size of the destination buffer by one.

Ah, thanks! I missed it. Replied to it pointing at my patch, also
spotted a typo in his patch. :)

Cheers, Phil
