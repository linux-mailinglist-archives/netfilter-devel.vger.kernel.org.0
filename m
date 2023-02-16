Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587E6699DBD
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Feb 2023 21:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBPUcC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Feb 2023 15:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPUcB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:32:01 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD7AE196A9
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Feb 2023 12:32:00 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/3] evaluate: print error on missing family in nat statement
Date:   Thu, 16 Feb 2023 21:31:55 +0100
Message-Id: <20230216203157.448390-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Print error message in case family cannot be inferred, before this
patch, $? shows 1 after nft execution but no error message was printed.

Fixes: e5c9c8fe0bcc ("evaluate: stmt_evaluate_nat_map() only if stmt->nat.ipportmap == true")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index fe6384a48e14..f92b160ce3a4 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3540,7 +3540,9 @@ static int stmt_evaluate_nat_map(struct eval_ctx *ctx, struct stmt *stmt)
 		addr_type = TYPE_IP6ADDR;
 		break;
 	default:
-		return -1;
+		return stmt_error(ctx, stmt,
+				  "Table family is %s, you must specify either ip or ip6 family after %s statement to disambiguate",
+				  family2str(stmt->nat.family), stmt->ops->name);
 	}
 	dtype = concat_type_alloc((addr_type << TYPE_BITS) | TYPE_INET_SERVICE);
 
-- 
2.30.2

