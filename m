Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9D84FA8D0
	for <lists+netfilter-devel@lfdr.de>; Sat,  9 Apr 2022 15:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbiDIOAt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 9 Apr 2022 10:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiDIOAt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:00:49 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD216DF2B
        for <netfilter-devel@vger.kernel.org>; Sat,  9 Apr 2022 06:58:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ndBbp-0008Jp-C7; Sat, 09 Apr 2022 15:58:37 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nftables 0/9] nftables: add support for wildcard string as set keys
Date:   Sat,  9 Apr 2022 15:58:23 +0200
Message-Id: <20220409135832.17401-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Allow to match something like

meta iifname { eth0, ppp* }.

Set ranges or concatenations are not yet supported.
Test passes on x86_64 and s390 (bigendian), however, the test fails dump
validation:

-  iifname { "eth0", "abcdef0" } counter packets 0 bytes 0
+  iifname { "abcdef0", "eth0" } counter packets 0 bytes 0

This happens with other tests as well.  Other tests fail
on s390 too but there are no new failures.

I wil try to get string range support working and will
then ook into concat set support.

Florian Westphal (9):
  evaluate: make byteorder conversion on string base type a no-op
  evaluate: keep prefix expression length
  segtree: split prefix and range creation to a helper function
  evaluate: string prefix expression must retain original length
  src: make interval sets work with string datatypes
  segtree: add string "range" reversal support
  tests: add testcases for interface names in sets
  segtree: use correct byte order for 'element get'
  segtree: add support for get element with sets that contain ifnames

 src/evaluate.c                                |  18 +-
 src/expression.c                              |   9 +-
 src/segtree.c                                 | 228 +++++++++++++-----
 .../sets/dumps/sets_with_ifnames.nft          |  28 +++
 tests/shell/testcases/sets/sets_with_ifnames  | 102 ++++++++
 5 files changed, 315 insertions(+), 70 deletions(-)
 create mode 100644 tests/shell/testcases/sets/dumps/sets_with_ifnames.nft
 create mode 100755 tests/shell/testcases/sets/sets_with_ifnames

-- 
2.35.1

