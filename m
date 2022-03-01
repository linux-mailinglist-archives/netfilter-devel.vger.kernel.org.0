Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5FC4C9762
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Mar 2022 21:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiCAU7W (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 1 Mar 2022 15:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiCAU7V (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:59:21 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA9CD50076
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Mar 2022 12:58:38 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2391160745
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Mar 2022 21:57:10 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v3 0/7] revisit overlap/automerge codebase
Date:   Tue,  1 Mar 2022 21:58:27 +0100
Message-Id: <20220301205834.290720-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This is another iteration on the set element automerge codebase.

This patchset removes the segment tree interval overlap/automerge codebase.
This is replaced with mergesort of the set elements + check for overlaps by
linearly iterating the set elements.

This version also contains support to delete via automerge which allows
you to merge new ranges to existing ones as well as to perform partial
deletions.

This adds a new testcases/sets/0069interval_merge_0.

This is passing tests/shell and tests/py.

Pablo Neira Ayuso (7):
  src: add EXPR_F_KERNEL to identify expression in the kernel
  src: replace interval segment tree overlap and automerge
  src: remove rbtree datastructure
  mnl: update mnl_nft_setelem_del() to allow for more reuse
  intervals: add support to automerge with kernel elements
  evaluate: allow for zero length ranges
  intervals: support to partial deletion with automerge

 include/Makefile.am                           |   2 +-
 include/expression.h                          |   7 +-
 include/intervals.h                           |  12 +
 include/mnl.h                                 |   3 +-
 include/rbtree.h                              |  98 ---
 include/rule.h                                |   2 +
 src/Makefile.am                               |   2 +-
 src/cache.c                                   |   6 +
 src/evaluate.c                                |  75 +-
 src/intervals.c                               | 740 ++++++++++++++++++
 src/libnftables.c                             |   4 +-
 src/mergesort.c                               |   1 +
 src/mnl.c                                     |   6 +-
 src/netlink.c                                 |   1 +
 src/rbtree.c                                  | 388 ---------
 src/rule.c                                    |  25 +-
 src/segtree.c                                 | 660 +---------------
 .../shell/testcases/sets/0069interval_merge_0 |  28 +
 .../sets/dumps/0069interval_merge_0.nft       |   9 +
 19 files changed, 895 insertions(+), 1174 deletions(-)
 create mode 100644 include/intervals.h
 delete mode 100644 include/rbtree.h
 create mode 100644 src/intervals.c
 delete mode 100644 src/rbtree.c
 create mode 100755 tests/shell/testcases/sets/0069interval_merge_0
 create mode 100644 tests/shell/testcases/sets/dumps/0069interval_merge_0.nft

-- 
2.30.2

