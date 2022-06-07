Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCDF53ABA5
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jun 2022 19:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356262AbiFARR2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Jun 2022 13:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244748AbiFARR1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:17:27 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A53A255A6
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jun 2022 10:17:26 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     nwhisper@gmail.com
Subject: [PATCH nft] evaluate: reset ctx->set after set interval evaluation
Date:   Wed,  1 Jun 2022 19:17:22 +0200
Message-Id: <20220601171722.236499-1-pablo@netfilter.org>
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

Otherwise bogus error reports on set datatype mismatch might occur, such as:

Error: datatype mismatch, expected Internet protocol, expression has type IPv4 address
    meta l4proto { tcp, udp } th dport 443 dnat to 10.0.0.1
                 ^^^^^^^^^^^^

with an unrelated set declaration.

table ip test {
       set set_with_interval {
               type ipv4_addr
               flags interval
       }

       chain prerouting {
               type nat hook prerouting priority dstnat; policy accept;
               meta l4proto { tcp, udp } th dport 443 dnat to 10.0.0.1
       }
}

This bug has been introduced in the evaluation step.

Reported-by: Roman Petrov <nwhisper@gmail.com>
Fixes: 81e36530fcac ("src: replace interval segment tree overlap and automerge)"
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c                                  | 10 ++++++----
 tests/shell/testcases/sets/dumps/set_eval_0.nft | 11 +++++++++++
 tests/shell/testcases/sets/set_eval_0           | 17 +++++++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)
 create mode 100644 tests/shell/testcases/sets/dumps/set_eval_0.nft
 create mode 100755 tests/shell/testcases/sets/set_eval_0

diff --git a/src/evaluate.c b/src/evaluate.c
index 1447a4c28aee..82bf1311fa53 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4005,8 +4005,9 @@ static int setelem_evaluate(struct eval_ctx *ctx, struct cmd *cmd)
 	cmd->elem.set = set_get(set);
 
 	if (set_is_interval(ctx->set->flags) &&
-	    !(set->flags & NFT_SET_CONCAT))
-		return interval_set_eval(ctx, ctx->set, cmd->expr);
+	    !(set->flags & NFT_SET_CONCAT) &&
+	    interval_set_eval(ctx, ctx->set, cmd->expr) < 0)
+		return -1;
 
 	ctx->set = NULL;
 
@@ -4184,8 +4185,9 @@ static int set_evaluate(struct eval_ctx *ctx, struct set *set)
 	}
 
 	if (set_is_interval(ctx->set->flags) &&
-	    !(ctx->set->flags & NFT_SET_CONCAT))
-		return interval_set_eval(ctx, ctx->set, set->init);
+	    !(ctx->set->flags & NFT_SET_CONCAT) &&
+	    interval_set_eval(ctx, ctx->set, set->init) < 0)
+		return -1;
 
 	ctx->set = NULL;
 
diff --git a/tests/shell/testcases/sets/dumps/set_eval_0.nft b/tests/shell/testcases/sets/dumps/set_eval_0.nft
new file mode 100644
index 000000000000..a45462b8adbf
--- /dev/null
+++ b/tests/shell/testcases/sets/dumps/set_eval_0.nft
@@ -0,0 +1,11 @@
+table ip nat {
+	set set_with_interval {
+		type ipv4_addr
+		flags interval
+	}
+
+	chain prerouting {
+		type nat hook prerouting priority dstnat; policy accept;
+		meta l4proto { tcp, udp } th dport 443 dnat to 10.0.0.1
+	}
+}
diff --git a/tests/shell/testcases/sets/set_eval_0 b/tests/shell/testcases/sets/set_eval_0
new file mode 100755
index 000000000000..82b6d3bc69a7
--- /dev/null
+++ b/tests/shell/testcases/sets/set_eval_0
@@ -0,0 +1,17 @@
+#!/bin/bash
+
+set -e
+
+RULESET="table ip nat {
+        set set_with_interval {
+                type ipv4_addr
+                flags interval
+        }
+
+        chain prerouting {
+                type nat hook prerouting priority dstnat; policy accept;
+                meta l4proto { tcp, udp } th dport 443 dnat to 10.0.0.1
+        }
+}"
+
+$NFT -f - <<< $RULESET
-- 
2.30.2

