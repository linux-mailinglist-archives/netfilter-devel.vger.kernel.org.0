Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B547F4E80
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Nov 2023 18:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjKVRgx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Nov 2023 12:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjKVRgw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:36:52 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D061B1
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Nov 2023 09:36:48 -0800 (PST)
Received: from [78.30.43.141] (port=34990 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r5r9Z-00DhMP-1H; Wed, 22 Nov 2023 18:36:46 +0100
Date:   Wed, 22 Nov 2023 18:36:44 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 1/1] tests: prettify JSON in test output and add
 helper
Message-ID: <ZV48LJYO0ObBy04G@calendula>
References: <20231122111946.439474-1-thaller@redhat.com>
 <ZV31GgRsu6Y7UScC@calendula>
 <267d0bff359a01b3222506e272bb1c2b63c154c8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <267d0bff359a01b3222506e272bb1c2b63c154c8.camel@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 22, 2023 at 01:55:57PM +0100, Thomas Haller wrote:
[...]
> As always, you will find some result files in /tmp/nft-
> test.latest.$USER/, which I usually read with
> 
>   $ grep --color=always ^ -aR /tmp/nft-test.latest.*/ | less -R
> 
> there will be a new file there, named "ruleset-diff.json.pretty".
> 
> It contains the content of "./tests/shell/helpers/json-diff-pretty.sh"
> output.
> 
> 
> For example:
> 
>   $ cp tests/shell/testcases/bitwise/dumps/0040mark_binop_2.json-nft tests/shell/testcases/bitwise/dumps/0040mark_binop_3.json-nft
>   $ ./tests/shell/run-tests.sh tests/shell/testcases/bitwise/0040mark_binop_3
> 
> 
> leaves a file
> 
>      /tmp/nft-test.latest.*/test-tests-shell-testcases-bitwise-0040mark_binop_3.1/ruleset-diff.json.pretty

Thanks for explaining, this is now applied.

And please, add copy and paste this info to the README file (unless I
am overlooking anything, it is not yet there).
