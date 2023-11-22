Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9B27F464D
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Nov 2023 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjKVMcP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Nov 2023 07:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjKVMcO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:32:14 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF2491
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Nov 2023 04:32:07 -0800 (PST)
Received: from [78.30.43.141] (port=40514 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r5mOg-00CdwR-ME; Wed, 22 Nov 2023 13:32:04 +0100
Date:   Wed, 22 Nov 2023 13:32:01 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>,
        Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH nft v3 1/1] tests/shell: sanitize "handle" in JSON output
Message-ID: <ZV30waZKED0YpnNx@calendula>
References: <ZVymYDwWLQBQUAAg@calendula>
 <20231121132331.3401846-1-thaller@redhat.com>
 <ZV3ZkD0Yi15ICNZT@calendula>
 <8a1e3a2451a770d49a9e130103b8a657e9c23c18.camel@redhat.com>
 <ZV3kjlO+DmfWm9DH@calendula>
 <f8d50ac543975cb9683eb652597370108f66320f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8d50ac543975cb9683eb652597370108f66320f.camel@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 22, 2023 at 01:16:38PM +0100, Thomas Haller wrote:
[...]
> 
> Note that on `master` there are
> 
>   - 386 shell tests
>   - 14 tests with .nodump files
>   - 372 tests with .nft dump files (386-14)
>   - 339 tests with .json-nft files
>   - 33 tests that lack .json-nft files (372-339)
> 
> Meaning, that they are IMO useful already, and there is no immediate
> hurry to address the missing 33 files.

This is useful, almost complete coverage is better than no coverage :)

> PS: Reminder: you can identify missing .json-nft files by running
> `./tools/check-tree.sh`.

Thanks. Maybe update tests/shell/README to add a few lines, I like to
go there when I forget things and...

$ git grep check-tree README
$

shows nothing.

> You can generate missing files either via
> 
>   $ DUMPGEN=all ./tests/shell/run-tests.sh tests/shell/testcases/cache/0010_implicit_chain_0
> 
> or just
> 
>   $ touch tests/shell/testcases/cache/dumps/0010_implicit_chain_0.json-nft
>   $ ./tests/shell/run-tests.sh tests/shell/testcases/cache/0010_implicit_chain_0 -g

Yes, that is missing.
