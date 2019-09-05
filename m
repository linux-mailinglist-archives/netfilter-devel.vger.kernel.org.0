Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44EC5AA9F2
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Sep 2019 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbfIERZb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Sep 2019 13:25:31 -0400
Received: from correo.us.es ([193.147.175.20]:52250 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfIERZb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:25:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AD6F91F0CE9
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Sep 2019 19:25:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9E554D2B1D
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Sep 2019 19:25:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 94163DA4D0; Thu,  5 Sep 2019 19:25:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 06E60A7D53;
        Thu,  5 Sep 2019 19:25:24 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 05 Sep 2019 19:25:24 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D922E42EE38E;
        Thu,  5 Sep 2019 19:25:23 +0200 (CEST)
Date:   Thu, 5 Sep 2019 19:25:25 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Eric Garver <eric@garver.life>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: shell: check that rule add with index works
 with echo
Message-ID: <20190905172525.o7epzqgau6dpdkim@salvia>
References: <20190903232713.14394-1-eric@garver.life>
 <20190905155418.z2lpiet466ceixjy@salvia>
 <20190905161354.3lqlvvhajzhdoaiy@roberto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905161354.3lqlvvhajzhdoaiy@roberto>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:13:54PM -0400, Eric Garver wrote:
> On Thu, Sep 05, 2019 at 05:54:18PM +0200, Pablo Neira Ayuso wrote:
> > On Tue, Sep 03, 2019 at 07:27:13PM -0400, Eric Garver wrote:
> > > If --echo is used the rule cache will not be populated. This causes
> > > rules added using the "index" keyword to be simply appended to the
> > > chain. The bug was introduced in commit 3ab02db5f836 ("cache: add
> > > NFT_CACHE_UPDATE and NFT_CACHE_FLUSHED flags").
> > > 
> > > Signed-off-by: Eric Garver <eric@garver.life>
> > > ---
> > > I think the issue is in cache_evaluate(). It sets the flags to
> > > NFT_CACHE_FULL and then bails early, but I'm not sure of the best way to
> > > fix it. So I'll start by submitting a test case. :)
> > > ---
> > >  tests/shell/testcases/cache/0007_echo_cache_init_0 | 14 ++++++++++++++
> > >  .../cache/dumps/0007_echo_cache_init_0.nft         |  7 +++++++
> > >  2 files changed, 21 insertions(+)
> > >  create mode 100755 tests/shell/testcases/cache/0007_echo_cache_init_0
> > >  create mode 100644 tests/shell/testcases/cache/dumps/0007_echo_cache_init_0.nft
> > > 
> > > diff --git a/tests/shell/testcases/cache/0007_echo_cache_init_0 b/tests/shell/testcases/cache/0007_echo_cache_init_0
> > > new file mode 100755
> > > index 000000000000..280a0d06bdc3
> > > --- /dev/null
> > > +++ b/tests/shell/testcases/cache/0007_echo_cache_init_0
> > > @@ -0,0 +1,14 @@
> > > +#!/bin/bash
> > > +
> > > +set -e
> > > +
> > > +$NFT -i >/dev/null <<EOF
> > > +add table inet t
> > > +add chain inet t c
> > > +add rule inet t c accept comment "first"
> > > +add rule inet t c accept comment "third"
> > > +EOF
> > > +
> > > +# make sure the rule cache gets initialized when using echo option
> > > +#
> > > +$NFT --echo add rule inet t c index 0 accept comment '"second"' >/dev/null
> > 
> > Looks like the problem is index == 0?
> 
> No. The index gets incremented by 1 by the JSON parser (CLI does the
> same thing). It's never zero if the "index" keyword is used.
> 
> It's just as easily reproduced if you use any other index.

I see, thanks. This one is passing tests here:

https://patchwork.ozlabs.org/patch/1158616/
