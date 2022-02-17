Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7644D4BA6DB
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Feb 2022 18:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbiBQRRj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Feb 2022 12:17:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243636AbiBQRRj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:17:39 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3587166E3D
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Feb 2022 09:17:24 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 658FA601E7
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Feb 2022 18:16:42 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v1 0/5] revisit overlap/automerge codebase
Date:   Thu, 17 Feb 2022 18:16:59 +0100
Message-Id: <20220217171705.2637781-1-pablo@netfilter.org>
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

This patchset removes the segment tree interval overlap/automerge codebase.
This is replaced with mergesort of the set elements + check for overlaps by
linearly iterating the set elements.

This is passing tests/shell and tests/py.

Pablo Neira Ayuso (5):
  src: add EXPR_F_KERNEL to identify expression in the kernel
  src: replace interval segment tree overlap and automerge
  src: remove rbtree datastructure
  mnl: update mnl_nft_setelem_del() to allow for more reuse
  intervals: add support to automerge with kernel elements

 include/Makefile.am  |   2 +-
 include/expression.h |   7 +-
 include/intervals.h  |   9 +
 include/mnl.h        |   3 +-
 include/rbtree.h     |  98 -------
 include/rule.h       |   3 +
 src/Makefile.am      |   2 +-
 src/cache.c          |   3 +-
 src/evaluate.c       |  50 +++-
 src/intervals.c      | 413 +++++++++++++++++++++++++++
 src/mergesort.c      |   1 +
 src/mnl.c            |   6 +-
 src/netlink.c        |   1 +
 src/rbtree.c         | 388 -------------------------
 src/rule.c           |  25 +-
 src/segtree.c        | 660 +------------------------------------------
 16 files changed, 510 insertions(+), 1161 deletions(-)
 create mode 100644 include/intervals.h
 delete mode 100644 include/rbtree.h
 create mode 100644 src/intervals.c
 delete mode 100644 src/rbtree.c

-- 
2.30.2

