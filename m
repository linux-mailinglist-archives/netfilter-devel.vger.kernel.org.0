Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B8231E88
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Jul 2020 14:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgG2M2c (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 29 Jul 2020 08:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2M2c (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:28:32 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DB0C061794
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Jul 2020 05:28:32 -0700 (PDT)
Received: from localhost ([::1]:47838 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1k0lC9-0003tL-25; Wed, 29 Jul 2020 14:28:29 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] json: Expect refcount increment by json_array_extend()
Date:   Wed, 29 Jul 2020 14:28:31 +0200
Message-Id: <20200729122831.24918-1-phil@nwl.cc>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This function is apparently not "joining" two arrays but rather copying
all items from the second array to the first, leaving the original
reference in place. Therefore it naturally increments refcounts, which
means if used to join two arrays caller must explicitly decrement the
second array's refcount.

Fixes: e70354f53e9f6 ("libnftables: Implement JSON output support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/json.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/json.c b/src/json.c
index 24583060e68e7..888cb371e971d 100644
--- a/src/json.c
+++ b/src/json.c
@@ -1568,7 +1568,7 @@ static json_t *table_print_json_full(struct netlink_ctx *ctx,
 static json_t *do_list_ruleset_json(struct netlink_ctx *ctx, struct cmd *cmd)
 {
 	unsigned int family = cmd->handle.family;
-	json_t *root = json_array();
+	json_t *root = json_array(), *tmp;
 	struct table *table;
 
 	list_for_each_entry(table, &ctx->nft->cache.list, list) {
@@ -1576,7 +1576,9 @@ static json_t *do_list_ruleset_json(struct netlink_ctx *ctx, struct cmd *cmd)
 		    table->handle.family != family)
 			continue;
 
-		json_array_extend(root, table_print_json_full(ctx, table));
+		tmp = table_print_json_full(ctx, table);
+		json_array_extend(root, tmp);
+		json_decref(tmp);
 	}
 
 	return root;
-- 
2.27.0

