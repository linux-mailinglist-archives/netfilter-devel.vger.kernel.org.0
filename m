Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B41B5153C5
	for <lists+netfilter-devel@lfdr.de>; Fri, 29 Apr 2022 20:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378022AbiD2SgH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 29 Apr 2022 14:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiD2SgG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:36:06 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB23ED4C90
        for <netfilter-devel@vger.kernel.org>; Fri, 29 Apr 2022 11:32:46 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nkVQ4-0001se-Ex; Fri, 29 Apr 2022 20:32:44 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/3] nftables: add support for wildcard interfaces
Date:   Fri, 29 Apr 2022 20:32:36 +0200
Message-Id: <20220429183239.5569-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

First patch is needed so kernel doesn't think end is before start,
second patch allows to dump "x .foo*" correctly, without this
nft tries to represent the start/end "name" with a range.
This doesn't work well because end range uses \ff padding.

Patch 3 adds tests.

Florian Westphal (3):
  netlink: swap byteorder for host-endian concat data
  segtree: add pretty-print support for wildcard strings in concatenated
    sets
  sets_with_ifnames: add test case for concatenated range

 src/netlink.c                                 |  4 +
 src/segtree.c                                 | 38 +++++++-
 .../sets/dumps/sets_with_ifnames.nft          | 25 ++++-
 tests/shell/testcases/sets/sets_with_ifnames  | 93 ++++++++++++++-----
 4 files changed, 134 insertions(+), 26 deletions(-)

-- 
2.35.1

