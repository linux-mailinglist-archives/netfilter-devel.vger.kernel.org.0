Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA51558851
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jun 2022 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiFWTEJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jun 2022 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiFWTD6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:03:58 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 300D5BB33C
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Jun 2022 11:09:55 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] intervals: fix crash when trying to remove element in empty set
Date:   Thu, 23 Jun 2022 20:09:50 +0200
Message-Id: <20220623180951.86277-1-pablo@netfilter.org>
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

The set deletion routine expects an initialized set, otherwise it crashes.

Fixes: 3e8d934e4f72 ("intervals: support to partial deletion with automerge")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/intervals.c                     |  6 +++++-
 tests/shell/testcases/sets/errors_0 | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100755 tests/shell/testcases/sets/errors_0

diff --git a/src/intervals.c b/src/intervals.c
index dcc06d18d594..c21b3ee0ad60 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -475,7 +475,11 @@ int set_delete(struct list_head *msgs, struct cmd *cmd, struct set *set,
 	if (set->automerge)
 		automerge_delete(msgs, set, init, debug_mask);
 
-	set_to_range(existing_set->init);
+	if (existing_set->init) {
+		set_to_range(existing_set->init);
+	} else {
+		existing_set->init = set_expr_alloc(&internal_location, set);
+	}
 
 	list_splice_init(&init->expressions, &del_list);
 
diff --git a/tests/shell/testcases/sets/errors_0 b/tests/shell/testcases/sets/errors_0
new file mode 100755
index 000000000000..2960b694c67c
--- /dev/null
+++ b/tests/shell/testcases/sets/errors_0
@@ -0,0 +1,14 @@
+#!/bin/bash
+
+set -e
+
+RULESET="table ip x {
+	set y {
+		type ipv4_addr
+		flags interval
+	}
+}
+
+delete element ip x y { 2.3.4.5 }"
+
+$NFT -f - <<< $RULESET || exit 0
-- 
2.30.2

