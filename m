Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3BD79296F
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Sep 2023 18:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352052AbjIEQ0b (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Sep 2023 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354379AbjIELJY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:09:24 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2201AB
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Sep 2023 04:09:19 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qdTvn-0006sH-T0; Tue, 05 Sep 2023 13:09:15 +0200
Date:   Tue, 5 Sep 2023 13:09:15 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v3 00/11] tests/shell: allow running tests as
Message-ID: <20230905110915.GD3531@breakpoint.cc>
References: <20230904135135.1568180-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904135135.1568180-1-thaller@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thomas Haller <thaller@redhat.com> wrote:
> Changes to v3:

I was about to apply this but 10 tests now fail for me because they
no longer execute as real root and hit the socket buffer limits.

Please fix this, the default needs to be 'all tests pass',
i.e. use plain 'unshare -n' by default.

I'll leave it up to you if you want to automatically go with
unpriv netns if the script is invoked as non-root user or via
env/cmdline switch.

At least one failure isn't your fault, the blame is
with a shortcut check in sets/0043concatenated_ranges_0, so the test
never execeuted fully in the past. I will try
to figure out when this got broken :/
