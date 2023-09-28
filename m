Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2930C7B25DC
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Sep 2023 21:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjI1TR2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Sep 2023 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjI1TR0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:17:26 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06DE1A7
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Sep 2023 12:17:24 -0700 (PDT)
Received: from [78.30.34.192] (port=36458 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qlwVk-0041YR-Op; Thu, 28 Sep 2023 21:17:22 +0200
Date:   Thu, 28 Sep 2023 21:17:20 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft,v3] tests: shell: fix spurious errors in
 sets/0036add_set_element_expiration_0
Message-ID: <ZRXRQO44pxHRa53x@calendula>
References: <20230927163937.757167-1-pablo@netfilter.org>
 <ZRWUpn963dk3Eaey@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRWUpn963dk3Eaey@orbyte.nwl.cc>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 28, 2023 at 04:58:46PM +0200, Phil Sutter wrote:
> On Wed, Sep 27, 2023 at 06:39:37PM +0200, Pablo Neira Ayuso wrote:
> > A number of changes to fix spurious errors:
> > 
> > - Add seconds as expiration, otherwise 14m59 reports 14m in minute
> >   granularity, this ensures suficient time in a very slow environment with
> >   debugging instrumentation.
> > 
> > - Provide expected output.
> > 
> > - Update sed regular expression to make 'ms' optional and use -E mode.
> > 
> > Fixes: adf38fd84257 ("tests: shell: use minutes granularity in sets/0036add_set_element_expiration_0")
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> > v3: - [ "$test_output" != "$EXPECTED" ], not [ "$test_output" != "$RULESET" ]
> >     - Make 'ms' optional in sed regular expression
> >     - Use -E in sed
> > 
> >  .../testcases/sets/0036add_set_element_expiration_0    | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tests/shell/testcases/sets/0036add_set_element_expiration_0 b/tests/shell/testcases/sets/0036add_set_element_expiration_0
> > index 12f10074409f..0fd016e9f857 100755
> > --- a/tests/shell/testcases/sets/0036add_set_element_expiration_0
> > +++ b/tests/shell/testcases/sets/0036add_set_element_expiration_0
> > @@ -3,17 +3,21 @@
> >  set -e
> >  
> >  drop_seconds() {
> > -       sed 's/m[0-9]*s[0-9]*ms/m/g'
> > +	sed -E 's/m[0-9]*s([0-9]*ms)?/m/g'
> >  }
> 
> So sometimes there's no ms part in output. In theory one would have to
> make the seconds part optional, too. Funny how tedious these little
> things may become to fix.
> 
> Anyway, it should work without -E by escaping braces and the question
> mark. But accoring to sed(1), -E is in POSIX meanwhile so no big deal.
> 
> >  RULESET="add table ip x
> > +add set ip x y { type ipv4_addr; flags dynamic,timeout; }
> > +add element ip x y { 1.1.1.1 timeout 30m expires 15m59s }"
> > +
> > +EXPECTED="add table ip x
> >  add set ip x y { type ipv4_addr; flags dynamic,timeout; } 
> >  add element ip x y { 1.1.1.1 timeout 30m expires 15m }"
> 
> I would have piped RULESET through drop_seconds in the $DIFF call below,
> but this variant surely saves a few cycles. :D

I am useless. I quickly tried this, but echo disregards newlines,
triggering a mismatch in the diff, perhaps printf can address this.

I just wanted to make this reliable, it has been bothering me in my
test infrastructure which is running this in a loop and occasionally
triggering this false positive.
