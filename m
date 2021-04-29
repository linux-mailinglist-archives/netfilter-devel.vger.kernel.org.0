Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4290D36F304
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Apr 2021 01:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhD2Xn7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Apr 2021 19:43:59 -0400
Received: from mail.netfilter.org ([217.70.188.207]:59552 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhD2Xnz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:43:55 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 375F864141
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Apr 2021 01:42:28 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 16/18] evaluate: remove set from cache on delete set command
Date:   Fri, 30 Apr 2021 01:42:53 +0200
Message-Id: <20210429234255.16840-17-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429234255.16840-1-pablo@netfilter.org>
References: <20210429234255.16840-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Update the cache to remove this set from the evaluation phase.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 49d47d0b4f34..19bf73878181 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4389,12 +4389,36 @@ static void chain_del_cache(struct eval_ctx *ctx, struct cmd *cmd)
 	chain_free(chain);
 }
 
+static void set_del_cache(struct eval_ctx *ctx, struct cmd *cmd)
+{
+	struct table *table;
+	struct set *set;
+
+	if (!cmd->handle.set.name)
+		return;
+
+	table = table_cache_find(&ctx->nft->cache.table_cache,
+				 cmd->handle.table.name,
+				 cmd->handle.family);
+	if (!table)
+		return;
+
+	set = set_cache_find(table, cmd->handle.set.name);
+	if (!set)
+		return;
+
+	set_cache_del(set);
+	set_free(set);
+}
+
 static int cmd_evaluate_delete(struct eval_ctx *ctx, struct cmd *cmd)
 {
 	switch (cmd->obj) {
 	case CMD_OBJ_ELEMENTS:
 		return setelem_evaluate(ctx, cmd);
 	case CMD_OBJ_SET:
+		set_del_cache(ctx, cmd);
+		return 0;
 	case CMD_OBJ_RULE:
 		return 0;
 	case CMD_OBJ_CHAIN:
-- 
2.20.1

