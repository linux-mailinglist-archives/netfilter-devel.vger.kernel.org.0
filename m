Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54997EC00D
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Nov 2023 11:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjKOJyP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Nov 2023 04:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjKOJyO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:54:14 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB9411C
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Nov 2023 01:54:11 -0800 (PST)
Received: from [78.30.43.141] (port=55214 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r3Cb1-00BFG7-CO; Wed, 15 Nov 2023 10:54:09 +0100
Date:   Wed, 15 Nov 2023 10:54:06 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Thomas Haller <thaller@redhat.com>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v3 2/6] tests/shell: check and generate JSON dump
 files
Message-ID: <ZVSVPgRFv9tTF4yQ@calendula>
References: <20231114153150.406334-1-thaller@redhat.com>
 <20231114160903.409552-1-thaller@redhat.com>
 <20231115082427.GC14621@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115082427.GC14621@breakpoint.cc>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 15, 2023 at 09:24:27AM +0100, Florian Westphal wrote:
> Thomas Haller <thaller@redhat.com> wrote:
> > The rules after a successful test are good opportunity to test
> > `nft -j list ruleset` and `nft -j --check`. This quite possibly touches
> > code paths that are not hit by other tests yet.
> 
> This series looks good to me, I'll apply it in the next few hours if
> noone else takes any action by then.

Just a question, patch 3 is missing in patchwork. I guess it is too
big.

My understanding is that this performs the json tests if nft comes with
json support.

I wanted to give this a run, description says a few tests are failing.
Last time we talked it is chain binding support, then there is a good
number of tests that are going to fail (or there is a mechanism to
temporarily disable json tests for this without losing coverage?).

What is the current output from tests? I wanted to make this run
myself so I don't need to ask.

I am asking all this because I am finishing backports for older stable
kernels while this is also going on.
