Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1413C5512D5
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jun 2022 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiFTIca (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jun 2022 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbiFTIc0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:32:26 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9ABB12A96
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Jun 2022 01:32:23 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 03/18] optimize: do not print stateful information
Date:   Mon, 20 Jun 2022 10:32:00 +0200
Message-Id: <20220620083215.1021238-4-pablo@netfilter.org>
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

Do not print stateful information such as counters which are likely set
to zero.

Before this patch:

  Merging:
  packets.conf:10:3-29:                 ip protocol  4 counter drop
  packets.conf:11:3-29:                 ip protocol 41 counter drop
  packets.conf:12:3-29:                 ip protocol 47 counter drop
  into:
          ip protocol { 4, 41, 47 } counter packets 0 bytes 0 drop
                                            ^^^^^^^^^^^^^^^^^
After:

  Merging:
  packets.conf:10:3-29:                 ip protocol  4 counter drop
  packets.conf:11:3-29:                 ip protocol 41 counter drop
  packets.conf:12:3-29:                 ip protocol 47 counter drop
  into:
          ip protocol { 4, 41, 47 } counter drop

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/optimize.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/optimize.c b/src/optimize.c
index 543d3ca5a9c7..b19a8b553555 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -873,6 +873,8 @@ static void merge_rules(const struct optimize_ctx *ctx,
 		assert(0);
 	}
 
+        octx->flags |= NFT_CTX_OUTPUT_STATELESS;
+
 	fprintf(octx->error_fp, "Merging:\n");
 	rule_optimize_print(octx, ctx->rule[from]);
 
@@ -885,6 +887,8 @@ static void merge_rules(const struct optimize_ctx *ctx,
 	fprintf(octx->error_fp, "into:\n\t");
 	rule_print(ctx->rule[from], octx);
 	fprintf(octx->error_fp, "\n");
+
+        octx->flags &= ~NFT_CTX_OUTPUT_STATELESS;
 }
 
 static bool stmt_type_eq(const struct stmt *stmt_a, const struct stmt *stmt_b)
-- 
2.30.2

