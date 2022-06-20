Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075555512DD
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jun 2022 10:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbiFTIce (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jun 2022 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbiFTIc3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:32:29 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C24EF12A95
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Jun 2022 01:32:28 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 16/18] optimize: assume verdict is same when rules have no verdict
Date:   Mon, 20 Jun 2022 10:32:13 +0200
Message-Id: <20220620083215.1021238-17-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620083215.1021238-1-pablo@netfilter.org>
References: <20220620083215.1021238-1-pablo@netfilter.org>
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

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/optimize.c                                        |  3 ++-
 .../testcases/optimizations/dumps/merge_reject.nft    |  6 ++++++
 tests/shell/testcases/optimizations/merge_reject      | 11 +++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/optimize.c b/src/optimize.c
index e4508fa5116a..c6b85d74d302 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -944,7 +944,8 @@ static enum stmt_types merge_stmt_type(const struct optimize_ctx *ctx)
 		}
 	}
 
-	return STMT_INVALID;
+	/* actually no verdict, this assumes rules have the same verdict. */
+	return STMT_VERDICT;
 }
 
 static void merge_rules(const struct optimize_ctx *ctx,
diff --git a/tests/shell/testcases/optimizations/dumps/merge_reject.nft b/tests/shell/testcases/optimizations/dumps/merge_reject.nft
index 9a13e2b96faa..c29ad6d5648b 100644
--- a/tests/shell/testcases/optimizations/dumps/merge_reject.nft
+++ b/tests/shell/testcases/optimizations/dumps/merge_reject.nft
@@ -5,3 +5,9 @@ table ip x {
 		ip daddr 172.30.254.252 tcp dport 3306 counter packets 0 bytes 0 reject with tcp reset
 	}
 }
+table ip6 x {
+	chain y {
+		meta l4proto . ip6 daddr . tcp dport { tcp . aaaa::3 . 8080, tcp . aaaa::2 . 3306, tcp . aaaa::4 . 3306 } counter packets 0 bytes 0 reject
+		ip6 daddr aaaa::5 tcp dport 3306 counter packets 0 bytes 0 reject with tcp reset
+	}
+}
diff --git a/tests/shell/testcases/optimizations/merge_reject b/tests/shell/testcases/optimizations/merge_reject
index 497e8f64dc5d..c0ef9cacbbf0 100755
--- a/tests/shell/testcases/optimizations/merge_reject
+++ b/tests/shell/testcases/optimizations/merge_reject
@@ -13,3 +13,14 @@ RULESET="table ip x {
 }"
 
 $NFT -o -f - <<< $RULESET
+
+RULESET="table ip6 x {
+	chain y {
+		meta l4proto tcp ip6 daddr aaaa::2 tcp dport 3306 counter packets 0 bytes 0 reject
+		meta l4proto tcp ip6 daddr aaaa::3 tcp dport 8080 counter packets 0 bytes 0 reject
+		meta l4proto tcp ip6 daddr aaaa::4 tcp dport 3306 counter packets 0 bytes 0 reject
+		meta l4proto tcp ip6 daddr aaaa::5 tcp dport 3306 counter packets 0 bytes 0 reject with tcp reset
+	}
+}"
+
+$NFT -o -f - <<< $RULESET
-- 
2.30.2

