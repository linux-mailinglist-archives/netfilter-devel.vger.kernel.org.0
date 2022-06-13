Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1484549C69
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jun 2022 20:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiFMS7K (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Jun 2022 14:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345445AbiFMS5y (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:57:54 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 636542A706
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jun 2022 09:05:41 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft 2/2] intervals: do not report exact overlaps for new elements
Date:   Mon, 13 Jun 2022 18:05:36 +0200
Message-Id: <20220613160536.127441-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613160536.127441-1-pablo@netfilter.org>
References: <20220613160536.127441-1-pablo@netfilter.org>
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

Two new elements that represent an exact overlap should not trigger an error.

   add table t
   add set t s { type ipv4_addr; flags interval; }
   add element t s { 1.0.1.0/24 }
   ...
   add element t s { 1.0.1.0/24 }

result in a bogus error.

 # nft -f set.nft
 set.nft:1002:19-28: Error: conflicting intervals specified
 add element t s { 1.0.1.0/24 }
                   ^^^^^^^^^^

Fixes: 3da9643fb9ff ("intervals: add support to automerge with kernel elements")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/intervals.c                            |  3 +--
 tests/shell/testcases/sets/exact_overlap_0 | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100755 tests/shell/testcases/sets/exact_overlap_0

diff --git a/src/intervals.c b/src/intervals.c
index bc414d6c8797..89f5c33d7a6e 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -540,8 +540,7 @@ static int setelem_overlap(struct list_head *msgs, struct set *set,
 		}
 
 		if (mpz_cmp(prev_range.low, range.low) == 0 &&
-		    mpz_cmp(prev_range.high, range.high) == 0 &&
-		    (elem->flags & EXPR_F_KERNEL || prev->flags & EXPR_F_KERNEL))
+		    mpz_cmp(prev_range.high, range.high) == 0)
 			goto next;
 
 		if (mpz_cmp(prev_range.low, range.low) <= 0 &&
diff --git a/tests/shell/testcases/sets/exact_overlap_0 b/tests/shell/testcases/sets/exact_overlap_0
new file mode 100755
index 000000000000..1ce9304a7455
--- /dev/null
+++ b/tests/shell/testcases/sets/exact_overlap_0
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+RULESET="add table t
+add set t s { type ipv4_addr; flags interval; }
+add element t s { 1.0.1.0/24 }
+add element t s { 1.0.2.0/23 }
+add element t s { 1.0.8.0/21 }
+add element t s { 1.0.32.0/19 }
+add element t s { 1.1.0.0/24 }
+add element t s { 1.1.2.0/23 }
+add element t s { 1.1.4.0/22 }
+add element t s { 1.1.8.0/24 }
+add element t s { 1.1.9.0/24 }
+add element t s { 1.1.10.0/23 }
+add element t s { 1.1.12.0/22 }
+add element t s { 1.1.16.0/20 }
+add element t s { 1.1.32.0/19 }
+add element t s { 1.0.1.0/24 }"
+
+$NFT -f - <<< $RULESET || exit 1
+
+$NFT add element t s { 1.0.1.0/24 }
-- 
2.30.2

