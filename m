Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068697B084E
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Sep 2023 17:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjI0Pcf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Sep 2023 11:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjI0Pce (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:32:34 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1411192
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Sep 2023 08:32:32 -0700 (PDT)
Received: from [78.30.34.192] (port=48598 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qlWWa-00DAdF-PT; Wed, 27 Sep 2023 17:32:31 +0200
Date:   Wed, 27 Sep 2023 17:32:27 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: shell: fix spurious errors in
 sets/0036add_set_element_expiration_0
Message-ID: <ZRRLCywy5pSEoD/i@calendula>
References: <20230927144803.138869-1-pablo@netfilter.org>
 <ZRRD7B/dvuCwgfvD@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRRD7B/dvuCwgfvD@orbyte.nwl.cc>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 27, 2023 at 05:02:04PM +0200, Phil Sutter wrote:
> On Wed, Sep 27, 2023 at 04:48:03PM +0200, Pablo Neira Ayuso wrote:
> > Add seconds as expiration, otherwise 14m59 reports 14m in minute
> > granularity, this ensures suficient time in a very slow environment with
> > debugging instrumentation.
> > 
> > Fixes: adf38fd84257 ("tests: shell: use minutes granularity in sets/0036add_set_element_expiration_0")
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> > I still see this failing occasionally due to timing issues, fix it.
> > 
> >  tests/shell/testcases/sets/0036add_set_element_expiration_0 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/shell/testcases/sets/0036add_set_element_expiration_0 b/tests/shell/testcases/sets/0036add_set_element_expiration_0
> > index 12f10074409f..a50ac91d43a6 100755
> > --- a/tests/shell/testcases/sets/0036add_set_element_expiration_0
> > +++ b/tests/shell/testcases/sets/0036add_set_element_expiration_0
> > @@ -8,7 +8,7 @@ drop_seconds() {
> >  
> >  RULESET="add table ip x
> >  add set ip x y { type ipv4_addr; flags dynamic,timeout; } 
> > -add element ip x y { 1.1.1.1 timeout 30m expires 15m }"
> > +add element ip x y { 1.1.1.1 timeout 30m expires 15m59s }"
> >  
> >  test_output=$($NFT -e -f - <<< "$RULESET" 2>&1 | grep -v '# new generation' | drop_seconds)
> 
> The next line in that file is:
> 
> | if [ "$test_output" != "$RULESET" ] ; then
> 
> You add "59s" to $RULESET and drop it from $test_output. I guess, to
> make it work, you also need to pipe $RULESET through drop_seconds before
> the comparison.

Indeed, apologies: See latest patch.

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20230927152514.473765-1-pablo@netfilter.org/
