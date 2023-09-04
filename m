Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257DE7913CA
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Sep 2023 10:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352584AbjIDIp5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 4 Sep 2023 04:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352582AbjIDIp5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:45:57 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A062912A
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Sep 2023 01:45:45 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qd5DK-00007N-RK; Mon, 04 Sep 2023 10:45:42 +0200
Date:   Mon, 4 Sep 2023 10:45:42 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v2 3/3] tests/shell: run each test in separate
 namespace and allow rootless
Message-ID: <20230904084542.GB11802@breakpoint.cc>
References: <20230901150916.183949-1-thaller@redhat.com>
 <20230901150916.183949-4-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901150916.183949-4-thaller@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thomas Haller <thaller@redhat.com> wrote:
> +	UNSHARE=( unshare -f -p --mount-proc -U --map-root-user -n )
> +	if ! "${UNSHARE[@]}" true ; then
> +		# Try without PID namespace.
> +		UNSHARE=( unshare -f -U --map-root-user -n )
> +		if ! "${UNSHARE[@]}" true ; then
> +			msg_error "Unshare does not work. Rerun with -U/--no-unshare or NFT_TEST_NO_UNSHARE=y"

This will always fail here due to
user.max_user_namespaces=0

in sysctl.cfg.

So please add a fallback to plain unshare -n or only use unpriv userns
if the script isn't called with uid 0.

>  	msg_info "[EXECUTING]	$testfile"
> -	test_output=$(NFT="$NFT" DIFF=$DIFF ${testfile} 2>&1)
> +	test_output=$(NFT="$NFT" DIFF=$DIFF "${UNSHARE[@]}" "$testfile" 2>&1)
>  	rc_got=$?

This is more complicated because we'll also need to collect the ruleset
dump from within the temporary ns.

Once all of that works you can remove kernel_cleanup().
