Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7E539F1E
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jun 2022 10:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbiFAIQQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Jun 2022 04:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiFAIQP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:16:15 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97B268AE74
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jun 2022 01:16:12 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] optimize: segfault when releasing unsupported statement
Date:   Wed,  1 Jun 2022 10:16:06 +0200
Message-Id: <20220601081606.190648-1-pablo@netfilter.org>
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

Call xfree() instead since stmt_alloc() does not initialize the
statement type fields.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1609
Fixes: ea1f1c9ff608 ("optimize: memleak in statement matrix")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/optimize.c b/src/optimize.c
index d6dfffec3c86..3a3049d43690 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -304,7 +304,7 @@ static int rule_collect_stmts(struct optimize_ctx *ctx, struct rule *rule)
 			clone->nat.type_flags = stmt->nat.type_flags;
 			break;
 		default:
-			stmt_free(clone);
+			xfree(clone);
 			continue;
 		}
 
-- 
2.30.2

