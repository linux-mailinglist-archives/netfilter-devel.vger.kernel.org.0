Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759C14CC01E
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Mar 2022 15:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiCCOjw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Mar 2022 09:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCCOjw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:39:52 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8603D14D736
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Mar 2022 06:39:06 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id D863062FE6
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Mar 2022 15:37:31 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 2/2] optimize: incorrect assert() for unexpected expression type
Date:   Thu,  3 Mar 2022 15:39:00 +0100
Message-Id: <20220303143900.702741-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220303143900.702741-1-pablo@netfilter.org>
References: <20220303143900.702741-1-pablo@netfilter.org>
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

assert(1) is noop, this should be assert(0) instead.

Fixes: 561aa3cfa8da ("optimize: merge verdict maps with same lookup key")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes

 src/optimize.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/optimize.c b/src/optimize.c
index cd799e0d3407..c81d19d4739b 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -362,11 +362,11 @@ static void merge_verdict_stmts(const struct optimize_ctx *ctx,
 				merge_vmap(ctx, stmt_a, stmt_b);
 				break;
 			default:
-				assert(1);
+				assert(0);
 			}
 			break;
 		default:
-			assert(1);
+			assert(0);
 			break;
 		}
 	}
@@ -385,7 +385,7 @@ static void merge_stmts(const struct optimize_ctx *ctx,
 		merge_verdict_stmts(ctx, from, to, merge, stmt_a);
 		break;
 	default:
-		assert(1);
+		assert(0);
 	}
 }
 
-- 
2.30.2

