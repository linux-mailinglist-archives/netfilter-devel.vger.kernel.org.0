Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0704D4FEC7D
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Apr 2022 03:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiDMBv4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Apr 2022 21:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiDMBvz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:51:55 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52916120B2
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Apr 2022 18:49:34 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nft,v6 0/8] revisit overlap/automerge codebase
Date:   Wed, 13 Apr 2022 03:49:22 +0200
Message-Id: <20220413014930.410728-1-pablo@netfilter.org>
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

This is a rebase on top of Florian's ifname support for sets.

This adds a new 8/8 patch to restore testcases/sets/sets_with_ifnames
after the rebase.

Pablo Neira Ayuso (8):
  src: add EXPR_F_KERNEL to identify expression in the kernel
  src: replace interval segment tree overlap and automerge
  src: remove rbtree datastructure
  mnl: update mnl_nft_setelem_del() to allow for more reuse
  intervals: add support to automerge with kernel elements
  evaluate: allow for zero length ranges
  intervals: support to partial deletion with automerge
  src: restore interval sets work with string datatypes

 include/Makefile.am                           |   2 +-
 include/expression.h                          |   7 +-
 include/intervals.h                           |  12 +
 include/mnl.h                                 |   3 +-
 include/rbtree.h                              |  98 ---
 include/rule.h                                |   2 +
 src/Makefile.am                               |   2 +-
 src/cache.c                                   |   6 +
 src/evaluate.c                                |  75 +-
 src/expression.c                              |   8 +-
 src/intervals.c                               | 740 ++++++++++++++++++
 src/libnftables.c                             |   4 +-
 src/mergesort.c                               |   1 +
 src/mnl.c                                     |   6 +-
 src/netlink.c                                 |   1 +
 src/rbtree.c                                  | 388 ---------
 src/rule.c                                    |  25 +-
 src/segtree.c                                 | 698 +----------------
 .../shell/testcases/sets/0069interval_merge_0 |  28 +
 .../sets/dumps/0069interval_merge_0.nft       |   9 +
 20 files changed, 914 insertions(+), 1201 deletions(-)
 create mode 100644 include/intervals.h
 delete mode 100644 include/rbtree.h
 create mode 100644 src/intervals.c
 delete mode 100644 src/rbtree.c
 create mode 100755 tests/shell/testcases/sets/0069interval_merge_0
 create mode 100644 tests/shell/testcases/sets/dumps/0069interval_merge_0.nft

--
2.30.2

