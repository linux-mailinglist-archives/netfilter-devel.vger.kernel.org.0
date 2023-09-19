Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E307A65A8
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 Sep 2023 15:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjISNsU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 19 Sep 2023 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjISNsT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:48:19 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C509E5
        for <netfilter-devel@vger.kernel.org>; Tue, 19 Sep 2023 06:48:13 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] limit: display default burst when listing ruleset
Date:   Tue, 19 Sep 2023 15:48:07 +0200
Message-Id: <20230919134807.220004-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Default burst for limit is 5 for historical reasons but it is not
displayed when listing the ruleset.

Update listing to display the default burst to disambiguate.

man nft(8) has been recently updated to document this, no action in this
front is therefore required.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/statement.c      |  4 +---
 tests/py/any/limit.t | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/src/statement.c b/src/statement.c
index 721739498e2e..66424eb420ab 100644
--- a/src/statement.c
+++ b/src/statement.c
@@ -486,9 +486,7 @@ static void limit_stmt_print(const struct stmt *stmt, struct output_ctx *octx)
 		nft_print(octx, "limit rate %s%" PRIu64 "/%s",
 			  inv ? "over " : "", stmt->limit.rate,
 			  get_unit(stmt->limit.unit));
-		if (stmt->limit.burst && stmt->limit.burst != 5)
-			nft_print(octx, " burst %u packets",
-				  stmt->limit.burst);
+		nft_print(octx, " burst %u packets", stmt->limit.burst);
 		break;
 	case NFT_LIMIT_PKT_BYTES:
 		data_unit = get_rate(stmt->limit.rate, &rate);
diff --git a/tests/py/any/limit.t b/tests/py/any/limit.t
index 86e8d43009b9..a04ef42af931 100644
--- a/tests/py/any/limit.t
+++ b/tests/py/any/limit.t
@@ -9,11 +9,11 @@
 *bridge;test-bridge;output
 *netdev;test-netdev;ingress,egress
 
-limit rate 400/minute;ok
-limit rate 20/second;ok
-limit rate 400/hour;ok
-limit rate 40/day;ok
-limit rate 400/week;ok
+limit rate 400/minute;ok;limit rate 400/minute burst 5 packets
+limit rate 20/second;ok;limit rate 20/second burst 5 packets
+limit rate 400/hour;ok;limit rate 400/hour burst 5 packets
+limit rate 40/day;ok;limit rate 40/day burst 5 packets
+limit rate 400/week;ok;limit rate 400/week burst 5 packets
 limit rate 1023/second burst 10 packets;ok
 limit rate 1023/second burst 10 bytes;fail
 
@@ -35,11 +35,11 @@ limit rate 1025 kbytes/second burst 1023 kbytes;ok
 limit rate 1025 mbytes/second burst 1025 kbytes;ok
 limit rate 1025000 mbytes/second burst 1023 mbytes;ok
 
-limit rate over 400/minute;ok
-limit rate over 20/second;ok
-limit rate over 400/hour;ok
-limit rate over 40/day;ok
-limit rate over 400/week;ok
+limit rate over 400/minute;ok;limit rate over 400/minute burst 5 packets
+limit rate over 20/second;ok;limit rate over 20/second burst 5 packets
+limit rate over 400/hour;ok;limit rate over 400/hour burst 5 packets
+limit rate over 40/day;ok;limit rate over 40/day burst 5 packets
+limit rate over 400/week;ok;limit rate over 400/week burst 5 packets
 limit rate over 1023/second burst 10 packets;ok
 
 limit rate over 1 kbytes/second;ok
-- 
2.30.2

