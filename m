Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B131F792983
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Sep 2023 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbjIEQ07 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Sep 2023 12:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354717AbjIENsO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:48:14 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2946198
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Sep 2023 06:48:10 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qdWPZ-0007RI-8f; Tue, 05 Sep 2023 15:48:09 +0200
Date:   Tue, 5 Sep 2023 15:48:09 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Thomas Haller <thaller@redhat.com>
Cc:     Florian Westphal <fw@strlen.de>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v3 00/11] tests/shell: allow running tests as
Message-ID: <20230905134809.GB28401@breakpoint.cc>
References: <20230904135135.1568180-1-thaller@redhat.com>
 <20230905110915.GD3531@breakpoint.cc>
 <e333c1c8d7b95591acdb8603fa7768af9299bafc.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e333c1c8d7b95591acdb8603fa7768af9299bafc.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thomas Haller <thaller@redhat.com> wrote:
> On Tue, 2023-09-05 at 13:09 +0200, Florian Westphal wrote:
> > Thomas Haller <thaller@redhat.com> wrote:
> > > Ch;anges to v3:
> > 
> > I was about to apply this but 10 tests now fail for me because they
> > no longer execute as real root and hit the socket buffer limits.
> > 
> > Please fix this, the default needs to be 'all tests pass',
> > i.e. use plain 'unshare -n' by default.
> > 
> > I'll leave it up to you if you want to automatically go with
> > unpriv netns if the script is invoked as non-root user or via
> > env/cmdline switch.
> > 
> > At least one failure isn't your fault, the blame is
> > with a shortcut check in sets/0043concatenated_ranges_0, so the test
> > never execeuted fully in the past. I will try
> > to figure out when this got broken :/

Seems its always broken.  Minimal reproducer:

nft -f - <<EOF
table ip filter {
        set test {
                type ipv4_addr . ether_addr . mark
                flags interval
                elements = { 198.51.100.0/25 . 00:0b:0c:ca:cc:10-c1:a0:c1:cc:10:00 . 0x0000006f, }
        }
}
EOF
nft get element ip filter test { 198.51.100.1 . 00:0b:0c:ca:cc:10 . 0x6f }
Error: Could not process rule: No such file or directory
get element ip filter test { 198.51.100.1 . 00:0b:0c:ca:cc:10 . 0x6f }
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
nft get element ip filter test { 198.51.100.1 . 00:0b:0c:ca:cc:10 . 0x6f-0x6f }
table ip ...

Seems like this doesn't emit the needed end keys because the 'INTERVAL' flag
isn't toggled without using at least one phony range in the query.
